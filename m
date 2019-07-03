Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E537C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 10:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEBCB218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 10:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfGCKVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 06:21:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20134 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727095AbfGCKVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 06:21:07 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x63AKvjT058550
        for <linux-kernel@vger.kernel.org>; Wed, 3 Jul 2019 06:21:05 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tgst024eh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 06:21:04 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <maier@linux.ibm.com>;
        Wed, 3 Jul 2019 11:20:19 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 3 Jul 2019 11:20:18 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x63AKGvV33882150
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Jul 2019 10:20:16 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4FE334C052;
        Wed,  3 Jul 2019 10:20:16 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 080F74C04A;
        Wed,  3 Jul 2019 10:20:16 +0000 (GMT)
Received: from oc4120165700.ibm.com (unknown [9.152.97.10])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  3 Jul 2019 10:20:15 +0000 (GMT)
From:   Steffen Maier <maier@linux.ibm.com>
To:     linux-doc@vger.kernel.org
Cc:     linux-s390@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] docs: s390: s390dbf: typos and formatting, update crash command
Date:   Wed,  3 Jul 2019 12:19:49 +0200
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562149189-1417-1-git-send-email-maier@linux.ibm.com>
References: <1562149189-1417-1-git-send-email-maier@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19070310-0008-0000-0000-000002F9683B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070310-0009-0000-0000-00002266B554
Message-Id: <1562149189-1417-4-git-send-email-maier@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-03_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907030125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
---
 Documentation/s390/s390dbf.rst | 122 +++++++++++++++++++++++------------------
 1 file changed, 68 insertions(+), 54 deletions(-)

diff --git a/Documentation/s390/s390dbf.rst b/Documentation/s390/s390dbf.rst
index be42892b159e..cdb36842b898 100644
--- a/Documentation/s390/s390dbf.rst
+++ b/Documentation/s390/s390dbf.rst
@@ -23,7 +23,8 @@ The debug feature may also very useful for kernel and driver development.
 Design:
 -------
 Kernel components (e.g. device drivers) can register themselves at the debug
-feature with the function call debug_register(). This function initializes a
+feature with the function call :c:func:`debug_register()`.
+This function initializes a
 debug log for the caller. For each debug log exists a number of debug areas
 where exactly one is active at one time.  Each debug area consists of contiguous
 pages in memory. In the debug areas there are stored debug entries (log records)
@@ -44,8 +45,9 @@ The debug areas themselves are also ordered in form of a ring buffer.
 When an exception is thrown in the last debug area, the following debug
 entries are then written again in the very first area.
 
-There are three versions for the event- and exception-calls: One for
-logging raw data, one for text and one for numbers.
+There are four versions for the event- and exception-calls: One for
+logging raw data, one for text, one for numbers (unsigned int and long),
+and one for sprintf-like formatted strings.
 
 Each debug entry contains the following data:
 
@@ -56,29 +58,29 @@ Each debug entry contains the following data:
 - Flag, if entry is an exception or not
 
 The debug logs can be inspected in a live system through entries in
-the debugfs-filesystem. Under the toplevel directory "s390dbf" there is
+the debugfs-filesystem. Under the toplevel directory "``s390dbf``" there is
 a directory for each registered component, which is named like the
 corresponding component. The debugfs normally should be mounted to
-/sys/kernel/debug therefore the debug feature can be accessed under
-/sys/kernel/debug/s390dbf.
+``/sys/kernel/debug`` therefore the debug feature can be accessed under
+``/sys/kernel/debug/s390dbf``.
 
 The content of the directories are files which represent different views
 to the debug log. Each component can decide which views should be
-used through registering them with the function debug_register_view().
+used through registering them with the function :c:func:`debug_register_view()`.
 Predefined views for hex/ascii, sprintf and raw binary data are provided.
 It is also possible to define other views. The content of
 a view can be inspected simply by reading the corresponding debugfs file.
 
 All debug logs have an actual debug level (range from 0 to 6).
-The default level is 3. Event and Exception functions have a 'level'
+The default level is 3. Event and Exception functions have a :c:data:`level`
 parameter. Only debug entries with a level that is lower or equal
 than the actual level are written to the log. This means, when
 writing events, high priority log entries should have a low level
 value whereas low priority entries should have a high one.
 The actual debug level can be changed with the help of the debugfs-filesystem
-through writing a number string "x" to the 'level' debugfs file which is
+through writing a number string "x" to the ``level`` debugfs file which is
 provided for every debug log. Debugging can be switched off completely
-by using "-" on the 'level' debugfs file.
+by using "-" on the ``level`` debugfs file.
 
 Example::
 
@@ -86,21 +88,21 @@ Example::
 
 It is also possible to deactivate the debug feature globally for every
 debug log. You can change the behavior using  2 sysctl parameters in
-/proc/sys/s390dbf:
+``/proc/sys/s390dbf``:
 
 There are currently 2 possible triggers, which stop the debug feature
