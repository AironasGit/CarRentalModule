page 50143 "Auto Rent Damage List"
{
    Caption = 'Auto Rent Damage List';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Auto Rent Damage";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                Caption = 'General';
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Line No.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Document No.';
                }
                field(Date; Rec.Date)
                {
                    ToolTip = 'Date';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Description';
                }
            }
        }
    }
}