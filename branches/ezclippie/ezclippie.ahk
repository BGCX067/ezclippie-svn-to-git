
; TODO: $y 年（yyyy） $M 月（MM）$d（dd）日$h(hh)时 $m(mm)分 $s(ss)秒，$w(dddd) 星期$now, 现在时间，$today,今天日期
; 1.1.6 支持 \| \^ 转义
; 1.1.5 支持 |^ 定位光标，扩展到53 键，取消自动保存（保护磁盘），按 Ctrl+Alt+s 保存，取消 win键
; 1.1.4 增加到 45 键，剪贴板更加可靠，增加声音提示。


ver = v.1.1.8
Gui, Font, S9
#include LVA.ahk

Gui, Add, ListView, r1 -ReadOnly AltSubmit grid NoSort x0 y0 w250 h610 vTLV gMyListView BackgroundWhite cAA0000, Text to Copy| Key
; Generated using SmartGUI Creator 4.0

aCt=45 ;45 ; 数组大小，45 个快捷键，45 段文本
CurrentFileName:="default.txt" ; 默认打开的文件

loop, read, %CurrentFileName%
{
Array%A_Index%=%A_LoopReadLine%
} ; 读取文件，一行文本赋给一个数组元素

 
key1:="Alt+``"
key2:="Alt+1"
key3:="Alt+2"
key4:="Alt+3"
key5:="Alt+4"
key6:="Alt+5"
key7:="Alt+6"
key8:="Alt+7"
key9:="Alt+8"
key10:="Alt+9"
key11:="Alt+0"
key12:="Alt+-"
key13:="Alt+="
key14:="Alt+\"
key15:="Alt+;"
key16:="CAl+``"
key17:="CAl+1"
key18:="CAl+2"
key19:="CAl+3"
key20:="CAl+4"
key21:="CAl+5"
key22:="CAl+6"
key23:="CAl+7"
key24:="CAl+8"
key25:="CAl+9"
key26:="CAl+0"
key27:="CAl+-"
key28:="CAl+="
key29:="CAl+\"
key30:="CAl+;"
key31:="ASh+``"
key32:="ASh+1"
key33:="ASh+2"
key34:="ASh+3"
key35:="ASh+4"
key36:="ASh+5"
key37:="ASh+6"
key38:="ASh+7"
key39:="ASh+8"
key40:="ASh+9"
key41:="ASh+0"
key42:="ASh+-"
key43:="ASh+="
key44:="ASh+\"
key45:="ASh+;"
j=0
loop %aCt% {
j+=1
LV_Add("" , Array%j%, key%j%)
}

LV_ModifyCol(1, 195)
LV_ModifyCol(2, 50)

;LV_add("","0",A1rray%10%)
;Menu, FileMenu, Add, &New, FileNew
Menu, FileMenu, Add, &Load, FileOpen
Menu, FileMenu, Add, &Reload, FileReload
Menu, FileMenu, Add, &Save, FileSave
Menu, FileMenu, Add, Save &As, FileSaveAs
Menu, FileMenu, Add  ; Separator line.
Menu, FileMenu, Add, E&xit, FileExit
;Menu, HelpMenu, Add, &About, HelpAbout

; Create the menu bar by attaching the sub-menus to it:
Menu, MyMenuBar, Add, &File, :FileMenu
;Menu, MyMenuBar, Add, &Help, :HelpMenu

; Attach the menu bar to the window:
Gui, Menu, MyMenuBar
gui +AlwaysOnTop
Gui, Add, StatusBar
SB_SetText(CurrentFileName)


;gui,  Resize
x:=A_ScreenWidth-255
Gui, Show, x%x% y0 h630 w250 , ezClippie %ver%

LVA_ListViewAdd("TLV", "AR")
OnMessage("0x4E", "LVA_OnNotify")
LVA_ListViewModify("TLV", "RB0xDDDDFF RFBlack")
LVA_Refresh("TLV")
WinSet, Transparent, 220, ezClippie
Return

!`::P(Array1)
!1::P(Array2)
!2::P(Array3)
!3::P(Array4)
!4::P(Array5)
!5::P(Array6)
!6::P(Array7)
!7::P(Array8)
!8::P(Array9)
!9::P(Array10)
!0::P(Array11)
!-::P(Array12)
!=::P(Array13)
!\::P(Array14)
!;::P(Array15)
^!`::P(Array16)
^!1::P(Array17)
^!2::P(Array18)
^!3::P(Array19)
^!4::P(Array20)
^!5::P(Array21)
^!6::P(Array22)
^!7::P(Array23)
^!8::P(Array24)
^!9::P(Array25)
^!0::P(Array26)
^!-::P(Array27)
^!=::P(Array28)
^!\::P(Array29)
^!;::P(Array30)

