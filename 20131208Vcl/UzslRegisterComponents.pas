//此段注释请仔细阅读，来自百度百科【Delphi 6.0】词条
//2.引用RegisterComponentEditor
//其中最关键的部分在于对RegisterComponentEditor的引用。
//    在Delphi5.0中，可以直接将$(DELPHI)\Source\ToolsAPI目录下的DsgnIntf.pas文件
//拷贝到控件的设计目录下或者拷贝到$(DELPHI)\Lib目录即可。
//    在Delphi6.0中，Delphi将文件分解成DesignIntf.pas和DesignEditors.pas两个文件
//，所以引用时要将$(DELPHI)\Source\ToolsAPI目录下的DesignIntf.pas和
//DesignEditors.pas两个文件拷贝到控件的设计目录下或者拷贝到$(DELPHI)\Lib目录。
//    当然，如果你的Delphi Package的搜索路径或者Delphi IDE的搜索路径可以搜索到
//$(DELPHI)\Source\ToolsAPI目录就省去此麻烦。
//
//3.作法
//    但是，在Delphi 6.0中，如果就此编译，会出现找不到Proxies.dcu文件的问题。因
//为Proxies被编译了，在Delphi的目录中根本就找不到此相关文件，它已经被编译到
//designide.dcp文件中，解决方案很简单，就是在你的Package中引用designide.dcp文件
//即可，具体作法是：
//Project－>View Source－>在requires部分加入对designide的引用即可。
//
//由于此部分文件只是在设计期间才有效，所以你的Package在设计时就要注意：
//   不要在运行期间将在进行期间使用的文件加入对DesignIntf.pas和DesignEditors.pas
//两个文件的引用，否则依然会出现找不到Proxies.dcu文件的问题，要将文件脱离！
//    当然，如果你的Package要在Delphi 5.0及Delphi6.0下同时能运行，那就要下点功夫
//通过编辑器的版本进行控制，Delphi 6.0的编辑器版本是VER140，Delphi 5.0的编辑器版
//本是VER130，下面是本人的一个真实的引用文件：
//
//uses
//  Classes, {$IFDEF VER140}DesignIntf, DesignEditors{$ELSE}DsgnIntf{$ENDIF};
//
//Package部分由于版本不同而对不同的版本要进行不同的设计，再此就不叙述了！
//
//    其它补记：由于Delphi 5.0和Delphi 6.0对过程及参数的定义区域不同而出现错误，
//所以在编写两个版本的Package时一定要注意引用虚函数时出现的问题。例如对TControl
//控件的SetAutoSize(Value: Boolean)过程的引用：
//
//在Delphi 5.0中定义为：
//private
//  procedure SetAutoSize(Value: Boolean);
//
//而在Delphi 6.0中定义为：
//protected
//  procedure SetAutoSize(Value: Boolean); virtual;
//
//此时的定义要根据自己的实际情况定义了，可不能随便定义了！

unit UzslRegisterComponents;

interface
uses
  Windows
//  , Messages
  , SysUtils
//  , Classes
//  , Graphics
//  , Controls
//  , Forms
//  , Dialogs
//  , StdCtrls
  ;

procedure Register;

implementation

uses
  Classes, DesignIntf
  , UzslEditors
  , UzslVcl
  , UVersionLabel
  , UAboutBoxDialog
  , UTableBox
  ;
//因为注册组件只是为了安装控件以便在设计时能在组件面板上找到相应的控件，这些是在
//设计组件时需要的，而实际使用组件时不需要这些代码，所以单独抽出来，详细理由及原
//因见单元开头注释
procedure Register;
begin
  RegisterComponents('zhshll', [
      TImagePanel
    , TVersionLabel
    , TAboutBoxDialog
    , TTableBox
    , TStoreProperties
    , TEditType
    ]);
  RegisterPropertyEditor(TypeInfo(TFileName), TVersionLabel, 'FileName', TFileNameProperty);
  RegisterPropertyEditor(TypeInfo(TDatabaseName), TTableBox, 'DatabaseName', TDatabaseNameProperty);
end;

end.
 