Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063B1C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 23:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C417F21019
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 23:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="hmw9H6hV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731214AbfGQXB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 19:01:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60493 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbfGQXB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 19:01:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6HN1GWo1723344
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Jul 2019 16:01:16 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6HN1GWo1723344
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563404476;
        bh=/homD5Ep82oYFNRz4K6P30qC1fMQ9WcPWv/u+GKym4c=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=hmw9H6hV+7oiYKqmF6mm3ifiFkny2uQJnNWYW6xQsXhK3dhyStPYM0P9d+JSj8UuA
         dVPcz+PnZL8BS6sbg5DsBRMMoYNCMd/mUQoYICgUB5lh0D5IEfz3lc8ug4TCBl+kyz
         3R3MnGwUQG2e7+50fVqK7WK54kq7/YBgfeHZIIJwxvrr7Op8bYqOKW3JInV4fjysUW
         DgxNQV/KJBn1tYHCvCWAzSm5Lk5gv/wZ8S/sDxNB0NeUxJCbYK2qebt7YE+5AIGCQ0
         Bp4FAhmnFoLTaVDLt/DfjeK7dYBMso8ZnkABptRWCPHKGLJ8cd2kouktdaWyew1zzO
         gKNL4UwpUt2kQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6HN1F2w1723341;
        Wed, 17 Jul 2019 16:01:15 -0700
Date:   Wed, 17 Jul 2019 16:01:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-266887291cac7f4020b5c83d2af9a13aece44a74@git.kernel.org>
Cc:     jolsa@redhat.com, mingo@kernel.org, adrian.hunter@intel.com,
        hpa@zytor.com, tglx@linutronix.de, acme@redhat.com,
        linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, jolsa@redhat.com, adrian.hunter@intel.com,
          hpa@zytor.com, tglx@linutronix.de, acme@redhat.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190710085810.1650-16-adrian.hunter@intel.com>
References: <20190710085810.1650-16-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf scripts python: exported-sql-viewer.py:
 Remove redundant semi-colons
Git-Commit-ID: 266887291cac7f4020b5c83d2af9a13aece44a74
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

Commit-ID:  266887291cac7f4020b5c83d2af9a13aece44a74
Gitweb:     https://git.kernel.org/tip/266887291cac7f4020b5c83d2af9a13aece44a74
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Wed, 10 Jul 2019 11:58:04 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 10 Jul 2019 12:31:01 -0300

perf scripts python: exported-sql-viewer.py: Remove redundant semi-colons

Remove redundant semi-colons added inadvertently.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190710085810.1650-16-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 6e7934f2ac9a..dbbd7a5d9b60 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -392,7 +392,7 @@ class FindBar():
 		self.hbox.addWidget(self.close_button)
 
 		self.bar = QWidget()
-		self.bar.setLayout(self.hbox);
+		self.bar.setLayout(self.hbox)
 		self.bar.hide()
 
 	def Widget(self):
@@ -470,7 +470,7 @@ class CallGraphLevelItemBase(object):
 		self.params = params
 		self.row = row
 		self.parent_item = parent_item
-		self.query_done = False;
+		self.query_done = False
 		self.child_count = 0
 		self.child_items = []
 		if parent_item:
@@ -517,7 +517,7 @@ class CallGraphLevelTwoPlusItemBase(CallGraphLevelItemBase):
 		self.time = time
 
 	def Select(self):
-		self.query_done = True;
+		self.query_done = True
 		query = QSqlQuery(self.glb.db)
 		if self.params.have_ipc:
 			ipc_str = ", SUM(insn_count), SUM(cyc_count)"
@@ -604,7 +604,7 @@ class CallGraphLevelOneItem(CallGraphLevelItemBase):
 		self.dbid = comm_id
 
 	def Select(self):
-		self.query_done = True;
+		self.query_done = True
 		query = QSqlQuery(self.glb.db)
 		QueryExec(query, "SELECT thread_id, pid, tid"
 					" FROM comm_threads"
@@ -622,7 +622,7 @@ class CallGraphRootItem(CallGraphLevelItemBase):
 	def __init__(self, glb, params):
 		super(CallGraphRootItem, self).__init__(glb, params, 0, None)
 		self.dbid = 0
-		self.query_done = True;
+		self.query_done = True
 		query = QSqlQuery(glb.db)
 		QueryExec(query, "SELECT id, comm FROM comms")
 		while query.next():
@@ -793,7 +793,7 @@ class CallTreeLevelTwoPlusItemBase(CallGraphLevelItemBase):
 		self.time = time
 
 	def Select(self):
-		self.query_done = True;
+		self.query_done = True
 		if self.calls_id == 0:
 			comm_thread = " AND comm_id = " + str(self.comm_id) + " AND thread_id = " + str(self.thread_id)
 		else:
@@ -881,7 +881,7 @@ class CallTreeLevelOneItem(CallGraphLevelItemBase):
 		self.dbid = comm_id
 
 	def Select(self):
-		self.query_done = True;
+		self.query_done = True
 		query = QSqlQuery(self.glb.db)
 		QueryExec(query, "SELECT thread_id, pid, tid"
 					" FROM comm_threads"
@@ -899,7 +899,7 @@ class CallTreeRootItem(CallGraphLevelItemBase):
 	def __init__(self, glb, params):
 		super(CallTreeRootItem, self).__init__(glb, params, 0, None)
 		self.dbid = 0
-		self.query_done = True;
+		self.query_done = True
 		query = QSqlQuery(glb.db)
 		QueryExec(query, "SELECT id, comm FROM comms")
 		while query.next():
@@ -971,7 +971,7 @@ class VBox():
 
 	def __init__(self, w1, w2, w3=None):
 		self.vbox = QWidget()
-		self.vbox.setLayout(QVBoxLayout());
+		self.vbox.setLayout(QVBoxLayout())
 
 		self.vbox.layout().setContentsMargins(0, 0, 0, 0)
 
@@ -1391,7 +1391,7 @@ class FetchMoreRecordsBar():
 		self.hbox.addWidget(self.close_button)
 
 		self.bar = QWidget()
-		self.bar.setLayout(self.hbox);
+		self.bar.setLayout(self.hbox)
 		self.bar.show()
 
 		self.in_progress = False
@@ -2206,7 +2206,7 @@ class ReportDialogBase(QDialog):
 		self.vbox.addLayout(self.grid)
 		self.vbox.addLayout(self.hbox)
 
-		self.setLayout(self.vbox);
+		self.setLayout(self.vbox)
 
 	def Ok(self):
 		vars = self.report_vars
@@ -3139,7 +3139,7 @@ class AboutDialog(QDialog):
 		self.vbox = QVBoxLayout()
 		self.vbox.addWidget(self.text)
 
-		self.setLayout(self.vbox);
+		self.setLayout(self.vbox)
 
 # Font resize
 
