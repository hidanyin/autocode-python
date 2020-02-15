unit TkinterWin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,ComObj,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, ImgList, ToolWin, System.ImageList, Vcl.Buttons, SynEdit,
  Vcl.Samples.Spin;

type
  TForm1 = class(TForm)
    ToolBar1: TToolBar;
    ToolButton_Label: TToolButton;
    ToolButton_Button: TToolButton;
    ToolButton_Checkbutton: TToolButton;
    ToolButton_Radiobutton: TToolButton;
    ToolButton_Entry: TToolButton;
    ToolButton_Listbox: TToolButton;
    ToolButton_Scale: TToolButton;
    Panel_Left: TPanel;
    Splitter1: TSplitter;
    Panel_Client: TPanel;
    Panel_Form: TPanel;
    Panel_FormTitle: TPanel;
    Panel_FormClient: TPanel;
    Image_FormIcon: TImage;
    Label_Caption: TLabel;
    SpeedButton_FormClose: TSpeedButton;
    SpeedButton_Min: TSpeedButton;
    SpeedButton_Max: TSpeedButton;
    ToolButton_Text: TToolButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    PageControl_Detail: TPageControl;
    TabSheet_Listbox: TTabSheet;
    TabSheet_Normal: TTabSheet;
    Panel9: TPanel;
    Label13: TLabel;
    Panel12: TPanel;
    Label16: TLabel;
    Edit_Title: TEdit;
    TabSheet_Scale: TTabSheet;
    SpinEdit_Height: TSpinEdit;
    Panel11: TPanel;
    Label15: TLabel;
    SpinEdit_Width: TSpinEdit;
    Panel32: TPanel;
    Label25: TLabel;
    SpinEdit_Top: TSpinEdit;
    Panel33: TPanel;
    Label32: TLabel;
    SpinEdit_Left: TSpinEdit;
    Panel2: TPanel;
    Label6: TLabel;
    SpinEdit_ListBoxHeight: TSpinEdit;
    Panel3: TPanel;
    Label7: TLabel;
    Panel4: TPanel;
    Label8: TLabel;
    SpinEdit_ListBoxWidth: TSpinEdit;
    Panel5: TPanel;
    Label9: TLabel;
    SpinEdit_ListBoxTop: TSpinEdit;
    Panel6: TPanel;
    Label10: TLabel;
    SpinEdit_ListBoxLeft: TSpinEdit;
    Memo: TMemo;
    Panel1: TPanel;
    Label1: TLabel;
    SpinEdit_ScaleHeight: TSpinEdit;
    Panel7: TPanel;
    Label2: TLabel;
    SpinEdit_ScaleWidth: TSpinEdit;
    Panel8: TPanel;
    Label3: TLabel;
    SpinEdit_ScaleTop: TSpinEdit;
    Panel10: TPanel;
    Label4: TLabel;
    SpinEdit_ScaleLeft: TSpinEdit;
    Panel13: TPanel;
    Label5: TLabel;
    SpinEdit_ScaleFrom: TSpinEdit;
    Panel14: TPanel;
    Label11: TLabel;
    SpinEdit_ScaleTo: TSpinEdit;
    Panel15: TPanel;
    Label12: TLabel;
    ComboBox_Direction: TComboBox;
    ToolButton_Delete: TToolButton;
    ToolButton4: TToolButton;
    procedure ControlMouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
    procedure ControlMouseMove(Sender: TObject; Shift: TShiftState; X,  Y: Integer);
    procedure ControlMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    //
    procedure Label_CaptionMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
      Y: Integer);
    procedure Label_CaptionMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Panel_FormClientMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer);
    procedure ControlMouseLeave(Sender: TObject);
    procedure Edit_TitleChange(Sender: TObject);
    procedure SpinEditChange(Sender: TObject);
    procedure MemoChange(Sender: TObject);
    procedure SpinEdit_ListBoxChange(Sender: TObject);
  private
    { Private declarations }
  public
     procedure ShowComponentInfo(ACtrl:TControl);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.ControlMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
     oControl  : TControl;
     iTag      : Integer;
