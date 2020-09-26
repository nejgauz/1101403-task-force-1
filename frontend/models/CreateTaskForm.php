<?php


namespace frontend\models;


use yii\base\Model;
use yii\web\UploadedFile;

class CreateTaskForm extends Model
{
    public $title;

    public $description;

    public $category = [
        '1' => 'Перевод',
        '2' => 'Уборка',
        '3' => 'Переезды',
        '4' => 'Компьютерная помощь',
        '5' => 'Ремонт квартирный',
        '6' => 'Ремонт техники',
        '7' => 'Красота',
        '8' => 'Фото'
    ];

    public $chosenCategory;

    /**
     * @var UploadedFile[]
     */
    public $attachments;

    // TODO: реализовать следующие части формы
//    public $location;

    public $budget;

    public $dt_end;

    public function rules()
    {
        return [
            [
                'description', 'string', 'length' => [4, 255],
                'skipOnEmpty' => false,
                'tooShort' => 'Описание должно содержать не менее 4 символов',
                'tooLong' => 'Описание должно содержать не более 255 символов'
            ],
            [
                ['title', 'category', 'attachments', 'budget', 'dt_end'], 'required', 'message' => 'Поле не может быть пустым'
            ],
            [
                'dt_end', function ($attribute, $params)
                {
                    if (strtotime($this->$attribute) < strtotime('tomorrow')) {
                        $this->addError($attribute, 'Дата не является допустимой. Выберите дату хотя бы на один день позднее, чем сегодня.');
                    }

                }
            ],
            [
                'attachments', 'file', 'mimeTypes' => 'image/*', 'maxFiles' => 5,
                'message' => 'Максимальное количество загружаемых файлов - 5'
            ],
            [
                'chosenCategory', 'exist', 'targetClass' => 'frontend\models\Categories', 'targetAttribute' => 'id',
                'message' => 'Выбранной категории не существует'
            ]
        ];
    }

    public function attributeLabels()
    {
        return [
            'title' => 'Мне нужно',
            'description' => 'Подробности задания',
            'category' => 'Категория',
            'attachments' => 'Файлы',
            // TODO: доделать
//            'location' => 'Локация',
            'budget' => 'Бюджет',
            'dt_end' => 'Срок исполнения',
            'chosenCategory' => 'Категория'
        ];
    }

}
