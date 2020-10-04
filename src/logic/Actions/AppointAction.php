<?php
namespace Htmlacademy\Logic\Actions;

class AppointAction extends AbstractAction
{
    /**
     * Возвращает название класса
     * @return string
     */
    public static function getTitle()
    {
        return 'Назначить';
    }

    /**
     * Возвращает внутреннее имя класса
     * @return string
     */
    public static function getInnerName()
    {
        return 'appoint';
    }

    /**
     * Проверяет, разрешено ли действие
     *
     * @param int $userId
     * @param int $clientId
     * @return bool
     */
    public static function isPermitted(int $userId, int $clientId)
    {
        if ($clientId === $userId) {
            return true;
        }
        return false;
    }
}