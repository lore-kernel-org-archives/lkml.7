Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCDDC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2399120863
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="uVoCYf0h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbfFQTKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:10:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54509 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfFQTKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:10:48 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJAU6N3558295
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:10:30 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJAU6N3558295
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560798630;
        bh=jqy2W1uQ+U3HoYQ5q30EU0aa+Le6izHRBn4PLjSLo1c=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=uVoCYf0hBI+h/KkxFVCvgXC0DAQIBDXZRva8hSN9okJr+Xx87wRMU9bblYK3OmI8y
         ghlzyUidLb/lPZcQZ8ZQbOTwGSb4J2n01BuIMNHl7llKiCVHyKisJ0RkhR6ZDMLaQs
         FiZ21oA6X3uzTa+M4Hhjl/Vl0KDAzUQQkg3siQhgdPlXEAjB5PDG35/PPlqY+7kpn1
         zk4eAIytQ+EigR9bPK6Am16WyLRVdKVvniY2W2qjdBPnhx+84NOEAR7zNITRRs4gT0
         U5SBnL3oTPD3mwJp2N3tLiPZ9sYG3QQ/7SNsuxvVX5vS0PFFLhJU6/1ZZ+CA9liMoD
         /2z6U5ip3bbXQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJAT3m3558292;
        Mon, 17 Jun 2019 12:10:29 -0700
Date:   Mon, 17 Jun 2019 12:10:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-38a846d47f3d2fe6783e2df7bc5c2415239e6a63@git.kernel.org>
Cc:     acme@redhat.com, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, mingo@kernel.org, jolsa@redhat.com,
        hpa@zytor.com, tglx@linutronix.de
Reply-To: tglx@linutronix.de, hpa@zytor.com, jolsa@redhat.com,
          mingo@kernel.org, linux-kernel@vger.kernel.org,
          adrian.hunter@intel.com, acme@redhat.com
In-Reply-To: <20190520113728.14389-21-adrian.hunter@intel.com>
References: <20190520113728.14389-21-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf scripts python: exported-sql-viewer.py: Add
 IPC information to Call Graph Graph
Git-Commit-ID: 38a846d47f3d2fe6783e2df7bc5c2415239e6a63
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

Commit-ID:  38a846d47f3d2fe6783e2df7bc5c2415239e6a63
Gitweb:     https://git.kernel.org/tip/38a846d47f3d2fe6783e2df7bc5c2415239e6a63
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Mon, 20 May 2019 14:37:26 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 5 Jun 2019 09:47:57 -0300

perf scripts python: exported-sql-viewer.py: Add IPC information to Call Graph Graph

Enhance the call graph to display IPC information if it is available.

Committer testing:

[acme@quaco adrian.hunter]$ python ~acme/libexec/perf-core/scripts/python/exported-sql-viewer.py ~/c/adrian.hunter/simple-retpoline.db

Reports -> Context Sensitive Callgraph, then expand a few trees, then
select with the mouse and press control+C:

Call Path                     Object          Count Time(ns) Time(%) Insn Insn   Cyc   Cyc    IPC Branch Branch
▼ simple-retpolin                                                    Cnt  Cnt(%) Cnt   Cnt(%)     Cnt    Cnt(%)
  ▼ 23003:23003
    ▼ _start                  ld-2.28.so         1 218295   100.0  127746 100.0 207320 100.0 0.62 13046  100.0
      ▶ unknown               unknown            1   3202     1.5       0   0.0      0   0.0    0     1    0.0
      ▶ _dl_start             ld-2.28.so         1 188471    86.3  123394  96.6 180007  86.8 0.69 12529   96.0
      ▶ _dl_init              ld-2.28.so         1  13406     6.1    3207   2.5  14868   7.2 0.22   327    2.5
      ▼ _start                simple-retpoline   1  12899     5.9    1142   0.9  11561   5.6 0.10   184    1.4
        ▶ unknown             unknown            1    846     6.6       0   0.0      0   0.0    0     1    0.5
        ▼ __libc_start_main   libc-2.28.so       1  11621    90.1    1129  98.9  10350  89.5 0.11   181   98.4
          ▶ __cxa_atexit      libc-2.28.so       1   2302    19.8     101   8.9   1817  17.6 0.06    13    7.2
          ▶ __libc_csu_init   simple-retpoline   1    121     1.0      43   3.8    340   3.3 0.13     8    4.4
          ▼ _setjmp           libc-2.28.so       1     74     0.6      46   4.1    206   2.0 0.22     4    2.2
            ▼ __sigsetjmp     libc-2.28.so       1     74   100.0      46 100.0    206 100.0 0.22     3   75.0
              ▶ __sigjmp_save libc-2.28.so       1      0     0.0       0   0.0      0   0.0    0     1   33.3
          ▼ main              simple-retpoline   1     44     0.4      23   2.0    126   1.2 0.18    12    6.6
            ▼ foo             simple-retpoline   2     44   100.0      23 100.0    126 100.0 0.18    10   83.3
                bar           simple-retpoline   2     22    50.0       6  26.1     61  48.4 0.10     2   20.0
          ▶ exit              libc-2.28.so       1   9029    77.7     878  77.8   7765  75.0 0.11   139   76.8

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190520113728.14389-21-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 69 +++++++++++++++++++-----
 1 file changed, 56 insertions(+), 13 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index b3508bd4eb00..f5b1b63995b0 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -505,18 +505,24 @@ class CallGraphLevelItemBase(object):
 
 class CallGraphLevelTwoPlusItemBase(CallGraphLevelItemBase):
 
