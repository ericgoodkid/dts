from django.shortcuts import render
from django.http import Http404, HttpResponse, JsonResponse
from personal import views
from django.template import Context, loader
import json
import MySQLdb
from django.views.decorators.csrf import csrf_exempt

def getDocumentList(request):
    con = getConnection()
    cursor = con.cursor()
    data = []
    proc = "SELECT if (t_document_personnel_details_receiver_type = 'Student', concat(r_student_name, ' [ ', r_course_name, ' ', r_student_section, ' ] '), concat(r_employee_name, ' [ ', r_office_position_name, ' of ', r_office_type, ' ]') ) as receiver, if (t_document_personnel_details_receiver_type = 'Employee', concat(r_student_name, ' [ ', r_course_name, ' ', r_student_section, ' ] '), concat(r_employee_name, ' [ ', r_office_position_name, ' of ', r_office_type, ' ]') ) as sender, t_document_code,DATE_FORMAT(t_document_date, '%M %d, %Y %I:%i %p '),t_document_remarks,concat(r_document_category_description , ' [ ', r_document_name ,' ]') FROM `t_document` inner join t_document_personnel_details on t_document.t_document_personnel_details_id = t_document_personnel_details.t_document_personnel_details_id inner join r_document_type on t_document_type_id = r_document_type_id inner join r_document_category on t_document_category_id = r_document_category_id inner join r_student on t_document_personnel_details_student_id = r_student_id inner join r_course on r_student_course_id = r_course_id inner join r_employee on t_document_personnel_details_employee_id = r_employee_id inner join r_office_position on r_employee_office_position_id = r_office_position_id inner join r_office on r_office_position_office_id = r_office_id where t_document_display_status = true order by t_document_id desc"
    cursor.execute(proc)
    data = cursor.fetchall()
    con.close()
    dump = json.dumps(data)
    return HttpResponse(dump, content_type='application/json')

def getDocumentItem(request):
    con = getConnection()
    cursor = con.cursor()
    data = []
    sCode = request.GET.get('sCode')
    proc = "SELECT t_document_personnel_details_receiver_type,r_student_id as studId, r_employee_id as empId,if (t_document_personnel_details_receiver_type = 'Student', concat(r_student_name, ' [ ', r_course_name, ' ', r_student_section, ' ] '), concat(r_employee_name, ' [ ', r_office_position_name, ' of ', r_office_type, ' ]') ) as receiver, if (t_document_personnel_details_receiver_type = 'Employee', concat(r_student_name, ' [ ', r_course_name, ' ', r_student_section, ' ] '), concat(r_employee_name, ' [ ', r_office_position_name, ' of ', r_office_type, ' ]') ) as sender, r_document_category_id, r_document_type_id FROM `t_document` inner join t_document_personnel_details on t_document.t_document_personnel_details_id = t_document_personnel_details.t_document_personnel_details_id inner join r_document_type on t_document_type_id = r_document_type_id inner join r_document_category on t_document_category_id = r_document_category_id inner join r_student on t_document_personnel_details_student_id = r_student_id inner join r_course on r_student_course_id = r_course_id inner join r_employee on t_document_personnel_details_employee_id = r_employee_id inner join r_office_position on r_employee_office_position_id = r_office_position_id inner join r_office on r_office_position_office_id = r_office_id where t_document_display_status = true and t_document_code = '" + sCode + "' order by t_document_id desc"
    cursor.execute(proc)
    data = cursor.fetchone()
    con.close()
    dump = json.dumps(data)
    return HttpResponse(dump, content_type='application/json')   

def getStudentList(request):
    con = getConnection()
    cursor = con.cursor()
    data = []
    proc = "SELECT r_student_id,concat(r_student_name, ' [ ', r_course_name, ' ', r_student_section, ' ] ') as studentName from r_student inner join r_course on r_student_course_id = r_course_id where r_student_display_status = true"
    cursor.execute(proc)
    data = cursor.fetchall()
    con.close()
    dump = json.dumps(data)
    return HttpResponse(dump, content_type='application/json')

def getEmployeeList(request):
    con = getConnection()
    cursor = con.cursor()
    data = []
    proc = "SELECT r_employee_id, concat(r_employee_name, ' [ ', r_office_position_name, ' of ', r_office_type, ' ]') as employeeName FROM r_employee inner join r_office_position on r_employee_office_position_id = r_office_position_id inner join r_office on r_office_position_office_id = r_office_id where r_employee_display_status = true"
    cursor.execute(proc)
    data = cursor.fetchall()
    con.close()
    dump = json.dumps(data)
    return HttpResponse(dump, content_type='application/json')


def getCategoryList(request):
    con = getConnection()
    cursor = con.cursor()
    data = []
    proc = "SELECT r_document_category_id , r_document_category_description FROM `r_document_category` WHERE r_document_category_display_status = true"
    cursor.execute(proc)
    data = cursor.fetchall()
    con.close()
    dump = json.dumps(data)
    return HttpResponse(dump, content_type='application/json')