-globally. The first possibility is to use the "debug_active" sysctl. If
-set to 1 the debug feature is running. If "debug_active" is set to 0 the
+globally. The first possibility is to use the ``debug_active`` sysctl. If
+set to 1 the debug feature is running. If ``debug_active`` is set to 0 the
 debug feature is turned off.
 
 The second trigger which stops the debug feature is a kernel oops.
 That prevents the debug feature from overwriting debug information that
 happened before the oops. After an oops you can reactivate the debug feature
-by piping 1 to /proc/sys/s390dbf/debug_active. Nevertheless, its not
+by piping 1 to ``/proc/sys/s390dbf/debug_active``. Nevertheless, it's not
 suggested to use an oopsed kernel in a production environment.
 
 If you want to disallow the deactivation of the debug feature, you can use
-the "debug_stoppable" sysctl. If you set "debug_stoppable" to 0 the debug
+the ``debug_stoppable`` sysctl. If you set ``debug_stoppable`` to 0 the debug
 feature cannot be stopped. If the debug feature is already stopped, it
 will stay deactivated.
 
@@ -113,16 +115,18 @@ Kernel Interfaces:
 Predefined views:
 -----------------
 
-extern struct debug_view debug_hex_ascii_view;
+.. code-block:: c
 
-extern struct debug_view debug_raw_view;
+  extern struct debug_view debug_hex_ascii_view;
 
-extern struct debug_view debug_sprintf_view;
+  extern struct debug_view debug_raw_view;
+
+  extern struct debug_view debug_sprintf_view;
 
 Examples
 --------
 
-::
+.. code-block:: c
 
   /*
    * hex_ascii- + raw-view Example
@@ -131,15 +135,15 @@ Examples
   #include <linux/init.h>
   #include <asm/debug.h>
 
-  static debug_info_t* debug_info;
+  static debug_info_t *debug_info;
 
   static int init(void)
   {
       /* register 4 debug areas with one page each and 4 byte data field */
 
-      debug_info = debug_register ("test", 1, 4, 4 );
-      debug_register_view(debug_info,&debug_hex_ascii_view);
-      debug_register_view(debug_info,&debug_raw_view);
+      debug_info = debug_register("test", 1, 4, 4 );
+      debug_register_view(debug_info, &debug_hex_ascii_view);
+      debug_register_view(debug_info, &debug_raw_view);
 
       debug_text_event(debug_info, 4 , "one ");
       debug_int_exception(debug_info, 4, 4711);
@@ -150,13 +154,13 @@ Examples
 
   static void cleanup(void)
   {
-      debug_unregister (debug_info);
+      debug_unregister(debug_info);
   }
 
   module_init(init);
   module_exit(cleanup);
 
-::
+.. code-block:: c
 
   /*
    * sprintf-view Example
@@ -165,15 +169,15 @@ Examples
   #include <linux/init.h>
   #include <asm/debug.h>
 
-  static debug_info_t* debug_info;
+  static debug_info_t *debug_info;
 
   static int init(void)
   {
       /* register 4 debug areas with one page each and data field for */
       /* format string pointer + 2 varargs (= 3 * sizeof(long))       */
 
-      debug_info = debug_register ("test", 1, 4, sizeof(long) * 3);
-      debug_register_view(debug_info,&debug_sprintf_view);
+      debug_info = debug_register("test", 1, 4, sizeof(long) * 3);
+      debug_register_view(debug_info, &debug_sprintf_view);
 
       debug_sprintf_event(debug_info, 2 , "first event in %s:%i\n",__FILE__,__LINE__);
       debug_sprintf_exception(debug_info, 1, "pointer to debug info: %p\n",&debug_info);
@@ -183,7 +187,7 @@ Examples
 
   static void cleanup(void)
   {
-      debug_unregister (debug_info);
+      debug_unregister(debug_info);
   }
 
   module_init(init);
@@ -252,7 +256,7 @@ Define 4 pages for the debug areas of debug feature "dasd"::
 
   > echo "4" > /sys/kernel/debug/s390dbf/dasd/pages
 
-Stooping the debug feature
+Stopping the debug feature
 --------------------------
 Example:
 
@@ -264,10 +268,11 @@ Example:
 
      > echo 0 > /proc/sys/s390dbf/debug_active
 
-lcrash Interface
+crash Interface
 ----------------
-It is planned that the dump analysis tool lcrash gets an additional command
-'s390dbf' to display all the debug logs. With this tool it will be possible
+The ``crash`` tool since v5.1.0 has a built-in command
+``s390dbf`` to display all the debug logs or export them to the file system.
+With this tool it is possible
 to investigate the debug logs on a live system and with a memory dump after
 a system crash.
 
@@ -276,8 +281,8 @@ Investigating raw memory
 One last possibility to investigate the debug logs at a live
 system and after a system crash is to look at the raw memory
 under VM or at the Service Element.
