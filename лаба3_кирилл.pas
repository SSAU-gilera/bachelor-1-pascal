uses crt; 
const lat=['a','e','y','u','i','o','A','E','Y','U','I','O'];
       rat=['q','w','r','t','p','s','d','f','g','h','j','k','l','z','x','c','v','b','n','m','Q','W','R','T','P','S','D','F','G','H','J','K','L','Z','X','C','V','B','N','M'];
type mas = array['A'..'Z'] of integer;
procedure StrToMas(s:string; var a:mas;var m,n:integer);
var b,i:integer;
    begin
        b:=length(s);
         for i:=1 to b do begin
           if s[i] in lat then
             begin
           inc (a[upcase(s[i])]);
            inc(m);
             end;
           if s[i] in rat then
             begin
              inc (a[upcase(s[i])]);
              inc(n);
             end;
         end;
   
    end;
procedure MasToStr(var a:mas; var res:string;m,n:integer);
  var c:char;
   begin
   res:='';
     if m>n then begin
       for c:='A' to 'Z' do begin
         if ((c in lat) and (a[c]>0)) then begin
           res:=res+c;
         end;
       end;
     end;
     if m<n then begin
       for c:='A' to 'Z' do begin
         if ((c in rat) and (a[c]>0)) then begin
           res:=res+c;
         end;
       end;
     end;
   end;
   procedure Alg(var f1,f2:text);
   var s,res:string;
   a:mas;
   m,n:integer;
   begin
        reset(f1);
        rewrite(f2);
      while eof(f1)=false do begin
         readln(f1,s);
         if s='' then begin 
           res:=s;
         end
         else if s='' then begin
          StrToMas(s,a,m,n);
          MasToStr(a,res,m,n); 
         end;
         writeln(f2,res);
      end;
      close(f1);close(f2);
   end;
   procedure Task;
   begin
   writeln('Абрамов К.Д. 6113 1 вариант');
   writeln('В исходном текстовом файле записаны строки, содержащие'); 
   writeln(' алфавитно-цифровые символы. Требуется написать');
   writeln('программу, которая для каждой строки исходного');
   writeln('файла будет выводить в результирующий файл последовательность');
   writeln('гласных строчных английских букв (“a”, “e”, … ”y”) из входной'); 
   writeln('последовательности, если гласных больше в этой строке,' );
   writeln('чем согласных и наоборот: выводить последовательность');
   writeln('согласных букв, если их больше, чем гласных. Печать должна' );
   writeln('происходить в алфавитном порядке.' );
   end;
   
   var f1,f2:text; 
   
    fname1,fname2,z:string;
   begin
   
     Task;
     writeln('Введите имя исходного файла:');
     readln(fname1);
        if FileExists(fname1) then begin
          writeln('Введите имя результирующего файла');
          readln(fname2);
          assign(f1,fname1);
          assign(f2,fname2);
          Alg(f1,f2);
          
        end
        else writeln('Файл с таким именем не существует');
       
   end.
     