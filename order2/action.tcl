
proc nLint_sreport {ruleno id args} {
 global g_SourceFile
   set line [npi_get $id -npiLineNo -npiFile $g_SourceFile]
   set file [npi_get $g_SourceFile -npiFullName]
 set fmt [nl_get $ruleno -nlMessage]
 set fmt_cmd "set msg \[format \$fmt "
 for {set i 0} {$i < [llength $args]} {incr i} {
   set fmt_cmd "$fmt_cmd \[lindex \$args $i\]"
 }
 set fmt_cmd "$fmt_cmd\]"
 eval $fmt_cmd
 nl_report $file $line $ruleno $msg
}
proc nLint_report {ruleno id args} {
 global g_SourceFile
   set line [npi_get $id -npiLineNo]
   set file [npi_get $id -npiFile]
 set fmt [nl_get $ruleno -nlMessage]

 set fmt_cmd "set msg \[format \$fmt "
 for {set i 0} {$i < [llength $args]} {incr i} {
   set fmt_cmd "$fmt_cmd \[lindex \$args $i\]"
 }
 set fmt_cmd "$fmt_cmd\]"
 eval $fmt_cmd
 nl_report $file $line $ruleno $msg
}
proc GlueLogic {} {
    global g_DesignUnit

    set en_dis [nl_get 30007 -nlStatus]
    if { $en_dis == "disable" } {
        return
    }
    if {[npi_get $g_DesignUnit -npiIsTopDesignUnit]} {
       set instlist [npi_iterate $g_DesignUnit -npiType npiInst]
       set instid [npi_scan $instlist]
       while {$instid != "NULL"} {
         if {[npi_get $instid -npiInstType] != "npiHierInst"} {
          set instname [npi_get $instid -npiName]
          nLint_report 30007 $instid $instname           
         }
        set instid [npi_scan $instlist]
       }
       npi_free $instlist
    }
}