begin
     ReleaseCapture;
     oControl  := TControl(Sender);
     //
     iTag := oControl.Tag;
     while iTag > 0 do begin
          oControl  := oControl.Parent;
          Dec(iTag);
     end;
     //
     if (x>=0)and(x<=3) then begin
          if (y>=0)and(y<=3) then oControl.Perform(WM_SysCommand,$F004,0);
          if (y>3)and(y<oControl.Height-3) then oControl.Perform(WM_SysCommand,$F001,0);
          if (y>=oControl.Height-3)and(y<=oControl.Height) then oControl.Perform(WM_SysCommand,$F007,0);
     end else if (x>3)and(x<oControl.Width-3) then begin
          if (y>=0)and(y<=3) then oControl.Perform(WM_SysCommand,$F003,0);
          if (y>3)and(y<oControl.Height-3) then oControl.Perform(WM_SysCommand,$F012,0);
          if (y>=oControl.Height-3)and(y<=oControl.Width) then oControl.Perform(WM_SysCommand,$F006,0);
     end else if (x>=oControl.Width-3)and(x<=oControl.Width) then begin
          if (y>=0)and(y<=3) then oControl.Perform(WM_SysCommand,$F005,0);
          if (y>3)and(y<oControl.Height-3) then oControl.Perform(WM_SysCommand,$F002,0);
          if (y>=oControl.Height-3)and(y<=oControl.Width) then oControl.Perform(WM_SysCommand,$F008,0);
     end;

     //
     ShowComponentInfo(oControl);
     //TPanel(oControl).BevelOuter     := bvSpace;
end;

procedure TForm1.ControlMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
     oControl  : TControl;
     iTag      : Integer;
begin
     oControl  := TControl(Sender);
     //
     iTag := oControl.Tag;
     while iTag > 0 do begin
          oControl  := oControl.Parent;
          Dec(iTag);
     end;
     //
     if (x>=0)and(x<=3) then begin
          if (y>=0)and(y<=3) then oControl.Cursor:=crSizeNWSE;
          if (y>3)and(y<oControl.Height-3) then oControl.Cursor:=crSizeWE;
          if (y>=oControl.Height-3)and(y<=oControl.Height) then oControl.Cursor:=crSizeNESW;
     end else if (x>3)and(x<oControl.Width-3) then begin
          if (y>=0)and(y<=3) then oControl.Cursor:=crSizeNS;
          if (y>3)and(y<oControl.Height-3) then oControl.Cursor:=crArrow;
          if (y>=oControl.Height-3)and(y<=oControl.Width) then oControl.Cursor:=crSizeNS;
     end else if (x>=oControl.Width-3)and(x<=oControl.Width) then begin
          if (y>=0)and(y<=3) then oControl.Cursor:=crSizeNESW;
          if (y>3)and(y<oControl.Height-3) then oControl.Cursor:=crSizeWE;
          if (y>=oControl.Height-3)and(y<=oControl.Width) then oControl.Cursor:=crSizeNWSE;
     end;
end;

procedure TForm1.Label_CaptionMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var
     oControl  : TControl;
     oPanel         : TPanel;
begin
     ReleaseCapture;
     oControl  := TControl(Sender);
     if (x>0)and(x<oControl.Width-1) then begin
          if (y>0)and(y<oControl.Height-1) then oControl.Parent.Parent.Perform(WM_SysCommand,$F012,0);
     end;
     //
     oPanel    := Panel_Form;
     //
     PageControl_Detail.Hint       := Panel_Form.Name;
     PageControl_Detail.ActivePage := TabSheet_Normal;
     TabSheet_Normal.Caption       := 'Window';
     //
     SpinEdit_Left.OnChange   := nil;
     SpinEdit_Top.OnChange    := nil;
     SpinEdit_Width.OnChange  := nil;
     SpinEdit_Height.OnChange := nil;
     //
     SpinEdit_Left.Value      := oPanel.Left;
     SpinEdit_Top.Value       := oPanel.Top;
     SpinEdit_Width.Value     := oPanel.Width;
     SpinEdit_Height.Value    := oPanel.Height;
     //
     SpinEdit_Left.OnChange   := SpinEditChange;
     SpinEdit_Top.OnChange    := SpinEditChange;
     SpinEdit_Width.OnChange  := SpinEditChange;
     SpinEdit_Height.OnChange := SpinEditChange;
     //
     Edit_Title.OnChange      := nil;
     Edit_Title.Text          := Label_Caption.Caption;
     Edit_Title.OnChange      := Edit_TitleChange;

