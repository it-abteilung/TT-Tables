#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
TableExtension 50016 tableextension50016 extends "Sales Shipment Line" 
{
    fields
    {
        field(50000;"Part No.";Code[20])
        {
        }
        field(50006;Delivery;Code[30])
        {
            Description = 'G-ERP';
        }
        field(82000;"Outstanding Amt.Excl.VAT (LCY)";Decimal)
        {
            Caption = 'Outstanding Amount Excl. VAT (LCY)';
        }
        field(83701;"EinstandspreisGes (MW)";Decimal)
        {
        }
        field(83712;"Betrag (MW)";Decimal)
        {
        }
    }
}

