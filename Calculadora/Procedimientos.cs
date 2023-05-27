using Newtonsoft.Json;
using Oracle.ManagedDataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;


namespace Calculadora
{
    public class Procedimientos
    {
        public string crearUsuarios(OracleConnection conn, string us_nom, string us_correro, string us_contra)
        {

            OracleParameter user_name = new OracleParameter();
            user_name.OracleDbType = OracleDbType.Varchar2;
            user_name.Value = us_nom;

            OracleParameter user_cor = new OracleParameter();
            user_cor.OracleDbType = OracleDbType.Varchar2;
            user_cor.Value = us_correro;


            OracleParameter user_contra = new OracleParameter();
            user_contra.OracleDbType = OracleDbType.Varchar2;
            user_contra.Value = us_contra;

            OracleCommand cmd = new OracleCommand();
            cmd.Connection = conn;
            cmd.CommandText = "crearUsuarios";
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add("Nombre:", OracleDbType.Varchar2).Value = user_name.Value;
            cmd.Parameters.Add("Correo:", OracleDbType.Varchar2).Value = user_cor.Value;
            cmd.Parameters.Add("Contraseña:", OracleDbType.Varchar2).Value = user_contra.Value;
            cmd.ExecuteNonQuery();

            string respuesta = "Uusuario creado";
            conn.Dispose();

            return respuesta;
        }
        public string listarUsuarios(OracleConnection conn)
        {

            OracleCommand cmd = new OracleCommand();
            cmd.Connection = conn;


            OracleParameter param_cursor = new OracleParameter();
            param_cursor.OracleDbType = OracleDbType.RefCursor;

            cmd.CommandText = "listarUsuarios";
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add("usr_cursor", OracleDbType.RefCursor).Direction = ParameterDirection.Output;



            DataSet ds = new DataSet();
            OracleDataAdapter da = new OracleDataAdapter(cmd);
            da.Fill(ds);

            return JsonConvert.SerializeObject(ds, Newtonsoft.Json.Formatting.Indented);
        }
        public string actualizarUsuario(OracleConnection conn, string us_nom, string us_correro, string us_contraseña)
        {


            OracleParameter user_nom = new OracleParameter();
            user_nom.OracleDbType = OracleDbType.Varchar2;
            user_nom.Value = us_nom;

            OracleParameter user_correo = new OracleParameter();
            user_correo.OracleDbType = OracleDbType.Varchar2;
            user_correo.Value = us_correro;

            OracleParameter user_contra = new OracleParameter();
            user_contra.OracleDbType = OracleDbType.Varchar2;
            user_contra.Value = us_contraseña;


            OracleCommand cmd = new OracleCommand();
            cmd.Connection = conn;
            cmd.CommandText = "actualizarUsuario";
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            cmd.Parameters.Add("Nombre:", OracleDbType.Varchar2).Value = user_nom.Value;
            cmd.Parameters.Add("Correo:", OracleDbType.Varchar2).Value = user_correo.Value;
            cmd.Parameters.Add("Contraseña:", OracleDbType.Varchar2).Value = user_contra.Value;
            cmd.ExecuteNonQuery();

            string respuesta = "Usuario Actualizado";
            conn.Dispose();

            return respuesta;
        }
        public string eliminarUsuario(OracleConnection conn, int us_id)
        {

            OracleParameter user_id = new OracleParameter();
            user_id.OracleDbType = OracleDbType.Varchar2;
            user_id.Value = us_id;


            OracleCommand cmd = new OracleCommand();
            cmd.Connection = conn;
            cmd.CommandText = "eliminarUsuario";
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add("ID:", OracleDbType.Varchar2).Value = user_id.Value;


            cmd.ExecuteNonQuery();

            string respuesta = "Usuario Eliminado";
            conn.Dispose();

            return respuesta;
        }
        public string crearCategoria(OracleConnection conn, string nom_cat)
        {

            OracleParameter cat_name = new OracleParameter();
            cat_name.OracleDbType = OracleDbType.Varchar2;
            cat_name.Value = nom_cat;

            OracleCommand cmd = new OracleCommand();
            cmd.Connection = conn;
            cmd.CommandText = "crearCategoria";
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add("Categoria:", OracleDbType.Varchar2).Value = cat_name.Value;
            cmd.ExecuteNonQuery();

            string respuesta = "Cateogria creado";
            conn.Dispose();

            return respuesta;
        }
        public string listarCategoria(OracleConnection conn)
        {

            OracleCommand cmd = new OracleCommand();
            cmd.Connection = conn;


            OracleParameter param_cursor = new OracleParameter();
            param_cursor.OracleDbType = OracleDbType.RefCursor;

            cmd.CommandText = "listarCategoria";
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add("list_cursor", OracleDbType.RefCursor).Direction = ParameterDirection.Output;



            DataSet ds = new DataSet();
            OracleDataAdapter da = new OracleDataAdapter(cmd);
            da.Fill(ds);

            return JsonConvert.SerializeObject(ds, Newtonsoft.Json.Formatting.Indented);
        }
        public string actualizarCategoria(OracleConnection conn, int cat_id, string cat_nombre)
        {


            OracleParameter cate_id = new OracleParameter();
            cate_id.OracleDbType = OracleDbType.Varchar2;
            cate_id.Value = cat_id;

            OracleParameter cate_nombre = new OracleParameter();
            cate_nombre.OracleDbType = OracleDbType.Varchar2;
            cate_nombre.Value = cat_nombre;


            OracleCommand cmd = new OracleCommand();
            cmd.Connection = conn;
            cmd.CommandText = "actualizarCategoria";
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            cmd.Parameters.Add("ID de la categoria para cambiar:", OracleDbType.Varchar2).Value = cate_id.Value;
            cmd.Parameters.Add("Nombre para actualizar:", OracleDbType.Varchar2).Value = cate_nombre.Value;


            cmd.ExecuteNonQuery();

            string respuesta = "Cateogria Actualizado";
            conn.Dispose();

            return respuesta;
        }

