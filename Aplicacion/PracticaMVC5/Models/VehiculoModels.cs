using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PracticaMVC5.Models
{
    public class VehiculoModels
    {
        public int Id { get; set; }
        public decimal Precio { get; set; }
        public string Marca { get; set; }
        public string Foto { get; set; }
    }
}