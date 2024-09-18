table 50029 "Lot No. Quantity Temp"
{
    TableType = Temporary;

    fields
    {
        field(1; "Item No."; Code[20])
        {

        }
        field(10; "Lot No."; Code[50])
        {

        }
        field(20; Description; Text[100])
        {

        }
        field(30; Location; Code[10])
        {

        }
        field(40; "Bin"; Code[20])
        {

        }
        field(50; "Quantity"; Decimal)
        {

        }
    }

    keys
    {
        key(key1; "Item No.", "Lot No.", Bin)
        {
            Clustered = true;
        }
    }
}