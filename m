Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F40AC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE09249B2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="KRVPW7kB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfE3IUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 04:20:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59655 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfE3IUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:20:52 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4U8KY6F2905807
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 30 May 2019 01:20:34 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4U8KY6F2905807
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559204435;
        bh=BTchVz5BKNKzaxqUNw0bC9ENGpTpnX6HhxPlvMLpto8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=KRVPW7kBnqTQY4UUcvdqdt2twsfjnpNJa/MIszyl6ASc/R0/01s7m458ezeyuj9NV
         Djbf1Z1Ff16VmdT/NSinEyGNPodzC4vRRYdWrzexfUHqHtgNFAlLRaWFHhOX06oRwD
         DT8EvllFohRZzQv2lmbLVddDennLiIlmAzVlbgGZHnUL5l5OLiojJPSICJL1TAhfhk
         FyeVuvFp3ZUPR9wgJUPys4Ok+HdQiu9yhe+KmWVMCCyrH+/l2LNJARH5jqqQxizFn6
         +idI6oryE10hpD88mONzkn2jlvNrtb3Q1C4B6gWo/eft2ST3SHac5X/cqPKCiuhRtj
         S5wAuJSNYWIkQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4U8KYlV2905804;
        Thu, 30 May 2019 01:20:34 -0700
Date:   Thu, 30 May 2019 01:20:34 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-3cd3216dbb421244b96b992f193e778a3baa2220@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, acme@redhat.com, mingo@kernel.org,
        adrian.hunter@intel.com, hpa@zytor.com, tglx@linutronix.de,
        jolsa@redhat.com
Reply-To: jolsa@redhat.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, hpa@zytor.com,
          adrian.hunter@intel.com, acme@redhat.com, mingo@kernel.org
In-Reply-To: <20190412113830.4126-6-adrian.hunter@intel.com>
References: <20190412113830.4126-6-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf scripts python: export-to-postgresql.py: Add
 support for pyside2
Git-Commit-ID: 3cd3216dbb421244b96b992f193e778a3baa2220
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  3cd3216dbb421244b96b992f193e778a3baa2220
Gitweb:     https://git.kernel.org/tip/3cd3216dbb421244b96b992f193e778a3baa2220
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Fri, 12 Apr 2019 14:38:27 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 18:37:45 -0300

perf scripts python: export-to-postgresql.py: Add support for pyside2

pyside2 is the future for pyside support.

Note pyside use Qt4 whereas pyside2 uses Qt5.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190412113830.4126-6-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/export-to-postgresql.py | 43 ++++++++++++++++++-----
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/tools/perf/scripts/python/export-to-postgresql.py b/tools/perf/scripts/python/export-to-postgresql.py
index c3eae1d77d36..b2f481b0d28d 100644
--- a/tools/perf/scripts/python/export-to-postgresql.py
+++ b/tools/perf/scripts/python/export-to-postgresql.py
@@ -27,18 +27,31 @@ import datetime
 #
 # fedora:
 #
-#	$ sudo yum install postgresql postgresql-server python-pyside qt-postgresql
+#	$ sudo yum install postgresql postgresql-server qt-postgresql
 #	$ sudo su - postgres -c initdb
 #	$ sudo service postgresql start
 #	$ sudo su - postgres
-#	$ createuser <your user id here>
+#	$ createuser -s <your user id here>    # Older versions may not support -s, in which case answer the prompt below:
 #	Shall the new role be a superuser? (y/n) y
+#	$ sudo yum install python-pyside
+#
+#	Alternately, to use Python3 and/or pyside 2, one of the following:
+#		$ sudo yum install python3-pyside
+#		$ pip install --user PySide2
+#		$ pip3 install --user PySide2
 #
 # ubuntu:
 #
-#	$ sudo apt-get install postgresql python-pyside.qtsql libqt4-sql-psql
+#	$ sudo apt-get install postgresql
 #	$ sudo su - postgres
 #	$ createuser -s <your user id here>
+#	$ sudo apt-get install python-pyside.qtsql libqt4-sql-psql
+#
+#	Alternately, to use Python3 and/or pyside 2, one of the following:
+#
+#		$ sudo apt-get install python3-pyside.qtsql libqt4-sql-psql
+#		$ sudo apt-get install python-pyside2.qtsql libqt5sql5-psql
+#		$ sudo apt-get install python3-pyside2.qtsql libqt5sql5-psql
 #
 # An example of using this script with Intel PT:
 #
@@ -199,7 +212,16 @@ import datetime
 #                   print "{0:>6}  {1:>10}  {2:>9}  {3:<30}  {4:>6}  {5:<30}".format(query.value(0), query.value(1), query.value(2), query.value(3), query.value(4), query.value(5))
 #                   call_path_id = query.value(6)
 
-from PySide.QtSql import *
+pyside_version_1 = True
+if not "pyside-version-1" in sys.argv:
+	try:
+		from PySide2.QtSql import *
+		pyside_version_1 = False
+	except:
+		pass
+
+if pyside_version_1:
+	from PySide.QtSql import *
 
 if sys.version_info < (3, 0):
 	def toserverstr(str):
@@ -255,11 +277,12 @@ def printdate(*args, **kw_args):
         print(datetime.datetime.today(), *args, sep=' ', **kw_args)
 
 def usage():
-	printerr("Usage is: export-to-postgresql.py <database name> [<columns>] [<calls>] [<callchains>]")
-	printerr("where:	columns		'all' or 'branches'")
-	printerr("		calls		'calls' => create calls and call_paths table")
-	printerr("		callchains	'callchains' => create call_paths table")
-	raise Exception("Too few arguments")
+	printerr("Usage is: export-to-postgresql.py <database name> [<columns>] [<calls>] [<callchains>] [<pyside-version-1>]");
+	printerr("where:  columns            'all' or 'branches'");
+	printerr("        calls              'calls' => create calls and call_paths table");
+	printerr("        callchains         'callchains' => create call_paths table");
+	printerr("        pyside-version-1   'pyside-version-1' => use pyside version 1");
+	raise Exception("Too few or bad arguments")
 
 if (len(sys.argv) < 2):
 	usage()
@@ -281,6 +304,8 @@ for i in range(3,len(sys.argv)):
 		perf_db_export_calls = True
 	elif (sys.argv[i] == "callchains"):
 		perf_db_export_callchains = True
+	elif (sys.argv[i] == "pyside-version-1"):
+		pass
 	else:
 		usage()
 
