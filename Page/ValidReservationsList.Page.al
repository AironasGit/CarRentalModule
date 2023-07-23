page 50136 "Valid Reservations List"
{
    Caption = 'Valid Reservations List';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Auto Reservation";
    Editable = false;
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
                field("Client No."; Rec."Client No.")
                {
                    ToolTip = 'Client No.';
                }
                field("Reserved From"; Rec."Reserved From")
                {
                    ToolTip = 'Reserved From';
                }
                field("Reserved Until"; Rec."Reserved Until")
                {
                    ToolTip = 'Reserved Until';
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.SetFilter("Reserved From", '%1..', CurrentDateTime);
    end;
}