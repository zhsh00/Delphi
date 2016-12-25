unit LinkUtil;

interface
uses
  Classes;

implementation
uses
  DownloadFrm, DrawFrm;

initialization

  RegisterClasses([
    TDownloadForm,
    TDrawForm
  ]);


end.
