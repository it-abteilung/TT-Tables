#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
TableExtension 50045 tableextension50045 extends "Warehouse Activity Line" 
{
    keys
    {
        // Unsupported feature: Key containing base fields
        // key(Key1;"Qty. to Handle")
        // {
        // MaintainSIFTIndex = false;
        // MaintainSQLIndex = false;
        // }
        // Unsupported feature: Key containing base fields
        // key(Key2;"No.","Whse. Document No.","Source No.","Serial No.","Lot No.","Source Line No.","Whse. Document Line No.","Source Subline No.","Activity Type","Action Type","Source Type","Source Subtype","Source Document","Whse. Document Type","Line No.")
        // {
        // }
        // Unsupported feature: Key containing base fields
        // key(Key3;"No.","Activity Type","Action Type","Qty. to Handle (Base)")
        // {
        // }
    }


    //Unsupported feature: Code Modification on "SplitLine(PROCEDURE 27)".

    //procedure SplitLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        OnBeforeSplitLines(WhseActivLine);

        WhseActivLine.TESTFIELD("Qty. to Handle");
        #4..16
        ELSE
          LineSpacing := 10000;

        IF LineSpacing = 0 THEN BEGIN
          ReNumberAllLines(NewWhseActivLine,WhseActivLine."Line No.",NewLineNo);
          WhseActivLine.GET(WhseActivLine."Activity Type",WhseActivLine."No.",NewLineNo);
          LineSpacing := 5000;
        END;

        NewWhseActivLine.RESET;
        NewWhseActivLine.INIT;
        NewWhseActivLine := WhseActivLine;
        #29..32
          WhseActivLine."Qty. Outstanding (Base)" - WhseActivLine."Qty. to Handle (Base)";
        NewWhseActivLine."Qty. Outstanding" := NewWhseActivLine.Quantity;
        NewWhseActivLine."Qty. Outstanding (Base)" := NewWhseActivLine."Qty. (Base)";
        NewWhseActivLine."Qty. to Handle" := NewWhseActivLine.Quantity;
        NewWhseActivLine."Qty. to Handle (Base)" := NewWhseActivLine."Qty. (Base)";
        NewWhseActivLine."Qty. Handled" := 0;
        NewWhseActivLine."Qty. Handled (Base)" := 0;
        GetLocation("Location Code");
        #41..66
            WhseActivLine."Qty. to Handle",WhseActivLine.Cubage,WhseActivLine.Weight);
        OnBeforeModifyOldWhseActivLine(WhseActivLine);
        WhseActivLine.MODIFY;

        OnAfterSplitLines(WhseActivLine,NewWhseActivLine);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..19
        #26..35
        IF ISSERVICETIER AND NOT GUIALLOWED THEN BEGIN
          NewWhseActivLine."Qty. to Handle" := 0;
          NewWhseActivLine."Qty. to Handle (Base)" := 0;
        END ELSE BEGIN
          NewWhseActivLine."Qty. to Handle" := NewWhseActivLine.Quantity;
          NewWhseActivLine."Qty. to Handle (Base)" := NewWhseActivLine."Qty. (Base)";
        END;
        #38..69
        */
    //end;
}

