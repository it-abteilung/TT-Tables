table 50037 "Employee Card History"
{
    Caption = 'Employee Card History';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(10; "Line No."; Integer)
        {
            Caption = 'Line No.';
            AutoIncrement = true;
        }
        field(20; "Issued On"; Date)
        {
            Caption = 'Issued On';

            trigger OnValidate()
            begin
                if "Expired On" = 0D then
                    Rec."Expired On" := "Issued On";
                if "Issued On" > "Expired On" then
                    Error('%1 kann nicht kleiner als %2 sein.', FieldCaption("Expired On"), FieldCaption("Issued On"));
            end;
        }
        field(30; "Expired On"; Date)
        {
            Caption = 'Expired On';

            trigger OnValidate()
            begin
                if "Issued On" > "Expired On" then
                    Error('%1 kann nicht kleiner als %2 sein.', FieldCaption("Expired On"), FieldCaption("Issued On"));
            end;
        }
        field(40; "Returned On"; Date)
        {
            Caption = 'Returned On';
        }

        field(50; Comment; Text[100])
        {
            Caption = 'Comment';
        }
    }

    keys
    {
        key(key1; "No.", "Line No.") { }
    }

}