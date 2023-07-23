table 50136 "Auto Rent Header"
{
    Caption = 'Auto Rent Header';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Client No."; Code[20])
        {
            Caption = 'Client No.';
            TableRelation = Customer."No.";
            trigger OnValidate()
            var
            begin
                CheckClientBlocked();
                CheckClientDebt();
            end;
        }
        field(3; "Drivers License"; Media)
        {
            Caption = 'Drivers License';
            ExtendedDatatype = Person;
        }
        field(4; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(5; "Car No."; Code[20])
        {
            Caption = 'Car No.';
            TableRelation = Auto."No.";
        }
        field(6; "Reserved From"; Date)
        {
            Caption = 'Reserved From Date';

        }
        field(7; "Reserved Until"; Date)
        {
            Caption = 'Reserved Until Date';
        }
        field(8; Sum; Decimal)
        {
            Caption = 'Sum';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Auto Rent Line".Sum where("Document No." = field("No.")));
        }
        field(9; Status; Enum "Auto Rent Header Status")
        {
            Caption = 'Status';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        AutoSetup: Record "Auto Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
    begin
        if "No." = '' then begin
            AutoSetup.Get();
            AutoSetup.TestField("Car Rent Nos");
            "No." := NoSeriesManagement.GetNextNo(AutoSetup."Car Rent Nos", WorkDate(), true);
        end;
    end;

    local procedure CheckClientBlocked()
    var
        Customer: Record Customer;
    begin
        if Customer.Get(Rec."Client No.") then
            Customer.TestField(Blocked, Customer.Blocked::" ");
    end;

    local procedure CheckClientDebt()
    var
        Customer: Record Customer;
        CustLedgEntry: Record "Cust. Ledger Entry";
        Debt: Decimal;
        Err: Label 'This Client is in debt';
    begin

        if Customer.Get(Rec."Client No.") then begin
            CustLedgEntry.SetFilter("Customer No.", Rec."Client No.");
            if CustLedgEntry.FindSet() then
                repeat
                    Debt += CustLedgEntry."Amount (LCY)";
                until CustLedgEntry.Next() = 0;
        end;
        if Debt > 0 then
            Error(Err);
    end;
}