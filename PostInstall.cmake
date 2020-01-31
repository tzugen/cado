execute_process(COMMAND bash -c "\
	if ! getent group _cado >/dev/null 2>&1; then
		groupadd \
			--system \
			_cado;
	fi"
	ERROR_QUIET OUTPUT_QUIET)
execute_process(COMMAND bash -c "\
	if ! getent passwd _cado >/dev/null 2>&1; then
		useradd \
			--no-create-home \
			--home-dir /nonexistent \
			--system \
			--shell /sbin/nologin \
			-g _cado \
			_cado;
	fi"
	ERROR_QUIET OUTPUT_QUIET)
execute_process(COMMAND mkdir -p ${CADO_SPOOL_DIR} ERROR_QUIET OUTPUT_QUIET)
execute_process(COMMAND chown root:_cado ${CADO_SPOOL_DIR} ERROR_QUIET OUTPUT_QUIET)
execute_process(COMMAND chmod 4770 ${CADO_SPOOL_DIR} ERROR_QUIET OUTPUT_QUIET)
execute_process(COMMAND chown :_cado ${BINDIR}/scado ERROR_QUIET OUTPUT_QUIET)
execute_process(COMMAND chmod g+s ${BINDIR}/scado ERROR_QUIET OUTPUT_QUIET)
execute_process(COMMAND chown _cado: ${BINDIR}/cado ERROR_QUIET OUTPUT_QUIET)
execute_process(COMMAND chmod u+s ${BINDIR}/cado ERROR_QUIET OUTPUT_QUIET)
execute_process(COMMAND ldconfig ${LIBDIR} ERROR_QUIET OUTPUT_QUIET)
execute_process(COMMAND ${BINDIR}/cado --setcap ERROR_QUIET OUTPUT_QUIET)
