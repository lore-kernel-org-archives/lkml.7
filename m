Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC462C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 08:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F0CB206BF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 08:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="sCk1kLw0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbfERIzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 04:55:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39483 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfERIzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 04:55:23 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I8tFhp1732976
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 01:55:15 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I8tFhp1732976
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558169716;
        bh=V6PiSYW7Efkn54P4pTH/SJXM4LPn1mxU6g5lpNAHWZ0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=sCk1kLw08i/R/9XQ8CKVWxfAUHKs4oCCV1/3UmrGbW9WoR/iyqWe47lqVEg/N3lt6
         a+9pKloUwiEWlGgIfrQQdPg/WapGIrQQc/8rj/PvaqHe1UELQR4VNRYy1WKYBhrM0L
         nI0VoTU/AiQjeNqZQfAWn8TM8RXkzNLr+H5DpvRiSzhRu2nO1Jqxdy1gDYYT/ESVHV
         td5nPoCIpMRcycup/HF86CaGdIjL+uLtx61/XR1PCud72+9psahUA1zkjyOpvPSbo0
         kXgxRYQo+ejVXRFtq8UTqh6g/dT9B6U8LehVlzcTiBARB1XsFA39nmYol+11SWhn1r
         KQJN5oGmtW8qg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I8tE6p1732973;
        Sat, 18 May 2019 01:55:14 -0700
Date:   Sat, 18 May 2019 01:55:14 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-4b2084537e5f3b58337bce894391fb63bf3b0e28@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, acme@redhat.com, hpa@zytor.com,
        jolsa@redhat.com
Reply-To: acme@redhat.com, linux-kernel@vger.kernel.org, jolsa@redhat.com,
          hpa@zytor.com, mingo@kernel.org, adrian.hunter@intel.com,
          tglx@linutronix.de
In-Reply-To: <20190503120828.25326-2-adrian.hunter@intel.com>
References: <20190503120828.25326-2-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf scripts python: exported-sql-viewer.py: Fix
 error when shrinking / enlarging font
Git-Commit-ID: 4b2084537e5f3b58337bce894391fb63bf3b0e28
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

Commit-ID:  4b2084537e5f3b58337bce894391fb63bf3b0e28
Gitweb:     https://git.kernel.org/tip/4b2084537e5f3b58337bce894391fb63bf3b0e28
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Fri, 3 May 2019 15:08:23 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:47 -0300

perf scripts python: exported-sql-viewer.py: Fix error when shrinking / enlarging font

Fix the following error if shrink / enlarge font is used with the help
window.

  Traceback (most recent call last):
    File "tools/perf/scripts/python/exported-sql-viewer.py", line 2791, in ShrinkFont
      ShrinkFont(win.view)
  AttributeError: 'HelpWindow' object has no attribute 'view'

Committer testing:

Before, matches above output:

  $ python ~acme/libexec/perf-core/scripts/python/exported-sql-viewer.py ~/c/adrian.hunter/simple-retpoline.db
  Traceback (most recent call last):
    File "/home/acme/libexec/perf-core/scripts/python/exported-sql-viewer.py", line 2780, in EnlargeFont
      EnlargeFont(win.view)
  AttributeError: 'HelpWindow' object has no attribute 'view'
  $

After:

No more tracebacks, but the fonts don't get enlarged, which is kinda
frustrating...

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190503120828.25326-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index db4655168ab1..fd073e4af8da 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -2755,6 +2755,14 @@ class MainWindow(QMainWindow):
 		help_menu = menu.addMenu("&Help")
 		help_menu.addAction(CreateAction("&Exported SQL Viewer Help", "Helpful information", self.Help, self, QKeySequence.HelpContents))
 
+	def Try(self, fn):
+		win = self.mdi_area.activeSubWindow()
+		if win:
+			try:
+				fn(win.view)
+			except:
+				pass
+
 	def Find(self):
 		win = self.mdi_area.activeSubWindow()
 		if win:
@@ -2772,12 +2780,10 @@ class MainWindow(QMainWindow):
 				pass
 
 	def ShrinkFont(self):
-		win = self.mdi_area.activeSubWindow()
-		ShrinkFont(win.view)
+		self.Try(ShrinkFont)
 
 	def EnlargeFont(self):
-		win = self.mdi_area.activeSubWindow()
-		EnlargeFont(win.view)
+		self.Try(EnlargeFont)
 
 	def EventMenu(self, events, reports_menu):
 		branches_events = 0
