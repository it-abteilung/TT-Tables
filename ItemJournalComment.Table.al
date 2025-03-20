table 50035 "Item Journal Comment"
{
    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(10; "Item No."; Code[20])
        {

        }
        field(20; "Serial No."; Code[20])
        {

        }
        field(30; "Quantity"; Decimal)
        {

        }
        field(40; "Entry Type"; Enum "Item Ledger Entry Type")
        {

        }
        field(50; "Short Comment"; Text[200])
        {

        }
    }
}