-It is possible to find the anker of the debug-logs through
-the 'debug_area_first' symbol in the System map. Then one has
+It is possible to find the anchor of the debug-logs through
+the ``debug_area_first`` symbol in the System map. Then one has
 to follow the correct pointers of the data-structures defined
 in debug.h and find the debug-areas in memory.
 Normally modules which use the debug feature will also have
@@ -286,7 +291,7 @@ this pointer it will also be possible to find the debug logs in
 memory.
 
 For this method it is recommended to use '16 * x + 4' byte (x = 0..n)
-for the length of the data field in debug_register() in
+for the length of the data field in :c:func:`debug_register()` in
 order to see the debug entries well formatted.
 
 
@@ -295,7 +300,7 @@ Predefined Views
 
 There are three predefined views: hex_ascii, raw and sprintf.
 The hex_ascii view shows the data field in hex and ascii representation
-(e.g. '45 43 4b 44 | ECKD').
+(e.g. ``45 43 4b 44 | ECKD``).
 The raw view returns a bytestream as the debug areas are stored in memory.
 
 The sprintf view formats the debug entries in the same way as the sprintf
@@ -335,18 +340,20 @@ The format of the raw view is:
 - datafield
 
 A typical line of the hex_ascii view will look like the following (first line
-is only for explanation and will not be displayed when 'cating' the view):
+is only for explanation and will not be displayed when 'cating' the view)::
 
-area  time           level exception cpu caller    data (hex + ascii)
---------------------------------------------------------------------------
-00    00964419409:440690 1 -         00  88023fe
+  area  time           level exception cpu caller    data (hex + ascii)
+  --------------------------------------------------------------------------
+  00    00964419409:440690 1 -         00  88023fe
 
 
 Defining views
 --------------
 
 Views are specified with the 'debug_view' structure. There are defined
-callback functions which are used for reading and writing the debugfs files::
+callback functions which are used for reading and writing the debugfs files:
+
+.. code-block:: c
 
   struct debug_view {
 	char name[DEBUG_MAX_PROCF_LEN];
@@ -357,7 +364,9 @@ callback functions which are used for reading and writing the debugfs files::
 	void*                private_data;
   };
 
-where::
+where:
+
+.. code-block:: c
 
   typedef int (debug_header_proc_t) (debug_info_t* id,
 				     struct debug_view* view,
@@ -395,10 +404,10 @@ Then 'header_proc' and 'format_proc' are called for each
 existing debug entry.
 
 The input_proc can be used to implement functionality when it is written to
-the view (e.g. like with 'echo "0" > /sys/kernel/debug/s390dbf/dasd/level).
+the view (e.g. like with ``echo "0" > /sys/kernel/debug/s390dbf/dasd/level``).
 
 For header_proc there can be used the default function
-debug_dflt_header_fn() which is defined in debug.h.
+:c:func:`debug_dflt_header_fn()` which is defined in debug.h.
 and which produces the same header output as the predefined views.
 E.g::
 
@@ -407,7 +416,9 @@ E.g::
 In order to see how to use the callback functions check the implementation
 of the default views!
 
-Example::
+Example:
+
+.. code-block:: c
 
   #include <asm/debug.h>
 
@@ -423,21 +434,20 @@ Example::
   };
 
   static int debug_test_format_fn(
-     debug_info_t * id, struct debug_view *view,
+     debug_info_t *id, struct debug_view *view,
      char *out_buf, const char *in_buf
   )
   {
     int i, rc = 0;
 
-    if(id->buf_size >= 4) {
+    if (id->buf_size >= 4) {
        int msg_nr = *((int*)in_buf);
-       if(msg_nr < sizeof(messages)/sizeof(char*) - 1)
+       if (msg_nr < sizeof(messages) / sizeof(char*) - 1)
 	  rc += sprintf(out_buf, "%s", messages[msg_nr]);
        else
 	  rc += sprintf(out_buf, UNKNOWNSTR, msg_nr);
     }
-   out:
-     return rc;
+    return rc;
   }
 
   struct debug_view debug_test_view = {
@@ -452,13 +462,17 @@ Example::
 test:
 =====
 
-::
+.. code-block:: c
 
   debug_info_t *debug_info;
+  int i;
   ...
-  debug_info = debug_register ("test", 0, 4, 4 ));
+  debug_info = debug_register("test", 0, 4, 4);
   debug_register_view(debug_info, &debug_test_view);
-  for(i = 0; i < 10; i ++) debug_int_event(debug_info, 1, i);
+  for (i = 0; i < 10; i ++)
+    debug_int_event(debug_info, 1, i);
+
+::
 
   > cat /sys/kernel/debug/s390dbf/test/myview
   00 00964419734:611402 1 - 00 88042ca   This error...........
-- 
1.8.3.1

