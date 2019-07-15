Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03171C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF34620693
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563225228;
	bh=0lIgg6FalpNVwMcwpZb2sbJWWOgYTTfgJ27Wfm/ALBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uEqJF4G3ElzXHTbf1bM3SsIelDLayjEl6dCVL3SrhY9KA8ISTzXgda2wAcJOBockG
	 /l/M6fq4eYaxNcgGBAgLPEuf3F1fVoOl56jnH/kcaP9ZCdV3dNToSc/zXml8xblXmM
	 zqizZ/wfd8noTVwQsFpnuoAgUdb/DwJZ2jHC5djE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733235AbfGOVNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 17:13:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:44650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731684AbfGOVNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 17:13:46 -0400
Received: from quaco.ghostprotocols.net (179-240-129-12.3g.claro.net.br [179.240.129.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D89320449;
        Mon, 15 Jul 2019 21:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563225225;
        bh=0lIgg6FalpNVwMcwpZb2sbJWWOgYTTfgJ27Wfm/ALBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0nvBq+GlcITkqyNntHTh/ezvCOFwMP0Rj3nM/SoYDo3EqkmImXDNa83U4CrHgbxgL
         +sLcYNTM4lZMT/I/71gXggTqgbEb3/8YIGZt6cYBnntkUhoe6N2xgtXQvU1M8qXPVl
         7W0+S3/YGJlVvNaO2fF9FVB+YHHAPH4Sjag/EWEo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 18/28] perf scripts python: exported-sql-viewer.py: Remove redundant semi-colons
Date:   Mon, 15 Jul 2019 18:11:50 -0300
Message-Id: <20190715211200.10984-19-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190715211200.10984-1-acme@kernel.org>
References: <20190715211200.10984-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Remove redundant semi-colons added inadvertently.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190710085810.1650-16-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.21.0

