#!/bin/bash
#	@Jefte de Lima Ferreira
#	jeftedelima at gmail dot com
#	CRON Example
#	*/5   **** root sh /home/dir/unboundSend.sh 192.168.10.1 Unbound 1> /dev/null	

#if [ -z ${1} ] || [ -z ${2} ] ; then
#	echo "You need to specify the IP address of zabbix server and hostname of your DNS Unbound on zabbix"
#	echo "Usage example: ./unboundSend.sh 192.168.10.1 UnboundServer"
#	exit 1
#fi

# ZABBIX_SERVER IP
IP_ZABBIX=$1
# NAME Unbound on Zabbix
NAME_HOST=$2
#ZABBIX_OPTS="-z ${IP_ZABBIX} -s ${NAME_HOST}"
ZABBIX_OPTS="$1"
DIR_TEMP=/var/tmp/
FILE="${DIR_TEMP}dump_unbound_control_stats.txt"
unbound-control stats > ${FILE}

TOTAL_NUM_QUERIES=$(grep -w 'total.num.queries' ${FILE} | cut -d '=' -f2)
TOTAL_NUM_CACHEHITS=$(grep -w 'total.num.cachehits' ${FILE} | cut -d '=' -f2)
TOTAL_NUM_CACHEMISS=$(grep -w 'total.num.cachemiss' ${FILE} | cut -d '=' -f2)
TOTAL_NUM_PREFETCH=$(grep -w 'total.num.prefetch' ${FILE} | cut -d '=' -f2)
TOTAL_NUM_RECURSIVEREPLIES=$(grep -w 'total.num.recursivereplies' ${FILE} | cut -d '=' -f2)

TOTAL_REQ_MAX=$(grep -w 'total.requestlist.max' ${FILE} | cut -d '=' -f2)
TOTAL_REQ_AVG=$(grep -w 'total.requestlist.avg' ${FILE} | cut -d '=' -f2)
TOTAL_REQ_OVERWRITTEN=$(grep -w 'total.requestlist.overwritten' ${FILE} | cut -d '=' -f2)
TOTAL_REQ_EXCEEDED=$(grep -w 'total.requestlist.exceeded' ${FILE} | cut -d '=' -f2)
TOTAL_REQ_CURRENT_ALL=$(grep -w 'total.requestlist.current.all' ${FILE} | cut -d '=' -f2)
TOTAL_REQ_CURRENT_USER=$(grep -w 'total.requestlist.current.user' ${FILE} | cut -d '=' -f2)

TOTAL_TCPUSAGE=$(grep -w 'total.tcpusage' ${FILE} | cut -d '=' -f2)

NUM_QUERY_TYPE_A=$(grep -w 'num.query.type.A' ${FILE} | cut -d '=' -f2)
NUM_QUERY_TYPE_NS=$(grep -w 'num.query.type.NS' ${FILE} | cut -d '=' -f2)
NUM_QUERY_TYPE_MX=$(grep -w 'num.query.type.MX' ${FILE} | cut -d '=' -f2)
NUM_QUERY_TYPE_TXT=$(grep -w 'num.query.type.TXT' ${FILE} | cut -d '=' -f2)
NUM_QUERY_TYPE_PTR=$(grep -w 'num.query.type.PTR' ${FILE} | cut -d '=' -f2)
NUM_QUERY_TYPE_AAAA=$(grep -w 'num.query.type.AAAA' ${FILE} | cut -d '=' -f2)
NUM_QUERY_TYPE_SRV=$(grep -w 'num.query.type.SRV' ${FILE} | cut -d '=' -f2)
NUM_QUERY_TYPE_SOA=$(grep -w 'num.query.type.SOA' ${FILE} | cut -d '=' -f2)

NUM_ANSWER_RCODE_NOERROR=$(grep -w 'num.answer.rcode.NOERROR' ${FILE} | cut -d '=' -f2)
NUM_ANSWER_RCODE_NXDOMAIN=$(grep -w 'num.answer.rcode.NXDOMAIN' ${FILE} | cut -d '=' -f2)
NUM_ANSWER_RCODE_SERVFAIL=$(grep -w 'num.answer.rcode.SERVFAIL' ${FILE} | cut -d '=' -f2)
NUM_ANSWER_RCODE_REFUSED=$(grep -w 'num.answer.rcode.REFUSED' ${FILE} | cut -d '=' -f2)
NUM_ANSWER_RCODE_nodata=$(grep -w 'num.answer.rcode.nodata' ${FILE} | cut -d '=' -f2)
NUM_ANSWER_secure=$(grep -w 'num.answer.secure' ${FILE} | cut -d '=' -f2)

