unit uFrmGenericoPgto;

interface

uses
  Sistemas.Controller, Sistemas.Dados, Sistemas.PagamentoUnico,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls;

type
  TFPgtoGenericoClazz = class of TFPgtoGenerico;
  TFPgtoGenerico = class(TForm)
    PTop: TPanel;
    lvDetalles: TListView;
    edtCapital: TLabeledEdit;
    edtPeriodos: TLabeledEdit;
    edtTaxaJuros: TLabeledEdit;
    btnSimular: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSimularClick(Sender: TObject);
  private
    class constructor Create();
  protected
    FSistemaClazz: TSistemaServiceClazz;
    FSistema: TSistemaService;

    procedure DoInicializaForm();
    procedure DoInitViewControls();
    procedure DoExibeDadosCotas(pCotas: TListaCotas);

    procedure simularFinanciamento();

    destructor Destroy(); override;
  public
    class function CriaFormFor(pMainForm: TForm; pSistemaClazz: TSistemaServiceClazz): TFPgtoGenerico;
  end;

  //todo criar View Controler Generico <T: class>
  TSistemaCotaHelper = class helper for TSistemaCota
  public
    function ToString(): String;
    //conversores de moeda -> string
    function JurosToString(): String;
    function AmortizacaoToString(): String;
    function PagamentoToString(): String;
    function SaldoDevedorToString(): String;
  end;

var
  FPgtoGenerico: TFPgtoGenerico;

implementation

{$R *.dfm}

class constructor TFPgtoGenerico.Create;
var
  clazz: TSistemaServiceClazz;
