object frmTempoChamados: TfrmTempoChamados
  Left = 0
  Top = 136
  Width = 642
  Height = 451
  Caption = 'Experi'#234'ncia - DBGrid com ProgressBar'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000008888800000000000000000000000008844444880000000000000000
    0000008447777744800000000000000000000844444444444800000000000000
    0000844444444444448000000000000000008444444444444480000000000000
    000844444E444444444800000000000000084444E44444444448000000000000
    0008444E6E44444444480000000000000008444CECECCCCC4448000000000000
    00084CCE6ECCCCCCCC4800000000000000008CCCE6ECCCCCCC80000000000000
    000088FCCECCCCCCF8800000000000000000088F8F8F8F8F8800000000000000
    00000088FFF8F8F88000000000000000000000088FFF8F880000000000000000
    0000000088FFF8800000000000000000000000007F8F8F700000000000000000
    0000000008FFF800000000000000000000000000088F88000000000000000000
    0000000008FFF800000000000000000000000000088F88000000000000000000
    0000000008FFF800000000000000000000000000088F88000000000000000000
    0000000008F87700000000000000000000000007888888870000000000000000
    0000000887777788000000000000000000000007788888770000000000000000
    000000000000000000000000000000000000000000000000000000000000FFFF
    FFFFFFF83FFFFFE00FFFFFC007FFFF8003FFFF0001FFFE0000FFFE0000FFFC00
    007FFC00007FFC00007FFC00007FFC00007FFE0000FFFE0000FFFF0001FFFF80
    03FFFFC007FFFFE00FFFFFE00FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF0
    1FFFFFF01FFFFFE00FFFFFC007FFFFC007FFFFC007FFFFE00FFFFFFFFFFF}
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 393
    Width = 139
    Height = 13
    Caption = 'Estilo da Barra de Progresso:'
  end
  object Button1: TButton
    Left = 550
    Top = 384
    Width = 75
    Height = 25
    Caption = 'Fechar'
    Default = True
    TabOrder = 0
    OnClick = Button1Click
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 8
    Width = 617
    Height = 369
    DataSource = DataSource1
    DefaultDrawing = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    TabOrder = 1
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDrawColumnCell = DBGrid1DrawColumnCell
    Columns = <
      item
        Expanded = False
        FieldName = 'PROBLEMA'
        Title.Alignment = taCenter
        Width = 220
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATAHORACHAMADO'
        Title.Alignment = taCenter
        Width = 132
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TEMPORESPONDER'
        Title.Alignment = taCenter
        Width = 107
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TEMPODECORRIDO'
        Title.Alignment = taCenter
        Width = 119
        Visible = True
      end>
  end
  object cboEstiloProgressBar: TComboBox
    Left = 156
    Top = 389
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 2
    Text = 'S'#243'lida'
    Items.Strings = (
      'S'#243'lida'
      'Segmentada')
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 224
    Top = 264
    object ClientDataSet1PROBLEMA: TStringField
      DisplayLabel = 'Problema'
      FieldName = 'PROBLEMA'
      Size = 100
    end
    object ClientDataSet1DATAHORACHAMADO: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Data-Hora Chamado'
      FieldName = 'DATAHORACHAMADO'
      DisplayFormat = 'dd/mm/yyyy hh:mm:ss'
    end
    object ClientDataSet1TEMPORESPONDER: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Tempo a Responder'
      FieldName = 'TEMPORESPONDER'
      DisplayFormat = 'hh:mm:ss'
    end
    object ClientDataSet1TEMPODECORRIDO: TStringField
      DisplayLabel = 'Tempo Decorrido'
      FieldKind = fkInternalCalc
      FieldName = 'TEMPODECORRIDO'
      ProviderFlags = []
      Size = 10
    end
  end
  object DataSource1: TDataSource
    AutoEdit = False
    DataSet = ClientDataSet1
    Left = 320
    Top = 264
  end
  object tmrProgresso: TTimer
    Enabled = False
    OnTimer = tmrProgressoTimer
    Left = 416
    Top = 264
  end
end
