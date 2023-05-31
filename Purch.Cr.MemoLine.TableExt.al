#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
TableExtension 50026 tableextension50026 extends "Purch. Cr. Memo Line" 
{
    fields
    {
        field(50010;Baugruppe;Code[20])
        {
            Description = 'G-ERP';
            TableRelation = "Job Planning Line".Baugruppe where ("Job No."=field("Job No."));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50020;Pos;Code[20])
        {
            Description = 'G-ERP';
            TableRelation = "Job Planning Line".Pos where ("Job No."=field("Job No."));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50040;Leistungsart;Option)
        {
            Description = 'G-ERP';
            OptionMembers = " ",Fremdlieferung,Fremdleistung,Transport,Flugkosten,Hotelkosten,Personal,Beistellung,"Auslöse";
        }
        field(50050;Leistungszeitraum;Code[7])
        {
            Description = 'G-ERP';
        }
        field(50060;"LOT-Nr. / Chargennr.";Code[20])
        {
            Caption = 'LOT-Nr. / Chargennr.';
        }
        field(50200;"Description 3";Text[50])
        {
            Caption = 'Description 2';
            Description = 'Kann gelöscht werden';
        }
        field(50300;"CO2 Menge in Kilogramm";Decimal)
        {
        }
        field(82000;"Outstanding Amt.Excl.VAT (LCY)";Decimal)
        {
            Caption = 'Outstanding Amount Excl. VAT (LCY)';
        }
    }
}