#	Sending info to zabbix_server, if variables is not empty!
[ -z ${TOTAL_NUM_QUERIES} ] ||  zabbix_sender $ZABBIX_OPTS -k total.num.queries -o ${TOTAL_NUM_QUERIES}
[ -z ${TOTAL_NUM_CACHEHITS} ] || zabbix_sender $ZABBIX_OPTS -k total.num.cachehits -o ${TOTAL_NUM_CACHEHITS}
[ -z ${TOTAL_NUM_CACHEMISS} ] || zabbix_sender $ZABBIX_OPTS -k total.num.cachemiss -o ${TOTAL_NUM_CACHEMISS}
[ -z ${TOTAL_NUM_PREFETCH} ] || zabbix_sender $ZABBIX_OPTS -k total.num.prefetch -o ${TOTAL_NUM_PREFETCH}
[ -z ${TOTAL_NUM_RECURSIVEREPLIES} ] || zabbix_sender $ZABBIX_OPTS -k total.num.recursivereplies -o ${TOTAL_NUM_RECURSIVEREPLIES}

[ -z ${TOTAL_REQ_MAX} ] || zabbix_sender $ZABBIX_OPTS -k total.requestlist.max -o ${TOTAL_REQ_MAX}
[ -z ${TOTAL_REQ_AVG} ] || zabbix_sender $ZABBIX_OPTS -k total.requestlist.avg -o ${TOTAL_REQ_AVG}
[ -z ${TOTAL_REQ_OVERWRITTEN} ] || zabbix_sender $ZABBIX_OPTS -k total.requestlist.overwritten -o ${TOTAL_REQ_OVERWRITTEN}
[ -z ${TOTAL_REQ_EXCEEDED} ] ||  zabbix_sender $ZABBIX_OPTS -k total.requestlist.exceeded -o ${TOTAL_REQ_EXCEEDED}
[ -z ${TOTAL_REQ_CURRENT_ALL} ] || zabbix_sender $ZABBIX_OPTS -k total.requestlist.current.all -o ${TOTAL_REQ_CURRENT_ALL}
[ -z ${TOTAL_REQ_CURRENT_USER} ] || zabbix_sender $ZABBIX_OPTS -k total.requestlist.current.user -o ${TOTAL_REQ_CURRENT_USER}

[ -z ${TOTAL_TCPUSAGE} ] || zabbix_sender $ZABBIX_OPTS -k total.tcpusage -o ${TOTAL_TCPUSAGE}

[ -z ${NUM_QUERY_TYPE_A} ] || zabbix_sender $ZABBIX_OPTS -k num.query.a -o ${NUM_QUERY_TYPE_A}
[ -z ${NUM_QUERY_TYPE_NS} ] || zabbix_sender $ZABBIX_OPTS -k num.query.ns -o ${NUM_QUERY_TYPE_NS}
[ -z ${NUM_QUERY_TYPE_MX} ] || zabbix_sender $ZABBIX_OPTS -k num.query.mx -o ${NUM_QUERY_TYPE_MX}
[ -z ${NUM_QUERY_TYPE_TXT} ] || zabbix_sender $ZABBIX_OPTS -k num.query.txt -o ${NUM_QUERY_TYPE_TXT}
[ -z ${NUM_QUERY_TYPE_PTR} ] || zabbix_sender $ZABBIX_OPTS -k num.query.ptr -o ${NUM_QUERY_TYPE_PTR}
[ -z ${NUM_QUERY_TYPE_AAAA} ] || zabbix_sender $ZABBIX_OPTS -k num.query.aaaa -o ${NUM_QUERY_TYPE_AAAA}
[ -z ${NUM_QUERY_TYPE_SRV} ] || zabbix_sender $ZABBIX_OPTS -k num.query.srv -o ${NUM_QUERY_TYPE_SRV}
[ -z ${NUM_QUERY_TYPE_SOA} ] || zabbix_sender $ZABBIX_OPTS -k num.query.soa -o ${NUM_QUERY_TYPE_SOA}

[ -z ${NUM_ANSWER_RCODE_NOERROR} ] || zabbix_sender $ZABBIX_OPTS -k num.answer.rcode.NOERROR -o ${NUM_ANSWER_RCODE_NOERROR}
[ -z ${NUM_ANSWER_RCODE_NXDOMAIN} ] || zabbix_sender $ZABBIX_OPTS -k num.answer.rcode.NXDOMAIN -o ${NUM_ANSWER_RCODE_NXDOMAIN}
[ -z ${NUM_ANSWER_RCODE_SERVFAIL} ] || zabbix_sender $ZABBIX_OPTS -k num.answer.rcode.SERVFAIL -o ${NUM_ANSWER_RCODE_SERVFAIL}
[ -z ${NUM_ANSWER_RCODE_REFUSED} ] || zabbix_sender $ZABBIX_OPTS -k num.answer.rcode.REFUSED -o ${NUM_ANSWER_RCODE_REFUSED}
[ -z ${NUM_ANSWER_RCODE_nodata} ] || zabbix_sender $ZABBIX_OPTS -k num.answer.rcode.nodata -o ${NUM_ANSWER_RCODE_nodata}
[ -z ${NUM_ANSWER_secure} ] || zabbix_sender $ZABBIX_OPTS -k num.answer.secure -o ${NUM_ANSWER_secure}
