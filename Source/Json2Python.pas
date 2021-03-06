unit Json2Python;

interface

uses
     //
     ACBaseUnits,

     //XMLGenCodeRecords,
     //SysConsts,
     //
     //XMLDoc,XMLIntf,
     //
     JsonDataObjects,

     //
     Classes,SysUtils;


//根据XML节点生成C/Cpp代码
function JsonToPython(ANode:TJsonObject):string;

implementation

function JsonToPython(ANode:TJsonObject):string;
const
     sIndent : string = '     ';
var
     slDM      : TStringList;
     slChild   : TStringList;
     I,J       : Integer;
     //
     //sIndent   : string;
     sCaption  : string;      //节点的Caption属性，但去除了其中的换行信息
     sName     : string;
     sWin      : string;
     sComp     : string;      // Component Name
     //
     xnElse    : TJsonObject;
     xnParent  : TJsonObject;
     joChild   : TJsonObject;

     procedure AddChildCodeWithIndent(II:Integer);
     var
          JJ   : Integer;
     begin
          //添加子代码
          slChild   := TStringList.Create;
          slChild.Text   := JsonToPython(ANode.A['items'][II]);
          //
          if slChild.Count = 0 then begin
               slDM.Add(sIndent+'pass');
          end else begin
               for JJ:=0 to slChild.Count-1 do begin
                    slDM.Add(sIndent+slChild[JJ]);
               end;
          end;
          //
          slChild.Destroy;
     end;
     procedure AddChildCodeWithoutIndent(II:Integer);
     var
          JJ   : Integer;
     begin
          //添加子代码
          slChild   := TStringList.Create;
          slChild.Text   := JsonToPython(ANode.A['items'][II]);
          //
          //
          if slChild.Count = 0 then begin
               slDM.Add('pass');
          end else begin
               for JJ:=0 to slChild.Count-1 do begin
                    slDM.Add(slChild[JJ]);
               end;
          end;
          //
          slChild.Destroy;
     end;
     procedure AddSpaceLine;
     begin
          if (slDM.Count>10)and(slDM[slDM.Count-1]<>'') then begin
               slDM.Add('');
          end;
     end;
     function _GetSProp(joNode:TJsonObject;AName:string):String;
     var
          II   : Integer;
     begin
          Result    := '';
          for II := 0 to joNode.A['property'].Count-1 do begin
               if joNode.A['property'][II].S['_m_'] = AName then begin
                    Result    := joNode.A['property'][II].S['value'];
                    Break;
               end;
          end;
     end;
     function _ItemsToStr(AItems:String):string;
     var
          II        : Integer;
          slItems   : TStringList;
     begin
          Result    := '';
          //
          slItems   := TStringList.Create;
          slItems.Text   := AItems;
          if slItems.Count>0 then begin
               Result    := '"'+slItems[0]+'"';
          end;

          for II := 1 to slItems.Count-1 do begin
               Result    := Result+',"'+slItems[II]+'"';
          end;
     end;

