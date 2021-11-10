program SimularFinanciamento;

uses
  Vcl.Forms,
  uFrmMain in 'uFrmMain.pas' {FMain},
  uFrmGenericoPgto in 'uFrmGenericoPgto.pas' {FPgtoGenerico},
  Sistemas.Controller in 'Sistemas\Sistemas.Controller.pas',
  Sistemas.PagamentoUnico in 'Sistemas\Sistemas.PagamentoUnico.pas',
  Sistemas.Dados in 'Sistemas\Sistemas.Dados.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFMain, FMain);
  Application.Run;
end.
