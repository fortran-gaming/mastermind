execute_process(COMMAND ${exe}
INPUT_FILE ${in_file}
TIMEOUT 5
RESULT_VARIABLE ret)

if(NOT ret EQUAL 2)
  message(FATAL_ERROR "expected error stop 2")
endif()