begin
     //如果当前节点不使能，则不生成代码
     if ANode.B['disabled'] then begin
          Result    := '';
          Exit;
     end;

     //创建代码对象
     slDM := TStringList.Create;

     //得到sCaption
     sCaption  := ANode.S['caption'];
     sCaption  := StringReplace(sCaption,#10,'',[rfReplaceAll]);
     sCaption  := Trim(StringReplace(sCaption,#13,'',[rfReplaceAll]));

     //添加名称作为注释的一部分
      if sCaption<>'' then begin
          slDM.Add('# '+sCaption);
     end;

     //添加注释
     if ANode.S['comment']<>'' then begin
          slDM.Add('# '+ANode.S['comment']);
     end;

     //生成代码
     sName     := ANode.S['_m_'];
     if sName = 'root' then begin

          //添加当前节点代码

          //添加子代码
          for I:=0 to ANode.A['items'].Count-1 do begin
               AddChildCodeWithoutIndent(I);
          end;
     end else if sName = 'function' then begin
          //添加当前节点代码
          slDM.Add('def '+ANode.S['source']+':');

          //添加子代码
          for I:=0 to ANode.A['items'].Count-1 do begin
               AddChildCodeWithIndent(I);
          end;
          //
          if slDM[slDM.Count-1]<>'' then begin
               slDM.Add('');
          end;
     end else if sName = 'class' then begin

          //添加当前节点代码
          slDM.Add('class '+ANode.S['caption']+':');

          //添加子代码
          for I:=0 to ANode.A['items'].Count-1 do begin
               AddChildCodeWithIndent(I);
          end;
          //
          if slDM[slDM.Count-1]<>'' then begin
               slDM.Add('');
          end;
     end else if acInStrings(sName, ['code']) then begin

          //添加当前节点代码
          slDM.Add(ANode.S['source']);

          //
          AddSpaceLine;
     end else if acInStrings(sName, ['break']) then begin

          //添加当前节点代码
          slDM.Add('break');

          //
          AddSpaceLine;
     end else if acInStrings(sName, ['continue']) then begin

          //添加当前节点代码
          slDM.Add('continue');

          //
          AddSpaceLine;
     end else if acInStrings(sName, ['block','try_body','set']) then begin

          //添加子代码
          for I:=0 to ANode.A['items'].Count-1 do begin
               AddChildCodeWithoutIndent(I);
          end;
          //
          AddSpaceLine;
     end else if acInStrings(sName, ['if']) then begin
          //添加当前节点代码
          slDM.Add('if '+ANode.S['source']+':');

          //
          AddChildCodeWithIndent(0);

          //添加子节点代码
          for I:=1 to ANode.A['items'].Count-1 do begin
               if ANode.A['items'][I].S['_m_'] = 'elif' then begin
                    slDM.Add('elif '+_GetSProp(ANode.A['items'][I],'source')+':');
               end else begin
                    slDM.Add('else:');
               end;

               AddChildCodeWithIndent(I);
          end;
          //
          AddSpaceLine;
     end else if acInStrings(sName, ['if_yes','if_else','elif']) then begin
          //添加子代码
          for I:=0 to ANode.A['items'].Count-1 do begin
               AddChildCodeWithoutIndent(I);
          end;
     end else if acInStrings(sName, ['for']) then begin
          //添加当前节点代码
          slDM.Add('for '+ANode.S['source']+':');

          //添加子节点代码
          AddChildCodeWithIndent(0);

          //
          AddSpaceLine;
     end else if acInStrings(sName, ['while']) then begin
          //添加当前节点代码
          slDM.Add('while '+ANode.S['source']+':');

          //添加子节点代码
          AddChildCodeWithIndent(0);

          //
          AddSpaceLine;
     end else if acInStrings(sName, ['try']) then begin

          //添加当前节点代码
          slDM.Add('try: ');

          //添加子节点代码
          AddChildCodeWithIndent(0);

          //except
          for I := 1 to ANode.A['items'].Count-2 do begin
               slDM.Add('except '+_GetSProp(ANode.A['items'][I],'source')+':');
               AddChildCodeWithIndent(I);
          end;

          //
          slDM.Add('else: ');
          AddChildCodeWithIndent(ANode.A['items'].Count-1);

          //
          AddSpaceLine;
     end else if acInStrings(sName, ['try_except']) then begin

          //添加子节点代码
          for I:=0 to ANode.A['items'].Count-1 do begin
               AddChildCodeWithoutIndent(I);
          end;
          //
          AddSpaceLine;
     end else if acInStrings(sName, ['try_else']) then begin

          //添加子节点代码
          for I:=0 to ANode.A['items'].Count-1 do begin
               AddChildCodeWithoutIndent(I);
          end;
          //
          AddSpaceLine;
     end else if acInStrings(sName, ['tk_window']) then begin
          sWin := ANode.S['compname'];
          if sWin = '' then begin
               sWin := 'win';
          end;

          slDM.Add('import tkinter as tk');
          //
          slDM.Add(sWin + ' = tk.Tk()');

          //标题
          slDM.Add('');
          slDM.Add('# title');
          slDM.Add(sWin + '.title('''+ANode.S['caption']+''')');

          //设定窗口的大小(长 * 宽)
          slDM.Add('');
          slDM.Add('# width/height/left/top');
          slDM.Add(Format('%s.geometry(''%dx%d+%d+%d'')',[sWin,Anode.I['width'],Anode.I['height'],Anode.I['left'],Anode.I['top']]));
          slDM.Add(Format('%s.configure(background="#%.2x%.2x%.2x")',[sWin,ANode.A['color'].I[0],ANode.A['color'].I[1],ANode.A['color'].I[2]]));

          //添加当前节点代码
          for I:=0 to ANode.A['items'].Count-1 do begin
               slDM.Add('');
               joChild   := ANode.A['items'].O[I];
               //
               if joChild.S['_m_'] = 'tk_label' then begin
                    sComp := joChild.S['compname'];
                    if sComp = '' then begin
                         sComp := 'label'+IntToStr(I);
                    end;
                    //
                    slDM.Add('labeltext = """');
                    slDM.Add(joChild.S['caption']);
                    slDM.Add('"""');
                    slDM.Add(Format('%s = tk.Label('+sWin+', text=labeltext, bg="#%.2x%.2x%.2x", font=("%s", %d),justify="%s", anchor="%s")',
                              [sComp,joChild.A['color'].I[0],joChild.A['color'].I[1],joChild.A['color'].I[2],
                              joChild.O['font'].S['_m_'],joChild.O['font'].I['size'],joChild.S['justify'],joChild.S['anchor']  ]));

               end else if joChild.S['_m_'] = 'tk_button' then begin
                    sComp := joChild.S['compname'];
                    if sComp = '' then begin
                         sComp := 'button'+IntToStr(I);
                    end;
                    //
                    slDM.Add(Format('%s = tk.Button('+sWin+', text="%s",  font=("%s", %d))',
                              [sComp,joChild.S['caption'],joChild.O['font'].S['_m_'],joChild.O['font'].I['size']]));

               end else if joChild.S['_m_'] = 'tk_entry' then begin
                    sComp := joChild.S['compname'];
                    if sComp = '' then begin
                         sComp := 'entry'+IntToStr(I);
                    end;
                    //
                    if joChild.B['password'] then begin
                         slDM.Add(Format('%s = tk.Entry('+sWin+', show="*",  font=("%s", %d))',
                                   [sComp,joChild.O['font'].S['_m_'],joChild.O['font'].I['size']]));
                    end else begin
                         slDM.Add(Format('%s = tk.Entry('+sWin+',  font=("%s", %d))',
                                   [sComp,joChild.O['font'].S['_m_'],joChild.O['font'].I['size']]));
                    end;
                    if joChild.S['default']<>'' then begin
                         slDM.Add(Format('%s.insert(0, "%s")', [sComp,joChild.S['default']]));
                    end;

               end else if joChild.S['_m_'] = 'tk_check' then begin
                    sComp := joChild.S['compname'];
                    if sComp = '' then begin
                         sComp := 'check'+IntToStr(I);
                    end;
                    //
                    slDM.Add(Format('%s = tk.Checkbutton('+sWin+',text="%s",  font=("%s", %d), anchor="w")',
                              [sComp,joChild.S['caption'] ,joChild.O['font'].S['_m_'],joChild.O['font'].I['size']]));

               end else if joChild.S['_m_'] = 'tk_radio' then begin
                    sComp := joChild.S['compname'];
                    if sComp = '' then begin
                         sComp := 'radio'+IntToStr(I);
                    end;
                    //
                    slDM.Add(Format('%s = tk.Radiobutton('+sWin+',text="%s",  font=("%s", %d), anchor="w")',
                              [sComp,joChild.S['caption'] ,joChild.O['font'].S['_m_'],joChild.O['font'].I['size']]));

               end else if joChild.S['_m_'] = 'tk_listbox' then begin
                    sComp := joChild.S['compname'];
                    if sComp = '' then begin
                         sComp := 'listbox'+IntToStr(I);
                    end;

                    //
                    slDM.Add(Format('%s = tk.Listbox('+sWin+',  font=("%s", %d))',
                              [sComp, joChild.O['font'].S['_m_'],joChild.O['font'].I['size']]));

                    //
                    slDM.Add('for item in ['+_ItemsToStr(joChild.S['lines'])+']:');
                    slDM.Add('     '+sComp+'.insert("end", item)');


               end else if joChild.S['_m_'] = 'tk_text' then begin
                    sComp := joChild.S['compname'];
                    if sComp = '' then begin
                         sComp := 'text'+IntToStr(I);
                    end;

                    //
                    slDM.Add(Format('%s = tk.Text('+sWin+',  font=("%s", %d))',
                              [sComp, joChild.O['font'].S['_m_'],joChild.O['font'].I['size']]));

                    //
                    slDM.Add('for item in ['+_ItemsToStr(joChild.S['caption'])+']:');
                    slDM.Add('     '+sComp+'.insert("end", item)');

               end;
               slDM.Add(Format('%s.place(x=%d,y=%d, width=%d, height=%d)',
                         [sComp,joChild.I['left'],joChild.I['top'],joChild.I['width'] ,joChild.I['height'] ]));
          end;
          //
          slDM.Add('');
          slDM.Add(sWin + '.mainloop()');
          //
          AddSpaceLine;
     end;
     //
     Result    := slDM.Text;
     //
     slDM.Destroy;
end;

end.
