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
                $form->select('parent_id', __('Parent Category'))
                ->options((new CourseType())::selectOptions());
                $form->text('title', __('Title'));
                $form->textarea('description', __('Description'));
                $form->number('Order', __('Order'));

                return $form;
            }
}