end;

procedure TForm1.Label_CaptionMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
     oControl  : TControl;
begin
     oControl  := TControl(Sender);
     if (x>3)and(x<oControl.Width-3) then begin
          if (y>3)and(y<oControl.Height-3) then oControl.Parent.Parent.Cursor:=crArrow;
     end;
end;

procedure TForm1.MemoChange(Sender: TObject);
var
     oPanel    : TPanel;
     oCtrl     : TControl;
begin
     oPanel    := TPanel(Panel_FormClient.FindChildControl(PageControl_Detail.Hint));
     //
     oCtrl     := oPanel.Controls[0];
     //
     if oCtrl.ClassType = TListBox then begin
          TListBox(oCtrl).Items.Clear;
          TListBox(oCtrl).Items.AddStrings(Memo.Lines);
     end else if oCtrl.ClassType = TMemo then begin
          TMemo(oCtrl).Lines.Clear;
          TMemo(oCtrl).Lines.AddStrings(Memo.Lines);
     end;
end;

procedure TForm1.Panel_FormClientMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
     oPanel         : TPanel;
     //
     oLabel         : TPanel;
     oCheckbutton   : TCheckBox;
     oRadiobutton   : TRadioButton;
     oButton        : TButton;
     oEntry         : TEdit;
     oListBox       : TListBox;
     oText          : TMemo;
     oScale         : TProgressBar;
     function _CreateGUIDName:string;
     begin
          Result    := CreateClassID;
          Delete(Result,1,1);
          Delete(Result,Length(Result),1);
          Result    := 'A'+StringReplace(Result,'-','',[rfReplaceAll]);
     end;
     //
     function _CreateParentPanel(X,Y:Integer):TPanel;
     begin
          Result    := TPanel.Create(Panel_FormClient);
          Result.Parent            := Panel_FormClient;
          Result.BorderWidth       := 2;
          Result.BevelOuter        := bvNone;
          Result.ParentBackground  := False;
          Result.Left              := X;
          Result.Top               := Y;
          Result.Height            := 30;
          Result.Width             := 120;
          Result.OnMouseDown       := ControlMouseDown;
          Result.OnMouseMove       := ControlMouseMove;
          Result.Tag               := -1;    //���Ϊ����
          Result.Name              := _CreateGUIDName;
          Result.Caption           := '';
     end;
