TableExtension 50006 tableextension50006 extends "Sales Header"
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
                LiquidityPlanning_l: Record "Liquidity Planning";
            begin
                LiquidityPlanning_l.SetRange("Job No.", "Job No.");
                LiquidityPlanning_l.SetFilter("Invoice No.", '%1', '');
                if LiquidityPlanning_l.FindSet() then begin
                    if Page.RunModal(0, LiquidityPlanning_l) = Action::LookupOK then begin
                        LiquidityPlanning_l."Invoice No." := "No.";
                        LiquidityPlanning_l.Modify();
                    end;
                end;
            end;
        }
        field(50003; Unterschriftscode; Code[10])
        {
            Caption = 'Unterschriftscode';
            Description = 'G-ERP';
            TableRelation = "Salesperson/Purchaser";
        }
        field(50004; "Unterschriftscode 2"; Code[10])
        {
            Caption = 'Unterschriftscode 2';
            Description = 'G-ERP';
            TableRelation = "Salesperson/Purchaser";
        }
        field(50005; "Validity (DAYS)"; Integer)
        {
            Description = 'G-ERP';
        }
        field(50006; Delivery; Code[30])
        {
            Description = 'G-ERP';

            trigger OnValidate()
            begin
                // if Delivery <> xRec.Delivery then
                //     UpdateSalesLines(FieldCaption(Delivery), CurrFieldNo <> 0);
            end;
        }
        field(50007; Preisstellung; Option)
        {
            Description = 'G-ERP';
            OptionCaption = 'unpacked,packed';
            OptionMembers = unpacked,packed;
        }
        field(50008; "Place of delivery"; Text[100])
        {
            Description = 'G-ERP';
        }
        field(50009; "Date of delivery"; Date)
        {
            Description = 'G-ERP';
        }
        field(50010; "Invoice No."; Code[30])
        {
            Description = 'G-ERP';
        }
        field(50011; Bank; Option)
        {
            Description = 'G-ERP';
            OptionMembers = " ","Deutsche Bank",OLB,LzO;
        }
        field(50015; Salutation; Text[100])
        {
            Caption = 'Anrede';
        }
        field(50050; Vortext1; Text[90])
        {
            Description = 'G-ERP';
        }
        field(50051; Vortext2; Text[90])
        {
            Description = 'G-ERP';
        }
        field(50052; Vortext3; Text[90])
        {
            Description = 'G-ERP';
        }
        field(50053; Vortext4; Text[90])
        {
            Description = 'G-ERP';
        }
        field(50060; Nachtext1; Text[90])
        {
            Description = 'G-ERP';
        }
        field(50061; Nachtext2; Text[90])
        {
            Description = 'G-ERP';
        }
        field(50062; Nachtext3; Text[90])
        {
            Description = 'G-ERP';
        }
        field(50063; Nachtext4; Text[70])
        {
            Description = 'G-ERP';
        }
        field(82007; "Sell-to Customer Name 3"; Text[50])
        {
            Caption = 'Sell-to Customer Name 3';
        }
        field(82008; "Bill-to Name 3"; Text[50])
        {
            Caption = 'Bill-to Name 3';
        }
        field(82009; "Ship-to Name 3"; Text[50])
        {
            Caption = 'Ship-to Name 3';
        }
        field(82010; "Sell-to Company No."; Code[20])
        {
            Caption = 'Sell-to Company No.';
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
        field(82011; "Outstanding Amt.Excl.VAT (LCY)"; Decimal)
        {
            CalcFormula = sum("Sales Line"."Outstanding Amt.Excl.VAT (LCY)" where("Document Type" = field("Document Type"),
                                                                                   "Document No." = field("No.")));
            Caption = 'Outstanding Amount Excl. VAT (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(82012; "Company No. Statistic"; Code[20])
        {
        }
        field(83701; Kostenstellenfilter; Code[10])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(83702; "EinstandGes (MW)"; Decimal)
        {
            CalcFormula = sum("Sales Line"."EinstandspreisGes (MW)" where("Document Type" = field("Document Type"),
                                                                           "Document No." = field("No."),
                                                                           "Shortcut Dimension 1 Code" = field(Kostenstellenfilter),
                                                                           Type = field(ArtFilter)));
            FieldClass = FlowField;
        }
        field(83711; "Chance of Success %"; Integer)
        {
            BlankZero = true;
            Caption = 'Chance of Success %';
            NotBlank = true;
            //ValuesAllowed = "0","10","20","30","40","50","60","70","80","90","100";
        }
        field(83738; "Betrag (MW)"; Decimal)
        {
            CalcFormula = sum("Sales Line"."Betrag (MW)" where("Document Type" = field("Document Type"),
                                                                "Document No." = field("No."),
                                                                "Shortcut Dimension 1 Code" = field(Kostenstellenfilter),
                                                                Type = field(ArtFilter)));
            FieldClass = FlowField;
        }
        field(83739; ArtFilter; Option)
        {
            FieldClass = FlowFilter;
            OptionMembers = " ",Sachkonto,Artikel,Ressource;
        }
        field(83750; "Status Approval 1"; Boolean)
        {
            Caption = 'Status Approval 1';
        }
        field(83751; "Status Approval 2"; Boolean)
        {
            Caption = 'Status Approval 2';
        }
    }
}

