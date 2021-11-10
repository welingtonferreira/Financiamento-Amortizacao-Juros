object FPgtoGenerico: TFPgtoGenerico
  Left = 0
  Top = 0
  Caption = 'Simular o Financiamento'
  ClientHeight = 469
  ClientWidth = 798
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object PTop: TPanel
    Left = 0
    Top = 0
    Width = 798
    Height = 51
    Align = alTop
    TabOrder = 0
    object edtCapital: TLabeledEdit
      Left = 16
      Top = 22
      Width = 154
      Height = 21
      Alignment = taRightJustify
      EditLabel.Width = 33
      EditLabel.Height = 13
      EditLabel.Caption = 'Capital'
      NumbersOnly = True
      TabOrder = 0
    end
    object edtPeriodos: TLabeledEdit
      Left = 176
      Top = 22
      Width = 121
      Height = 21
      Alignment = taRightJustify
      EditLabel.Width = 30
      EditLabel.Height = 13
      EditLabel.Caption = 'Meses'
      NumbersOnly = True
      TabOrder = 1
    end
    object edtTaxaJuros: TLabeledEdit
      Left = 303
      Top = 22
      Width = 121
      Height = 21
      Alignment = taRightJustify
      EditLabel.Width = 53
      EditLabel.Height = 13
      EditLabel.Caption = 'Taxa Juros'
      NumbersOnly = True
      TabOrder = 2
    end
    object btnSimular: TButton
      Left = 430
      Top = 7
      Width = 129
      Height = 36
      Caption = 'Simular Financiamento'
      TabOrder = 3
      OnClick = btnSimularClick
    end
  end
  object lvDetalles: TListView
    Left = 0
    Top = 51
    Width = 798
    Height = 418
    Align = alClient
    Columns = <
      item
        Caption = 'N'
      end
      item
        Alignment = taRightJustify
        AutoSize = True
        Caption = 'Juros'
      end
      item
        Alignment = taRightJustify
        AutoSize = True
        Caption = 'Amortiza'#231#227'o Saldo Devedor'
      end
      item
        Alignment = taRightJustify
        AutoSize = True
        Caption = 'Pagamento'
      end
      item
        Alignment = taRightJustify
        AutoSize = True
        Caption = 'Saldo Devedor'
      end>
    ColumnClick = False
    GridLines = True
    Groups = <
      item
        Header = 'Inicial'
        GroupID = 0
        State = [lgsNormal]
        HeaderAlign = taLeftJustify
        FooterAlign = taLeftJustify
        TitleImage = -1
      end
      item
        Header = 'Meses'
        GroupID = 1
        State = [lgsNormal]
        HeaderAlign = taLeftJustify
        FooterAlign = taLeftJustify
        TitleImage = -1
      end
      item
        Header = 'Final'
        GroupID = 2
        State = [lgsNormal]
        HeaderAlign = taLeftJustify
        FooterAlign = taLeftJustify
        TitleImage = -1
      end>
    HotTrack = True
    HotTrackStyles = [htHandPoint]
    Items.ItemData = {
      05520000000100000000000000FFFFFFFFFFFFFFFF0400000000000000000000
      0001300003310031003100407AFA3003320032003200F868FA30033200320032
      00586DFA300432003200320032000888FA30FFFFFFFFFFFFFFFF}
    GroupView = True
    RowSelect = True
    TabOrder = 1
    ViewStyle = vsReport
    ExplicitTop = 57
  end
end
