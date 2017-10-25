unit Myloo.Phonetic.Interfaces;

interface

type
  IPhoneticMatching = interface
    function Phonetic(AText:string):string;
    function Similar(const AText, AOther: string): Boolean;
    function Compare(const AText, AOther: string): Integer;
    function Proc(const AText, AOther: string): Boolean;
  end;

implementation

end.
