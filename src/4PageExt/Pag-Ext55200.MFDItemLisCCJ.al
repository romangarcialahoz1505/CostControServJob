pageextension 55200 "MFD Item Lis CCJ" extends "Item List"
{
    actions
    {
        addbefore("Item Journal")
        {
            action("CreateCCJ")
            {
                ApplicationArea = All;
                Caption = 'Crear Proyecto Control Coste';
                ToolTip = 'Crea un proyecto para cotrolar los costes de un producto de servicios';
                Image = Costs;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    CreateJobPage: Page "MFD Create Job CCJ";

                begin
                    CreateJobPage.SetFromItem(Rec);
                    CreateJobPage.RunModal();

                end;
            }
        }
    }
}
