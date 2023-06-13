<?php

namespace App\Admin\Controllers;

use App\Models\User;
use App\Models\CourseType;
use App\Models\Course;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;
use Encore\Admin\Layout\Content;
use Encore\Admin\Tree;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class CourseController extends AdminController
{

    protected function grid(){
        $grid = new Grid(new Course());

        return $grid;
    }

    //
    protected function detail($id)
        {
            $show = new Show(Course::findOrFail($id));

            $show->field('id', __('Id'));
            $show->field('title', __('Category'));
            $show->field('description', __('Description'));
            $show->field('order', __("Order"));
            $show->field('created_at', __('Created at'));
            $show->field('updated_at', __('Updated at'));


            return $show;
        }

        protected function form()
            {
                $form = new Form(new Course());
                $form->text('name', __('Name'));
                //getting categories
                //key value pair -> last one is the key
                $result = CourseType::pluck('title', 'id');
                //selecting one of the options from result
                $form->select('type_id', __('Category'))->options($result);
                $form->image('thumbnail', __('Thumbnail'))->uniqueName();
                $form->file('video', __('Video'))->uniqueName();
                $form->text('description', __('Description'));
                $form->decimal('price', __('Price'));
                $form->number('lesson_num', __('Lesson number'));
                $form->number('video_length', __('Video length'));
                $result = User::pluck('name', 'token');
                $form->select('user_token', __('Teacher'))->options($result);
                $form->display('created_at', __('Created at'));
                $form->display('updated_at', __('Updated at'));
               /*$form->text('title', __('Title'));
                $form->textarea('description', __('Description'));
                $form->number('Order', __('Order'));*/

                return $form;
            }
}
