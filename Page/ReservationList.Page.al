page 50135 "Reservation List"
{
    Caption = 'Reservation List';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Auto Reservation";
    AutoSplitKey = true;
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
                    trigger OnValidate()
                    begin
                        CheckReservationDateOverlap();
                    end;
                }
                field("Client No."; Rec."Client No.")
                {
                    ToolTip = 'Client No.';
                }
                field("Reserved From"; Rec."Reserved From")
                {
                    ToolTip = 'Reserved From';
                    trigger OnValidate()
                    begin
                        CheckReservationDateOverlap();
                    end;
                }
                field("Reserved Until"; Rec."Reserved Until")
                {
                    ToolTip = 'Reserved Until';
                    trigger OnValidate()
                    begin
                        CheckReservationDateOverlap();
                    end;
                }
            }
        }
    }

    local procedure CheckReservationDateOverlap()
    var
        AutoReservation: Record "Auto Reservation";
        ReservationDateOverlapErr: Label 'This car is already reserved at this time';
    begin
        AutoReservation.SetCurrentKey("Car No.");
        AutoReservation.SetFilter("Car No.", Rec."Car No.");
        if (Format(Rec."Reserved From", 0) = '') or (Format(Rec."Reserved Until", 0) = '') then
            exit;
        if AutoReservation.FindSet() then
            repeat
                if not (AutoReservation."Line No." = Rec."Line No.") then
                    if (Rec."Reserved From" <= AutoReservation."Reserved Until") and (Rec."Reserved From" >= AutoReservation."Reserved From") then
                        Error(ReservationDateOverlapErr);
            until AutoReservation.Next() = 0;
    end;
}