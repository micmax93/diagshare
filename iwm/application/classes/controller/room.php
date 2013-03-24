<?php
/**
 * Created by: Marcin Biernacki <phisikus@platinum.linux.pl>
 * User: phisikus
 * Date: 24.03.13
 */

require("IwMController.php");

class Controller_Room extends IwMController
{

    public function action_get()
    {
       $rooms["OIOM"] = array(
            'Adam Kowalski' => array(
                "Zestaw1" => "Zdjęcie klatki piersiowej",
                "Obraz1" => "Inne zdjęcie"
            )
        );
        $rooms["Chirurgia"] = array(
            'Adam Kowalski' => array(
                "Zestaw1" => "Zdjęcie klatki piersiowej",
                "Obraz1" => "Inne zdjęcie"
            )
        );
        $rooms["Kardiologia"] = array(
            'Adam Kowalski' => array(
                "Zestaw1" => "Zdjęcie klatki piersiowej",
                "Obraz1" => "Inne zdjęcie"
            )
        );

        $rooms["Pulmunologia"] = array(
            'Adam Kowalski' => array(
                "Zestaw1" => "Zdjęcie klatki piersiowej",
                "Obraz1" => "Inne zdjęcie"
            )
        );

        $rooms["Kardiochirurgia"] = array(
            'Adam Kowalski' => array(
                "Zestaw1" => "Zdjęcie klatki piersiowej",
                "Obraz1" => "Inne zdjęcie"
            )
        );

        $rooms["Dermatologia"] = array(
            'Adam Kowalski' => array(
                "Zestaw1" => "Zdjęcie klatki piersiowej",
                "Obraz1" => "Inne zdjęcie"
            )
        );
        $rooms["Ogólny"] = array(
            'Adam Kowalski' => array(
                "Zestaw1" => "Zdjęcie klatki piersiowej",
                "Obraz1" => "Inne zdjęcie"
            )
        );



        $this->response->headers('Content-Type', 'application/json');
        $this->response->body(json_encode($rooms));
    }

}
