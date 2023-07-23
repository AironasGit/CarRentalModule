table 50130 "Auto Setup"
{
    Caption = 'Auto Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Car Nos"; Code[20])
        {
            Caption = 'Car No. Series';
            TableRelation = "No. Series";
        }
        field(3; "Car Rent Nos"; Code[20])
        {
            Caption = 'Car Rent No. Series';
            TableRelation = "No. Series";
        }
        field(4; "Attachment location"; Code[10])
        {
            Caption = 'Attachment Location';
            TableRelation = Location;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

}