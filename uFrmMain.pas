unit uFrmMain;

interface

uses
  Sistemas.Controller,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus;

type
  TFMain = class(TForm)
    MainMenuPrincipal: TMainMenu;
    MenuItemSimulacoes: TMenuItem;
    procedure FormCreate(Sender: TObject);
  private
    procedure BindaListaSistemas();
    procedure DoCriaNovoSistema(Sender: TObject);
  public
    { Public declarations }
  end;

var
  FMain: TFMain;

implementation

{$R *.dfm}

uses
  uFrmGenericoPgto;

procedure TFMain.BindaListaSistemas();
var
  clazz: TSistemaServiceClazz;
  newItem: TMenuItem;
begin
  try
    for clazz in TSistemaController.Instance.GetSistemas() do
    begin
      newItem := MainMenuPrincipal.CreateMenuItem();
      with newItem do
      begin
        Caption := clazz.GetNomeSistema();
        Tag := Cardinal(clazz);
        OnClick := DoCriaNovoSistema;
      end;
      MenuItemSimulacoes.Add(newItem);
    end;
  except
    on E: Exception do
    begin
      ShowMessage('TFMain.BindaListaSistemas()' + #13 + E.Message);
    end;
  end;
end;

procedure TFMain.DoCriaNovoSistema(Sender: TObject);
var
  clazz: TSistemaServiceClazz;
begin
  try
    clazz := TSistemaServiceClazz(Cardinal(TMenuItem(Sender).Tag));
    TFPgtoGenerico.CriaFormFor(Self, clazz);
  except
    on E: Exception do
    begin
      ShowMessage('TFMain.DoCriaNovoSistema' + #13 + E.Message);
    end;
  end;
end;

procedure TFMain.FormCreate(Sender: TObject);
begin
  try
    BindaListaSistemas();
  except
    on E: Exception do
    begin
      ShowMessage('TFMain.FormCreate' + #13 + E.Message);
    end;
  end;
end;

end.
