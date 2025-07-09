# students/views.py
from django.shortcuts import render, redirect, get_object_or_404
from .models import Student

def student_list(request):
    students = Student.objects.all()
    return render(request, 'students/student_list.html', {'students': students})

def add_student(request):
    if request.method == 'POST':
        first_name = request.POST.get('first_name')
        last_name = request.POST.get('last_name')
        student_id = request.POST.get('student_id')
        email = request.POST.get('email')
        Student.objects.create(
            first_name=first_name,
            last_name=last_name,
            student_id=student_id,
            email=email
        )
    return redirect('student_list')

def delete_student(request, student_id):
    student = get_object_or_404(Student, pk=student_id)
    student.delete()
    return redirect('student_list')