begin
     if ToolButton_Label.Down then begin
          oPanel    := _CreateParentPanel(X,Y);
          //
          oLabel              := TPanel.Create(oPanel);
          oLabel.Parent       := oPanel;
          oLabel.Caption      := 'Label';
          oLabel.Align        := alClient;
          oLabel.Tag          := 1;
          oLabel.Alignment    := taLeftJustify;
          oLabel.BevelOuter   := bvNone;
          oLabel.OnMouseDown  := ControlMouseDown;
          oLabel.OnMouseMove  := ControlMouseMove;
     end else if ToolButton_Button.Down then begin
          oPanel    := _CreateParentPanel(X,Y);
          //
          oButton             := TButton.Create(oPanel);
          oButton.Parent      := oPanel;
          oButton.Caption     := 'Button';
          oButton.Align       := alClient;
          oButton.Tag         := 1;
          oButton.OnMouseDown := ControlMouseDown;
          oButton.OnMouseMove := ControlMouseMove;
     end else if ToolButton_Checkbutton.Down then begin
          oPanel    := _CreateParentPanel(X,Y);
          //
          oCheckbutton             := TCheckBox.Create(oPanel);
          oCheckbutton.Parent      := oPanel;
          oCheckbutton.Caption     := 'Checkbutton';
          oCheckbutton.Align       := alClient;
          oCheckbutton.Tag         := 1;
          oCheckbutton.OnMouseDown := ControlMouseDown;
          oCheckbutton.OnMouseMove := ControlMouseMove;
     end else if ToolButton_Radiobutton.Down then begin
          oPanel    := _CreateParentPanel(X,Y);
          //
          oRadiobutton             := TRadioButton.Create(oPanel);
          oRadiobutton.Parent      := oPanel;
          oRadiobutton.Caption     := 'Radiobutton';
          oRadiobutton.Align       := alClient;
          oRadiobutton.Tag         := 1;
          oRadiobutton.OnMouseDown := ControlMouseDown;
          oRadiobutton.OnMouseMove := ControlMouseMove;
     end else if ToolButton_Entry.Down then begin
          oPanel    := _CreateParentPanel(X,Y);
          //
          oEntry              := TEdit.Create(oPanel);
          oEntry.Parent       := oPanel;
          oEntry.Text         := 'Entry';
          oEntry.Align        := alClient;
          oEntry.Tag          := 1;
          oEntry.OnMouseDown  := ControlMouseDown;
          oEntry.OnMouseMove  := ControlMouseMove;
     end else if ToolButton_ListBox.Down then begin
          oPanel         := _CreateParentPanel(X,Y);
          oPanel.Height  := 60;
          //
          oListBox         := TListBox.Create(oPanel);
          oListBox.Parent  := oPanel;
          oListBox.Items.Text := 'Python';
          oListBox.Items.Add('Delphi');
          oListBox.Items.Add('Java');
          oListBox.Items.Add('JavaScript');
          oListBox.Align      := alClient;
          oListBox.Tag        := 1;
          oListBox.OnMouseDown:= ControlMouseDown;
          oListBox.OnMouseMove:= ControlMouseMove;
     end else if ToolButton_Text.Down then begin
          oPanel    := _CreateParentPanel(X,Y);
          //
          oText               := TMemo.Create(oPanel);
          oText.Parent        := oPanel;
          oText.Text          := 'Text';
          oText.Align         := alClient;
          oText.Tag           := 1;
          oText.OnMouseDown   := ControlMouseDown;
          oText.OnMouseMove   := ControlMouseMove;
     end else if ToolButton_Scale.Down then begin
          oPanel    := _CreateParentPanel(X,Y);
          //
          oScale              := TProgressBar.Create(oPanel);
          oScale.Parent       := oPanel;
          oScale.Position     := 30;
          oScale.Align        := alClient;
          oScale.Tag          := 1;
          oScale.OnMouseDown  := ControlMouseDown;
          oScale.OnMouseMove  := ControlMouseMove;
     end;
     //
     ShowComponentInfo(oPanel);
end;

procedure TForm1.ControlMouseLeave(Sender: TObject);
begin
     TPanel(Sender).BevelOuter     := bvNone;
     ShowComponentInfo(TPanel(Sender));
end;

procedure TForm1.ControlMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
     TPanel(Sender).BevelOuter     := bvNone;
     ShowComponentInfo(TPanel(Sender));
end;

procedure TForm1.Edit_TitleChange(Sender: TObject);
var
     oPanel    : TPanel;
     oCtrl          : TControl;
     //
     oLabel         : TPanel;
     oCheckbutton   : TCheckBox;
     oRadiobutton   : TRadioButton;
     oButton        : TButton;
     oEntry         : TEdit;
     oListBox       : TListBox;
     oText          : TMemo;
     procedure SetLTWH;
     begin
          oPanel.Left    := SpinEdit_Left.Value;
          oPanel.Top     := SpinEdit_Top.Value;
          oPanel.Width   := SpinEdit_Width.Value;
          oPanel.Height  := SpinEdit_Height.Value;
     end;
