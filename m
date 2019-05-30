Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B691DC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89056249B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="fcKrvxQz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfE3IUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 04:20:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53605 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfE3IUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:20:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4U8JoiF2905687
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 30 May 2019 01:19:51 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4U8JoiF2905687
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559204391;
        bh=6yg+DSnzrt2njCrmc7gOYUApy04fugo1hla0BSEDeG0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=fcKrvxQzX+ksJkciMSV8klJTP8lFS4/YvRIlO9S+8Cq3xYV8KFHYFMlmNWOI7XeXB
         LBUzyZsClAw+o9GmJ6UjJ16lkFL1TSmj1/Ehyizlq80jpdzGLGvnYWUY660SvT76F9
         JKoHHq2qc5B0oWRUV61wGlbFNJRX+zFkyqyqeCHpUSIqVCVtioaUV1YRvvzQLLZz9O
         r0MZ8E4SHItplbrgtktx3AdpveGIG9qOz4cUhl0Q19QeoeVD7ciaVILwaHeq/DY441
         mdsWzg1OSx8ZPvQZy5I5rWBh+Sx0BoOZ36Ji6KeV6w5Gxlk6Hjc6IbMuxb+PC+c66Y
         L6qpZp1I/q5gw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4U8JorK2905684;
        Thu, 30 May 2019 01:19:50 -0700
Date:   Thu, 30 May 2019 01:19:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-bfb3170e2481b76a4f8aae94176e45d681a37f3e@git.kernel.org>
Cc:     adrian.hunter@intel.com, hpa@zytor.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        acme@redhat.com
Reply-To: jolsa@redhat.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, acme@redhat.com, mingo@kernel.org,
          adrian.hunter@intel.com, hpa@zytor.com
In-Reply-To: <20190412113830.4126-5-adrian.hunter@intel.com>
References: <20190412113830.4126-5-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf scripts python: export-to-sqlite.py: Add
 support for pyside2
Git-Commit-ID: bfb3170e2481b76a4f8aae94176e45d681a37f3e
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

Commit-ID:  bfb3170e2481b76a4f8aae94176e45d681a37f3e
Gitweb:     https://git.kernel.org/tip/bfb3170e2481b76a4f8aae94176e45d681a37f3e
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Fri, 12 Apr 2019 14:38:26 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 18:37:45 -0300

perf scripts python: export-to-sqlite.py: Add support for pyside2

pyside2 is the future for pyside support.

Note pyside use Qt4 whereas pyside2 uses Qt5.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190412113830.4126-5-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/export-to-sqlite.py | 44 +++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/tools/perf/scripts/python/export-to-sqlite.py b/tools/perf/scripts/python/export-to-sqlite.py
index bf271fbc3a88..f617e518332f 100644
--- a/tools/perf/scripts/python/export-to-sqlite.py
+++ b/tools/perf/scripts/python/export-to-sqlite.py
@@ -21,6 +21,26 @@ import datetime
 # provides LGPL-licensed Python bindings for Qt.  You will also need the package
 # libqt4-sql-sqlite for Qt sqlite3 support.
 #
+# Examples of installing pyside:
+#
+# ubuntu:
+#
+#	$ sudo apt-get install python-pyside.qtsql libqt4-sql-psql
+#
+#	Alternately, to use Python3 and/or pyside 2, one of the following:
+#
+#		$ sudo apt-get install python3-pyside.qtsql libqt4-sql-psql
+#		$ sudo apt-get install python-pyside2.qtsql libqt5sql5-psql
+#		$ sudo apt-get install python3-pyside2.qtsql libqt5sql5-psql
+# fedora:
+#
+#	$ sudo yum install python-pyside
+#
+#	Alternately, to use Python3 and/or pyside 2, one of the following:
+#		$ sudo yum install python3-pyside
+#		$ pip install --user PySide2
+#		$ pip3 install --user PySide2
+#
 # An example of using this script with Intel PT:
 #
 #	$ perf record -e intel_pt//u ls
@@ -49,7 +69,16 @@ import datetime
 # difference is  the 'transaction' column of the 'samples' table which is
 # renamed 'transaction_' in sqlite because 'transaction' is a reserved word.
 
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
 
 sys.path.append(os.environ['PERF_EXEC_PATH'] + \
 	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
@@ -69,11 +98,12 @@ def printdate(*args, **kw_args):
         print(datetime.datetime.today(), *args, sep=' ', **kw_args)
 
 def usage():
-	printerr("Usage is: export-to-sqlite.py <database name> [<columns>] [<calls>] [<callchains>]");
-	printerr("where:	columns		'all' or 'branches'");
-	printerr("		calls		'calls' => create calls and call_paths table");
-	printerr("		callchains	'callchains' => create call_paths table");
-	raise Exception("Too few arguments")
+	printerr("Usage is: export-to-sqlite.py <database name> [<columns>] [<calls>] [<callchains>] [<pyside-version-1>]");
+	printerr("where:  columns            'all' or 'branches'");
+	printerr("        calls              'calls' => create calls and call_paths table");
+	printerr("        callchains         'callchains' => create call_paths table");
+	printerr("        pyside-version-1   'pyside-version-1' => use pyside version 1");
+	raise Exception("Too few or bad arguments")
 
 if (len(sys.argv) < 2):
 	usage()
@@ -95,6 +125,8 @@ for i in range(3,len(sys.argv)):
 		perf_db_export_calls = True
 	elif (sys.argv[i] == "callchains"):
 		perf_db_export_callchains = True
+	elif (sys.argv[i] == "pyside-version-1"):
+		pass
 	else:
 		usage()
 