!+`::P(Array31)
!+1::P(Array32)
!+2::P(Array33)
!+3::P(Array34)
!+4::P(Array35)
!+5::P(Array36)
!+6::P(Array37)
!+7::P(Array38)
!+8::P(Array39)
!+9::P(Array40)
!+0::P(Array41)
!+-::P(Array42)
!+=::P(Array43)
!+\::P(Array44)
!+;::P(Array45)
/*
P000(s){
clip:=ClipboardAll
clipboard=
Clipboard=%s%
clipwait
;Sleep 100
if clipboard <>
{
send ^v
SoundPlay min.wav
 }
;sleep 100
Clipboard:=clip
clip=
Return
}
*/
P(s){
;;;;;;;;;;
BlockInput on
midstr=
s:=replaceDtTm(s)
s:=myESC(s)

StringSplit, wds, s, "^|"
s1:=myUnESC(wds1) 
s2:=myUnESC(wds2)
s:=s1 . midstr . s2
clip:=ClipboardAll
clipboard=
Clipboard=%s%
clipwait
;Sleep 1
if clipboard <>
{
send ^v
i:=dbcsStrLen(wds2)
;i:=Strlen(wds2)
;m; Run or activate Notepad
; Works with any Windows version
; (uses window classes instead of
; windows title).
send, {LEFT %i%}
;send {LEFT %i%}
SoundPlay min.wav
 }
;sleep 100
Clipboard:=clip
clip=
BlockInput off
Return
}

dbcsStrLen(s){
        len := DllCall("MultiByteToWideChar", "Uint", 0, "Uint", 0, "Uint", &s, "int", -1, "Uint", 0, "int", 0) - 1
        Return len
}

myESC(s){
StringReplace, s, s, \|, 97e8cd29c8c56ed7fe56ed46865fc2c8, 1
StringReplace, s, s, \^, 28d397e87306b8631f3ed80d858d35f0, 1
return s
}

myUnESC(s){
StringReplace, s, s, 97e8cd29c8c56ed7fe56ed46865fc2c8, |, 1
StringReplace, s, s, 28d397e87306b8631f3ed80d858d35f0, ^, 1
return s
}

replaceDtTm(s){
;yyyy-MM-dd HH:mm
FormatTime, dttm1 , , yyyy
FormatTime, dttm2 , , MM
FormatTime, dttm3 , , dd
FormatTime, dttm4 , , dddd
FormatTime, dttm5 , , HH
FormatTime, dttm6 , , mm
FormatTime, dttm7 , , ss
FormatTime, dttm8 , , yyyy-MM-dd
FormatTime, dttm9 , , HH:mm
;$y 年（yyyy） $M 月（MM）$d（dd）日$w(dddd) 星期$h(hh)时 $m(mm)分 $s(ss)秒，$now, 现在时间，$today,今天日期
StringCaseSense,On
StringReplace,s,s,$y$, %dttm1%, 1
StringReplace,s,s,$M$, %dttm2%, 1
StringReplace,s,s,$d$, %dttm3%, 1
StringReplace,s,s,$w$, %dttm4%, 1
StringReplace,s,s,$h$, %dttm5%, 1
StringReplace,s,s,$m$, %dttm6%, 1
StringReplace,s,s,$s$, %dttm7%, 1
StringReplace,s,s,$today$, %dttm8%, 1
StringReplace,s,s,$jt$, %dttm8%, 1
StringReplace,s,s,$rq$, %dttm8%, 1
StringReplace,s,s,$now$, %dttm9%, 1
StringReplace,s,s,$sj$, %dttm9%, 1
StringReplace,s,s,$xz$, %dttm9%, 1
return s
}

MyListView:
critical
if A_GuiEvent = e  ; 
{
LV_GetText(sss, A_EventInfo, 1)
  Array%A_EventInfo%:=sss
;Gosub SaveCurrentFile
 }
return

/*if A_Guievent = I
{
  LV_GetText(txt, A_EventInfo, 1)
  tooltip %txt%

}
return
*/
FileOpen:
Gui +OwnDialogs  ; Force the user to dismiss the FileSelectFile dialog before returning to the main window.
FileSelectFile, SelectedFileName, 3,, Open File, Text Documents (*.txt)
if SelectedFileName =  ; No file selected.
    return
Gosub FileRead
return

FileRead:  ; Caller has set the variable SelectedFileName for us.
loop %aCt%{
Array%A_Index%=
}

loop, read, %SelectedFileName%
{
Array%A_Index%=%A_LoopReadLine%
}
LV_Delete()
loop %aCt% {
j=%A_Index%
LV_Add("" , Array%j%, key%j%)
}	
LV_ModifyCol(1, 195)
LV_ModifyCol(2, 50)
CurrentFileName = %SelectedFileName%
;gui, add, text,, %CurrentFileName%
;Gui, Show  ; Show file name in title bar.
SB_SetText(CurrentFileName)
return

FileReload:  ; Caller has set the variable SelectedFileName for us.
loop %aCt%{
Array%A_Index%=
}
loop, read, %CurrentFileName%
{
Array%A_Index%=%A_LoopReadLine%
}
LV_Delete()
loop %aCt% {
j=%A_Index%
LV_Add("" , Array%j%, key%j%)
}	
LV_ModifyCol(1, 195)
LV_ModifyCol(2, 50)
;CurrentFileName = %SelectedFileName%
;gui, add, text,, %CurrentFileName%
;Gui, Show  ; Show file name in title bar.
SB_SetText(CurrentFileName " reloaded!")
Sleep, 1500 
SB_SetText(CurrentFileName)
return

FileSave:
if CurrentFileName =   ; No filename selected yet, so do Save-As instead.
    Goto FileSaveAs
Gosub SaveCurrentFile
return

FileSaveAs:
Gui +OwnDialogs  ; Force the user to dismiss the FileSelectFile dialog before returning to the main window.
FileSelectFile, SelectedFileName, S16, .txt, Save File, Text Documents (*.txt)
if SelectedFileName =  ; No file selected.
    return
CurrentFileName = %SelectedFileName%
Gosub SaveCurrentFile
return

SaveCurrentFile:  ; Caller has ensured that CurrentFileName is not blank.
IfExist %CurrentFileName%
{
    filecopy, %CurrentFileName%, %CurrentFileName%.bak, 1
    FileDelete %CurrentFileName%
    if ErrorLevel
    {
        SB_SetText(CurrentFileName " failed")
        return
    }
}
txt0:=""
Loop % LV_GetCount()
{
    LV_GetText(tt, A_Index, 1)
    txt0 .=tt . "`n"
} 
FileAppend %txt0%, %CurrentFileName%
SB_SetText(CurrentFileName " saved!")
Sleep, 1500  
SB_SetText(CurrentFileName)

