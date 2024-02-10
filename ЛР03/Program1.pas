uses crt;

const
  Lat = ['a'..'z', 'A'..'Z'];

type
  mas = array['A'..'Z'] of integer;

procedure Task;
begin
  writeln('Лабораторная работа №2');
  writeln('Гижевская Валерия');
  writeln('Группа 6113-020302D');
  writeln('Вариант 10' + #13#10);
  writeln('В исходном текстовом файле записаны строки, содержащие текст на английском языке.');
  writeln('Требуется написать программу, которая для каждой строки исходного файла будет определять');
  writeln('и выводить в результирующий файл английскую букву, встречающуюся в этой строке чаще всего, и количество там таких букв.');
  writeln('Строчные и прописные буквы при этом считаются не различимыми. Если искомых букв несколько,');
  writeln('то программа должна выводить на экран первую из них по алфавиту.' + #13#10);
end;

procedure StrToMas(s: string; var a: mas);//получаем из строки массив количества повторений каждой буквы
var
  l, i: integer;
begin
  l := length(s);
  for i := 1 to l do
    if s[i] in Lat then inc(a[upcase(s[i])]);
end;

procedure MasToStr(var a: mas; var res: string);//получаем результирющую строку
var
  c, d: char;
  max: integer;
begin
  max := 0;
  d:= '&' ;
  res := '';
  for c := 'A' to 'Z' do 
  begin
    if max < a[c] then begin
      max := a[c];
      d := c;
    end;
    a[c] := 0;
  end;
  if max > 0 then
    res := res + d + ' - ' + max
  else res := '-';
end;

procedure Alg(var f1, f2: text);// создает результирующий файл и записывает в него результат
var
  s, res: string;
  a: mas;
begin
  reset(f1);
  rewrite(f2);
  while not eof(f1) do 
  begin
    readln(f1, s);
    if s <> '' then begin
      strtomas(s, a);
      mastostr(a, res);
    end
    else res := '';
    writeln(f2, res);
  end;
  close(f1);
  close(f2);
end;

var
  f1, f2: text;
  fname1, fname2: string;

begin
  Task;
  write('Имя исходного файла: ');
  readln(fname1);
  if FileExists(fname1) then begin
    write('Имя результирующего файла: ');
    readln(fname2);
    assign(f1, fname1);
    assign(f2, fname2);
    Alg(f1, f2);
  end
  else writeln('Файл не существует');
end.
