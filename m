Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67152C004EF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 09:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45B0020693
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 09:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbfGJJAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 05:00:18 -0400
Received: from mga12.intel.com ([192.55.52.136]:35485 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727802AbfGJI7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 04:59:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 01:59:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,474,1557212400"; 
   d="scan'208";a="186102568"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.122])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jul 2019 01:59:45 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 15/21] perf scripts python: exported-sql-viewer.py: Remove redundant semi-colons
Date:   Wed, 10 Jul 2019 11:58:04 +0300
Message-Id: <20190710085810.1650-16-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190710085810.1650-1-adrian.hunter@intel.com>
References: <20190710085810.1650-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant semi-colons added inadvertently.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../scripts/python/exported-sql-viewer.py     | 24 +++++++++----------
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
 
-- 
2.17.1

