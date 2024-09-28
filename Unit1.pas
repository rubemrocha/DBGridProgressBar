{$WARNINGS OFF}

unit Unit1;

interface

uses
  Forms, StdCtrls, Controls, Grids, DBGrids, DB, Classes, DBClient, ExtCtrls,
  Graphics, Types;

type
  //  altera��o local para poder ter acesso � propriedade Row, sem
  //  ter que fazer aquela 'gambiarra' de criar uma classe 'hackeada'!!!
  TDBGrid = class(DBGrids.TDBGrid)
  public
    property Row;
  end;                                   

  TfrmTempoChamados = class(TForm)
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    Button1: TButton;
    ClientDataSet1PROBLEMA: TStringField;
    ClientDataSet1DATAHORACHAMADO: TDateTimeField;
    ClientDataSet1TEMPORESPONDER: TDateTimeField;
    tmrProgresso: TTimer;
    ClientDataSet1TEMPODECORRIDO: TStringField;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    cboEstiloProgressBar: TComboBox;
    procedure Button1Click(Sender: TObject);
    procedure tmrProgressoTimer(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    procedure DisableDataControls;
    procedure EnableDataControls;
    procedure UpdateIndicators;
    procedure SetupDataSet;
  public
    constructor Create(AOwner: TComponent); override;
  end;

var
  frmTempoChamados: TfrmTempoChamados;

implementation

uses
  Math, SysUtils, Windows, DateUtils;

const
  clLightOrange = TColor($0091C8FF);
  clOrange = TColor($000080FF);

{$R *.dfm}

procedure TfrmTempoChamados.Button1Click(Sender: TObject);
begin
  Close;
end;

constructor TfrmTempoChamados.Create(AOwner: TComponent);
begin
  inherited;
  Position := poScreenCenter;
  BorderStyle := bsSingle;
  BorderIcons := [biSystemMenu];
  Application.Icon.Assign(Self.Icon);
  Application.Title := Self.Caption;
  SetupDataSet;
  tmrProgresso.Enabled := true;
end;

procedure TfrmTempoChamados.UpdateIndicators;
const
  AStepChars: array[0..1] of Char = ('g', '�');
var
  rowDelta: Integer;
  row: integer;
  lNow: TDateTime;
  lInterval, lDiff, lPerc: Int64;
  lBookmark: TBookmark;
begin
  DisableDataControls;
  lBookmark := ClientDataSet1.GetBookmark;
  rowDelta := -1 + DBGrid1.Row;
  row := ClientDataSet1.RecNo;
  lNow := Now();
  try
    ClientDataSet1.First;
    while not ClientDataSet1.Eof do
    begin
      // c�lcula tempo decorrido desde a abertura do chamado

      { 1 - verifica o intervalo total a ser verificado }
      lInterval := Succ(MillisecondsBetween(
        ClientDataSet1DATAHORACHAMADO.AsDateTime,
        ClientDataSet1DATAHORACHAMADO.AsDateTime +
        TimeOf(ClientDataSet1TEMPORESPONDER.AsDateTime)));

      { 2 - verifica quanto foi decorrido da ocorr�ncia }
      lDiff :=
        MillisecondsBetween(ClientDataSet1DATAHORACHAMADO.AsDateTime, lNow);

      { 3 - calcula o percentual }
      lPerc := Trunc(Min((lDiff / lInterval) * 100.00, 100.00));

      { 4 - ajuste do c�lculo para determinar tamanho da 'barra de progresso' }
      lPerc := lPerc div ClientDataSet1TEMPODECORRIDO.Size;

      // configura 'barra de progresso' para o percentual calculado
      ClientDataSet1.Edit;
      ClientDataSet1TEMPODECORRIDO.AsString :=
        StringOfChar(AStepChars[cboEstiloProgressBar.ItemIndex], lPerc);
      ClientDataSet1.Post;

      // vai para a pr�xima ocorr�ncia a ser atualizada
      ClientDataSet1.Next;
    end;
  finally
    if ClientDataSet1.BookmarkValid(lBookmark) then
      ClientDataSet1.GotoBookmark(lBookmark)
    else
    begin
      ClientDataSet1.RecNo := row;
      ClientDataSet1.MoveBy(-rowDelta);
      ClientDataSet1.MoveBy(rowDelta);
    end;
    ClientDataSet1.FreeBookmark(lBookmark);
    EnableDataControls;
  end;
end;

procedure TfrmTempoChamados.tmrProgressoTimer(Sender: TObject);
begin
  tmrProgresso.Enabled := false;
  try
    UpdateIndicators
  finally
    tmrProgresso.Enabled := true
  end
end;

procedure TfrmTempoChamados.DisableDataControls;
begin
  while not ClientDataSet1.ControlsDisabled do
    ClientDataSet1.DisableControls
end;

procedure TfrmTempoChamados.EnableDataControls;
begin
  while ClientDataSet1.ControlsDisabled do
    ClientDataSet1.EnableControls
end;

procedure TfrmTempoChamados.SetupDataSet;
begin
  with ClientDataSet1 do
  begin
    CreateDataSet;
    AppendRecord(['Problema na impressora', Now(), StrToTime('00:02:00'), EmptyStr]);
    AppendRecord(['Windows n�o inicia', Now(), StrToTime('00:02:30'), EmptyStr]);
    AppendRecord(['Impressora manchando impress�es', Now(), StrToTime('00:01:45'), EmptyStr]);
  end;
end;

procedure TfrmTempoChamados.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
const
  AFontes: array[0..1] of string = ('Webdings', 'Wingdings 2');
  Aligns: array[TAlignment] of integer = (DT_LEFT, DT_RIGHT, DT_CENTER);
var
  lColor: TColor;
  lText: string;
  lRect: TRect;
begin
  //   pega o valor do campo a ser escrito na c�lula
  lText := DBGrid1.DataSource.DataSet.FieldByName(Column.FieldName).DisplayText;

  //   associa a fonte usada pela coluna como fonte do grid para efeito de
  //   escrita do texto
  DBGrid1.Canvas.Font.Assign(Column.Font);

  //   checa se a coluna � que conter� a 'barra de progresso' para
  //   definir a cor certa do texto
  DBGrid1.Canvas.Font.Charset := ANSI_CHARSET;
  if Column.FieldName = ClientDataSet1TEMPODECORRIDO.FieldName then
  begin;
    DBGrid1.Canvas.Font.Name := AFontes[cboEstiloProgressBar.ItemIndex];
    DBGrid1.Canvas.Font.Charset := SYMBOL_CHARSET;
    if Length(lText) = 100 then       // 100% do tempo da resposta
      lColor := clRed
    else if Length(lText) >= 9 then    // acima de 80% sem resposta
      lColor := clOrange
    else if Length(lText) >= 6 then    // acima de 60% sem resposta
      lColor := clLightOrange
    else if Length(lText) >= 3 then    // acima de 40% sem resposta
      lColor := clYellow
    else                               // abaixo de 40% sem resposta
      lColor := clGreen;
    DBGrid1.Canvas.Font.Color := lColor;
  end else if gdSelected in State then
    DBGrid1.Canvas.Font.Color := clCaptionText
  else
    DBGrid1.Canvas.Font.Color := clWindowText;

  //   verifica a cor de fundo adequada para a c�lula de acordo
  //   com o seu estado no grid
  if gdSelected in State then
    DBGrid1.Canvas.Brush.Color := clHotlight
  else
    DBGrid1.Canvas.Brush.Color := clWindow;
  DBGrid1.Canvas.FillRect(Rect);

  //   ajusta �rea de escrita do texto
  lRect := Rect;
  InflateRect(lRect, -1, -1);

  //   desenha o texto com a fun��o DrawText() da API do Windows
  DrawText(DBGrid1.Canvas.Handle, PChar(lText), -1, lRect,
    DT_VCENTER or DT_NOCLIP or DT_SINGLELINE or Aligns[Column.Alignment]);
end;

end.
