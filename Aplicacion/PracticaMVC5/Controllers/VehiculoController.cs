using PracticaMVC5.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace PracticaMVC5.Controllers
{
    public class VehiculoController : Controller
    {

        private readonly string _connectionString;

        public VehiculoController ()
        {
            _connectionString = ConfigurationManager.ConnectionStrings["conectDB"].ToString();
        }
        
        // GET: Vehiculo
        public ActionResult Index()
        {

            using (SqlConnection sql = new SqlConnection(_connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SpVehiculo", sql))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@spopc", 1));
                    cmd.Parameters.Add(new SqlParameter("@spcod", ""));
                    cmd.Parameters.Add(new SqlParameter("@spmarca", ""));
                    cmd.Parameters.Add(new SqlParameter("@spprecion", Convert.ToDecimal(0)));
                    cmd.Parameters.Add(new SqlParameter("@spfoto", ""));

                    var resp = new List<VehiculoModels>();
                    sql.Open();
                    using (var reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            resp.Add(new VehiculoModels()
                            {
                                Id = (int)reader["Id"],
                                Precio = Convert.ToDecimal(reader["Precio"]),
                                Marca = reader["Marca"].ToString(),
                                Foto = reader["Foto"].ToString()
                            });
                        }
                    }
                    return View(resp);
                }                
            }
        }

        [HttpGet]
        public ActionResult Nuevo(string Marca = "", Decimal Precio = 0, int Cod = 0, string Foto = "")
        {
            ViewBag.Message = "";
            ViewBag.Marca = Marca;
            ViewBag.Precio = Precio;
            ViewBag.Cod = Cod;
            ViewBag.Foto = Foto;
            return View();
        }

        [HttpPost]
        public ActionResult Nuevo(FormCollection value)
        {
            ViewBag.Message = value["Marca"];
            using (SqlConnection sql = new SqlConnection(_connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SpVehiculo", sql))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@spopc", 2));
                    cmd.Parameters.Add(new SqlParameter("@spcod", value["Id"]));
                    cmd.Parameters.Add(new SqlParameter("@spmarca", value["Marca"]));
                    cmd.Parameters.Add(new SqlParameter("@spprecion", Convert.ToDecimal(value["Precio"])));
                    cmd.Parameters.Add(new SqlParameter("@spfoto", value["Foto"]));

                    var resp = new List<VehiculoModels>();
                    sql.Open();
                    using (var reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            resp.Add(new VehiculoModels()
                            {
                                Id = (int)reader["Id"],
                                Precio = Convert.ToDecimal(reader["Precio"]),
                                Marca = reader["Marca"].ToString(),
                                Foto = reader["Foto"].ToString()
                            });
                        }
                    }
                    return RedirectToAction("Index");
                }
            }
        }
    }
}