-	def __init__(self, glb, params, row, comm_id, thread_id, call_path_id, time, branch_count, parent_item):
+	def __init__(self, glb, params, row, comm_id, thread_id, call_path_id, time, insn_cnt, cyc_cnt, branch_count, parent_item):
 		super(CallGraphLevelTwoPlusItemBase, self).__init__(glb, params, row, parent_item)
 		self.comm_id = comm_id
 		self.thread_id = thread_id
 		self.call_path_id = call_path_id
+		self.insn_cnt = insn_cnt
+		self.cyc_cnt = cyc_cnt
 		self.branch_count = branch_count
 		self.time = time
 
 	def Select(self):
 		self.query_done = True;
 		query = QSqlQuery(self.glb.db)
-		QueryExec(query, "SELECT call_path_id, name, short_name, COUNT(calls.id), SUM(return_time - call_time), SUM(branch_count)"
+		if self.params.have_ipc:
+			ipc_str = ", SUM(insn_count), SUM(cyc_count)"
+		else:
+			ipc_str = ""
+		QueryExec(query, "SELECT call_path_id, name, short_name, COUNT(calls.id), SUM(return_time - call_time)" + ipc_str + ", SUM(branch_count)"
 					" FROM calls"
 					" INNER JOIN call_paths ON calls.call_path_id = call_paths.id"
 					" INNER JOIN symbols ON call_paths.symbol_id = symbols.id"
@@ -527,7 +533,15 @@ class CallGraphLevelTwoPlusItemBase(CallGraphLevelItemBase):
 					" GROUP BY call_path_id, name, short_name"
 					" ORDER BY call_path_id")
 		while query.next():
-			child_item = CallGraphLevelThreeItem(self.glb, self.params, self.child_count, self.comm_id, self.thread_id, query.value(0), query.value(1), query.value(2), query.value(3), int(query.value(4)), int(query.value(5)), self)
+			if self.params.have_ipc:
+				insn_cnt = int(query.value(5))
+				cyc_cnt = int(query.value(6))
+				branch_count = int(query.value(7))
+			else:
+				insn_cnt = 0
+				cyc_cnt = 0
+				branch_count = int(query.value(5))
+			child_item = CallGraphLevelThreeItem(self.glb, self.params, self.child_count, self.comm_id, self.thread_id, query.value(0), query.value(1), query.value(2), query.value(3), int(query.value(4)), insn_cnt, cyc_cnt, branch_count, self)
 			self.child_items.append(child_item)
 			self.child_count += 1
 
@@ -535,10 +549,17 @@ class CallGraphLevelTwoPlusItemBase(CallGraphLevelItemBase):
 
 class CallGraphLevelThreeItem(CallGraphLevelTwoPlusItemBase):
 
-	def __init__(self, glb, params, row, comm_id, thread_id, call_path_id, name, dso, count, time, branch_count, parent_item):
-		super(CallGraphLevelThreeItem, self).__init__(glb, params, row, comm_id, thread_id, call_path_id, time, branch_count, parent_item)
+	def __init__(self, glb, params, row, comm_id, thread_id, call_path_id, name, dso, count, time, insn_cnt, cyc_cnt, branch_count, parent_item):
+		super(CallGraphLevelThreeItem, self).__init__(glb, params, row, comm_id, thread_id, call_path_id, time, insn_cnt, cyc_cnt, branch_count, parent_item)
 		dso = dsoname(dso)
-		self.data = [ name, dso, str(count), str(time), PercentToOneDP(time, parent_item.time), str(branch_count), PercentToOneDP(branch_count, parent_item.branch_count) ]
+		if self.params.have_ipc:
+			insn_pcnt = PercentToOneDP(insn_cnt, parent_item.insn_cnt)
+			cyc_pcnt = PercentToOneDP(cyc_cnt, parent_item.cyc_cnt)
+			br_pcnt = PercentToOneDP(branch_count, parent_item.branch_count)
+			ipc = CalcIPC(cyc_cnt, insn_cnt)
+			self.data = [ name, dso, str(count), str(time), PercentToOneDP(time, parent_item.time), str(insn_cnt), insn_pcnt, str(cyc_cnt), cyc_pcnt, ipc, str(branch_count), br_pcnt ]
+		else:
+			self.data = [ name, dso, str(count), str(time), PercentToOneDP(time, parent_item.time), str(branch_count), PercentToOneDP(branch_count, parent_item.branch_count) ]
 		self.dbid = call_path_id
 
 # Context-sensitive call graph data model level two item
@@ -546,18 +567,28 @@ class CallGraphLevelThreeItem(CallGraphLevelTwoPlusItemBase):
 class CallGraphLevelTwoItem(CallGraphLevelTwoPlusItemBase):
 
 	def __init__(self, glb, params, row, comm_id, thread_id, pid, tid, parent_item):
-		super(CallGraphLevelTwoItem, self).__init__(glb, params, row, comm_id, thread_id, 1, 0, 0, parent_item)
-		self.data = [str(pid) + ":" + str(tid), "", "", "", "", "", ""]
+		super(CallGraphLevelTwoItem, self).__init__(glb, params, row, comm_id, thread_id, 1, 0, 0, 0, 0, parent_item)
+		if self.params.have_ipc:
+			self.data = [str(pid) + ":" + str(tid), "", "", "", "", "", "", "", "", "", "", ""]
+		else:
+			self.data = [str(pid) + ":" + str(tid), "", "", "", "", "", ""]
 		self.dbid = thread_id
 
 	def Select(self):
 		super(CallGraphLevelTwoItem, self).Select()
 		for child_item in self.child_items:
 			self.time += child_item.time
+			self.insn_cnt += child_item.insn_cnt
+			self.cyc_cnt += child_item.cyc_cnt
 			self.branch_count += child_item.branch_count
 		for child_item in self.child_items:
 			child_item.data[4] = PercentToOneDP(child_item.time, self.time)
-			child_item.data[6] = PercentToOneDP(child_item.branch_count, self.branch_count)
+			if self.params.have_ipc:
+				child_item.data[6] = PercentToOneDP(child_item.insn_cnt, self.insn_cnt)
+				child_item.data[8] = PercentToOneDP(child_item.cyc_cnt, self.cyc_cnt)
+				child_item.data[11] = PercentToOneDP(child_item.branch_count, self.branch_count)
+			else:
+				child_item.data[6] = PercentToOneDP(child_item.branch_count, self.branch_count)
 
 # Context-sensitive call graph data model level one item
 
@@ -565,7 +596,10 @@ class CallGraphLevelOneItem(CallGraphLevelItemBase):
 
 	def __init__(self, glb, params, row, comm_id, comm, parent_item):
 		super(CallGraphLevelOneItem, self).__init__(glb, params, row, parent_item)
-		self.data = [comm, "", "", "", "", "", ""]
+		if self.params.have_ipc:
+			self.data = [comm, "", "", "", "", "", "", "", "", "", "", ""]
+		else:
+			self.data = [comm, "", "", "", "", "", ""]
 		self.dbid = comm_id
 
 	def Select(self):
@@ -694,14 +728,23 @@ class CallGraphModel(CallGraphModelBase):
 		return CallGraphRootItem(self.glb, self.params)
 
 	def columnCount(self, parent=None):
-		return 7
+		if self.params.have_ipc:
+			return 12
+		else:
+			return 7
 
 	def columnHeader(self, column):
-		headers = ["Call Path", "Object", "Count ", "Time (ns) ", "Time (%) ", "Branch Count ", "Branch Count (%) "]
+		if self.params.have_ipc:
+			headers = ["Call Path", "Object", "Count ", "Time (ns) ", "Time (%) ", "Insn Cnt", "Insn Cnt (%)", "Cyc Cnt", "Cyc Cnt (%)", "IPC", "Branch Count ", "Branch Count (%) "]
+		else:
+			headers = ["Call Path", "Object", "Count ", "Time (ns) ", "Time (%) ", "Branch Count ", "Branch Count (%) "]
 		return headers[column]
 
 	def columnAlignment(self, column):
-		alignment = [ Qt.AlignLeft, Qt.AlignLeft, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight ]
+		if self.params.have_ipc:
+			alignment = [ Qt.AlignLeft, Qt.AlignLeft, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight ]
+		else:
+			alignment = [ Qt.AlignLeft, Qt.AlignLeft, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight ]
 		return alignment[column]
 
 	def DoFindSelect(self, query, match):
