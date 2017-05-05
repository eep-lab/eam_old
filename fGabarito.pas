unit fGabarito;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin;

type
  TGabaritos = class(TForm)
    ListBox1: TListBox;
    Label2: TLabel;
    SpinEdit2: TSpinEdit;
    Label3: TLabel;
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    SaveDialog1: TSaveDialog;
    Label4: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FVetBlc: Array of Integer;
    procedure Add(nrotts: Integer);
  public
    { Public declarations }
    Resolucao: Byte;
  end;

var
  Gabaritos: TGabaritos;

implementation

uses fUnit1;

{$R *.dfm}

procedure TGabaritos.Button1Click(Sender: TObject);
var
  F: TextFile;
  a1, a2: Integer;
  s1: String;
begin
  If SaveDialog1.Execute then begin
    AssignFile(F, SaveDialog1.FileName);
    Rewrite(F);
    Write(F,
    'EAM 3.0'+#13#10+
    #13#10+
    '[Sessão]'+#13#10);

    If RadioButton2.Checked then Write(F, 'Nome da Sessão= Gabarito 1024 x 768'+#13#10)
    else Write(F, 'Nome da Sessão= Gabarito 800 x 600'+#13#10);

    Write(F, 'Número de Blocos= '+IntToStr(ListBox1.Items.Count)+#13#10);

    Write(F,
    #13#10+
    '[Estímulos]'+#13#10+
    'A1='+#13#10+
    'A2='+#13#10+
    'A3='+#13#10+
    'A4='+#13#10+
    'A5='+#13#10+
    'A6='+#13#10+
    'A7='+#13#10+
    'A8='+#13#10+
    'A9='+#13#10+
    'A10='+#13#10+
    #13#10+
    'B1='+#13#10+
    'B2='+#13#10+
    'B3='+#13#10+
    'B4='+#13#10+
    'B5='+#13#10+
    'B6='+#13#10+
    'B7='+#13#10+
    'B8='+#13#10+
    'B9='+#13#10+
    'B10='+#13#10+
    #13#10+
    'C1='+#13#10+
    'C2='+#13#10+
    'C3='+#13#10+
    'C4='+#13#10+
    'C5='+#13#10+
    'C6='+#13#10+
    'C7='+#13#10+
    'C8='+#13#10+
    'C9='+#13#10+
    'C10='+#13#10+
    #13#10+
    'D1='+#13#10+
    'D2='+#13#10+
    'D3='+#13#10+
    'D4='+#13#10+
    'D5='+#13#10+
    'D6='+#13#10+
    'D7='+#13#10+
    'D8='+#13#10+
    'D9='+#13#10+
    'D10='+#13#10+
    #13#10+
    'E1='+#13#10+
    'E2='+#13#10+
    'E3='+#13#10+
    'E4='+#13#10+
    'E5='+#13#10+
    'E6='+#13#10+
    'E7='+#13#10+
    'E8='+#13#10+
    'E9='+#13#10+
    'E10='+#13#10+
    #13#10+
    'F1='+#13#10+
    'F2='+#13#10+
    'F3='+#13#10+
    'F4='+#13#10+
    'F5='+#13#10+
    'F6='+#13#10+
    'F7='+#13#10+
    'F8='+#13#10+
    'F9='+#13#10+
    'F10='+#13#10+
    #13#10+
    'G1='+#13#10+
    'G2='+#13#10+
    'G3='+#13#10+
    'G4='+#13#10+
    'G5='+#13#10+
    'G6='+#13#10+
    'G7='+#13#10+
    'G8='+#13#10+
    'G9='+#13#10+
    'G10='+#13#10+
    #13#10+
    'H1='+#13#10+
    'H2='+#13#10+
    'H3='+#13#10+
    'H4='+#13#10+
    'H5='+#13#10+
    'H6='+#13#10+
    'H7='+#13#10+
    'H8='+#13#10+
    'H9='+#13#10+
    'H10='+#13#10+
    #13#10+
    'I1='+#13#10+
    'I2='+#13#10+
    'I3='+#13#10+
    'I4='+#13#10+
    'I5='+#13#10+
    'I6='+#13#10+
    'I7='+#13#10+
    'I8='+#13#10+
    'I9='+#13#10+
    'I10='+#13#10+
    #13#10+
    'J1='+#13#10+
    'J2='+#13#10+
    'J3='+#13#10+
    'J4='+#13#10+
    'J5='+#13#10+
    'J6='+#13#10+
    'J7='+#13#10+
    'J8='+#13#10+
    'J9='+#13#10+
    'J10='+#13#10+
    #13#10+
    '[Conseqüências]'+#13#10+
    'CS1='+#13#10+
    'CS2='+#13#10+
    'CS3='+#13#10+
    'CS4='+#13#10+
    'CS5='+#13#10+
    'CS6='+#13#10+
    'CS7='+#13#10+
    'CS8='+#13#10+
    'CS9='+#13#10+
    'CS10='+#13#10+
    'CS11='+#13#10+
    'CS12='+#13#10+
    'CS13='+#13#10+
    'CS14='+#13#10+
    'CS15='+#13#10+
    'CS16='+#13#10+
    'CS17='+#13#10+
    'CS18='+#13#10+
    'CS19='+#13#10+
    'CS20='+#13#10+
    'CS21='+#13#10+
    'CS22='+#13#10+
    'CS23='+#13#10+
    'CS24='+#13#10+
    'CS25='+#13#10+
    'CS26='+#13#10+
    'CS27='+#13#10+
    'CS28='+#13#10+
    'CS29='+#13#10+
    'CS30='+#13#10+
    'CS31='+#13#10+
    'CS32='+#13#10+
    'CS33='+#13#10+
    'CS34='+#13#10+
    'CS35='+#13#10+
    'CS36='+#13#10+
    'CS37='+#13#10+
    'CS38='+#13#10+
    'CS39='+#13#10+
    'CS40='+#13#10+
    'CS41='+#13#10+
    'CS42='+#13#10+
    'CS43='+#13#10+
    'CS44='+#13#10+
    'CS45='+#13#10+
    'CS46='+#13#10+
    'CS47='+#13#10+
    'CS48='+#13#10+
    'CS49='+#13#10+
    'CS50='+#13#10+
    #13#10+
    '[Posição das Chaves de Modelo]'+#13#10+
    'Lembrete: Para cada uma das 9 chaves de modelo digite 4 valores (em pixels) que corresponderão respectivamente:'+#13#10+
    '- à posição da lateral esquerda da chave'+#13#10+
    '- à posição do topo da chave'+#13#10+
    '- à largura da chave'+#13#10+
    '- à altura da chave'+#13#10+
    #13#10);

    If RadioButton2.Checked then Write(F,
    'Chave de Modelo 1= 010 010 200 150'+#13#10+
    'Chave de Modelo 2= 412 010 200 150'+#13#10+
    'Chave de Modelo 3= 814 010 200 150'+#13#10+
    'Chave de Modelo 4= 010 309 200 150'+#13#10+
    'Chave de Modelo 5= 412 309 200 150'+#13#10+
    'Chave de Modelo 6= 814 309 200 150'+#13#10+
    'Chave de Modelo 7= 010 608 200 150'+#13#10+
    'Chave de Modelo 8= 412 608 200 150'+#13#10+
    'Chave de Modelo 9= 814 608 200 150'+#13#10)
    else
    Write (F,
    'Chave de Modelo 1= 010 010 200 150'+#13#10+
    'Chave de Modelo 2= 300 010 200 150'+#13#10+
    'Chave de Modelo 3= 590 010 200 150'+#13#10+
    'Chave de Modelo 4= 010 225 200 150'+#13#10+
    'Chave de Modelo 5= 300 225 200 150'+#13#10+
    'Chave de Modelo 6= 590 225 200 150'+#13#10+
    'Chave de Modelo 7= 010 430 200 150'+#13#10+
    'Chave de Modelo 8= 300 430 200 150'+#13#10+
    'Chave de Modelo 9= 590 430 200 150'+#13#10);

    Write (F, #13#10+
    '[Posição das Chaves de Comparação]'+#13#10+
    'Lembrete: Para especificar a posição de cada uma das 9 chaves de comparação proceda de maneira idêntica à utilizada para especificar a posição das chaves de modelo.'+#13#10+
    #13#10);

    If RadioButton2.Checked then Write(F,
    'Chave de Comparação 1= 010 010 200 150'+#13#10+
    'Chave de Comparação 2= 412 010 200 150'+#13#10+
    'Chave de Comparação 3= 814 010 200 150'+#13#10+
    'Chave de Comparação 4= 010 309 200 150'+#13#10+
    'Chave de Comparação 5= 412 309 200 150'+#13#10+
    'Chave de Comparação 6= 814 309 200 150'+#13#10+
    'Chave de Comparação 7= 010 608 200 150'+#13#10+
    'Chave de Comparação 8= 412 608 200 150'+#13#10+
    'Chave de Comparação 9= 814 608 200 150'+#13#10)
    else
    Write (F,
    'Chave de Comparação 1= 010 010 200 150'+#13#10+
    'Chave de Comparação 2= 300 010 200 150'+#13#10+
    'Chave de Comparação 3= 590 010 200 150'+#13#10+
    'Chave de Comparação 4= 010 225 200 150'+#13#10+
    'Chave de Comparação 5= 300 225 200 150'+#13#10+
    'Chave de Comparação 6= 590 225 200 150'+#13#10+
    'Chave de Comparação 7= 010 430 200 150'+#13#10+
    'Chave de Comparação 8= 300 430 200 150'+#13#10+
    'Chave de Comparação 9= 590 430 200 150'+#13#10);

    Write (F, #13#10+
    '[Posição das Chaves de Conseqüência]'+#13#10+
    'Lembrete: Estão disponíveis duas chaves para conseqüenciar respostas corretas e outras duas chaves '+
    'para conseqüencias respostas incorretas. Para especificar a posição de cada uma dessas chaves proceda '+
    'de maneira idêntica à utilizada para especificar a posição das chaves de modelo e de comparação'+#13#10+
    #13#10);
          
    If RadioButton2.Checked then Write(F,
    'Chave de Conseqüência para Resposta Correta 1= 152 114 720 540'+#13#10+
    'Chave de Conseqüência para Resposta Correta 2= 332 249 360 270'+#13#10+
    #13#10+
    'Chave de Conseqüência para Resposta Incorreta 1= 152 114 720 540'+#13#10+
    'Chave de Conseqüência para Resposta Incorreta 2= 332 249 360 270'+#13#10+
    #13#10)
    else
    Write (F,
    'Chave de Conseqüência para Resposta Correta 1= 130 100 540 405'+#13#10+
    'Chave de Conseqüência para Resposta Correta 2= 260 200 280 210'+#13#10+
    #13#10+
    'Chave de Conseqüência para Resposta Incorreta 1= 130 100 540 405'+#13#10+
    'Chave de Conseqüência para Resposta Incorreta 2= 260 200 280 210'+#13#10+
    #13#10);
    For a1:= 1 to ListBox1.Items.Count do begin
      Write(F,
      '[Bloco'+IntToStr(a1)+']'+#13#10+
      'Nome do Bloco='+#13#10+
      'Número de Tentativas do Bloco= '+IntToStr(FVetBlc[a1-1])+#13#10+
      'Número Máximo de Erros no Bloco= '+IntToStr(FVetBlc[a1-1])+#13#10+
      'Número Máximo de Execuções do Bloco= 1'+#13#10+
      'Intervalo entre Tentativas (ITI)= 0'+#13#10+
      #13#10+
      'Atraso da Conseqüência= 0'+#13#10+
      'Tipo de Cursor de Fundo= -3'+#13#10+
      'Tipo de Cursor para as Chaves= -3'+#13#10+
      'Cor de Fundo das Tentativas= 0'+#13#10+
      'Duração da Apresentação da Conseqüência Visual= 1000'+#13#10+
      #13#10);
      For a2:= 1 to FVetBlc[a1-1] do begin
        s1:= IntToStr(a2);
        Write(F,
        'T'+s1+' Chv Mod 1='+#13#10+
        'T'+s1+' Chv Mod 2='+#13#10+
        'T'+s1+' Chv Mod 3='+#13#10+
        'T'+s1+' Chv Mod 4='+#13#10+
        'T'+s1+' Chv Mod 5='+#13#10+
        'T'+s1+' Chv Mod 6='+#13#10+
        'T'+s1+' Chv Mod 7='+#13#10+
        'T'+s1+' Chv Mod 8='+#13#10+
        'T'+s1+' Chv Mod 9='+#13#10+
        'T'+s1+' Chv Cmp 1='+#13#10+
        'T'+s1+' Chv Cmp 2='+#13#10+
        'T'+s1+' Chv Cmp 3='+#13#10+
        'T'+s1+' Chv Cmp 4='+#13#10+
        'T'+s1+' Chv Cmp 5='+#13#10+
        'T'+s1+' Chv Cmp 6='+#13#10+
        'T'+s1+' Chv Cmp 7='+#13#10+
        'T'+s1+' Chv Cmp 8='+#13#10+
        'T'+s1+' Chv Cmp 9='+#13#10+
        'T'+s1+' Número da Chave Correta= 1'+#13#10+
        'T'+s1+' Chv Csq Correta 1='+#13#10+
        'T'+s1+' Chv Csq Correta 2='+#13#10+
        'T'+s1+' Paralel Correta= 11111111'+#13#10+
        'T'+s1+' Chv Csq Incorreta 1='+#13#10+
        'T'+s1+' Chv Csq Incorreta 2='+#13#10+
        'T'+s1+' Paralel Incorreta= 00000000'+#13#10+
        #13#10);
      end;
    end;
    CloseFile(F);
  end;
  SetCurrentDir(CurPath);  
  Close;
end;

procedure TGabaritos.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TGabaritos.FormCreate(Sender: TObject);
begin
  Add(3);
end;

procedure TGabaritos.Button3Click(Sender: TObject);
begin
  Add(3);
end;

procedure TGabaritos.Add(nrotts: Integer);
begin
  ListBox1.Items.Add('Bloco '+IntToStr(ListBox1.Items.Count+1)+'    ('+IntToStr(nrotts)+'  tts)');
  SetLength(FVetBlc, ListBox1.Items.Count);
  FVetBlc[ListBox1.Items.Count-1]:= nrotts;
end;

procedure TGabaritos.SpinEdit2Change(Sender: TObject);
begin
  If ListBox1.ItemIndex > -1 then begin
    FVetBlc[ListBox1.ItemIndex]:= SpinEdit2.Value;
    ListBox1.Items[ListBox1.ItemIndex]:=('Bloco '+IntToStr(ListBox1.ItemIndex+1)+
                                         '    ('+IntToStr(FVetBlc[ListBox1.ItemIndex])+'  tts)')
  end;
end;

procedure TGabaritos.Button4Click(Sender: TObject);
var a1, a2: Integer;
begin
  If ListBox1.ItemIndex > -1 then begin
    a2:= ListBox1.ItemIndex;
    ListBox1.DeleteSelected;
    For a1:= a2 to ListBox1.Items.Count-1 do begin
      FVetBlc[a1]:= FVetBlc[a1+1];
      ListBox1.Items[a1]:= ('Bloco '+IntToStr(a1+1)+'    ('+IntToStr(FVetBlc[a1])+'  tts)')
    end;
  end;
end;

procedure TGabaritos.ListBox1Click(Sender: TObject);
begin
  If ListBox1.ItemIndex > -1 then SpinEdit2.Value:= FVetBlc[ListBox1.ItemIndex]
  else SpinEdit2.Value:= 1;
end;

procedure TGabaritos.ListBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (Key = 38) or (Key = 40) then
    ListBox1Click(nil);
end;

end.
