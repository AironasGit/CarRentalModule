table 50138 "Auto Rent Damage"
{
    Caption = 'Auto Rent Damage';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Line No."; Integer)
        {
            Caption = 'Line No.';
            AutoIncrement = true;
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Auto Rent Header"."No.";
        }
        field(3; Date; Date)
        {
            Caption = 'Date';
        }
        field(4; Description; Text[100])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Document No.")
        {
            Clustered = true;
        }
        key(Key2; "Line No.")
        {
        }
    }

}