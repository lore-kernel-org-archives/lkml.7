Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCE0C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666CF2499B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="P6tavBhZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfE3ITZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 04:19:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60061 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfE3ITY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:19:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4U8J71i2905609
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 30 May 2019 01:19:07 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4U8J71i2905609
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559204348;
        bh=ufEvxYH+FQ15r7b4lPA0eQVczpyxOEqsRjJ32cUFTRM=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=P6tavBhZmTTqruZnJLlTTbxfuh0IGC0/T9QkSd2v1dSJlH0Ns81zSFOHswYyVxjU3
         MPlSsrxJE0V7c4XKkim8/FYRdn9zgBoCT0Oa49I+pLUmwRAx18mPqe88jehMzodVCP
         GLGP4zRv/2V1F95HTlU4Wd453FPNtv2H0uTnvyAqTru/3beqXHrbQZrdTR0uhxCqkN
         BzU3ZNCRBdaLJJOappECVWT7vwh0eDjKZ1Yoh/hAl3/6xWaBkIMpBSzzwYNX8CEwzo
         AyclpcOmgi+GkxCUtUTQRn1y1exYm2WfwTUS/bh+dlqzmtOtM4M2pLeNHggLMgecFx
         dNiW8gsm5rawQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4U8J7TP2905606;
        Thu, 30 May 2019 01:19:07 -0700
Date:   Thu, 30 May 2019 01:19:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-df8ea22a8fd9e4e8502f4fa917622801e1b4d09e@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, acme@redhat.com,
        hpa@zytor.com, tglx@linutronix.de, jolsa@redhat.com,
        adrian.hunter@intel.com
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org, acme@redhat.com,
          hpa@zytor.com, adrian.hunter@intel.com, tglx@linutronix.de,
          jolsa@redhat.com
In-Reply-To: <20190412113830.4126-4-adrian.hunter@intel.com>
References: <20190412113830.4126-4-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf scripts python: exported-sql-viewer.py: Add
 support for pyside2
Git-Commit-ID: df8ea22a8fd9e4e8502f4fa917622801e1b4d09e
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

Commit-ID:  df8ea22a8fd9e4e8502f4fa917622801e1b4d09e
Gitweb:     https://git.kernel.org/tip/df8ea22a8fd9e4e8502f4fa917622801e1b4d09e
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Fri, 12 Apr 2019 14:38:25 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 18:37:45 -0300

perf scripts python: exported-sql-viewer.py: Add support for pyside2

pyside2 is the future for pyside support.

Note pyside use Qt4 whereas pyside2 uses Qt5.

Committer testing:

On a system with just:

  # rpm -qa| grep -i pyside
  python2-pyside-1.2.4-7.fc29.x86_64
  #

Running:

  $ python ~acme/libexec/perf-core/scripts/python/exported-sql-viewer.py ~/c/adrian.hunter/simple-retpoline.db &
  [1] 7438

Makes it use the pyside 1 files:

  $ grep -i pyside /proc/7438/maps | cut -d ' ' -f 6- | sort -u
     /usr/lib64/libpyside-python2.7.so.1.2.4
     /usr/lib64/python2.7/site-packages/PySide/QtCore.so
     /usr/lib64/python2.7/site-packages/PySide/QtGui.so
     /usr/lib64/python2.7/site-packages/PySide/QtSql.so
  $ rpm -qf /usr/lib64/libpyside-python2.7.so.1.2.4
  python2-pyside-1.2.4-7.fc29.x86_64
  $

To get PySide2 I guess one needs to do:

  $ pip install PySide2

But thats a 142MiB download I can't do right now, perhaps before pushing
upstream...

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190412113830.4126-4-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 28 ++++++++++++++++++------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 498b79454012..6fe553258ce5 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -105,10 +105,23 @@ except ImportError:
 	glb_nsz = 16
 import re
 import os
-from PySide.QtCore import *
-from PySide.QtGui import *
-from PySide.QtSql import *
+
 pyside_version_1 = True
+if not "--pyside-version-1" in sys.argv:
+	try:
+		from PySide2.QtCore import *
+		from PySide2.QtGui import *
+		from PySide2.QtSql import *
+		from PySide2.QtWidgets import *
+		pyside_version_1 = False
+	except:
+		pass
+
+if pyside_version_1:
+	from PySide.QtCore import *
+	from PySide.QtGui import *
+	from PySide.QtSql import *
+
 from decimal import *
 from ctypes import *
 from multiprocessing import Process, Array, Value, Event
@@ -2755,7 +2768,7 @@ class WindowMenu():
 			action = self.window_menu.addAction(label)
 			action.setCheckable(True)
 			action.setChecked(sub_window == self.mdi_area.activeSubWindow())
-			action.triggered.connect(lambda x=nr: self.setActiveSubWindow(x))
+			action.triggered.connect(lambda a=None,x=nr: self.setActiveSubWindow(x))
 			self.window_menu.addAction(action)
 			nr += 1
 
@@ -3115,14 +3128,14 @@ class MainWindow(QMainWindow):
 			event = event.split(":")[0]
 			if event == "branches":
 				label = "All branches" if branches_events == 1 else "All branches " + "(id=" + dbid + ")"
-				reports_menu.addAction(CreateAction(label, "Create a new window displaying branch events", lambda x=dbid: self.NewBranchView(x), self))
+				reports_menu.addAction(CreateAction(label, "Create a new window displaying branch events", lambda a=None,x=dbid: self.NewBranchView(x), self))
 				label = "Selected branches" if branches_events == 1 else "Selected branches " + "(id=" + dbid + ")"
-				reports_menu.addAction(CreateAction(label, "Create a new window displaying branch events", lambda x=dbid: self.NewSelectedBranchView(x), self))
+				reports_menu.addAction(CreateAction(label, "Create a new window displaying branch events", lambda a=None,x=dbid: self.NewSelectedBranchView(x), self))
 
 	def TableMenu(self, tables, menu):
 		table_menu = menu.addMenu("&Tables")
 		for table in tables:
-			table_menu.addAction(CreateAction(table, "Create a new window containing a table view", lambda t=table: self.NewTableView(t), self))
+			table_menu.addAction(CreateAction(table, "Create a new window containing a table view", lambda a=None,t=table: self.NewTableView(t), self))
 
 	def NewCallGraph(self):
 		CallGraphWindow(self.glb, self)
@@ -3365,6 +3378,7 @@ def Main():
 	usage_str =	"exported-sql-viewer.py [--pyside-version-1] <database name>\n" \
 			"   or: exported-sql-viewer.py --help-only"
 	ap = argparse.ArgumentParser(usage = usage_str, add_help = False)
+	ap.add_argument("--pyside-version-1", action='store_true')
 	ap.add_argument("dbname", nargs="?")
 	ap.add_argument("--help-only", action='store_true')
 	args = ap.parse_args()
