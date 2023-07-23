table 50134 "Auto Reservation"
{
    Caption = 'Auto Reservation';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(2; "Car No."; Code[20])
        {
            Caption = 'Car No.';
            TableRelation = Auto."No.";
        }
        field(3; "Client No."; Code[20])
        {
            Caption = 'Client No.';
            TableRelation = Customer."No.";
        }
        field(4; "Reserved From"; DateTime)
        {
            Caption = 'Reserved from date time';
        }
        field(5; "Reserved Until"; DateTime)
        {
            Caption = 'Reserved until date time';
        }
    }

    keys
    {
        key(Key1; "Car No.", "Line No.")
        {
            Clustered = true;
        }
    }
}