begin
     if PageControl_Detail.Hint = 'Panel_Form' then begin
          Label_Caption.Caption    := Edit_Title.Text;
     end else begin
          oPanel    := TPanel(Panel_FormClient.FindChildControl(PageControl_Detail.Hint));
          //
          oCtrl     := oPanel.Controls[0];
          //
          if oCtrl.ClassType = TPanel then begin
               TPanel(oCtrl).Caption    := Edit_Title.Text;
          end else if oCtrl.ClassType = TButton then begin
               TButton(oCtrl).Caption    := Edit_Title.Text;
          end else if oCtrl.ClassType = TCheckBox then begin
               TCheckBox(oCtrl).Caption    := Edit_Title.Text;
          end else if oCtrl.ClassType = TRadioButton then begin
               TRadioButton(oCtrl).Caption    := Edit_Title.Text;
          end else if oCtrl.ClassType = TEdit then begin
               TEdit(oCtrl).Text    := Edit_Title.Text;
          end else if oCtrl.ClassType = TMemo then begin
               TMemo(oCtrl).Text    := Edit_Title.Text;
          end;
     end;
end;

procedure TForm1.ShowComponentInfo(ACtrl: TControl);
var
     oPanel         : TPanel;
     //
     oLabel         : TPanel;
     oCheckbutton   : TCheckBox;
     oRadiobutton   : TRadioButton;
     oButton        : TButton;
     oEntry         : TEdit;
     oListBox       : TListBox;
     oText          : TMemo;
     oScale         : TProgressBar;
     procedure ShowLTWH;
     begin
          SpinEdit_Left.OnChange   := nil;
          SpinEdit_Top.OnChange    := nil;
          SpinEdit_Width.OnChange  := nil;
          SpinEdit_Height.OnChange := nil;
          //
          SpinEdit_Left.Value      := oPanel.Left;
          SpinEdit_Top.Value       := oPanel.Top;
          SpinEdit_Width.Value     := oPanel.Width;
          SpinEdit_Height.Value    := oPanel.Height;
          //
          SpinEdit_Left.OnChange   := SpinEditChange;
          SpinEdit_Top.OnChange    := SpinEditChange;
          SpinEdit_Width.OnChange  := SpinEditChange;
          SpinEdit_Height.OnChange := SpinEditChange;
     end;
     procedure ShowListBoxLTWH;
     begin
          SpinEdit_ListBoxLeft.OnChange   := nil;
          SpinEdit_ListBoxTop.OnChange    := nil;
          SpinEdit_ListBoxWidth.OnChange  := nil;
          SpinEdit_ListBoxHeight.OnChange := nil;
          //
          SpinEdit_ListBoxLeft.Value      := oPanel.Left;
          SpinEdit_ListBoxTop.Value       := oPanel.Top;
          SpinEdit_ListBoxWidth.Value     := oPanel.Width;
          SpinEdit_ListBoxHeight.Value    := oPanel.Height;
          //
          SpinEdit_ListBoxLeft.OnChange   := SpinEdit_ListBoxChange;
          SpinEdit_ListBoxTop.OnChange    := SpinEdit_ListBoxChange;
          SpinEdit_ListBoxWidth.OnChange  := SpinEdit_ListBoxChange;
          SpinEdit_ListBoxHeight.OnChange := SpinEdit_ListBoxChange;
     end;

