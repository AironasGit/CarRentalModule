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
                Editable = Rec.Status = Rec.Status::Open;
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
                    trigger OnValidate()
                    begin
                        CheckReservationDateOverlap();
                        InsertCarRentalPrice();
                    end;
                }
                field(Date; Rec.Date)
                {
                    ToolTip = 'Date';
                }
                field("Reserved From"; Rec."Reserved From")
                {
                    ToolTip = 'Reserved From Date';
                    trigger OnValidate()
                    begin
                        CheckReservationDateOverlap();
                        UpdateCarRentPrice();
                    end;
                }
                field("Reserved Until"; Rec."Reserved Until")
                {
                    ToolTip = 'Reserved Until';
                    trigger OnValidate()
                    begin
                        CheckReservationDateOverlap();
                        UpdateCarRentPrice();
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
                part(Options; "Auto Rent Line SubPage")
                {
                    Caption = 'Options';
                    Editable = Rec.Status = Rec.Status::Open;
                    SubPageLink = "Document No." = field("No.");
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

    local procedure InsertCarRentalPrice()
    var
        AutoRentLine: Record "Auto Rent Line";
        AutoRec: Record Auto;
        ResourceRec: Record Resource;
        AutoRentLineType: Enum "Auto Rent Line Type";
        Days: Integer;
    begin
        if not (Format(Rec."Reserved From", 0) = '') and not (Format(Rec."Reserved Until", 0) = '') then
            Days := Rec."Reserved Until" - Rec."Reserved From";

        AutoRec.Reset();
        AutoRec.SetFilter("No.", Rec."Car No.");
        AutoRec.FindFirst();

        ResourceRec.SetFilter("No.", AutoRec."Rental Service");
        ResourceRec.FindFirst();

        AutoRentLine.Init();
        AutoRentLine."Document No." := Rec."No.";
        AutoRentLine.Type := AutoRentLineType::Resource;
        AutoRentLine."No." := AutoRec."Rental Service";
        AutoRentLine.Description := ResourceRec.Name;
        AutoRentLine.Quantity := 1;
        AutoRentLine.Price := ResourceRec."Unit Price" * Days;
        AutoRentLine.Sum := ResourceRec."Unit Price" * Days;

        if not AutoRentLine.Insert(true) then
            AutoRentLine.Modify(true);
    end;

    local procedure UpdateCarRentPrice()
    var
        AutoRentLine: Record "Auto Rent Line";
        ResourceRec: Record Resource;
        Days: Integer;
    begin
        if not (Format(Rec."Reserved From", 0) = '') and not (Format(Rec."Reserved Until", 0) = '') then
            Days := Rec."Reserved Until" - Rec."Reserved From";

        AutoRentLine.Reset();
        AutoRentLine.SetFilter("Document No.", Rec."No.");
        AutoRentLine.FindFirst();

        ResourceRec.SetFilter("No.", AutoRentLine."No.");
        ResourceRec.FindFirst();

        AutoRentLine.Price := ResourceRec."Unit Price" * Days;
        AutoRentLine.Sum := ResourceRec."Unit Price" * Days;

        AutoRentLine.Modify(true);

    end;


}