proc FirstLast {listid} {
 set line_list [list 0]
 set counter 0
 if {$listid != "NULL"} {
   set id [npi_scan $listid]
  if {$id == "NULL"} {
   set tmp [list 10000 0]  
  } else {
   while {$id != "NULL"} {
    set lineno [npi_get $id -npiLineNo]
    set line_list [lappend line_list $lineno]
    incr counter
    set id [npi_scan $listid]
   }
   npi_free $listid
   set first_line [lindex [lsort -integer $line_list] 1]
   set last_line [lindex [lsort -integer $line_list] end]
   set tmp [list $first_line $last_line]
  }
 } else {
   set tmp [list 10000 0]
 }
 return $tmp
}
proc FileHeader {} {
global g_SourceFile
 set fullname [npi_get $g_SourceFile -npiFullName]
 set counter 0
 set linelist [npi_iterate $g_SourceFile -npiType npiLine]
 set lineid [npi_scan $linelist]
  while {$lineid != "NULL"} {
    set line_content [npi_get $lineid -npiValue]
    set m_line [npi_get $lineid -npiLineNo -npiFile $g_SourceFile]
    switch -glob $line_content {
      *//*+FHDR* {incr counter;set tlineid $lineid}
      *//*FILE*NAME*[a-zA-Z0-9]* {incr counter;set tlineid $lineid}
      *//*AUTHOR*[a-zA-Z0-9]* {incr counter;set tlineid $lineid}
      *//*CONTACT*INFORMATION*[a-zA-Z0-9]* {incr counter;set tlineid $lineid}
      *//*RELEASE*VERSION*[a-zA-Z0-9]* {incr counter;set tlineid $lineid}
      *//*VERSION*DESCRIPTION*[a-zA-Z0-9]* {incr counter;set tlineid $lineid}
      *//*RELEASE*DATE*[a-zA-Z0-9]* {incr counter;set tlineid $lineid}
      *//*PURPOSE*[a-zA-Z0-9]* {incr counter;set tlineid $lineid}
      *//*PARAMETERS* {incr counter;set tlineid $lineid}
      *//*-FHDR* {incr counter;set tlineid $lineid}
      *module* {set mlineid $lineid;break}
     default {}
    }
    set module_line [expr $m_line+1]
    set lineid [npi_scan $linelist]
  }
  switch -exact $counter {
    0 {nLint_sreport  30001 $mlineid 10}
    1 {nLint_sreport  30001 $tlineid 9}
    2 {nLint_sreport  30001 $tlineid 8}
    3 {nLint_sreport  30001 $tlineid 7}
    4 {nLint_sreport  30001 $tlineid 6}
    5 {nLint_sreport  30001 $tlineid 5}
    6 {nLint_sreport  30001 $tlineid 4}
    7 {nLint_sreport  30001 $tlineid 3}
    8 {nLint_sreport  30001 $tlineid 2}
    9 {nLint_sreport  30001 $tlineid 1}
    default {}
  }
  set counter 0
}
proc CheckConstructHeader {} {
    global g_SourceFile g_Line
    set full_name [npi_get $g_SourceFile -npiFullName]
    set construct_line [npi_get $g_Line -npiLineNo -npiFile $g_SourceFile]
    set comment_line [expr $construct_line-1]
    set target_handle [npi_handle_by_index $full_name $comment_line]
    set com_content [npi_get $target_handle -npiValue]
    set counter 0
    while {[string match "*//*" $com_content] || [regexp {^\s*$} $com_content]} {
      switch -glob $com_content {
        *//*+CHDR* {incr counter}
        *//*CONSTRUCT*NAME*&*RETURN*VALUES* {incr counter}
        *//*TYPE* {incr counter}
        *//*PURPOSE* {incr counter}
        *//*PARAMETERS* {incr counter}
        *//*-CHDR* {incr counter}
        default {}
      }
      set comment_line [expr $comment_line-1]
      set target_handle [npi_handle_by_index $full_name $comment_line]
      set com_content [npi_get $target_handle -npiValue]
    }
    switch -exact $counter {
      0 {nLint_sreport  30002 $g_Line 6}
      1 {nLint_sreport  30002 $g_Line 5}
      2 {nLint_sreport  30002 $g_Line 4}
      3 {nLint_sreport  30002 $g_Line 3}
      4 {nLint_sreport  30002 $g_Line 2}
      5 {nLint_sreport  30002 $g_Line 1}
      default {}
    }
    set counter 0
}

proc FindTfp {} {

  global g_SourceFile g_Line

    set content [npi_get $g_Line -npiValue]
    switch -regexp -- $content {
      {^ *[t][a][s][k]*}  -
      {^ *[f][u][n][c][t][i][o][n]*}  -
      {^ *[p][r][i][m][i][t][i][v][e]*}  {CheckConstructHeader}
      default {}
    }
} 

proc Ckcom {lineno filename} {
  global g_Primitive
  set com_line [expr $lineno-1]
  set file_handle [npi_handle_by_name $filename]
  set full_name [npi_get $file_handle -npiFullName]
  set line_handle [npi_handle_by_index $full_name $lineno]
  set target_handle [npi_handle_by_index $full_name $com_line]
   set com_content [npi_get $target_handle -npiValue]
   if {[string match "*//*" $com_content] != 1} {
     nLint_report 30012 $g_Primitive
   }
}

proc CkPrimitive {} {
global g_Scope g_Primitive
 if {[npi_get $g_Primitive -npiType] == "npiGate"} {
  set file [npi_get $g_Primitive -npiFile]
  set line [npi_get $g_Primitive -npiLineNo]
  Ckcom $line $file
 }
}

proc CheckComment {} {
global g_SourceFile g_Line
 set full_name [npi_get $g_SourceFile -npiFullName]
 set func_line [npi_get $g_Line -npiLineNo -npiFile $g_SourceFile]
 set comment_line [expr $func_line-1]
 set target_handle [npi_handle_by_index $full_name $comment_line]
 set com_content [npi_get $target_handle -npiValue]

 if {[string match "*//*" $com_content] != 1} {
   nLint_sreport 30010 $g_Line
  }
}