begin
  try
    TSistemaController.Instance.RegistraFormFor(TSistemaPgtoUnicoService, TFPgtoGenerico);
  except
    on E: Exception do
    begin
      ShowMessage('class constructor TFPgtoGenerico.Create' + #13 + E.Message);
    end;
  end;
end;

class function TFPgtoGenerico.CriaFormFor(pMainForm: TForm; pSistemaClazz: TSistemaServiceClazz): TFPgtoGenerico;
begin
  try
    Result := TFPgtoGenerico.Create(pMainForm);
    with Result do
    begin
      FSistemaClazz := pSistemaClazz;
      DoInicializaForm();
    end;
  except
    on E: Exception do
    begin
      ShowMessage('TFPgtoGenerico.CriaFormFor' + #13 + E.Message);
    end;
  end;
end;

destructor TFPgtoGenerico.Destroy;
begin
  try
    FSistema.Free();
    inherited Destroy();
  except
    on E: Exception do
    begin
      ShowMessage('TFPgtoGenerico.Destroy' + #13 + E.Message);
    end;
  end;
end;

procedure TFPgtoGenerico.DoInicializaForm();
begin
  try
    Caption := FSistemaClazz.GetNomeSistema();
    FSistema := FSistemaClazz.LazyLoadIt();
    DoInitViewControls();

    Show();
  except
    on E: Exception do
    begin
      ShowMessage('TFPgtoGenerico.DoInicializaForm()' + #13 + E.Message);
    end;
  end;
end;

procedure TFPgtoGenerico.DoInitViewControls;
begin
  try
    lvDetalles.Clear();
  except
    on E: Exception do
    begin
      ShowMessage('TFPgtoGenerico.DoInitViewControls' + #13 + E.Message);
    end;
  end;
end;

procedure TFPgtoGenerico.DoExibeDadosCotas(pCotas: TListaCotas);

  procedure AddItemLista(ACaption: String; AitemConta: TSistemaCota);
  begin
    //add item
    with lvDetalles.Items.Add() do
    begin
      Caption := ACaption;
      SubItems.Add(AitemConta.JurosToString());
      SubItems.Add(AitemConta.AmortizacaoToString());
      SubItems.Add(AitemConta.PagamentoToString());
      SubItems.Add(AitemConta.SaldoDevedorToString());
      Data := nil;

      case AitemConta.NumCota of
        0: GroupID := 0;
        TSistemaService.C_NUM_COTA_TOTAL: GroupID := 2;
        else GroupID := 1;
      end;
    end;
  end;
var
  vCota: TSistemaCota;
  vCotaTotal: TSistemaCota;
begin
  try
    lvDetalles.Clear();

    for vCota in pCotas do
    begin
      AddItemLista(IntToStr(vCota.NumCota), vCota);
    end;
    //add total financiamento - com base na ultima cota e no servico
    vCotaTotal := FSistema.CalculaCotaDeTotais();
    AddItemLista('Totais', vCotaTotal);
    vCotaTotal.Free();
  except
    on E: Exception do
    begin
      ShowMessage('TFPgtoGenerico.DoExibeDadosCotas' + #13 + E.Message);
    end;
  end;
end;

procedure TFPgtoGenerico.simularFinanciamento();
var
  vDados: TListaCotas;
  vCapital, vTaxa: Extended;
  vCotas: Word;
begin
  try
    vCapital := StrToFloatDef(edtCapital.Text, 0.0);
    vTaxa := StrToFloatDef(edtTaxaJuros.Text, 0.0);
    vCotas := StrToIntDef(edtPeriodos.Text, 0);

    Assert(vCapital > 0, 'Capital deve ter valor superior a 0.');
    Assert(vTaxa > 0, 'Taxa deve ter valor superior a 0.');
    Assert(vCotas > 0, 'Periodos deve ter valor superior a 0.');

    vDados := FSistema.CalculaCotasFinanciamento(vCapital, vTaxa, vCotas);
    DoExibeDadosCotas(vDados);
    vDados.Free();
  except
    on E: Exception do
    begin
      ShowMessage('TFPgtoGenerico.DoExibeDadosCotas' + #13 + E.Message);
    end;
  end;
end;

procedure TFPgtoGenerico.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  try
    Action := caFree;
  except
    on E: Exception do
    begin
      ShowMessage('TFPgtoGenerico.FormClose' + #13 + E.Message);
    end;
  end;
end;

procedure TFPgtoGenerico.btnSimularClick(Sender: TObject);
begin
  try
    simularFinanciamento();
  except
    on E: Exception do
    begin
      ShowMessage('TFPgtoGenerico.btnSimularClick' + #13 + E.Message);
    end;
  end;
end;

{ TSistemaCotaHelper }
function TSistemaCotaHelper.AmortizacaoToString: String;
begin
  try
    Result := FormatCurr(',0.00', Self.Amortizacao);
  except
    on E: Exception do
    begin
      ShowMessage('TSistemaCotaHelper.AmortizacaoToString' + #13 + E.Message);
    end;
  end;
end;

function TSistemaCotaHelper.JurosToString: String;
begin
  try
    Result := FormatCurr(',0.00', Self.Juros);
  except
    on E: Exception do
    begin
      ShowMessage('TSistemaCotaHelper.JurosToString' + #13 + E.Message);
    end;
  end;
end;

function TSistemaCotaHelper.PagamentoToString: String;
begin
  try
    Result := FormatCurr(',0.00', Self.Pagamento);
  except
    on E: Exception do
    begin
      ShowMessage('TSistemaCotaHelper.PagamentoToString' + #13 + E.Message);
    end;
  end;
end;

function TSistemaCotaHelper.SaldoDevedorToString: String;
begin
  try
    Result := FormatCurr(',0.00', Self.SaldoDevedor);
  except
    on E: Exception do
    begin
      ShowMessage('TSistemaCotaHelper.SaldoDevedorToString' + #13 + E.Message);
    end;
  end;
end;

function TSistemaCotaHelper.ToString: String;
begin
  try
    Result := Format('#%d, J:%s, A:%s, P:%s, S:%s', [
                Self.NumCota,
                Self.JurosToString,
                Self.AmortizacaoToString,
                Self.PagamentoToString,
                Self.SaldoDevedorToString
               ]);
  except
    on E: Exception do
    begin
      ShowMessage('TSistemaCotaHelper.ToString' + #13 + E.Message);
    end;
  end;
end;

end.
