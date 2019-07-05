Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D0DC4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 10:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F87121850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 10:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbfGEKxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 06:53:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37482 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727311AbfGEKxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 06:53:22 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x65ArAbS134050
        for <linux-kernel@vger.kernel.org>; Fri, 5 Jul 2019 06:53:19 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tj234phvy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 06:53:19 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 5 Jul 2019 11:53:15 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 5 Jul 2019 11:53:12 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x65ArAx941222532
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 5 Jul 2019 10:53:10 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE74D4C050;
        Fri,  5 Jul 2019 10:53:10 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6CB814C044;
        Fri,  5 Jul 2019 10:53:10 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.152.224.145])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  5 Jul 2019 10:53:10 +0000 (GMT)
Subject: Re: [PATCH 1/3] docs: s390: restore important non-kdoc parts of
 s390dbf.rst
To:     Steffen Maier <maier@linux.ibm.com>, linux-doc@vger.kernel.org
Cc:     linux-s390@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org
References: <1562149189-1417-1-git-send-email-maier@linux.ibm.com>
 <1562149189-1417-2-git-send-email-maier@linux.ibm.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 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
 syiRa+UVlsKmx1hsEg==
Date:   Fri, 5 Jul 2019 12:53:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1562149189-1417-2-git-send-email-maier@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19070510-0016-0000-0000-0000028F76A9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070510-0017-0000-0000-000032ED1A5D
Message-Id: <f2834ae2-d3c5-d1ef-bb97-8a887a3954f9@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-05_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907050136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03.07.19 12:19, Steffen Maier wrote:
> Complements previous ("s390: include/asm/debug.h add kerneldoc markups")
> which seemed to have dropped important non-kdoc parts such as
> user space interface (level, size, flush)
> as well as views and caution regarding strings in the sprintf view.
> 
> Signed-off-by: Steffen Maier <maier@linux.ibm.com>

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

