page 50139 "Auto Rent Header Card"
{
    Caption = 'Auto Rent Header Card';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Auto Rent Header";
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
                    Editable = Rec.Status = Rec.Status::Open;
                }
                field("Client No."; Rec."Client No.")
                {
                    ToolTip = 'Client No.';
                    Editable = Rec.Status = Rec.Status::Open;
                }
                field("Car No."; Rec."Car No.")
                {
                    ToolTip = 'Car No.';
                    Editable = Rec.Status = Rec.Status::Open;
                    trigger OnValidate()
                    begin
                        CheckReservationDateOverlap()
                    end;
                }
                field(Date; Rec.Date)
                {
                    ToolTip = 'Date';
                    Editable = Rec.Status = Rec.Status::Open;
                }
                field("Reserved From"; Rec."Reserved From")
                {
                    ToolTip = 'Reserved From Date';
                    Editable = Rec.Status = Rec.Status::Open;
                    trigger OnValidate()
                    begin
                        CheckReservationDateOverlap()
                    end;
                }
                field("Reserved Until"; Rec."Reserved Until")
                {
                    ToolTip = 'Reserved Until';
                    Editable = Rec.Status = Rec.Status::Open;
                    trigger OnValidate()
                    begin
                        CheckReservationDateOverlap()
                    end;
                }
                field(Sum; Rec.Sum)
                {
                    ToolTip = 'Sum';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Status';
                }
                field("Drivers License"; Rec."Drivers License")
                {
                    ToolTip = 'Drivers License';
                }
            }
            group(Rent)
            {
                Caption = 'Rent';
                part("Auto Rent Line SubPage"; "Auto Rent Line SubPage")
                {
                    SubPageLink = "Document No." = FIELD("No.");
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ImportDriversLicense)
            {
                ToolTip = 'Import Drivers License';
                Caption = 'Import Drivers License';
                ApplicationArea = All;
                Image = Import;

                trigger OnAction()
                var
                    AutoRentHeaderManagement: Codeunit "Auto Rent Header - Management";
                begin
                    AutoRentHeaderManagement.ImportDriverLicense(Rec);
                end;
            }
            action(DeleteDriversLicense)
            {
                ToolTip = 'Delete Drivers License';
                Caption = 'Delete Drivers License';
                ApplicationArea = All;
                Image = Delete;

                trigger OnAction()
                var
                    AutoRentHeaderManagement: Codeunit "Auto Rent Header - Management";
                begin
                    AutoRentHeaderManagement.DeleteDriverLicense(Rec);
                end;
            }
            action(ChangeStatusToIssued)
            {
                Caption = 'Change Status To Issued';
                ToolTip = 'Change Status To Issued';

                trigger OnAction()
                var
                    AutoRentHeaderManagement: Codeunit "Auto Rent Header - Management";
                begin
                    AutoRentHeaderManagement.ChangeStatusToIssued(Rec);
                end;
            }
            action(Return)
            {
                Caption = 'Return Car';
                ToolTip = 'Return Car';
                Image = Return;
                trigger OnAction()
                var
                    AutoRentHeaderManagement: Codeunit "Auto Rent Header - Management";
                    CarReturnedMsg: Label 'The car has been returned';
                begin
                    AutoRentHeaderManagement.InsertAutoDamage(Rec);
                    AutoRentHeaderManagement.InsertFinishedAutoRentHeader(Rec);
                    AutoRentHeaderManagement.InsertFinishedAutoRentLine(Rec);
                    AutoRentHeaderManagement.DeleteAutoRentContract(Rec);
                    Message(CarReturnedMsg);
                end;
            }
        }
    }
    local procedure CheckReservationDateOverlap()
    var
        AutoRentHeader: Record "Auto Rent Header";
        AutoReservation: Record "Auto Reservation";
        ReservationDateOverlapErr: Label 'This car is already reserved at this time';
    begin
        AutoReservation.SetCurrentKey("Car No.");
        AutoReservation.SetFilter("Car No.", Rec."Car No.");
        if (Format(Rec."Reserved From", 0) = '') or (Format(Rec."Reserved Until", 0) = '') then
            exit;
        if AutoReservation.FindSet() then
            repeat
                if not (AutoRentHeader."No." = Rec."No.") then
                    if (Rec."Reserved From" <= DT2Date(AutoReservation."Reserved Until")) and (Rec."Reserved From" >= DT2Date(AutoReservation."Reserved From")) then
                        Error(ReservationDateOverlapErr);
            until AutoReservation.Next() = 0;
    end;

    // TODO: Automatically insert first line into the "Auto Rent Line" table that contains the cars rent price from the Auto table
}