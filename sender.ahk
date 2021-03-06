if !fileexist("ftp.ini"){
   msgbox, FTP 설정파일인 ftp.ini가 없습니다. 먼저 severmaker로 설정파일부터 만드세요.
   exitapp
}

#Include ./lib/INet.ahk

iniread, server, ftp.ini, Server, Server
iniread, User, ftp.ini, Server, User
iniread, Pwd, ftp.ini, Server, Pwd
iniread, port, ftp.ini, Server, Port

IfNotExist, .\send.txt
{
   msgbox, send.txt 파일이 없네요 빈 send.txt파일을 생성합니다.
   FileAppend,,send.txt
}
msgbox, send.txt 파일에 보내고싶은 메세지를 입력했다면 확인을 눌러주세요.
INetOpen()
hFTP := INetConnect(Server, Port, User, Pwd, "ftp")

if(hFTP)
{
   if(FtpPutFile(hFTP, "send.txt")) ;텍스트파일을 보낸다.
   Msgbox 파일 업로드 성공
   else
      Msgbox 파일 업로드 오류 : %A_LastError%

   INetCloseHandle(hFTP)
}
INetClose()