def getTypeList(request):
    con = getConnection()
    cursor = con.cursor()
    data = []
    proc = "SELECT r_document_type_id, r_document_name FROM `r_document_type` WHERE r_document_display_status = true"
    cursor.execute(proc)
    data = cursor.fetchall()
    con.close()
    dump = json.dumps(data)
    return HttpResponse(dump, content_type='application/json')

@csrf_exempt
def removeDocument(request):
    con = getConnection()
    cursor = con.cursor()
    if request.is_ajax():
        code = request.POST.get('sCode')
        proc = "update t_document set t_document_display_status = false WHERE t_document_code  = '" + code + "' "
        cursor.execute(proc)
        con.commit()
        con.close()
        return HttpResponse(getSuccessResult(), content_type='application/json')
    con.close()
    raise Http404

@csrf_exempt
def updateStatusDocument(request):
    con = getConnection()
    cursor = con.cursor()
    if request.is_ajax():
        code = request.POST.get('sCode')
        sStatus = request.POST.get('sStatus')
        proc = "update t_document set t_document_remarks = '" + sStatus + "' WHERE t_document_code  = '" + code + "' "
        cursor.execute(proc)
        con.commit()
        con.close()
        return HttpResponse(getSuccessResult(), content_type='application/json')
    con.close()
    raise Http404

@csrf_exempt
def saveDocument(request):
    con = getConnection()
    cursor = con.cursor()
    if request.is_ajax():
        sSenderType = request.POST.get('sSenderType')
        sCategoryId = request.POST.get('sCategoryId')
        sTypeId = request.POST.get('sTypeId')
        sReceiverId = request.POST.get('sReceiverId')
        sSenderId = request.POST.get('sSenderId')

        proc = "INSERT INTO t_document_personnel_details (t_document_personnel_details_receiver_type,t_document_personnel_details_student_id,t_document_personnel_details_employee_id) VALUES ('Employee','" + sReceiverId + "','" + sSenderId + "') "
        if sSenderType == 'Student':
            proc = "INSERT INTO t_document_personnel_details (t_document_personnel_details_receiver_type,t_document_personnel_details_student_id,t_document_personnel_details_employee_id) VALUES ('Student','" + sSenderId + "','" + sReceiverId + "') "
        cursor.execute(proc)
        con.commit()

        proc = "select CONCAT('DOC',RIGHT(100000+count(t_document_id)+1,5)) CODE from `t_document`"
        cursor.execute(proc)
        data = cursor.fetchone()    
        sCode = data[0]

        proc = "select t_document_personnel_details_id  from `t_document_personnel_details` order by t_document_personnel_details_id  desc limit 1"
        cursor.execute(proc)
        data = cursor.fetchone()    
        sDetailsId = data[0]
        proc = "INSERT INTO t_document (t_document_code , t_document_personnel_details_id, t_document_type_id, t_document_category_id) VALUES ('" + str(sCode) + "','" + str(sDetailsId) + "','" + sTypeId + "','" + sCategoryId + "') "
        cursor.execute(proc)
        con.commit()
        con.close()
        return HttpResponse(getSuccessResult(), content_type='application/json')
    con.close()
    raise Http404



@csrf_exempt
def updateDocument(request):
    con = getConnection()
    cursor = con.cursor()
    if request.is_ajax():
        code = request.POST.get('sCode')
        sSenderId = request.POST.get('sSenderId')
        sReceiverId = request.POST.get('sReceiverId')
        sTypeId = request.POST.get('sTypeId')
        sCategoryId = request.POST.get('sCategoryId')
        sSenderType = request.POST.get('sSenderType')
        proc = "update t_document set t_document_type_id  = '" + sTypeId + "', t_document_category_id = '" + sCategoryId + "'  WHERE t_document_code  = '" + code + "' "
        cursor.execute(proc)
        con.commit()

        proc = "select t_document_personnel_details_id  from `t_document` WHERE t_document_code  = '" + code + "'" 
        cursor.execute(proc)
        data = cursor.fetchone()    
        iDetailsId = data[0]

        proc = "update t_document_personnel_details set t_document_personnel_details_receiver_type  = 'Employee', t_document_personnel_details_student_id = '" + sReceiverId + "', t_document_personnel_details_employee_id  = '" + sSenderId + "'  WHERE t_document_personnel_details_id  = '" + str(iDetailsId) + "' "
        if sSenderType == 'Student':
            proc = "update t_document_personnel_details set t_document_personnel_details_receiver_type  = 'Student', t_document_personnel_details_student_id = '" + sSenderId + "', t_document_personnel_details_employee_id  = '" + sReceiverId + "'  WHERE t_document_personnel_details_id  = '" + str(iDetailsId) + "' "

        cursor.execute(proc)
        con.commit()


        con.close()
        return HttpResponse(getSuccessResult(), content_type='application/json')
    con.close()
    raise Http404

def getSuccessResult():
    return json.dumps({'bSuccess': True}) 

def getConnection():
    return MySQLdb.connect(user='root',db='dts',passwd='',host='localhost')