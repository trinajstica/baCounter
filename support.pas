unit support;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

function leadingzero (w: integer; count: byte): string;

implementation

function leadingzero (w: integer; count: byte): string;
var s : string;
  i : integer;
begin
  str (w: 0, s);
  i := length (s);
  if length (s) < count then
  begin
    repeat s := '0' + s; inc (i); until i = count;
  end;
  leadingzero := s;
  if length (s) > count then delete (s, 1, length (s) - 2);
end;



end.

