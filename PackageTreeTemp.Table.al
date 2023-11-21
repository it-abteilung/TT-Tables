table 50023 "Package Tree Temp"
{
    Caption = 'Package Tree Temp';
    TableType = Temporary;

    fields
    {
        field(1; "Entry No."; Integer)
        {

        }
        field(2; "Indentation"; Integer)
        {

        }
        field(10; "Job No."; Code[20])
        {

        }
        field(11; "Job Line No."; Integer)
        {

        }
        field(12; "Job Description"; Text[100])
        {

        }
        field(20; "Item No."; Code[20])
        {

        }
        field(21; "Item Description"; Text[100])
        {

        }
        field(30; Bin; Code[20])
        {

        }
        field(40; "Posting Date"; Date)
        {

        }
        field(50; "Requested Quantity"; Decimal)
        {

        }
        field(60; "Packed Quantity"; Decimal)
        {

        }
        field(70; "Delta Quantity"; Decimal)
        {

        }
        field(100; "Package List"; Text[255])
        {

        }

        field(200; "On Tool Request"; Boolean)
        {

        }

    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(
        key2; "Item Description", Indentation, Bin)
        {
        }
    }
}
