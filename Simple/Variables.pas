unit Variables;

interface
uses
  Classes;

const
  maxTsSize = 256;

var
  AllFormsList: TList;
  AllTsofPageControl: TList;

implementation


initialization
begin
  AllFormsList := TList.Create;
  AllTsofPageControl := TList.Create;
end;

finalization
begin
  AllFormsList.Free;
  AllTsofPageControl.Free;
end;

end.
 