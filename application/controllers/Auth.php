<?php

//defined('BASEPATH') OR exit('No direct script access allowed');

require_once APPPATH . '/libraries/REST_Controller.php';
require APPPATH . 'libraries/REST_Controller_Definitions.php';

class Auth extends REST_Controller {

    public function __construct() {
        parent::__construct();
        $this->load->model('Loginapi_model');
    }

    public function login_post() {
        
        $username = $this->post('username');
        $password = $this->post('password');
        
        $invalidLogin = array ('invalid' => $username,
                               'status' => false);
        
        if(!$username || !$password) $this->response($username, REST_Controller::HTTP_NOT_FOUND);
        
        $id = $this->Loginapi_model->login($username,$password);
        $nu_rol = $this->Loginapi_model->rol($id);
        
        if($id) {
            
            $valid = array ('id' => $id,
                            'username' => $username,
                            'rol' => $nu_rol,
                        	'token' => $token = bin2hex(random_bytes(8)));
            
            $this->set_response($valid, REST_Controller::HTTP_OK);
        }
        else {
            $this->set_response($invalidLogin, REST_Controller::HTTP_NOT_FOUND);
        }
    }

/*      public function registro_post()
    {
        header("Access-Control-Allow-Origin: *");
        $_POST = json_decode($this->security->xss_clean(file_get_contents("php://input")),true);
        
        $input = $this->input->post();
        $this->db->insert('usuarios',$input);
     
        $this->response(['Usuario creado'], REST_Controller::HTTP_OK);
    } */

      public function insertcurso_post()
    {
        header("Access-Control-Allow-Origin: *");
        $_POST = json_decode($this->security->xss_clean(file_get_contents("php://input")),true);

        $maestro_id = $this->post('maestro_id');
        $nombre_curso = $this->post('nombre_curso');
        
        $valid = array ('maestro_id' => $maestro_id,
                        'nombre_curso' => $nombre_curso,
                        'clave_curso' => $token = bin2hex(random_bytes(3)));

        $this->db->insert('cursos',$valid);
     
        $this->response(['Curso creado'], REST_Controller::HTTP_OK);
    }

   public function curso_get($id){
        $data = $this->db->get_where("cursos", ['maestro_id' => $id])->result();
        $this->response($data, REST_Controller::HTTP_OK);
    }

   public function borrar_delete($id){
        $this->db->delete("cursos", array('id' => $id));
        $this->response(['Curso deleted successfully.'], REST_Controller::HTTP_OK);
    } 

       
       function upload_post() {
           header("Access-Control-Allow-Origin: *");
       //   $_POST = json_decode($this->security->xss_clean(file_get_contents("php://input")),true);
           header('Access-Control-Allow-Methods: POST');
           header('Access-Control-Allow-Headers: Content-Type');
            
        // Condicion para subir archivo
        if ($this->input->method()) {

            if(!$_FILES) {
                $this->response('Por favor escoje un archivo', 500);
                return;
            }
            
            //ruta de la carpeta en donde se van a suibr los archivos
            $upload_path = '/uploads/';
            //ruta destino
            $config['upload_path'] = $upload_path;
            //se permite todo tipo de archivo (imagen y audios)
            $config['allowed_types'] = '*';
            //permitir el peso maximo del archivo (0 significa que no tiene limite de peso) 
            $config['max_size'] = '0';
            //caracteres (largo de nombre)
            $config['max_filename'] = '255';
            //encriptar el nombre del archivo
            //$config['encrypt_name'] = TRUE;
            
            $this->load->library('upload', $config);
            
            //si la carpeta exite nos mandara a decir que ya se encuentra.
            //en caso de que no exista la crea
            if (file_exists($upload_path . $_FILES['file']['name'])) {
                $archivo = $this->response('El archivo ya existe => ' . $upload_path . $_FILES['file']['name']);
                return $archivo;
            } else {
                if (!file_exists($upload_path)) {
                    mkdir($upload_path, 0777, true);
                }
                
                //subir el archivo y capturar el post
                if($this->upload->do_upload('file')) {
                                    
                                         $problema = $this->input->post('problema');
                                         $imagen = 'https://' . $_SERVER['SERVER_NAME'] . $upload_path . $_FILES['file']['name'];
                                         $audio = 'https://' . $_SERVER['SERVER_NAME'] . $upload_path . $_FILES['file']['name'];
                                         $ejercicio_id = $this->input->post('ejercicio_id');


                                         
                                         $data = array (
                                                'problema'=>$problema,
                                                'imagen'=>$imagen,
                                                'audio'=>$audio,
                                                'ejercicio_id'=>$ejercicio_id
                                            );
                                         //insertar datos en la base
                                       $this->db->insert('ejercicio_contenidos',$data);

                                       $response=$this->response('si se pudo');

                    return $response;

                } else {
                        //en caso de que no te manda el mensaje de error
                    $this->response('Error al subir el archivo =>' . $this->upload->display_errors(), 500);
                    return;
                }
            }
   
        }
    }

}