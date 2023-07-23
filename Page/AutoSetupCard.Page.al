page 50130 "Auto Setup Card"
{
    Caption = 'Auto Setup Card';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Auto Setup";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Car Nos"; Rec."Car Nos")
                {
                    ToolTip = 'Car No. Series';
                }
                field("Car Rent Nos"; Rec."Car Rent Nos")
                {
                    ToolTip = 'Car Rent No. Series';
                }
                field("Attachment location"; Rec."Attachment location")
                {
                    ToolTip = 'Attachment location';
                }
            }
        }
    }
}