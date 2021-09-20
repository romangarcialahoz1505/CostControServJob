pageextension 55202 "MFD Jobs Setup CCJ" extends "Jobs Setup"
{
    layout
    {
        addafter("Job WIP Nos.")
        {
            group(CostControlServicies)
            {
                Caption = 'Control Coste Servicios';

                field("Customer No. CCJ"; "Customer No. CCJ")
                {
                    ToolTip = 'Ciente predeterminado en la generacion de proyectos para el control de coste de produtos servicios';
                }
                field("Job Posting Group CCJ"; "Job Posting Group CCJ")
                {
                    ToolTip = 'Grupo registro proyectos predeterminado en la generacion de proyectos para el control de coste de produtos servicios';
                }
                field("Method WIP CCJ"; "Method WIP CCJ")
                {
                    ToolTip = 'Método WIP predeterminado en la generacion de proyectos para el control de coste de produtos servicios';
                }
                field("Multi-Jobs per Item CCJ"; "Multi-Jobs per Item CCJ")
                {
                    ToolTip = 'Permitir Multi-proyectos por producto';
                }
                field("Job Task No CCJ"; "Job Task No CCJ")
                {
                    ToolTip = 'Código tarea predeterminado para generar la única del proyecto';
                }
                field("Job Type Line Default CCJ"; "Job Type Line Default CCJ")
                {
                    ToolTip = 'Tipo Línea Proyecto al indicar introducier el código del proyecto en documentos de compra al proyecto';
                }
                field("Self-fullfill Puchase Doc. Job"; "Self-fullfill Puchase Doc. Job")
                {
                    ToolTip = 'Autocumplimentar los campos en documentos de compras con la tarea del proyecto asignado';
                }
            }
        }
    }

}
