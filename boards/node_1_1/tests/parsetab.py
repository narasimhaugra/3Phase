
# parsetab.py
# This file is automatically generated. Do not edit.
_tabversion = '3.2'

_lr_method = 'LALR'

_lr_signature = '\x89\xa6\xf1j\x12\xdb\x86\xe9\xa1\xbc\xe5\xb5\xbb\xeb@\x1a'
    
_lr_action_items = {'NOTFOUND':([0,],[1,]),'WORD':([1,2,3,4,5,6,14,15,16,17,],[8,9,10,11,12,13,18,19,20,21,]),'ERROR':([0,],[2,]),'NUMBER':([21,],[22,]),'RUNNING':([0,],[3,]),'PASS':([0,],[4,]),'FAIL':([0,],[5,]),'INPUT':([0,],[6,]),'DOT':([8,10,11,12,],[14,15,16,17,]),'$end':([7,9,13,18,19,20,22,],[0,-6,-3,-1,-2,-4,-5,]),}

_lr_action = { }
for _k, _v in _lr_action_items.items():
   for _x,_y in zip(_v[0],_v[1]):
      if not _x in _lr_action:  _lr_action[_x] = { }
      _lr_action[_x][_k] = _y
del _lr_action_items

_lr_goto_items = {'operation':([0,],[7,]),}

_lr_goto = { }
for _k, _v in _lr_goto_items.items():
   for _x,_y in zip(_v[0],_v[1]):
       if not _x in _lr_goto: _lr_goto[_x] = { }
       _lr_goto[_x][_k] = _y
del _lr_goto_items
_lr_productions = [
  ("S' -> operation","S'",1,None,None,None),
  ('operation -> NOTFOUND WORD DOT WORD','operation',4,'p_operation_notfound','/usr/local/lib/python2.7/dist-packages/gpos_utils-0.1-py2.7.egg/gpos_utils/gptest/grammar.py',7),
  ('operation -> RUNNING WORD DOT WORD','operation',4,'p_operation_running','/usr/local/lib/python2.7/dist-packages/gpos_utils-0.1-py2.7.egg/gpos_utils/gptest/grammar.py',11),
  ('operation -> INPUT WORD','operation',2,'p_operation_input','/usr/local/lib/python2.7/dist-packages/gpos_utils-0.1-py2.7.egg/gpos_utils/gptest/grammar.py',15),
  ('operation -> PASS WORD DOT WORD','operation',4,'p_operation_pass','/usr/local/lib/python2.7/dist-packages/gpos_utils-0.1-py2.7.egg/gpos_utils/gptest/grammar.py',19),
  ('operation -> FAIL WORD DOT WORD NUMBER','operation',5,'p_operation_fail','/usr/local/lib/python2.7/dist-packages/gpos_utils-0.1-py2.7.egg/gpos_utils/gptest/grammar.py',23),
  ('operation -> ERROR WORD','operation',2,'p_operation_error','/usr/local/lib/python2.7/dist-packages/gpos_utils-0.1-py2.7.egg/gpos_utils/gptest/grammar.py',27),
]
