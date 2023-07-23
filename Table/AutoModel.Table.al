table 50132 "Auto Model"
{
    Caption = 'Auto Model';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; "Brand Code"; Code[10])
        {
            Caption = 'Brand Code';
            TableRelation = "Auto Mark".Code;
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; Code)
        {
            Clustered = true;
        }
        key(Key2; "Brand Code")
        {
        }
    }
}