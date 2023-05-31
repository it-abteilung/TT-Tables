#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 82015 SalesBuffer
{

    fields
    {
        field(2;LineType;Option)
        {
            OptionCaption = ' ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)';
            OptionMembers = " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        }
        field(3;Dimension1Code;Code[20])
        {
        }
        field(5;AmountM1;Decimal)
        {
        }
        field(6;CostM1;Decimal)
        {
        }
        field(7;AmountM2;Decimal)
        {
        }
        field(8;CostM2;Decimal)
        {
        }
        field(9;AmountM3;Decimal)
        {
        }
        field(10;CostM3;Decimal)
        {
        }
        field(11;AmountM4;Decimal)
        {
        }
        field(12;CostM4;Decimal)
        {
        }
        field(14;CAmountM1;Decimal)
        {
        }
        field(15;CCostM1;Decimal)
        {
        }
        field(16;CAmountM2;Decimal)
        {
        }
        field(17;CCostM2;Decimal)
        {
        }
        field(18;CAmountM3;Decimal)
        {
        }
        field(19;CCostM3;Decimal)
        {
        }
        field(20;CAmountM4;Decimal)
        {
        }
        field(21;CCostM4;Decimal)
        {
        }
    }

    keys
    {
        key(Key1;Dimension1Code,LineType)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

