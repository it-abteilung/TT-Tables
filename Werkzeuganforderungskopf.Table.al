Table 50008 Werkzeuganforderungskopf
{

    fields
    {
        field(1; "Projekt Nr"; Code[20])
        {
            TableRelation = Job."No.";

            trigger OnValidate()
            var
                Job_l: Record Job;
            begin
                if Job_l.Get("Projekt Nr") then begin
                    Schiff := Job_l.Objektname;
                    Reparaturort := Job_l.Reparaturort;
                    // MODIFY();
                end;
            end;
        }
        field(2; "Lfd Nr"; Integer)
        {
        }
        field(10; Belegdatum; Date)
        {
        }
        field(20; "Geplantes Versanddatum"; Date)
        {
        }
        field(500; Beschreibung; Text[100])
        {
            CalcFormula = lookup(Job.Description where("No." = field("Projekt Nr")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(501; "Beschreibung 2"; Text[50])
        {
            CalcFormula = lookup(Job."Description 2" where("No." = field("Projekt Nr")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(502; Stichwort; Text[50])
        {
        }
        field(600; Typ; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Stock,Order,Request';
            OptionMembers = " ",Lagerware,Bestellung,Anfrage;
        }
        field(710; Reparaturleiter; Code[20])
        {
            TableRelation = Resource;
        }
        field(720; Schiff; Text[50])
        {
            Caption = 'Schiff/Objekt';
        }
        field(730; Reparaturort; Text[50])
        {
        }
        field(740; Reparaturbeginn; Date)
        {
        }
        field(750; Reparaturende; Date)
        {
        }
        field(760; Fertigstellung; Date)
        {
        }
        field(770; "Freigabe Schweißzusätze am"; Date)
        {
        }
        field(780; "Freigabe Schweißzusätze durch"; Code[20])
        {
            TableRelation = Resource;
        }
        field(790; "Abholung am"; Date)
        {
        }
        field(800; "Abholung durch"; Code[20])
        {
            TableRelation = Resource;
        }
        field(810; "Transport LKW"; Boolean)
        {
        }
        field(820; "Transport Seefracht"; Boolean)
        {
        }
        field(830; "Transport Luftfracht"; Boolean)
        {
        }
        field(840; "Transport Sonstig"; Boolean)
        {
        }
        field(841; "Transport Sonstig Text"; Text[50])
        {
        }
        field(850; "Weitertransport von"; Text[50])
        {
        }
        field(860; "Weitertransport nach"; Text[50])
        {
        }
        field(870; "Verpackung Kiste"; Boolean)
        {
        }
        field(880; "Verpackung Verschlag"; Boolean)
        {
        }
        field(890; "Verpackung Container"; Boolean)
        {
        }
        field(900; "Verpackung Unverpackt"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Projekt Nr", "Lfd Nr")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