> ---
>  Documentation/s390/s390dbf.rst | 339 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 339 insertions(+)
> 
> diff --git a/Documentation/s390/s390dbf.rst b/Documentation/s390/s390dbf.rst
> index d2595b548879..01d66251643d 100644
> --- a/Documentation/s390/s390dbf.rst
> +++ b/Documentation/s390/s390dbf.rst
> @@ -112,6 +112,345 @@ Kernel Interfaces:
>  Predefined views:
>  -----------------
>  
> +extern struct debug_view debug_hex_ascii_view;
> +
> +extern struct debug_view debug_raw_view;
> +
> +extern struct debug_view debug_sprintf_view;
> +
> +Examples
> +--------
> +
> +::
> +
> +  /*
> +   * hex_ascii- + raw-view Example
> +   */
> +
> +  #include <linux/init.h>
> +  #include <asm/debug.h>
> +
> +  static debug_info_t* debug_info;
> +
> +  static int init(void)
> +  {
> +      /* register 4 debug areas with one page each and 4 byte data field */
> +
> +      debug_info = debug_register ("test", 1, 4, 4 );
> +      debug_register_view(debug_info,&debug_hex_ascii_view);
> +      debug_register_view(debug_info,&debug_raw_view);
> +
> +      debug_text_event(debug_info, 4 , "one ");
> +      debug_int_exception(debug_info, 4, 4711);
> +      debug_event(debug_info, 3, &debug_info, 4);
> +
> +      return 0;
> +  }
> +
> +  static void cleanup(void)
> +  {
> +      debug_unregister (debug_info);
> +  }
> +
> +  module_init(init);
> +  module_exit(cleanup);
> +
> +::
> +
> +  /*
> +   * sprintf-view Example
> +   */
> +
> +  #include <linux/init.h>
> +  #include <asm/debug.h>
> +
> +  static debug_info_t* debug_info;
> +
> +  static int init(void)
> +  {
> +      /* register 4 debug areas with one page each and data field for */
> +      /* format string pointer + 2 varargs (= 3 * sizeof(long))       */
> +
> +      debug_info = debug_register ("test", 1, 4, sizeof(long) * 3);
> +      debug_register_view(debug_info,&debug_sprintf_view);
> +
> +      debug_sprintf_event(debug_info, 2 , "first event in %s:%i\n",__FILE__,__LINE__);
> +      debug_sprintf_exception(debug_info, 1, "pointer to debug info: %p\n",&debug_info);
> +
> +      return 0;
> +  }
> +
> +  static void cleanup(void)
> +  {
> +      debug_unregister (debug_info);
> +  }
> +
> +  module_init(init);
> +  module_exit(cleanup);
> +
> +Debugfs Interface
> +-----------------
> +Views to the debug logs can be investigated through reading the corresponding
> +debugfs-files:
> +
> +Example::
> +
> +  > ls /sys/kernel/debug/s390dbf/dasd
> +  flush  hex_ascii  level pages raw
> +  > cat /sys/kernel/debug/s390dbf/dasd/hex_ascii | sort -k2,2 -s
> +  00 00974733272:680099 2 - 02 0006ad7e  07 ea 4a 90 | ....
> +  00 00974733272:682210 2 - 02 0006ade6  46 52 45 45 | FREE
> +  00 00974733272:682213 2 - 02 0006adf6  07 ea 4a 90 | ....
> +  00 00974733272:682281 1 * 02 0006ab08  41 4c 4c 43 | EXCP
> +  01 00974733272:682284 2 - 02 0006ab16  45 43 4b 44 | ECKD
> +  01 00974733272:682287 2 - 02 0006ab28  00 00 00 04 | ....
> +  01 00974733272:682289 2 - 02 0006ab3e  00 00 00 20 | ...
> +  01 00974733272:682297 2 - 02 0006ad7e  07 ea 4a 90 | ....
> +  01 00974733272:684384 2 - 00 0006ade6  46 52 45 45 | FREE
> +  01 00974733272:684388 2 - 00 0006adf6  07 ea 4a 90 | ....
> +
> +See section about predefined views for explanation of the above output!
> +
> +Changing the debug level
> +------------------------
> +
> +Example::
> +
> +
> +  > cat /sys/kernel/debug/s390dbf/dasd/level
> +  3
> +  > echo "5" > /sys/kernel/debug/s390dbf/dasd/level
> +  > cat /sys/kernel/debug/s390dbf/dasd/level
> +  5
> +
> +Flushing debug areas
> +--------------------
> +Debug areas can be flushed with piping the number of the desired
> +area (0...n) to the debugfs file "flush". When using "-" all debug areas
> +are flushed.
> +
> +Examples:
> +
> +1. Flush debug area 0::
> +
> +     > echo "0" > /sys/kernel/debug/s390dbf/dasd/flush
> +
> +2. Flush all debug areas::
> +
> +     > echo "-" > /sys/kernel/debug/s390dbf/dasd/flush
> +
> +Changing the size of debug areas
> +------------------------------------
> +It is possible the change the size of debug areas through piping
> +the number of pages to the debugfs file "pages". The resize request will
> +also flush the debug areas.
> +
> +Example:
> +
> +Define 4 pages for the debug areas of debug feature "dasd"::
> +
> +  > echo "4" > /sys/kernel/debug/s390dbf/dasd/pages
> +
> +Stooping the debug feature
> +--------------------------
> +Example:
> +
> +1. Check if stopping is allowed::
> +
> +     > cat /proc/sys/s390dbf/debug_stoppable
> +
> +2. Stop debug feature::
> +
> +     > echo 0 > /proc/sys/s390dbf/debug_active
> +
> +lcrash Interface
> +----------------
> +It is planned that the dump analysis tool lcrash gets an additional command
> +'s390dbf' to display all the debug logs. With this tool it will be possible
> +to investigate the debug logs on a live system and with a memory dump after
> +a system crash.
> +
> +Investigating raw memory
> +------------------------
> +One last possibility to investigate the debug logs at a live
> +system and after a system crash is to look at the raw memory
> +under VM or at the Service Element.
> +It is possible to find the anker of the debug-logs through
> +the 'debug_area_first' symbol in the System map. Then one has
> +to follow the correct pointers of the data-structures defined
> +in debug.h and find the debug-areas in memory.
> +Normally modules which use the debug feature will also have
> +a global variable with the pointer to the debug-logs. Following
> +this pointer it will also be possible to find the debug logs in
> +memory.
> +
> +For this method it is recommended to use '16 * x + 4' byte (x = 0..n)
> +for the length of the data field in debug_register() in
> +order to see the debug entries well formatted.
> +
> +
> +Predefined Views
> +----------------
> +
> +There are three predefined views: hex_ascii, raw and sprintf.
> +The hex_ascii view shows the data field in hex and ascii representation
> +(e.g. '45 43 4b 44 | ECKD').
> +The raw view returns a bytestream as the debug areas are stored in memory.
> +
> +The sprintf view formats the debug entries in the same way as the sprintf
> +function would do. The sprintf event/exception functions write to the
> +debug entry a pointer to the format string (size = sizeof(long))
> +and for each vararg a long value. So e.g. for a debug entry with a format
> +string plus two varargs one would need to allocate a (3 * sizeof(long))
> +byte data area in the debug_register() function.
> +
> +IMPORTANT:
> +  Using "%s" in sprintf event functions is dangerous. You can only
> +  use "%s" in the sprintf event functions, if the memory for the passed string
> +  is available as long as the debug feature exists. The reason behind this is
> +  that due to performance considerations only a pointer to the string is stored
> +  in  the debug feature. If you log a string that is freed afterwards, you will
> +  get an OOPS when inspecting the debug feature, because then the debug feature
> +  will access the already freed memory.
> +
> +NOTE:
> +  If using the sprintf view do NOT use other event/exception functions
> +  than the sprintf-event and -exception functions.
> +
> +The format of the hex_ascii and sprintf view is as follows:
> +
> +- Number of area
> +- Timestamp (formatted as seconds and microseconds since 00:00:00 Coordinated
> +  Universal Time (UTC), January 1, 1970)
> +- level of debug entry
> +- Exception flag (* = Exception)
> +- Cpu-Number of calling task
> +- Return Address to caller
> +- data field
> +
> +The format of the raw view is:
> +
> +- Header as described in debug.h
> +- datafield
> +
> +A typical line of the hex_ascii view will look like the following (first line
> +is only for explanation and will not be displayed when 'cating' the view):
> +
> +area  time           level exception cpu caller    data (hex + ascii)
> +--------------------------------------------------------------------------
> +00    00964419409:440690 1 -         00  88023fe
> +
> +
> +Defining views
> +--------------
> +
> +Views are specified with the 'debug_view' structure. There are defined
> +callback functions which are used for reading and writing the debugfs files::
> +
> +  struct debug_view {
> +	char name[DEBUG_MAX_PROCF_LEN];
> +	debug_prolog_proc_t* prolog_proc;
> +	debug_header_proc_t* header_proc;
> +	debug_format_proc_t* format_proc;
> +	debug_input_proc_t*  input_proc;
> +	void*                private_data;
> +  };
> +
> +where::
> +
> +  typedef int (debug_header_proc_t) (debug_info_t* id,
> +				     struct debug_view* view,
> +				     int area,
> +				     debug_entry_t* entry,
> +				     char* out_buf);
> +
> +  typedef int (debug_format_proc_t) (debug_info_t* id,
> +				     struct debug_view* view, char* out_buf,
> +				     const char* in_buf);
> +  typedef int (debug_prolog_proc_t) (debug_info_t* id,
> +				     struct debug_view* view,
> +				     char* out_buf);
> +  typedef int (debug_input_proc_t) (debug_info_t* id,
> +				    struct debug_view* view,
> +				    struct file* file, const char* user_buf,
> +				    size_t in_buf_size, loff_t* offset);
> +
> +
> +The "private_data" member can be used as pointer to view specific data.
> +It is not used by the debug feature itself.
> +
> +The output when reading a debugfs file is structured like this::
> +
> +  "prolog_proc output"
> +
> +  "header_proc output 1"  "format_proc output 1"
> +  "header_proc output 2"  "format_proc output 2"
> +  "header_proc output 3"  "format_proc output 3"
> +  ...
> +
> +When a view is read from the debugfs, the Debug Feature calls the
> +'prolog_proc' once for writing the prolog.
> +Then 'header_proc' and 'format_proc' are called for each
> +existing debug entry.
> +
> +The input_proc can be used to implement functionality when it is written to
> +the view (e.g. like with 'echo "0" > /sys/kernel/debug/s390dbf/dasd/level).
> +
> +For header_proc there can be used the default function
> +debug_dflt_header_fn() which is defined in debug.h.
> +and which produces the same header output as the predefined views.
> +E.g::
> +
> +  00 00964419409:440761 2 - 00 88023ec
> +
> +In order to see how to use the callback functions check the implementation
> +of the default views!
> +
> +Example::
> +
> +  #include <asm/debug.h>
> +
> +  #define UNKNOWNSTR "data: %08x"
> +
> +  const char* messages[] =
> +  {"This error...........\n",
> +   "That error...........\n",
> +   "Problem..............\n",
> +   "Something went wrong.\n",
> +   "Everything ok........\n",
> +   NULL
> +  };
> +
> +  static int debug_test_format_fn(
> +     debug_info_t * id, struct debug_view *view,
> +     char *out_buf, const char *in_buf
> +  )
> +  {
> +    int i, rc = 0;
> +
> +    if(id->buf_size >= 4) {
> +       int msg_nr = *((int*)in_buf);
> +       if(msg_nr < sizeof(messages)/sizeof(char*) - 1)
> +	  rc += sprintf(out_buf, "%s", messages[msg_nr]);
> +       else
> +	  rc += sprintf(out_buf, UNKNOWNSTR, msg_nr);
> +    }
> +   out:
> +     return rc;
> +  }
> +
> +  struct debug_view debug_test_view = {
> +    "myview",                 /* name of view */
> +    NULL,                     /* no prolog */
> +    &debug_dflt_header_fn,    /* default header for each entry */
> +    &debug_test_format_fn,    /* our own format function */
> +    NULL,                     /* no input function */
> +    NULL                      /* no private data */
> +  };
> +
> +test:
> +=====
> +
>  ::
>  
>    debug_info_t *debug_info;
> 

