page 50132 "Auto Model List"
{
    Caption = 'Auto Model List';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Auto Model";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                Caption = 'General';
                field("Brand Code"; Rec."Brand Code")
                {
                    ToolTip = 'Brand Code';
                }
                field(Code; Rec.Code)
                {
                    ToolTip = 'Code';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Description';
                }
            }
        }
    }
}