begin
     if ACtrl.Tag = - 1 then begin
          oPanel    := TPanel(ACtrl);
     end else begin
          oPanel    := TPanel(ACtrl.Parent);
     end;
     //
     if oPanel = Panel_Client then Exit;

     //
     PageControl_Detail.Hint  := oPanel.Name;

     if oPanel.Controls[0].ClassType = TPanel then begin
          oLabel    := TPanel(oPanel.Controls[0]);
          //
          PageControl_Detail.ActivePage := TabSheet_Normal;
          TabSheet_Normal.Caption       := 'Label';

          //
          Edit_Title.OnChange           := nil;
          Edit_Title.Text               := oLabel.Caption;
          Edit_Title.OnChange           := Edit_TitleChange;
          //
          ShowLTWH;
     end else if oPanel.Controls[0].ClassType = TButton then begin
          oButton   := TButton(oPanel.Controls[0]);
          //
          PageControl_Detail.ActivePage := TabSheet_Normal;
          TabSheet_Normal.Caption       := 'Button';
          Edit_Title.OnChange           := nil;
          Edit_Title.Text               := oButton.Caption;
          Edit_Title.OnChange           := Edit_TitleChange;
          //
          ShowLTWH;
     end else if oPanel.Controls[0].ClassType = TCheckBox then begin
          oCheckbutton   := TCheckBox(oPanel.Controls[0]);
          //
          PageControl_Detail.ActivePage := TabSheet_Normal;
          TabSheet_Normal.Caption       := 'Checkbutton';
          Edit_Title.OnChange           := nil;
          Edit_Title.Text               := oCheckbutton.Caption;
          Edit_Title.OnChange           := Edit_TitleChange;
          //
          ShowLTWH;
     end else if oPanel.Controls[0].ClassType = TRadioButton then begin
          oRadiobutton   := TRadioButton(oPanel.Controls[0]);
          //
          PageControl_Detail.ActivePage := TabSheet_Normal;
          TabSheet_Normal.Caption       := 'Radiobutton';
          Edit_Title.OnChange           := nil;
          Edit_Title.Text               := oRadiobutton.Caption;
          Edit_Title.OnChange           := Edit_TitleChange;
          //
          ShowLTWH;
     end else if oPanel.Controls[0].ClassType = TEdit then begin
          oEntry   := TEdit(oPanel.Controls[0]);
          //
          PageControl_Detail.ActivePage := TabSheet_Normal;
          TabSheet_Normal.Caption       := 'Entry';
          Edit_Title.OnChange           := nil;
          Edit_Title.Text               := oEntry.Text;
          Edit_Title.OnChange           := Edit_TitleChange;
          //
          ShowLTWH;
     end else if oPanel.Controls[0].ClassType = TMemo then begin
          oText   := TMemo(oPanel.Controls[0]);
          //
          PageControl_Detail.ActivePage := TabSheet_ListBox;
          TabSheet_ListBox.Caption      := 'Text';
          Memo.OnChange           := nil;
          Memo.Text               := oText.Text;
          Memo.OnChange           := MemoChange;
          //
          ShowListBoxLTWH;
     end else if oPanel.Controls[0].ClassType = TListBox then begin
          oListBox  := TListBox(oPanel.Controls[0]);
          //
          PageControl_Detail.ActivePage := TabSheet_ListBox;
          TabSheet_ListBox.Caption      := 'Listbox';
          Memo.OnChange           := nil;
          Memo.Lines.Assign(oListBox.Items);
          Memo.OnChange           := MemoChange;
          //
          ShowListBoxLTWH;
     end;
end;

procedure TForm1.SpinEditChange(Sender: TObject);
var
     oPanel    : TPanel;
     oCtrl          : TControl;
     //
     oLabel         : TPanel;
     oCheckbutton   : TCheckBox;
     oRadiobutton   : TRadioButton;
     oButton        : TButton;
     oEntry         : TEdit;
     oListBox       : TListBox;
     oText          : TMemo;
     procedure SetLTWH;
     begin
          oPanel.Left    := SpinEdit_Left.Value;
          oPanel.Top     := SpinEdit_Top.Value;
          oPanel.Width   := SpinEdit_Width.Value;
          oPanel.Height  := SpinEdit_Height.Value;
     end;
begin
     if PageControl_Detail.Hint = 'Panel_Form' then begin
          oPanel    := Panel_Form;
     end else begin
          oPanel    := TPanel(Panel_FormClient.FindChildControl(PageControl_Detail.Hint));
     end;
     //
     SetLTWH;
end;

procedure TForm1.SpinEdit_ListBoxChange(Sender: TObject);
var
     oPanel    : TPanel;
     oCtrl          : TControl;
     //
     oLabel         : TPanel;
     oCheckbutton   : TCheckBox;
     oRadiobutton   : TRadioButton;
     oButton        : TButton;
     oEntry         : TEdit;
     oListBox       : TListBox;
     oText          : TMemo;
     procedure SetLTWH;
     begin
          oPanel.Left    := SpinEdit_ListBoxLeft.Value;
          oPanel.Top     := SpinEdit_ListBoxTop.Value;
          oPanel.Width   := SpinEdit_ListBoxWidth.Value;
          oPanel.Height  := SpinEdit_ListBoxHeight.Value;
     end;
begin
     oPanel    := TPanel(Panel_FormClient.FindChildControl(PageControl_Detail.Hint));
     //
     SetLTWH;
end;

end.