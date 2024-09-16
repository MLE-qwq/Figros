unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, MPlayer;

type
  TfDiff = class(TForm)
    Panel1: TPanel;
    b1: TButton;
    b2: TButton;
    b3: TButton;
    b4: TButton;
    b5: TButton;
    b6: TButton;
    b8: TButton;
    b7: TButton;
    b9: TButton;
    b10: TButton;
    b0: TButton;
    bQuit: TButton;
    bCustom: TButton;
    Panel2: TPanel;
    tNote: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    tTL: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    bCusStart: TButton;
    bFold: TButton;
    tExpand: TTimer;
    tFold: TTimer;
    snd: TMediaPlayer;
    tSnd: TTimer;
    tSndCD: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure tExpandTimer(Sender: TObject);
    procedure bCustomClick(Sender: TObject);
    procedure bFoldClick(Sender: TObject);
    procedure tFoldTimer(Sender: TObject);
    procedure bQuitClick(Sender: TObject);
    procedure bCusStartClick(Sender: TObject);
    procedure b0Click(Sender: TObject);
    procedure b1Click(Sender: TObject);
    procedure b2Click(Sender: TObject);
    procedure b3Click(Sender: TObject);
    procedure b4Click(Sender: TObject);
    procedure b5Click(Sender: TObject);
    procedure b6Click(Sender: TObject);
    procedure b7Click(Sender: TObject);
    procedure b8Click(Sender: TObject);
    procedure b9Click(Sender: TObject);
    procedure b10Click(Sender: TObject);
    procedure tSndTimer(Sender: TObject);
    procedure tSndCDTimer(Sender: TObject);
    procedure CreateDump(s:string);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fDiff: TfDiff;

implementation

uses Unit1, Unit2;

{$R *.dfm}

procedure TfDiff.CreateDump(s:string);
var
  ts:TStringList;
