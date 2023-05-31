#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50011 Wareneingangskontrolle
{

    fields
    {
        field(1;Bestellnr;Code[20])
        {
        }
        field(10;Kontrolleur;Text[30])
        {
        }
        field(20;"Allgemeine Sichtkontolle";Boolean)
        {
        }
        field(30;"Sichtbare Beschädigungen";Text[50])
        {
        }
        field(40;"Welche Papiere vorhanden";Text[50])
        {
        }
        field(50;"Vollzähligkeit";Boolean)
        {
        }
        field(60;Verpackung;Boolean)
        {
        }
        field(70;Gefahrstoff;Boolean)
        {
        }
        field(80;Bemerkung;Text[250])
        {
        }
        field(90;"erstellt am";Date)
        {
        }
        field(100;"erstellt von";Text[30])
        {
        }
        field(110;"geprüft am";Date)
        {
        }
        field(120;"geprüft von";Text[30])
        {
        }
        field(130;"geprüft QM am";Date)
        {
        }
        field(140;"geprüft von QM";Text[30])
        {
        }
    }

    keys
    {
        key(Key1;Bestellnr)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

