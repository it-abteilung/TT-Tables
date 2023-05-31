#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
TableExtension 50037 tableextension50037 extends "Purchase Header Archive"
{
    fields
    {
        field(50000; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            Description = 'G-ERP';
            TableRelation = Job;

            trigger OnValidate()
            var
                Job: Record Job;
            begin
            end;
        }
        field(50003; Unterschriftscode; Code[10])
        {
            Caption = 'Salesperson Code';
            Description = 'G-ERP';
            TableRelation = "Salesperson/Purchaser";

            trigger OnValidate()
            var
                ApprovalEntry: Record "Approval Entry";
            begin
            end;
        }
        field(50004; "Unterschriftscode 2"; Code[10])
        {
            Caption = 'Salesperson Code';
            Description = 'G-ERP';
            TableRelation = "Salesperson/Purchaser";

            trigger OnValidate()
            var
                ApprovalEntry: Record "Approval Entry";
            begin
            end;
        }
        field(50005; Leistung; Text[120])
        {
            Description = 'G-ERP';
        }
        field(50007; "Betriebsstätte Rotterdam"; Boolean)
        {
            Description = 'G-ERP';
        }
        field(50010; Besteller; Code[20])
        {
            Description = 'G-ERP';
            TableRelation = Resource;
        }
        field(50011; Bestellername; Text[100])
        {
            CalcFormula = lookup(Resource.Name where("No." = field(Besteller)));
            Description = 'G-ERP';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50040; Leistungsart; Option)
        {
            Description = 'G-ERP';
            OptionMembers = " ",Fremdlieferung,Fremdleistung,Transport,Reisekosten,Hotelkosten,Personal,Beistellung,"Auslöse";
        }
        field(50050; Leistungszeitraum; Code[7])
        {
            Description = 'G-ERP';
        }
        field(50060; Serienanfragennr; Code[20])
        {
            Description = 'G-ERP';
        }
        field(50070; "Angebotsabgabe bis"; Date)
        {
            Description = 'G-ERP';
        }
        field(50080; TreeNo; Integer)
        {
            InitValue = 1;
        }
        field(50090; "Keine Angebotsabgabe"; Boolean)
        {
        }
        field(50100; "Buy-from Contact Ansprech"; Code[20])
        {
            Caption = 'Eink. von KontaktAnsprech';

            trigger OnLookup()
            var
                Cont: Record Contact;
                ContBusinessRelation: Record "Contact Business Relation";
            begin
            end;

            trigger OnValidate()
            var
                ContBusinessRelation: Record "Contact Business Relation";
                Cont: Record Contact;
            begin
            end;
        }
        field(82007; "Pay-to Name 3"; Text[50])
        {
            Caption = 'Pay-to Name 3';
        }
        field(82008; "Buy-from Vendor Name 3"; Text[50])
        {
            Caption = 'Buy-from Vendor Name 3';
        }
        field(82009; "Ship-to Name 3"; Text[50])
        {
            Caption = 'Ship-to Name 3';
        }
        field(82010; "Buy-from Company No."; Code[20])
        {
            Caption = 'Buy-from Company No.';
            TableRelation = Contact;

            trigger OnLookup()
            var
                Cont: Record Contact;
                ContBusinessRelation: Record "Contact Business Relation";
            begin
            end;

            trigger OnValidate()
            var
                ContBusinessRelation: Record "Contact Business Relation";
                Cont: Record Contact;
            begin
            end;
        }
    }
}