Return

FileExit:     ; User chose "Exit" from the File menu.
;HelpAbout: 
GuiClose:
ExitApp


pair(p)
{
ClipSaved := ClipboardAll
clipboard = %p%
send ^v{LEFT}
Clipboard := ClipSaved 
ClipSaved = 
return
}

^\:: WinRestore ezClippie
^+\:: WinMinimize ezClippie

^!s::Gosub SaveCurrentFile
/*
^':: pair("“”")
^+':: pair("“”")
^+0:: pair("()")
^+9:: pair("（）")

addpair(l, r)
{
ClipSaved := ClipboardAll
Clipboard =
send ^c
clipwait , , 1
clipboard :=l . clipboard . r
send ^v
clipboard := ClipSaved
ClipSaved =
return
}
!+9:: addpair("（", "）")
!+0:: addpair("(", ")")
!+':: addpair("“", "”")
*/
^!c::
 clip:=ClipboardAll
 clipboard=
 send ^c
 clipwait

if clipboard <>
{
  loop
  {
	if Array%A_Index%=
	{
		Array%A_Index%= %clipboard%
		gosub RefreshLV
        WinRestore ezClippie
        LV_Modify(A_index, "+Focus +Select")
		break
	}
  }
}
Clipboard:=clip
clip=

return

RefreshLV:
 LV_Delete()
 loop %aCt% {
 LV_Add("" , Array%A_Index%, key%A_Index%)
}
 LV_ModifyCol(1, 195)
 LV_ModifyCol(2, 50)
return

RControl::
tstr=
loop %aCt%{
  if Array%A_Index% <>
  {
   tstr := tstr . Key%A_Index% . "`t" . Array%A_Index% . "`n"
  }
 }
 ToolTip, %tstr%, A_CaretX + 10, A_CaretY + 10
 SetTimer, RemoveToolTip, 5000
 return

RemoveToolTip:
SetTimer, RemoveToolTip, Off
ToolTip