proc CKFunctional {} {
global g_SourceFile g_Line
set content [npi_get $g_Line -npiValue]
 switch -regexp -- $content {
   {^ *[a][l][w][a][y][s].+} -
   {^ *[a][s][s][i][g][n].+} -
   {^ *[f][u][n][c][t][i][o][n].+} -
   {^ *[t][a][s][k].+} {CheckComment}
   {^ *[/][\*].*} -
   {^ *[\*][/].*} {nLint_sreport 30011 $g_Line}
  {^ *[`][d][e][f][i][n][e].*} -
  {^ *[`][e][l][s][e].*} -
  {^ *[`][e][l][s][i][f].*} -
  {^ *[`][i][f][d][e][f].*} -
  {^ *[`][i][f][n][d][e][f].*} -
  {^ *[`][i][n][c][l][u][d][e].*} -
  {^ *[`][l][i][n][e].*} -
  {^ *[`][u][n][d][e][f].*} {nLint_sreport 30013 $g_Line }
  default {}
 }
}
proc ConsisSignal {} {
 global g_Port
 set portname [npi_get $g_Port -npiName]
 set portinstlist [npi_iterate $g_Port -npiType npiPortInst]
 if {$portinstlist != "NULL"} {
  set portinstid [npi_scan $portinstlist]
   while {$portinstid !="NULL"} {
    set portinstname [npi_get $portinstid -npiName]
     if {[string compare $portinstname $portname] != 0} {
       nLint_report 30003 $portinstid $portname $portinstname
     }
     set portinstid [npi_scan $portinstlist]
   }
   npi_free $portinstlist
 }
}

proc CheckDesignUnitWithInstanceName {} {
    global g_DesignUnit

    set en_dis [nl_get 30006 -nlStatus]
    if { $en_dis == "disable" } {
        return
    }
    set prefix [nl_get 30006 -nlArgument 0]
    set moduleName [npi_get $g_DesignUnit -npiName]
    
    set idList [npi_iterate $g_DesignUnit -npiReferenced]
    set idInst [npi_scan $idList]
    while { $idInst != "NULL" } {
        set instName [npi_get $idInst -npiName]
        set subName "$prefix$moduleName"
        if {[string match "$subName" $instName] == 1} {
        } else {
           if {[string match "$subName?" $instName] == 1 && [regexp {.+_[0-9]$} $instName] ==1} {
           } else {
             nLint_report 30006 $idInst $instName $moduleName $prefix
           }
        }
        set idInst [npi_scan $idList]
    }
}

