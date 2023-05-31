#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
TableExtension 50040 tableextension50040 extends "Transfer Line" 
{

    //Unsupported feature: Code Modification on "UpdateWithWarehouseShipReceive(PROCEDURE 41)".

    //procedure UpdateWithWarehouseShipReceive();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF Location.RequireShipment("Transfer-from Code") THEN
          VALIDATE("Qty. to Ship",0)
        ELSE
          VALIDATE("Qty. to Ship","Outstanding Quantity");

        IF Location.RequireReceive("Transfer-to Code") THEN
          VALIDATE("Qty. to Receive",0)
        #8..10
          IF ("In-Transit Code" = '') AND ("Quantity Shipped" = "Quantity Received") THEN
            VALIDATE("Qty. to Receive","Qty. to Ship");
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
          //-ETISCAN001
          //VALIDATE("Qty. to Ship","Outstanding Quantity");
          InitQtyToShip;
          //+ETISCAN001
        #5..13
        */
    //end;


    //Unsupported feature: Code Modification on "GetDefaultBin(PROCEDURE 5)".

    //procedure GetDefaultBin();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF (FromLocationCode <> '') AND ("Item No." <> '') THEN BEGIN
          GetLocation(FromLocationCode);
          IF Location."Bin Mandatory" AND NOT Location."Directed Put-away and Pick" THEN BEGIN
        #4..7

        IF (ToLocationCode <> '') AND ("Item No." <> '') THEN BEGIN
          GetLocation(ToLocationCode);
          IF Location."Bin Mandatory" AND NOT Location."Directed Put-away and Pick" THEN
            WMSManagement.GetDefaultBin("Item No.","Variant Code",ToLocationCode,"Transfer-To Bin Code");
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..10
          IF ("Transfer-To Bin Code" = '') THEN                              // G-ERP.AG 2021-04-26
        #11..13
        */
    //end;
}

