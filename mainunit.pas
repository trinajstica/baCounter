unit mainunit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Arrow, ExtCtrls;

type

  { TMainForm }

  TMainForm = class(TForm)
    Arrow1: TArrow;
    Arrow2: TArrow;
    Arrow3: TArrow;
    Arrow4: TArrow;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Panel1: TPanel;
    Timer1: TTimer;
    TrayIcon1: TTrayIcon;
    procedure Arrow1Click(Sender: TObject);
    procedure Arrow2Click(Sender: TObject);
    procedure Arrow3Click(Sender: TObject);
    procedure Arrow4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Label1DblClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure TrayIcon1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    min,sek:integer;
    done:boolean;
    narjeno:boolean;
  end;

var
  MainForm: TMainForm;

implementation uses support, LCLIntf, LCLProc, LazHelpHTML, UTF8Process;

{$R *.lfm}

{ TMainForm }


procedure TMainForm.Label1Click(Sender: TObject);
begin
  if min=0 then exit;
  if Timer1.Enabled then
  begin
    Timer1.Enabled:=False;button2.caption:='Start';Application.ProcessMessages;
  end else
  begin
    Timer1.Enabled:=True;button2.caption:='Stop';Application.ProcessMessages;
  end;
  done:=true;
end;

procedure TMainForm.Label1DblClick(Sender: TObject);
begin
  narjeno:=false;
  Timer1.Enabled:=False;done:=true;
  sek:=60;min:=0;Label1.caption:=LeadingZero(min,4);
  label3.caption:=LeadingZero(sek,2);
  button2.caption:='Start';
end;

procedure TMainForm.Arrow1Click(Sender: TObject);
begin
  done:=true;narjeno:=false;
  Label1.Font.Color:=clDefault;
  Timer1.Enabled:=False;if min<9999 then
  begin
    min:=min+1;if min>9999 then min:=9999;
    Label1.caption:=LeadingZero(min,4);
  end;
end;

procedure TMainForm.Arrow2Click(Sender: TObject);
begin
  done:=true;narjeno:=false;
  Label1.Font.Color:=clDefault;
  Timer1.Enabled:=False;if min>0 then
  begin
    min:=min-1;if min<0 then min:=0;
    Label1.caption:=LeadingZero(min,4);
  end;
end;

procedure TMainForm.Arrow3Click(Sender: TObject);
begin
  done:=true;narjeno:=false;
  Label1.Font.Color:=clDefault;
  Timer1.Enabled:=False;if min<9999 then
  begin
    min:=min+15;if min>9999 then min:=9999;
    Label1.caption:=LeadingZero(min,4);
  end;
end;

procedure TMainForm.Arrow4Click(Sender: TObject);
begin
  done:=true;narjeno:=false;
  Label1.Font.Color:=clDefault;
  Timer1.Enabled:=False;if min>0 then
  begin
    min:=min-15;if min<0 then min:=0;
    Label1.caption:=LeadingZero(min,4);
  end;
end;

procedure TMainForm.Button1Click(Sender: TObject);
begin
  done:=true;close;
end;

procedure TMainForm.Timer1Timer(Sender: TObject);
begin
  if narjeno and (min=0) then begin timer1.Enabled:=false;exit; end;
  if not narjeno then
  begin
    dec(sek);if sek<1 then
    begin
      sek:=60;dec(min);
      label3.caption:=LeadingZero(Sek,2);
      if min>0 then
      begin
        Label1.Font.Color:=clDefault;
        Label1.caption:=LeadingZero(min,4);
      end else
      begin
        timer1.enabled:=false;Label1.Font.Color:=clRed;done:=false;
        Label1.caption:=LeadingZero(min,4);
        button2.Caption:='DONE';
        repeat
          Label1.Font.Color:=Random($7FFFFFFF);
          sleep(30);
          Color:=Random($7FFFFFFF);
          application.processmessages;
        until done;
        narjeno:=true;
        Label1.Font.Color:=clBlack;
        Color:=clDefault;
      end;
    end else
    begin
      label3.caption:=LeadingZero(Sek,2);
    end;
  end;
end;

procedure TMainForm.TrayIcon1Click(Sender: TObject);
begin
  if MainForm.visible then MainForm.visible:=false else MainForm.visible:=true;
end;


end.

