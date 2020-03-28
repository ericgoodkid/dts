from django.shortcuts import render
from django.http import Http404,HttpResponse
import json
import MySQLdb


def indexPage(request):    
    return render(request, 'templates/personal/Admin/ClearanceSignatory.html',{"list": {}})


