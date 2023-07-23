page 50137 "Auto Damage List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Auto Damage";

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
                field("Car No."; Rec."Car No.")
                {
                    ToolTip = 'Car No.';
                }
                field("Date"; Rec.Date)
                {
                    ToolTip = 'Date';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Description';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Status';
                }
            }
        }
    }
}