table 50139 "Finished Auto Rent Header"
{
    Caption = 'Finished Auto Rent Header';
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
        }
        field(3; "Driver License"; Media)
        {
            Caption = 'Driver License';
        }
        field(4; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(5; "Car No."; Code[20])
        {
            Caption = 'Car No.';
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
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

}