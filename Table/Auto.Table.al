table 50133 Auto
{
    Caption = 'Auto';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; Name; Code[20])
        {
            Caption = 'Name';
        }
        field(3; Brand; Code[20])
        {
            Caption = 'Brand';
            TableRelation = "Auto Mark".Code;
        }
        field(4; Model; Code[20])
        {
            Caption = 'Model';
            TableRelation = "Auto Model".Code where("Brand Code" = field(Brand));
        }
        field(5; "Manufacture Year"; Integer)
        {
            Caption = 'Year of Manufacture';
        }
        field(6; "Civil Insurance"; Date)
        {
            Caption = 'Civil insurance is valid until';
        }
        field(7; TA; Date)
        {
            Caption = 'TA is valid until';
        }
        field(8; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location.Code;
        }
        field(9; "Rental Service"; Code[20])
        {
            Caption = 'Rental Servie';
            TableRelation = Resource;
        }
        field(10; "Rental Price"; Decimal)
        {
            CalcFormula = lookup(Resource."Unit Price" where("No." = field("Rental Service")));
            Editable = false;
            Caption = 'Rental Price';
            FieldClass = FlowField;
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
            AutoSetup.TestField("Car Nos");
            "No." := NoSeriesManagement.GetNextNo(AutoSetup."Car Nos", WorkDate(), true);
        end;
    end;
}