proc Compare {counter} {
 global IO_array line_array
 for {set i 0} {$i <[expr $counter-1]} {incr i} {
   set signame1 [npi_get $IO_array($i) -npiName]
   set signame2 [npi_get $IO_array([expr $i+1]) -npiName]
   if {$line_array($i) ==$line_array([expr $i+1])} {
     set filename [npi_get $IO_array($i) -npiFile]
     set fileid [npi_handle_by_name $filename]
     set full_name [npi_get $fileid -npiFullName]
     set lineid [npi_handle_by_index $full_name $line_array($i)]
     set line_content [npi_get $lineid -npiValue]
     if {[string first $signame1 $line_content] > [string first $signame2 $line_content]} {
       nLint_report 30004 $IO_array($i) $signame1 $signame2
     }
#     puts "same line"
   } else {
     if {$line_array($i)> $line_array([expr $i+1])} {
#      puts "wrong order"
      nLint_report 30004 $IO_array($i) $signame1 $signame2
     }
   }
 }
}
proc Internal {} {
 global g_Module
# puts "[npi_get $g_Module -npiName]"
 set file [npi_get $g_Module -npiFile]
  set IOlist [npi_iterate $g_Module -npiType npiIODecl]
  set Processlist [npi_iterate $g_Module -npiType npiProcess]
  set ConAssList [npi_iterate $g_Module -npiType npiContAssign]
  set IOlastline [lindex [FirstLast $IOlist] end]
  set uplimit $IOlastline
  set Pfirstline [lindex [FirstLast $Processlist] 0]
  set Cfirstline [lindex [FirstLast $ConAssList] 0]
  if {$Pfirstline >= $Cfirstline} {
    set lowlimit $Cfirstline
  } else {
    set lowlimit $Pfirstline
  }
#  puts "uplimit $uplimit lowlimit $lowlimit"
  set Netlist [npi_iterate $g_Module -npiType npiNet]
  set Reglist [npi_iterate $g_Module -npiType npiReg]
  if {$Netlist != "NULL"} {
   set Netid [npi_scan $Netlist]
    while {$Netid != "NULL"} {
     set NetLine [npi_get $Netid -npiLineNo]
     set NetName [npi_get $Netid -npiName]
     set NetFile [npi_get $Netid -npiFile]
     set NetFileid [npi_handle_by_name $NetFile]
     set full_name [npi_get $NetFileid -npiFullName]
     set NetLineid [npi_handle_by_index $full_name $NetLine]
     set LineContent [npi_get $NetLineid -npiValue]
#     puts "test [regexp {.*[i][n][p][u][t].*} $LineContent] [regexp {.*[o][u][t][p][u][t].*} $LineContent] [regexp {.*[i][n][o][u][t].*} $LineContent]"
     if {[regexp {.*[w][i][r][e].*} $LineContent]} {
        if {$NetLine < $uplimit || $NetLine > $lowlimit} {
#         puts "$NetName $NetLine $uplimit $lowlimit"
         nLint_report 30005 $Netid $NetName
        }
     }
     set Netid [npi_scan $Netlist]
    }
   npi_free $Netlist
  }
  if {$Reglist != "NULL"} {
   set Regid [npi_scan $Reglist]
    while {$Regid != "NULL"} {
     set RegLine [npi_get $Regid -npiLineNo]
     set RegName [npi_get $Regid -npiName]
#      puts "$RegName $RegLine $uplimit $lowlimit"
     if {$RegLine < $uplimit || $RegLine > $lowlimit} {
      nLint_report 30005 $Regid $RegName
     }
    set Regid [npi_scan $Reglist]
    }
   npi_free $Reglist
  }
}

proc PortOrder {} {
 global g_Module IO_array line_array
# puts "[npi_get $g_Module -npiName]"
 set file [npi_get $g_Module -npiFile]
  set IOlist [npi_iterate $g_Module -npiType npiIODecl]
  set counter 0
  set IO_array($counter) ""
  set line_array($counter) 0
  if {$IOlist != "NULL"} {
   set IOid [npi_scan $IOlist]
#    puts "IOid $IOid"
    while {$IOid !="NULL"} {
        set IO_array($counter) $IOid
        set line_array($counter) [npi_get $IOid -npiLineNo]
      incr counter
      set IOid [npi_scan $IOlist]
    }
   npi_free $IOlist
  }
 Compare $counter
}
npi_register_cb -npiNetlist -npiModuleBased npiDesignUnitBegin GlueLogic
npi_register_cb -npiSourceCode npiSourceFileBegin FileHeader
npi_register_cb -npiSourceCode npiLineBegin FindTfp
npi_register_cb -npiSourceCode npiLineBegin CKFunctional
npi_register_cb -npiNetlist -npiModuleBased npiDesignUnitBegin CheckDesignUnitWithInstanceName
npi_register_cb -npiNetlist -npiInstanceBased npiPort ConsisSignal
npi_register_cb -npiLanguage -npiModuleBased Primitive CkPrimitive
npi_register_cb -npiLanguage -npiModuleBased ModuleBegin PortOrder
npi_register_cb -npiLanguage -npiModuleBased ModuleBegin Internal
npi_traverse_model -npiSourceCode
npi_traverse_model -npiNetlist -npiInstanceBased 
npi_traverse_model -npiModuleBased
