page 50145 "Finished Auto Rent Header Card"
{
    Caption = 'Finished Auto Rent Header Card';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Finished Auto Rent Header";
    Editable = false;
    layout
    {
        area(Content)
        {
            group(General)
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
                field("Car No."; Rec."Car No.")
                {
                    ToolTip = 'Car No.';
                }
                field(Date; Rec.Date)
                {
                    ToolTip = 'Date';
                }
                field("Reserved From"; Rec."Reserved From")
                {
                    ToolTip = 'Reserved From Date';
                }
                field("Reserved Until"; Rec."Reserved Until")
                {
                    ToolTip = 'Reserved Until';
                }
                field(Sum; Rec.Sum)
                {
                    ToolTip = 'Sum';
                }
                field("Driver License"; Rec."Driver License")
                {
                    ToolTip = 'Driver License';
                }
            }
            group(Rent)
            {
                Caption = 'Rent';
                part("Finished Auto Rent Line Line SubPage"; "Finished Auto Rent LineSubPage")
                {
                    SubPageLink = "Document No." = FIELD("No.");
                }
            }
        }
    }
}