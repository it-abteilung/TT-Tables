#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50004 "Serienanfragen erstellen"
{

    fields
    {
        field(10;"Projekt Nr";Code[20])
        {
        }
        field(20;Zeilennr;Integer)
        {
        }
        field(30;"Artikelnr.";Code[20])
        {

            trigger OnValidate()
            var
                Item: Record Item;
            begin
                Item.Get("Artikelnr.");
                Beschreibung := Item.Description;
                "Beschreibung 2" := Item."Description 2";
                Einheit := Item."Base Unit of Measure";
            end;
        }
        field(40;Beschreibung;Text[50])
        {
        }
        field(50;"Beschreibung 2";Text[50])
        {
        }
        field(60;Menge;Decimal)
        {
        }
        field(70;Einheit;Text[10])
        {
        }
        field(80;"Serienanfragen erstellt";Boolean)
        {
        }
    }

    keys
    {
        key(Key1;"Projekt Nr",Zeilennr)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

