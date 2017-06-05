/////////////////////////////////////////////////////////////////////////////////////
// 系统定时自动维护 Tomcat
// Ver:20170605
// Copyright (c) 2017 nufeng74
/////////////////////////////////////////////////////////////////////////////////////
var tomcatfolder="D:\\apache-tomcat-7.0";
var tomcathost="127.0.0.1";
var tomcatport=8009;
var whjsmsgurl=  "http://localhost/jw/jwsys/sysmsg/whjsmsg.do";
var whksmsgurl= "http://localhost/jw/jwsys/sysmsg/whksmsg.do";
var cmdstr="cmd /c "& tomcatfolder &"\\restart.exe"

var cdo = WScript.CreateObject('CDO.Message');
//Tomcat 维护前提示
try{
cdo.CreateMHTMLBody( whjsmsgurl,31);
}catch(e){}
WScript.sleep(10000);

var wshell = new ActiveXObject('WScript.Shell');
//WScript.Echo("Tomcat重新启动...");
wshell.Run(cmdstr,0);
//WScript.Echo("正在测试Tomcat是否运行正常...");
var Winsock=new ActiveXObject('MSWINsock.Winsock');
Winsock.RemoteHost = tomcathost;
Winsock.RemotePort = tomcatport;
Winsock.Connect();
WScript.sleep(15000);
var i=0,max=30;
while(true){
if(i>max)break;
//WScript.Echo(i+" :State: "+Winsock.State);
if( Winsock.State == 7){
		break;
}
if(Winsock.State == 0 || Winsock.State == 9){
try{
Winsock.Close();
}catch(e){}
try{
	Winsock.Connect();
}catch(e){}
	WScript.sleep(10000);
}
i++;
}
Winsock.Close();
//Tomcat维护完毕提示
try{
cdo.CreateMHTMLBody(whksmsgurl,31);
}catch(e){}

