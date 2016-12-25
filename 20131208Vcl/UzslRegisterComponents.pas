//�˶�ע������ϸ�Ķ������԰ٶȰٿơ�Delphi 6.0������
//2.����RegisterComponentEditor
//������ؼ��Ĳ������ڶ�RegisterComponentEditor�����á�
//    ��Delphi5.0�У�����ֱ�ӽ�$(DELPHI)\Source\ToolsAPIĿ¼�µ�DsgnIntf.pas�ļ�
//�������ؼ������Ŀ¼�»��߿�����$(DELPHI)\LibĿ¼���ɡ�
//    ��Delphi6.0�У�Delphi���ļ��ֽ��DesignIntf.pas��DesignEditors.pas�����ļ�
//����������ʱҪ��$(DELPHI)\Source\ToolsAPIĿ¼�µ�DesignIntf.pas��
//DesignEditors.pas�����ļ��������ؼ������Ŀ¼�»��߿�����$(DELPHI)\LibĿ¼��
//    ��Ȼ��������Delphi Package������·������Delphi IDE������·������������
//$(DELPHI)\Source\ToolsAPIĿ¼��ʡȥ���鷳��
//
//3.����
//    ���ǣ���Delphi 6.0�У�����ʹ˱��룬������Ҳ���Proxies.dcu�ļ������⡣��
//ΪProxies�������ˣ���Delphi��Ŀ¼�и������Ҳ���������ļ������Ѿ������뵽
//designide.dcp�ļ��У���������ܼ򵥣����������Package������designide.dcp�ļ�
//���ɣ����������ǣ�
//Project��>View Source��>��requires���ּ����designide�����ü��ɡ�
//
//���ڴ˲����ļ�ֻ��������ڼ����Ч���������Package�����ʱ��Ҫע�⣺
//   ��Ҫ�������ڼ佫�ڽ����ڼ�ʹ�õ��ļ������DesignIntf.pas��DesignEditors.pas
//�����ļ������ã�������Ȼ������Ҳ���Proxies.dcu�ļ������⣬Ҫ���ļ����룡
//    ��Ȼ��������PackageҪ��Delphi 5.0��Delphi6.0��ͬʱ�����У��Ǿ�Ҫ�µ㹦��
//ͨ���༭���İ汾���п��ƣ�Delphi 6.0�ı༭���汾��VER140��Delphi 5.0�ı༭����
//����VER130�������Ǳ��˵�һ����ʵ�������ļ���
//
//uses
//  Classes, {$IFDEF VER140}DesignIntf, DesignEditors{$ELSE}DsgnIntf{$ENDIF};
//
//Package�������ڰ汾��ͬ���Բ�ͬ�İ汾Ҫ���в�ͬ����ƣ��ٴ˾Ͳ������ˣ�
//
//    �������ǣ�����Delphi 5.0��Delphi 6.0�Թ��̼������Ķ�������ͬ�����ִ���
//�����ڱ�д�����汾��Packageʱһ��Ҫע�������麯��ʱ���ֵ����⡣�����TControl
//�ؼ���SetAutoSize(Value: Boolean)���̵����ã�
//
//��Delphi 5.0�ж���Ϊ��
//private
//  procedure SetAutoSize(Value: Boolean);
//
//����Delphi 6.0�ж���Ϊ��
//protected
//  procedure SetAutoSize(Value: Boolean); virtual;
//
//��ʱ�Ķ���Ҫ�����Լ���ʵ����������ˣ��ɲ�����㶨���ˣ�

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
//��Ϊע�����ֻ��Ϊ�˰�װ�ؼ��Ա������ʱ�������������ҵ���Ӧ�Ŀؼ�����Щ����
//������ʱ��Ҫ�ģ���ʵ��ʹ�����ʱ����Ҫ��Щ���룬���Ե������������ϸ���ɼ�ԭ
//�����Ԫ��ͷע��
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
 