        public string eliminarCategoria(OracleConnection conn, int cat_id)
        {

            OracleParameter cate_id = new OracleParameter();
            cate_id.OracleDbType = OracleDbType.Varchar2;
            cate_id.Value = cat_id;


            OracleCommand cmd = new OracleCommand();
            cmd.Connection = conn;
            cmd.CommandText = "eliminarCategoria";
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add("Id de Categoria", OracleDbType.Varchar2).Value = cate_id.Value;


            cmd.ExecuteNonQuery();

            string respuesta = "Categoria Eliminado";
            conn.Dispose();

            return respuesta;
        }
        public string crearProducto(OracleConnection conn, string nom_prod, string des_prod, int pre_prod, int cate_id)
        {

            OracleParameter prod_name = new OracleParameter();
            prod_name.OracleDbType = OracleDbType.Varchar2;
            prod_name.Value = nom_prod;


            OracleParameter prod_des = new OracleParameter();
            prod_des.OracleDbType = OracleDbType.Varchar2;
            prod_des.Value = des_prod;


            OracleParameter prod_pre = new OracleParameter();
            prod_pre.OracleDbType = OracleDbType.Varchar2;
            prod_pre.Value = pre_prod;


            OracleParameter prod_fk = new OracleParameter();
            prod_fk.OracleDbType = OracleDbType.Varchar2;
            prod_fk.Value = cate_id;

            OracleCommand cmd = new OracleCommand();
            cmd.Connection = conn;
            cmd.CommandText = "crearProducto";
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add("Nombre :", OracleDbType.Varchar2).Value = prod_name.Value;
            cmd.Parameters.Add("Descipcion :", OracleDbType.Varchar2).Value = prod_des.Value;
            cmd.Parameters.Add("Precio :", OracleDbType.Varchar2).Value = prod_pre.Value;
            cmd.Parameters.Add("Cateogira (ID) :", OracleDbType.Varchar2).Value = prod_fk.Value;


            cmd.ExecuteNonQuery();

            string respuesta = "Producto creado";
            conn.Dispose();

            return respuesta;
        }
        public string listarProductos(OracleConnection conn)
        {

            OracleCommand cmd = new OracleCommand();
            cmd.Connection = conn;


            OracleParameter param_cursor = new OracleParameter();
            param_cursor.OracleDbType = OracleDbType.RefCursor;

            cmd.CommandText = "listarProductos";
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add("list_prod", OracleDbType.RefCursor).Direction = ParameterDirection.Output;



            DataSet ds = new DataSet();
            OracleDataAdapter da = new OracleDataAdapter(cmd);
            da.Fill(ds);

            return JsonConvert.SerializeObject(ds, Newtonsoft.Json.Formatting.Indented);
        }
        public string actualizarProducto(OracleConnection conn, int prod_id, string prod_nombre, string prod_des, string prod_precio, int prod_idcat)
        {

            OracleParameter id_produc = new OracleParameter();
            id_produc.OracleDbType = OracleDbType.Varchar2;
            id_produc.Value = prod_id;

            OracleParameter produ_name = new OracleParameter();
            produ_name.OracleDbType = OracleDbType.Varchar2;
            produ_name.Value = prod_nombre;

            OracleParameter produ_des = new OracleParameter();
            produ_des.OracleDbType = OracleDbType.Varchar2;
            produ_des.Value = prod_des;

            OracleParameter produ_precio = new OracleParameter();
            produ_precio.OracleDbType = OracleDbType.Varchar2;
            produ_precio.Value = prod_precio;

            OracleParameter cate_nombre = new OracleParameter();
            cate_nombre.OracleDbType = OracleDbType.Varchar2;
            cate_nombre.Value = prod_idcat;



            OracleCommand cmd = new OracleCommand();
            cmd.Connection = conn;
            cmd.CommandText = "actualizarProducto";
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            cmd.Parameters.Add("ID del producto a actualizar para cambiar:", OracleDbType.Varchar2).Value = id_produc.Value;
            cmd.Parameters.Add("Nombre para actualizar:", OracleDbType.Varchar2).Value = produ_name.Value;
            cmd.Parameters.Add("Descripcion para modificar:", OracleDbType.Varchar2).Value = produ_des.Value;
            cmd.Parameters.Add("Precio para modificar:", OracleDbType.Varchar2).Value = produ_precio.Value;
            cmd.Parameters.Add("iD para cambiar la categoria del prodcuto:", OracleDbType.Varchar2).Value = cate_nombre.Value;




            cmd.ExecuteNonQuery();

            string respuesta = "Produdcto Actualizado";
            conn.Dispose();

            return respuesta;
        }
        public string eliminarProducto(OracleConnection conn, int prod_id)
        {

            OracleParameter produ_id = new OracleParameter();
            produ_id.OracleDbType = OracleDbType.Varchar2;
            produ_id.Value = prod_id;


            OracleCommand cmd = new OracleCommand();
            cmd.Connection = conn;
            cmd.CommandText = "eliminarProducto";
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add("Id de Categoria para eliminar ", OracleDbType.Varchar2).Value = produ_id.Value;


            cmd.ExecuteNonQuery();

            string respuesta = "Producto Eliminado";
            conn.Dispose();

            return respuesta;

        }
    }
}