begin
  ts:=TStringList.Create;
  try
    CreateDirectory(PChar(ExtractFilePath(Application.ExeName)+'\.figros\records\'),nil);
    ts.Add('Figros_Lastplayed_Format');
    ts.Add(trim(s));
    ts.SaveToFile(ExtractFilePath(Application.ExeName)+'\.figros\records\last_played.mqdata');
  except
    MessageBox(Handle,'Error: Failed to create dump. ','Figros',16);
  end;
  ts.Free;
end;

procedure TfDiff.FormCreate(Sender: TObject);
var
  ts:TStringList;
begin
  Self.DoubleBuffered:=false;
  ClientWidth:=428;
  ClientHeight:=410;
  Left:=Screen.Width div 2 - width div 2;
  Top:=Screen.Height div 2 - height div 2;
  ts:=TStringList.Create;
  if (FIleExists(ExtractFilePath(Application.ExeName)+'\.figros\records\last_played.mqdata')) then begin
    ts.LoadFromFile(ExtractFilePath(Application.ExeName)+'\.figros\records\last_played.mqdata');
    if (trim(ts[1])='tutorial') then begin
      b0.Caption:='> '+b0.Caption+' <';
      b0.Font.Style:=[fsBold];
    end;
    if (trim(ts[1])='peaceful') then begin
      b1.Caption:='> '+b1.Caption+' <';
      b1.Font.Style:=[fsBold];
    end;
    if (trim(ts[1])='easy') then begin
      b2.Caption:='> '+b2.Caption+' <';
      b2.Font.Style:=[fsBold];
    end;
    if (trim(ts[1])='mild') then begin
      b3.Caption:='> '+b3.Caption+' <';
      b3.Font.Style:=[fsBold];
    end;
    if (trim(ts[1])='moderate') then begin
      b4.Caption:='> '+b4.Caption+' <';
      b4.Font.Style:=[fsBold];
    end;
    if (trim(ts[1])='normal') then begin
      b5.Caption:='> '+b5.Caption+' <';
      b5.Font.Style:=[fsBold];
    end;
    if (trim(ts[1])='hard') then begin
      b6.Caption:='> '+b6.Caption+' <';
      b6.Font.Style:=[fsBold];
    end;
    if (trim(ts[1])='very_hard') then begin
      b7.Caption:='> '+b7.Caption+' <';
      b7.Font.Style:=[fsBold];
    end;
    if (trim(ts[1])='demon') then begin
      b8.Caption:='> '+b8.Caption+' <';
      b8.Font.Style:=[fsBold];
    end;
    if (trim(ts[1])='extreme') then begin
      b9.Caption:='> '+b9.Caption+' <';
      b9.Font.Style:=[fsBold];
    end;
    if (trim(ts[1])='next_to_impossible') then begin
      b10.Caption:='> '+b10.Caption+' <';
      b10.Font.Style:=[fsBold];
    end;
  end;
  ts.Free;  
  CreateDump('customize');
end;

procedure TfDiff.tExpandTimer(Sender: TObject);
begin
  ClientWidth:=ClientWidth+10;
  Left:=Left-5;
  if (ClientWidth>=654) then begin
    Left:=Left+ClientWidth-654;
    ClientWidth:=654;
    tExpand.Enabled:=false;
    bFold.Enabled:=true;
    tNote.Enabled:=true;
    tTL.Enabled:=true;
    bCusStart.Enabled:=true;
  end;
end;

procedure TfDiff.bCustomClick(Sender: TObject);
begin
  tExpand.Enabled:=true;
  bCustom.Enabled:=false;
end;

procedure TfDiff.bFoldClick(Sender: TObject);
begin
  tFold.Enabled:=true;  
  bFold.Enabled:=false;
  tNote.Enabled:=false;
  tTL.Enabled:=false;
  bCusStart.Enabled:=false;
end;

procedure TfDiff.tFoldTimer(Sender: TObject);
begin
  ClientWidth:=ClientWidth-10;
  Left:=Left+5;
  if (ClientWidth<=428) then begin
    Left:=Left-(428-ClientWidth);
    ClientWidth:=428;
    tFold.Enabled:=false;
    bCustom.Enabled:=true;
  end;
end;

procedure TfDiff.bQuitClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfDiff.bCusStartClick(Sender: TObject);
begin
  try
    fMain.maxlvls:=strtoint(tNote.Text);
    fMain.tm:=strtoint(tTL.Text);
    if (fMain.maxlvls<=0) or (fMain.maxlvls>8388608) then StrtoInt('Error');
    if (fMain.tm<=0) then StrtoInt('Error');
    SetCursorPos(0,0);
    if fResult.lDiff.Caption='' then
      fResult.lDiff.Caption:='CUSTOMIZED ('+inttostr(fMain.maxlvls)+', '+inttostr(fMain.tm)+' ms) Lv.?';
    fMain.left:=screen.Width div 2 - fMain.width div 2;
    fMain.top:=screen.HEight div 2 - fMain.height div 2;
    fMain.Show;
    Hide;
  except
    MessageBox(Handle,'Error: The note count must be an integer in the range of 1 and 2^23 while the minimum time limit must be an integer greater than 0. ','Figros',16);
  end;
end;

procedure TfDiff.b0Click(Sender: TObject);
begin
  CreateDump('tutorial');
  fResult.lDiff.Caption:='TUTORIAL Lv.0';
  tNote.Text:='11';
  tTL.Text:='1500';
  bCusStart.Click;
end;

procedure TfDiff.b1Click(Sender: TObject);
begin          
  CreateDump('peaceful');        
  fResult.lDiff.Caption:='PEACEFUL Lv.1';
  tNote.Text:='21';
  tTL.Text:='1000';
  bCusStart.Click;
end;

procedure TfDiff.b2Click(Sender: TObject);
begin           
  CreateDump('easy'); 
  fResult.lDiff.Caption:='EZ Lv.2';
  tNote.Text:='31';
  tTL.Text:='800';
  bCusStart.Click;
end;

procedure TfDiff.b3Click(Sender: TObject);
begin           
  CreateDump('mild');               
  fResult.lDiff.Caption:='MILD Lv.3';
  tNote.Text:='41';
  tTL.Text:='750';
  bCusStart.Click;
end;

procedure TfDiff.b4Click(Sender: TObject);
begin          
  CreateDump('moderate');       
  fResult.lDiff.Caption:='MODERATE Lv.4';
  tNote.Text:='51';
  tTL.Text:='700';
  bCusStart.Click;
end;

procedure TfDiff.b5Click(Sender: TObject);
begin          
  CreateDump('normal');          
  fResult.lDiff.Caption:='NORMAL Lv.5';
  tNote.Text:='61';
  tTL.Text:='650';
  bCusStart.Click;
end;

procedure TfDiff.b6Click(Sender: TObject);
begin         
  CreateDump('hard');           
  fResult.lDiff.Caption:='HARD Lv.6';
  tNote.Text:='71';
  tTL.Text:='600';
  bCusStart.Click;
end;

procedure TfDiff.b7Click(Sender: TObject);
begin    
  CreateDump('very_hard');                  
  fResult.lDiff.Caption:='HARD+ Lv.7';
  tNote.Text:='81';
  tTL.Text:='550';
  bCusStart.Click;
end;

procedure TfDiff.b8Click(Sender: TObject);
begin    
  CreateDump('demon');         
  fResult.lDiff.Caption:='DEMON Lv.8';
  tNote.Text:='91';
  tTL.Text:='500';
  bCusStart.Click;
end;

procedure TfDiff.b9Click(Sender: TObject);
begin   
  CreateDump('extreme');
  fResult.lDiff.Caption:='EXTREME Lv.9';
  tNote.Text:='101';
  tTL.Text:='450';
  bCusStart.Click;
end;

procedure TfDiff.b10Click(Sender: TObject);
begin  
  CreateDump('next_to_impossible');
  fResult.lDiff.Caption:='NEXT TO IMPOSSIBLE Lv.10';
  tNote.Text:='114';
  tTL.Text:='400';
  bCusStart.Click;
end;

procedure TfDiff.tSndTimer(Sender: TObject);
begin
  if (snd.Position>=snd.Length-100) then begin
    tSnd.Enabled:=false;
    snd.Position:=0;
    snd.Play;
    tSnd.Enabled:=true;
  end;
end;

procedure TfDiff.tSndCDTimer(Sender: TObject);
begin
  tSndCD.Enabled:=false;
  snd.FileName:=ExtractFilePath(Application.ExeName)+'\.figros\assets\title.mp3';
  snd.Open;
  snd.Play;
  tSnd.Enabled:=true;
end;

procedure TfDiff.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  Application.Terminate;
end;

end.
