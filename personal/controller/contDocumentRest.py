from django.shortcuts import render
from django.http import Http404,HttpResponse
import json
import MySQLdb


def Admin_ClearanceSignatory(request):    
    return render(request, 'personal/Admin/ClearanceSignatory.html',{"list":Admin_List()})


