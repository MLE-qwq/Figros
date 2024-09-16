unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, MPlayer;

type
  TfResult = class(TForm)
    lScore: TLabel;
    lLevel: TLabel;
    Timer1: TTimer;
    snd: TMediaPlayer;
    Timer2: TTimer;
    ap: TImage;
    bRetry: TButton;
    bQuit: TButton;
    lDiff: TLabel;
    lRecord: TLabel;
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure bRetryClick(Sender: TObject);
    procedure bQuitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fResult: TfResult;

implementation

{$R *.dfm}

procedure TfResult.Timer1Timer(Sender: TObject);
begin
  lScore.Left:=(136+lSCORE.Left) div 2;
  lRecord.Left:=lScore.Left+lScore.Width-lRecord.Width-4;
  if (lScore.Left=136) then begin
    timer1.Enabled:=false;
    lLevel.Visible:=true;
    ap.Visible:=true;
  end;
end;

procedure TfResult.Timer2Timer(Sender: TObject);
begin
  if (snd.Position>=snd.Length-100) then begin
    timer2.Enabled:=false;
    snd.Position:=0;
    snd.Play;
    timer2.Enabled:=true;
  end;
end;

procedure TfResult.bRetryClick(Sender: TObject);
begin
  WinExec(PChar(Application.Exename),SW_SHOWNORMAL);
  Application.Terminate;
end;

procedure TfResult.bQuitClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfResult.FormCreate(Sender: TObject);
begin
  Self.DoubleBuffered:=true;
  Width:=434;
end;

procedure TfResult.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  Application.Terminate;
end;

end.
