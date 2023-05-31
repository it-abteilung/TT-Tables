#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
TableExtension 50015 tableextension50015 extends "Sales Shipment Header"
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
        }
        field(50004; "Unterschriftscode 2"; Code[10])
        {
            Caption = 'Salesperson Code';
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
        field(50063; Nachtext4; Text[90])
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
        field(82012; "Company No. Statistic"; Code[20])
        {
        }
        field(83711; "Chance of Success %"; Integer)
        {
            BlankZero = true;
            Caption = 'Chance of Success %';
            NotBlank = true;
            //ValuesAllowed = "0","10","20","30","40","50","60","70","80","90","100";
        }
    }
}

