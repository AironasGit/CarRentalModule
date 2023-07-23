table 50140 "Finished Auto Rent Line"
{
    Caption = 'Finished Auto Rent Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'No.';
        }
        field(3; Type; Enum "Auto Rent Line Type")
        {
            Caption = 'Type';
        }
        field(4; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(6; Quantity; Integer)
        {
            Caption = 'Quantity';
        }
        field(7; Price; Decimal)
        {
            Caption = 'Price';
        }
        field(8; Sum; Decimal)
        {
            Caption = 'Sum';
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
}