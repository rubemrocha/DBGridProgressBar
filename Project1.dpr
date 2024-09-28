program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {frmTempoChamados};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmTempoChamados, frmTempoChamados);
  Application.Run;
end.
