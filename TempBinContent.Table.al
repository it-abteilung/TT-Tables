table 50062 "Temp. Bin Content"
{
    Caption = 'Temp. Bin Content';
    TableType = Temporary;

    fields
    {
        field(1; "Entry No."; Code[20])
        {
            Caption = 'Entry No.';
        }
        field(10; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
        }
        field(20; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
        }
        field(50; "Item No."; Code[20])
        {
            Caption = 'Item No.';
        }
        field(60; "Item Description"; Text[100])
        {
            Caption = 'Item Description';
        }
        field(70; "Item Description 2"; Text[50])
        {
            Caption = 'Item Description 2';
        }
        field(80; "Serial No."; Code[50])
        {
            Caption = 'Serial No.';
        }
        field(90; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(100; "Base Unit of Measure"; Code[10])
        {
            Caption = 'Base Unit of Measure';
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(key2; "Bin Code") { }
    }
}