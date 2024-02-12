table 50061 "Material To Quote"
{
    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(10; "Material No."; Code[20]) { }
        field(20; "Material Entry No."; Integer) { }
        field(30; "Item No."; Code[20]) { }
        field(40; "Serial Quote No."; Code[20]) { }
    }
    keys
    {
        key(key1; "Entry No.")
        {
            Clustered = true;
        }
    }
}