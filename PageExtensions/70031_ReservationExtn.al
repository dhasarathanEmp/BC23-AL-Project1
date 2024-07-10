pageextension 70031 ReservationExtn extends Reservation
{
    //Commented Auto Reserve1 function
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        modify(CancelReservationCurrentLine)
        {
            Enabled = false;
        }
    }
    procedure SetTransLine(CurrentTransLine: Record "Transfer Line"; Direction: Option Outbound,Inbound)
    begin
        CLEARALL;
        Block := TRUE;
        TransLine := CurrentTransLine;
        ReservEntry.SetSource(
          DATABASE::"Transfer Line", Direction, CurrentTransLine."Document No.", CurrentTransLine."Line No.",
          '', CurrentTransLine."Derived From Line No.");
        ReservEntry."Item No." := CurrentTransLine."Item No.";
        ReservEntry."Variant Code" := CurrentTransLine."Variant Code";
        CASE Direction OF
            Direction::Outbound:
                BEGIN
                    ReservEntry."Location Code" := CurrentTransLine."Transfer-from Code";
                    ReservEntry."Shipment Date" := CurrentTransLine."Shipment Date";
                END;
            Direction::Inbound:
                BEGIN
                    ReservEntry."Location Code" := CurrentTransLine."Transfer-to Code";
                    ReservEntry."Shipment Date" := CurrentTransLine."Receipt Date";
                END;
        END;
        ReservEntry."Qty. per Unit of Measure" := CurrentTransLine."Qty. per Unit of Measure";
        CaptionText := ReserveTransLine.Caption(TransLine);
        UpdateReservFrom;
    end;

    /* procedure AutoReserve1()
     begin
         ReservMgt.AutoReserveBatch(
           FullAutoReservation, ReservEntry.Description,
           ReservEntry."Shipment Date", QtyToReserve - QtyReserved, QtyToReserveBase - QtyReservedBase, Block);

         UpdateReservFrom;
     end; */

    var
        myInt: Integer;
        ReservEntry: Record "Reservation Entry";
        TransLine: Record "Transfer Line";
        Block: Boolean;
        CaptionText: Text;
        ReserveTransLine: Codeunit "Transfer Line-Reserve";
        ReservMgt: Codeunit "Reservation Management";


}