using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace Calculadora
{
    /// <summary>
    /// Descripción breve de WebService1
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class WebService1 : System.Web.Services.WebService
    {
        [WebMethod]
        public string crearUsuarios( string us_nom, string us_correro, string us_contra)
        {
            Oracle_conection conn = new Oracle_conection();
            conn.EstablecerConnection();

            Procedimientos pc = new Procedimientos();


            return pc.crearUsuarios(conn.GetConexion(), us_nom, us_correro, us_contra);

        }
        [WebMethod]
        public string listarUsuarios()
        {
            Oracle_conection conn = new Oracle_conection();
            conn.EstablecerConnection();

            Procedimientos pc = new Procedimientos();

            return pc.listarUsuarios(conn.GetConexion());

        }
        [WebMethod]
        public string actualizarUsuario( string us_nom, string us_correro, string us_contra)
        {
            Oracle_conection conn = new Oracle_conection();
            conn.EstablecerConnection();

            Procedimientos pc = new Procedimientos();


            return pc.actualizarUsuario(conn.GetConexion(), us_nom, us_correro, us_contra);


        }
        [WebMethod]
        public string eliminarUsuario(int us_id)
        {
            Oracle_conection conn = new Oracle_conection();
            conn.EstablecerConnection();
            
            Procedimientos pc = new Procedimientos();


            return pc.eliminarUsuario(conn.GetConexion(), us_id);

        }

        [WebMethod]
        public string crearCategoria(string nom_cat)
        {
            Oracle_conection conn = new Oracle_conection();
            conn.EstablecerConnection();

            Procedimientos pc = new Procedimientos();


            return pc.crearCategoria(conn.GetConexion(), nom_cat);

        }
        [WebMethod]
        public string listarCategoria()
        {
            Oracle_conection conn = new Oracle_conection();
            conn.EstablecerConnection();

            Procedimientos pc = new Procedimientos();

            return pc.listarCategoria(conn.GetConexion());

        }
        [WebMethod]
        public string actualizarCategoria (int cat_id, string cat_nombre)
        {
            Oracle_conection conn = new Oracle_conection();
            conn.EstablecerConnection();

            Procedimientos pc = new Procedimientos();


            return pc.actualizarCategoria(conn.GetConexion(), cat_id, cat_nombre);


        }
        [WebMethod]
        public string eliminarCategoria(int cat_id)
        {
            Oracle_conection conn = new Oracle_conection();
            conn.EstablecerConnection();

            Procedimientos pc = new Procedimientos();


            return pc.eliminarCategoria(conn.GetConexion(), cat_id);

        }

        [WebMethod]
        public string crearProducto(string nom_prod, string des_prod, int pre_prod, int cate_id)
        {
            Oracle_conection conn = new Oracle_conection();
            conn.EstablecerConnection();

            Procedimientos pc = new Procedimientos();


            return pc.crearProducto(conn.GetConexion(), nom_prod, des_prod, pre_prod, cate_id);

        }
        [WebMethod]
        public string listarProductos()
        {
            Oracle_conection conn = new Oracle_conection();
            conn.EstablecerConnection();

            Procedimientos pc = new Procedimientos();

            return pc.listarProductos(conn.GetConexion());

        }
        [WebMethod]
        public string actualizarProducto(int prod_id, string prod_nombre, string prod_des, string prod_precio, int prod_idcat)
        {
            Oracle_conection conn = new Oracle_conection();
            conn.EstablecerConnection();

            Procedimientos pc = new Procedimientos();


            return pc.actualizarProducto(conn.GetConexion(), prod_id, prod_nombre, prod_des, prod_precio, prod_idcat);


        }
        [WebMethod]
        public string eliminarProducto(int prod_id)
        {
            Oracle_conection conn = new Oracle_conection();
            conn.EstablecerConnection();

            Procedimientos pc = new Procedimientos();


            return pc.eliminarProducto(conn.GetConexion(), prod_id);

        }


    }
}