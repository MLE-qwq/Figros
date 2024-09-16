unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, MMsystem;

type
  TfMain = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Timer1: TTimer;
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure processRecords;
  private
    { Private declarations }
  public
    timeout,lvl,maxlvls,tm:integer;
  end;

var
  fMain: TfMain;

implementation

uses Unit2, Unit3;

{$R *.dfm}

function tofilename(s:string):string;
var
  i:integer;
begin
  s:=trim(s);
  for i:=1 to length(s) do begin
    if (s[i]=' ') or (s[i]='.') or (s[i]='\') or (s[i]='/') or (s[i]=':') or (s[i]='*') or (s[i]='?') or (s[i]='"') or (s[i]='''') or (s[i]='<') or (s[i]='>') or (s[i]='|') then begin
      s[i]:='_';
    end;
  end;
  Result:=trim(s);
end;

function scoretostr(n:integer):string;
var
  s:string;
begin
  s:=inttostr(n);
  while (length(s)<7) do
    s:='0'+s;
  Result:=s;
end;

procedure TfMain.processRecords;
var
  ts:TStringList;
  tg:string;
  b:boolean;
  old:integer;
begin
  ts:=TStringList.Create;
  b:=true;
  old:=0;
  tg:=ExtractFilePath(Application.ExeName)+'\.figros\records\'+tofilename(fResult.lDiff.Caption)+'.mqdata';
  if (FileExists(tg)) then begin
    try
      ts.LoadFromFile(tg);
      old:=strtoint(ts[1]);
    except
      MessageBox(Handle,'Error: Failed to LOAD record. ','Figros',16);
    end;
  end
  else begin
    old:=0;
  end;

  if (old>=lvl*1000000 div maxlvls) then begin
    fResult.lRecord.Font.Style:=[];
    if (old=lvl*1000000 div maxlvls) then
      fResult.lRecord.Caption:='BEST '+scoretostr(old)+' (+'+scoretostr(old-(lvl*1000000 div maxlvls))+')'
    else
      fResult.lRecord.Caption:='BEST '+scoretostr(old)+' (-'+scoretostr(old-(lvl*1000000 div maxlvls))+')';
    if (old=1000000) then
      fResult.lRecord.Font.Color:=rgb(255,255,100)
    else if (old>900000) then
      fResult.lRecord.Font.Color:=rgb(100,255,255)
    else
      fResult.lRecord.Font.Color:=clWhite;
  end
  else begin
    fResult.lRecord.Font.Style:=[];
    fResult.lRecord.Caption:='NEW RECORD '+scoretostr(lvl*1000000 div maxlvls)+' (+'+scoretostr((lvl*1000000 div maxlvls)-old)+')';
    if (lvl*1000000 div maxlvls=1000000) then
      fResult.lRecord.Font.Color:=rgb(255,255,100)
    else if (lvl*1000000 div maxlvls>900000) then
      fResult.lRecord.Font.Color:=rgb(100,255,255)
    else
      fResult.lRecord.Font.Color:=clWhite;
  end;
  ts.Clear;
  ts.Add('Figros_Record_Format');
  if (lvl*1000000 div maxlvls>old) then
    ts.Add(inttostr(lvl*1000000 div maxlvls))
  else
    ts.Add(inttostr(old)); 
  try
    CreateDirectory(PChar(ExtractFilePath(Application.ExeName)+'\.figros\records\'),nil);
    ts.SaveToFile(tg);
  except
    MessageBox(Handle,'Error: Failed to SAVE record. ','Figros',16);
  end;
  ts.Free;
end;

procedure TfMain.Button2Click(Sender: TObject);
begin
  try
    if fDiff.tSnd.Enabled then begin
      fDiff.tSnd.Enabled:=false;
      fDiff.snd.Pause;
    end;
  except
  end;
  button1.SetFocus;
  lvl:=lvl+1;
  Button2.Width:=(180*(maxlvls*12 div 10-lvl)) div maxlvls;
  Button2.HEight:=(100*(maxlvls*12 div 10-lvl)) div maxlvls;
  timer1.Enabled:=false;
  timeout:=(1500*(maxlvls-lvl)) div maxlvls div 100 * 100;
  if (timeout<tm) then
    timeout:=tm;
  Button2.Caption:=inttostr(lvl)+'/'+inttostr(maxlvls)+', '+inttostr(timeout)+' ms';
  if (lvl>=maxlvls) then begin
    Timer1.Enabled:=false;
    processRecords;
    if (lvl=maxlvls) then
      fResult.snd.FileName:=Extractfilepath(Application.ExeName)+'\.figros\assets\ending.wav'
    else if (lvl*1000000 div maxlvls>=600000) then
      fResult.snd.FileName:=Extractfilepath(Application.ExeName)+'\.figros\assets\ending1.wav'
    else
      fResult.snd.FileName:=Extractfilepath(Application.ExeName)+'\.figros\assets\ending2.wav';
    fResult.snd.Open;
    fResult.snd.Play;            
    fResult.Timer2.Enabled:=true;
    fResult.Left:=Screen.Width div 2 - fResult.Width div 2;
    fResult.Top:=Screen.Height div 2 - fResult.Height div 2;
    fResult.lScore.Caption:=inttostr(lvl*1000000 div maxlvls);
    fResult.ap.Left:=-1145;
    while (length(fResult.lScore.Caption)<7) do
      fResult.lScore.Caption:='0'+fResult.lScore.Caption;
    if (lvl*1000000 div maxlvls=1000000) then begin
      fResult.lLevel.Left:=-1145;
      fResult.ap.Left:=56;          
      fResult.lScore.Font.Color:=rgb(255,255,100);
    end
    else if (lvl*1000000 div maxlvls>=900000) then begin
      fResult.lLevel.Caption:='V';
      fResult.lLevel.Font.Color:=rgb(100,255,255);
      fResult.lScore.Font.Color:=rgb(100,255,255);
    end
    else if (lvl*1000000 div maxlvls>=800000) then
      fResult.lLevel.Caption:='S'
    else if (lvl*1000000 div maxlvls>=700000) then
      fResult.lLevel.Caption:='A'           
    else if (lvl*1000000 div maxlvls>=600000) then
      fResult.lLevel.Caption:='B'
    else if (lvl*1000000 div maxlvls>=500000) then
      fResult.lLevel.Caption:='C'
    else if (lvl*1000000 div maxlvls>=400000) then
      fResult.lLevel.Caption:='D'
    else if (lvl*1000000 div maxlvls>=300000) then
      fResult.lLevel.Caption:='E'
    else
      fResult.lLevel.Caption:='F';
    fResult.Timer1.Enabled:=true;
    fResult.Show;
    Hide;
    exit;
  end;
  Randomize;
  sndPlaySound(PCHar(Extractfilepath(Application.ExeName)+'\.figros\assets\hit'+inttostr(random(3))+'.wav'),SND_ASYNC);

  Left:=Random(Screen.Width-Width);
  Top:=Random(Screen.Height-Height);
  timer1.Enabled:=true;
end;

procedure TfMain.FormCreate(Sender: TObject);
begin
  maxlvls:=67;
  tm:=600;
  button2.Caption:='MOVE MOUSE HERE TO START';
end;

procedure TfMain.Timer1Timer(Sender: TObject);
begin
  timeout:=timeout-50;
  if (timeout<=0) then timeout:=0;
  if (Button2.Width>=114) then
    Button2.Caption:=inttostr(lvl)+'/'+inttostr(maxlvls)+', '+inttostr(timeout)+' ms'
  else if (Button2.Width>=89) then
    Button2.Caption:=inttostr(lvl)+'/'+inttostr(maxlvls)+','+inttostr(timeout)
  else if (Button2.Width>=57) then
    Button2.Caption:=inttostr(lvl)+','+inttostr(timeout)
  else
    Button2.Caption:=inttostr(lvl);
  Application.ProcessMessages;
  if (timeout<=0) then begin
    Timer1.Enabled:=false; 
    processRecords;
    if (lvl=maxlvls) then
      fResult.snd.FileName:=Extractfilepath(Application.ExeName)+'\.figros\assets\ending.wav'
    else if (lvl*1000000 div maxlvls>=600000) then
      fResult.snd.FileName:=Extractfilepath(Application.ExeName)+'\.figros\assets\ending1.wav'
    else
      fResult.snd.FileName:=Extractfilepath(Application.ExeName)+'\.figros\assets\ending2.wav';
    fResult.snd.Open;
    fResult.snd.Play;
    fResult.Timer2.Enabled:=true;
    fResult.Left:=Screen.Width div 2 - fResult.Width div 2;
    fResult.Top:=Screen.Height div 2 - fResult.Height div 2;
    fResult.lScore.Caption:=inttostr(lvl*1000000 div maxlvls);
    fResult.ap.Left:=-1145;
    while (length(fResult.lScore.Caption)<7) do
      fResult.lScore.Caption:='0'+fResult.lScore.Caption;
    if (lvl*1000000 div maxlvls=1000000) then begin
      fResult.lLevel.Left:=-1145;
      fResult.ap.Left:=56;
      fResult.lScore.Font.Color:=rgb(255,255,100);
    end
    else if (lvl*1000000 div maxlvls>=900000) then begin
      fResult.lLevel.Caption:='V';
      fResult.lLevel.Font.Color:=rgb(100,255,255);
      fResult.lScore.Font.Color:=rgb(100,255,255);
    end
    else if (lvl*1000000 div maxlvls>=800000) then
      fResult.lLevel.Caption:='S'
    else if (lvl*1000000 div maxlvls>=700000) then
      fResult.lLevel.Caption:='A'           
    else if (lvl*1000000 div maxlvls>=600000) then
      fResult.lLevel.Caption:='B'
    else if (lvl*1000000 div maxlvls>=500000) then
      fResult.lLevel.Caption:='C'
    else if (lvl*1000000 div maxlvls>=400000) then
      fResult.lLevel.Caption:='D'
    else if (lvl*1000000 div maxlvls>=300000) then
      fResult.lLevel.Caption:='E'
    else
      fResult.lLevel.Caption:='F';
    fResult.Timer1.Enabled:=true;
    fResult.Show;
    Hide;
    exit;
  end;
end;

procedure TfMain.Button2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  button2.Click;
end;

procedure TfMain.FormShow(Sender: TObject);
begin
  Left:=-1145;
  Top:=-1919;
  fDiff.Show;
end;

procedure TfMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose:=false;
end;

end.
