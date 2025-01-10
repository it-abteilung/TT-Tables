TableExtension 50008 tableextension50008 extends "Purchase Header"
{
    fields
    {
        modify("Buy-from Vendor No.")
        {
            trigger OnAfterValidate()
            begin
                GetVend("Buy-from Vendor No.");
                VALIDATE("Location Code", 'WHV');                       // G-ERP.AG 2020-09-04
                //G-ERP+
                Leistungsart := Vend.Leistungsart;
                //G-ERP-
            end;
        }
        field(50000; "Job No."; Code[20])
        {
            Caption = 'Projektnr.';
            Description = 'G-ERP';
            TableRelation = Job;

            trigger OnValidate()
            var
                Job: Record Job;
            begin
                if "Job No." <> '' then begin
                    UpdatePurchLines(FieldCaption("Job No."), false);
                    Job.Get("Job No.");
                    Validate("Betriebsstätte Rotterdam", Job."Betriebsstätte Rotterdam");
                end;
            end;
        }
        field(50003; Unterschriftscode; Code[10])
        {
            Caption = 'Unterschriftscode';
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
            Caption = 'Unterschriftscode 2';
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
        field(50012; Bestellnummer; Code[20])
        {
            Caption = 'Bestellnummer';
        }
        field(50030; Anforderer; Code[50])
        {
        }
        field(50040; Leistungsart; Option)
        {
            Description = 'G-ERP';
            OptionMembers = " ",Fremdlieferung,Fremdleistung,Transport,Flugkosten,Hotelkosten,Personal,Beistellung,"Auslöse";

            trigger OnValidate()
            begin
                UpdatePurchLinesByFieldNo(FieldNo(Leistungsart), false);
            end;
        }
        field(50050; Leistungszeitraum; Code[7])
        {
            Description = 'G-ERP';

            trigger OnValidate()
            var
                Matches: Record Matches;
                Regex: Codeunit Regex;
                Pattern: Text;
                IndexPos: Integer;
                InputStrLen: Integer;

            begin
                if Leistungszeitraum <> '' then begin
                    InputStrLen := StrLen(Leistungszeitraum);

                    if InputStrLen < 3 then begin
                        Error('Eingabe benötigt eine minimale L#nge von drei Ziffern');
                    end;

                    Pattern := '^(0?[1-9]|1[0-2])\/?(20[0-9]{2}|[0-9]{2})$';
                    if Regex.IsMatch(Rec.Leistungszeitraum, Pattern, 0) then begin
                        // 0 = / not in string
                        IndexPos := Format(Leistungszeitraum).IndexOf('/');
                        if IndexPos = 0 then begin
                            if InputStrLen < 7 then begin
                                if InputStrLen = 3 then begin
                                    Leistungszeitraum := '0' + CopyStr(Leistungszeitraum, 1, 1) + '/20' + CopyStr(Leistungszeitraum, 2, 2);
                                end else begin
                                    Leistungszeitraum := CopyStr(Leistungszeitraum, 1, 2) + '/20' + CopyStr(Leistungszeitraum, InputStrLen - 1, 2);
                                end;
                            end;
                        end else begin
                            if InputStrLen < 7 then begin
                                if IndexPos = 2 then begin
                                    Leistungszeitraum := '0' + CopyStr(Leistungszeitraum, 1, 1) + '/20' + CopyStr(Leistungszeitraum, IndexPos + 1, 2);
                                end else begin
                                    Leistungszeitraum := CopyStr(Leistungszeitraum, 1, 2) + '/20' + CopyStr(Leistungszeitraum, InputStrLen - 1, 2);
                                end;
                            end;
                        end;
                        UpdatePurchLines(FieldCaption(Leistungszeitraum), false);
                    end else
                        Error('Das Format wird nicht unterstützt. Versuche die Formate mmjj, mmjjjj, mm/jj oder mm/jjjj');
                end;
            end;
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
        field(50101; "Abschlag2 %"; Decimal)
        {
        }
        field(50102; "Abschlag3 %"; Decimal)
        {
        }
        field(50103; "Abschlag1 Absolut"; Decimal)
        {
        }
        field(50104; "Abschlag2 Absolut"; Decimal)
        {
        }
        field(50105; "Abschlag3 Absolut"; Decimal)
        {
        }
        field(50106; "Abschlag1 Datum"; Date)
        {
        }
        field(50107; "Abschlag2 Datum"; Date)
        {
        }
        field(50108; "Abschlag3 Datum"; Date)
        {
        }
        field(50109; "Abschlag1 %"; Decimal)
        {
        }
        field(50200; "Status Purchase"; Option)
        {
            Caption = 'Beleg Status';
            OptionCaption = ' ,Teil geliefert,geliefert,Teil fakturiert,fakturiert';
            OptionMembers = " ","partly delivered",delivered,"partly invoiced",invoiced;
        }
        field(50300; "Goods Receiving Date"; Date)
        {
            Caption = 'Wareneingangsdatum';
            Description = 'G-ERP';
        }
        field(50301; Employee; Text[50])
        {
            Caption = 'Mitarbeiter';
            Description = 'G-ERP';
        }
        field(50302; "Employee No."; Code[20])
        {
            Caption = 'Mitarberiter Nr.';
            Description = 'G-ERP';
            TableRelation = Employee."No.";

            trigger OnValidate()
            var
                Employee_l: Record Employee;
            begin
                if Employee_l.Get("Employee No.") then
                    Employee := Employee_l."Last Name";
            end;
        }
        field(50310; "Amt. Rcd. Not Invoiced"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Purchase Line"."Amt. Rcd. Not Invoiced" where("Document Type" = field("Document Type"),
                                                                              "Document No." = field("No.")));
            Caption = 'Qty. Rcd. Not Invoiced (Base)';
            Description = 'G-ERP';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50320; "Outstanding Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Purchase Line"."Outstanding Amount" where("Document Type" = field("Document Type"),
                                                                          "Document No." = field("No.")));
            Caption = 'Outstanding Amount';
            Description = 'G-ERP';
            FieldClass = FlowField;

            trigger OnValidate()
            var
                Currency2: Record Currency;
            begin
            end;
        }
        field(50350; "CO2 Menge in Kilogramm"; Decimal)
        {
            CalcFormula = sum("Purchase Line"."CO2 Menge in Kilogramm" where("Document Type" = field("Document Type"),
                                                                              "Document No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50400; "Send Date"; Date)
        {
            Caption = 'Send Date';
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
    keys
    {
        key(Key1; Serienanfragennr, TreeNo)
        {
        }
        key(KeyPRD; "Promised Receipt Date")
        {
        }
    }
    local procedure GetVend(VendNo: Code[20])
    begin
        IF VendNo <> Vend."No." THEN
            Vend.GET(VendNo);
    end;

    var
        "*****G-ERP*****": Integer;
        Purchaser: Record "Salesperson/Purchaser";
        Vend: Record Vendor;

}

