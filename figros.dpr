program figros;

uses
  Forms,
  Unit1 in 'Unit1.pas' {fMain},
  Unit2 in 'Unit2.pas' {fResult},
  Unit3 in 'Unit3.pas' {fDiff};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Figros';
  Application.CreateForm(TfMain, fMain);
  Application.CreateForm(TfDiff, fDiff);
  Application.CreateForm(TfResult, fResult);
  Application.Run;
end.
