table 61011 "Temp. Werkzeuganforderung"
{
    Caption = 'Temporäre Werkzeuganforderung';
    TableType = Temporary;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;
        }
        field(10; "Description"; Text[150])
        {
            Caption = 'Description';
            Editable = false;
        }
        field(20; "Description 2"; Text[100])
        {
            Caption = 'Description 2';
            Editable = false;
        }
        field(30; "On-Stock Quantity"; Decimal)
        {
            Caption = 'On-Stock Quantity';
            Editable = false;
        }
        field(40; "Required Quantity"; Decimal)
        {
            Caption = 'Required Quantity';
        }
        field(50; "Base Unit of Measure"; Code[10])
        {
            Caption = 'Base Unit of Measure';
            Editable = false;
        }
        field(60; "Item Category Code"; Code[20])
        {
            Caption = 'Item Category Code';
            Editable = false;
        }
        // field(70; "Hazardous Substance"; Boolean)
        // {
        //     Caption = 'Hazardous Substance';
        //     Editable = false;
        // }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}
