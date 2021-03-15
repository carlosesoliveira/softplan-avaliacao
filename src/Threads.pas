unit Threads;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.ExtCtrls;

type

  ThPai = class(TThread)
  private
    FNumThreads: Integer;
    FTempo: Integer;
    Contador: Integer;
    procedure Acabou(Sender: TObject);
  protected
    procedure Execute; override;
  public
    constructor Create(NumThreads, Tempo: Integer);
    function WaitForMultipleThreads(const ThrArr: array of TThread;
      TimeOutVal: DWORD): Word;
  end;

  ThFilho = class(TThread)
  private
    FTempo: Integer;
  protected
    procedure Execute; override;
  public
    constructor Create(Tempo: Integer);
  end;

  TfThreads = class(TForm)
    mmoLog: TMemo;
    Panel1: TPanel;
    edtNumThreads: TEdit;
    edtTempo: TEdit;
    btnStart: TButton;
    Label1: TLabel;
    Label2: TLabel;
    pbar1: TProgressBar;
    lblAndamento: TLabel;
    procedure btnStartClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    threadPai: ThPai;
  end;

var
  fThreads: TfThreads;

implementation

{$R *.dfm}

procedure TfThreads.btnStartClick(Sender: TObject);
var
  NumThreads, iTempo: Integer;
begin
  NumThreads := StrToIntDef(edtNumThreads.Text, 5);
  iTempo := StrToIntDef(edtTempo.Text, 5000);
  threadPai := ThPai.Create(NumThreads, iTempo);
  threadPai.Priority := tpNormal;
  threadPai.Start;
end;

{ ThPai }

procedure ThPai.Acabou(Sender: TObject);
begin
  Inc(Self.Contador);

  if Contador = Self.FNumThreads then
  begin
    Self.Terminate;
    Application.MessageBox(PChar('Processamento foi concluído!'), 'SUCESSO', MB_OK + MB_ICONINFORMATION);
  end;
end;

constructor ThPai.Create(NumThreads, Tempo: Integer);
begin
  inherited Create(True); // Entrar em modo suspenso
  Self.FNumThreads := NumThreads;
  Self.FTempo := Tempo;
  FreeOnTerminate := False;
  Self.Contador := 0;
end;

procedure ThPai.Execute;
var
  Threads: TList;
  aThreads: array of TThread;
  i: Integer;
begin
  SetLength(aThreads, Self.FNumThreads - 1);
  Threads := TList.Create;

  for i := 0 to Self.FNumThreads - 1 do
  begin
    Threads.Add(ThFilho.Create(Self.FTempo));
    ThFilho(Threads[i]).Priority := tpNormal;
    ThFilho(Threads[i]).OnTerminate := Acabou;
    aThreads[i] := ThFilho(Threads[i]);
  end;

  Self.WaitForMultipleThreads(aThreads, INFINITE);
end;

function ThPai.WaitForMultipleThreads(const ThrArr: array of TThread;
  TimeOutVal: DWORD): Word;
var
  hnds: TWOHandleArray;
  k: Integer;
begin
  for k := 0 to High(ThrArr) do
    hnds[k] := ThrArr[k].Handle;
  Result := WaitForMultipleObjects(High(ThrArr) + 1, @hnds, True, TimeOutVal);
end;

{ ThFilho }

constructor ThFilho.Create(Tempo: Integer);
begin
  inherited Create(False); // Vai para o metodo Execute automaticamente
  FreeOnTerminate := True; // Sai da memoria ao concluir execucao
  Self.FTempo := Tempo;
end;

procedure ThFilho.Execute;
var
  j: Integer;
begin
  inherited;
  with fThreads.mmoLog.Lines do
  begin
    Add(IntToStr(Self.ThreadID) + ' - Iniciando processamento');
    for j := 0 to 10 - 1 do
    begin
      Synchronize(
        procedure
        begin
          fThreads.lblAndamento.Caption := IntToStr(Self.ThreadID) +
            ' - processando iteração ' + IntToStr(j);
          fThreads.pbar1.StepIt;
        end);
      Sleep(Random(Self.FTempo));
    end;
    Add(IntToStr(Self.ThreadID) + ' - Processamento finalizado');
  end;

end;

procedure TfThreads.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if (threadPai <> nil) and (not threadPai.Terminated) then
  begin
    Action := caNone;
    Application.MessageBox
      (PChar('Os processos ainda não foram concluidos, por favor aguarde!'),
      'ATENÇÃO', MB_OK + MB_ICONWARNING);
  end;
end;

procedure TfThreads.FormCreate(Sender: TObject);
begin
  threadPai := nil;
end;

end.
