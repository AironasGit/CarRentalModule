page 50140 "Finished Auto Rent Header List"
{
    Caption = 'Finished Auto Rent Header List';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Finished Auto Rent Header";
    CardPageId = "Finished Auto Rent Header Card";
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ToolTip = 'No.';
                }
                field("Client No."; Rec."Client No.")
                {
                    ToolTip = 'Client No.';
                }
                field("Driver License"; Rec."Driver License")
                {
                    ToolTip = 'Driver License';
                }
                field(Date; Rec.Date)
                {
                    ToolTip = 'Date';
                }
                field("Car No."; Rec."Car No.")
                {
                    ToolTip = 'Car No.';
                }
                field("Reserved From"; Rec."Reserved From")
                {
                    ToolTip = 'Reserved From';
                }
                field("Reserved Until"; Rec."Reserved Until")
                {
                    ToolTip = 'Reserved Until';
                }
                field(Sum; Rec.Sum)
                {
                    ToolTip = 'Sum';
                }
            }
        }
    }
}