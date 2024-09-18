table 50027 "Purchase Liquidity"
{
    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(10; "Document Type"; Enum "Purchase Document Type")
        {
        }
        field(20; "Document No."; Code[20])
        {
        }
        field(25; "Job No."; Code[20])
        {
        }
        field(30; "Goods Receipt Date"; Date)
        {
        }
        field(40; "Is Discount"; Boolean)
        {
        }
        field(50; "Due Date"; Date)
        {
        }
        field(60; "Discount Percent"; Decimal)
        {
        }
        field(70; "Discount Amount"; Decimal)
        {
        }
        field(80; "Quantity"; Decimal)
        {
        }
        field(90; "Direct Unit Cost"; Decimal)
        {
        }
        field(100; "Amount"; Decimal)
        {
        }
    }

    keys
    {
        key(key1; "Entry No.")
        {
            Clustered = true;
        }
    }
}