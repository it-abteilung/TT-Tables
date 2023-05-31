#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
TableExtension 50002 tableextension50002 extends Customer 
{
    fields
    {
        field(50000;"Alte Nr.";Code[20])
        {
            Description = 'G-ERP';
        }
        field(50010;Latitude;Decimal)
        {
            DecimalPlaces = 6:8;
            Description = 'G-ERP';
        }
        field(50020;Longitude;Decimal)
        {
            DecimalPlaces = 6:8;
            Description = 'G-ERP';
        }
        field(60000;DATEV;Code[20])
        {
            Caption = 'DATEV';
            Description = 'G-ERP';
        }
        field(82000;"Net Outstanding Orders (LCY)";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Sales Line"."Outstanding Amt.Excl.VAT (LCY)" where ("Document Type"=const(Order),
                                                                                   "Sell-to Customer No."=field("No."),
                                                                                   "Shortcut Dimension 1 Code"=field("Global Dimension 1 Filter"),
                                                                                   "Shortcut Dimension 2 Code"=field("Global Dimension 2 Filter"),
                                                                                   "Currency Code"=field("Currency Filter")));
            Caption = 'Net Outstanding Orders (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(82001;"Net Outstanding Quotes (LCY)";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Sales Line"."Outstanding Amt.Excl.VAT (LCY)" where ("Document Type"=const(Quote),
                                                                                   "Sell-to Customer No."=field("No."),
                                                                                   "Shortcut Dimension 1 Code"=field("Global Dimension 1 Filter"),
                                                                                   "Shortcut Dimension 2 Code"=field("Global Dimension 2 Filter"),
                                                                                   "Currency Code"=field("Currency Filter")));
            Caption = 'Net Outstanding Quotes (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(82002;"Dialing Code";Text[30])
        {
            Caption = 'Dialing Code';
            CharAllowed = '09--';

            trigger OnValidate()
            begin
                // + 01 ctm.we
                //generatePhoneNo;
                // - 01 ctm.we
            end;
        }
        field(82003;"Sales Sell-To-Cust (LCY)";Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where ("Initial Document Type"=filter(Invoice|"Credit Memo"),
                                                                                 "Entry Type"=const("Initial Entry"),
                                                                                 "Customer No."=field("No."),
                                                                                 "Initial Entry Global Dim. 1"=field("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2"=field("Global Dimension 2 Filter"),
                                                                                 "Posting Date"=field("Date Filter"),
                                                                                 "Currency Code"=field("Currency Filter")));
            Caption = 'Sales Sell-To-Cust (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(82007;"Name 3";Text[50])
        {
            Caption = 'Name 3';
        }
        field(83801;"Complete Phone No.";Text[90])
        {
            Caption = 'Complete Phone No.';
        }
    }
}

