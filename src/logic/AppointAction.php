<?php
namespace Htmlacademy\Logic;

class AppointAction extends AbstractAction
{
    /**
     * Возвращает название класса
     * @return string
     */
    static function getTitle()
    {
        return 'Назначить';
    }

    /**
     * Возвращает внутреннее имя класса
     * @return string
     */
    static function getInnerName()
    {
        return 'appoint';
    }

    /**
     * Проверяет, разрешено ли действие
     *
     * @param int $clientId
     * @return bool
     */
    static function isPermitted($userId, $clientId)
    {
        if ($clientId === $userId) {
            return true;
        }
        return false;
    }
}
