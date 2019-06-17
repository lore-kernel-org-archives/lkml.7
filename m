Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2FFC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A3F208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Fb09t2+c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbfFQTJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:09:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36941 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfFQTJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:09:25 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJ95PH3558016
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:09:05 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJ95PH3558016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560798546;
        bh=KPqZ+Y7YJop9PZmX82N/anlcBKZLYLYfICHtmKdTGLA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Fb09t2+cfV+7bwqPAiHjhvQ7xqSnNW47ZWqmtaLzLwI1Pz9FC/svCSBsAhssagG4q
         K06qxhFvCnMj5+Qp/1TLFAkw833EKiy8bYDu29c2k/De25Z+ztX5wqCIt+ARrI2kK7
         PJ5ooD09+N17FuHHP2HNmrPHKhZarPuTbFdyA8EcJOEgLUnRQAV3xcvt6syUHK40SV
         3QQBxrie1u8mP2nN+ZuviBo0PerG/NluDxvWLdb7B2J4/eNtSPWpFPVpxkSTfmvrmR
         wPSFFdAN+1jNQZZyxwYXviBvaRHMNNetKNH9m9VoA8KIrQCK3TdyBRCBdKmNxOYNL6
         QvnWOXYwbSlNQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJ95NF3558013;
        Mon, 17 Jun 2019 12:09:05 -0700
Date:   Mon, 17 Jun 2019 12:09:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-530e22fd5c6d2c572b1bbdda23eafa01a005fce0@git.kernel.org>
Cc:     adrian.hunter@intel.com, mingo@kernel.org, tglx@linutronix.de,
        jolsa@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        acme@redhat.com
Reply-To: tglx@linutronix.de, adrian.hunter@intel.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, acme@redhat.com,
          jolsa@redhat.com
In-Reply-To: <20190520113728.14389-19-adrian.hunter@intel.com>
References: <20190520113728.14389-19-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf scripts python: exported-sql-viewer.py: Add
 IPC information to the Branch reports
Git-Commit-ID: 530e22fd5c6d2c572b1bbdda23eafa01a005fce0
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

Commit-ID:  530e22fd5c6d2c572b1bbdda23eafa01a005fce0
Gitweb:     https://git.kernel.org/tip/530e22fd5c6d2c572b1bbdda23eafa01a005fce0
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Mon, 20 May 2019 14:37:24 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 5 Jun 2019 09:47:57 -0300

perf scripts python: exported-sql-viewer.py: Add IPC information to the Branch reports

Enhance the "All branches" and "Selected branches" reports to display IPC
information if it is available.

Committer testing:

So, testing this I noticed that it all starts with the left arrow in every
line, that should mean there is some tree there, i.e. look at all those ▶
symbols:

Reports -> All Branches:

Time              CPU Command         PID   TID   Branch Type  In Tx  Insn Cnt  Cyc Cnt  IPC  Branch
▶ 187836112195670 7   simple-retpolin 23003 23003 trace begin  No     0         0        0               0 unknown (unknown) -> 7f6f33d4f110
+_start (ld-2.28.so)
▶ 187836112195987 7   simple-retpolin 23003 23003 trace end    No     0         883      0    7f6f33d4f110 _start (ld-2.28.so) -> 0 unknown
+(unknown)
▶ 187836112199189 7   simple-retpolin 23003 23003 trace begin  No     0         0        0               0 unknown (unknown) -> 7f6f33d4f110
+_start (ld-2.28.so)
▶ 187836112199189 7   simple-retpolin 23003 23003 call         No     0         0        0    7f6f33d4f113 _start+0x3 (ld-2.28.so) -> 7f6f33d4ff50
+_dl_start (ld-2.28.so)
▶ 187836112199544 7   simple-retpolin 23003 23003 trace end    No     17        996      0.02 7f6f33d4ff73 _dl_start+0x23 (ld-2.28.so) -> 0
+unknown (unknown)
▶ 187836112200939 7   simple-retpolin 23003 23003 trace begin  No     0         0        0               0 unknown (unknown) -> 7f6f33d4ff73
+_dl_start+0x23 (ld-2.28.so)
▶ 187836112201229 7   simple-retpolin 23003 23003 trace end    No     1         816      0.00 7f6f33d4ff7a _dl_start+0x2a (ld-2.28.so) -> 0
+unknown (unknown)
▶ 187836112203500 7   simple-retpolin 23003 23003 trace begin  No     0         0        0               0 unknown (unknown) -> 7f6f33d4ff7a
+_dl_start+0x2a (ld-2.28.so)

But if you click on it, that ▶ disappears and a new click doesn't make
it reappear, looks buggy, minor oddity, reported to Adrian.

Reports -> Selected Branches, then ask for branches in the ld-2.28.so
DSO:

Time               CPU  Command          PID    TID    Branch Type        In Tx  Insn Cnt  Cyc Cnt  IPC   Branch
▶ 187836112195987  7    simple-retpolin  23003  23003  trace end          No     0         883      0     7f6f33d4f110 _start (ld-2.28.so) -> 0 unknown (unknown)
▶ 187836112199189  7    simple-retpolin  23003  23003  trace begin        No     0         0        0                0 unknown (unknown) -> 7f6f33d4f110 _start (ld-2.28.so)
▶ 187836112199189  7    simple-retpolin  23003  23003  call               No     0         0        0     7f6f33d4f113 _start+0x3 (ld-2.28.so) -> 7f6f33d4ff50 _dl_start (ld-2.28.so)
▶ 187836112199544  7    simple-retpolin  23003  23003  trace end          No     17        996      0.02  7f6f33d4ff73 _dl_start+0x23 (ld-2.28.so) -> 0 unknown (unknown)
▶ 187836112200939  7    simple-retpolin  23003  23003  trace begin        No     0         0        0                0 unknown (unknown) -> 7f6f33d4ff73 _dl_start+0x23 (ld-2.28.so)
▶ 187836112201229  7    simple-retpolin  23003  23003  trace end          No     1         816      0.00  7f6f33d4ff7a _dl_start+0x2a (ld-2.28.so) -> 0 unknown (unknown)
▶ 187836112203500  7    simple-retpolin  23003  23003  trace begin        No     0         0        0                0 unknown (unknown) -> 7f6f33d4ff7a _dl_start+0x2a (ld-2.28.so)
▶ 187836112203528  7    simple-retpolin  23003  23003  unconditional jump No     0         0        0     7f6f33d4ffe7 _dl_start+0x97 (ld-2.28.so) -> 7f6f33d5000b _dl_start+0xbb (ld-2.28.so)
▶ 187836112203528  7    simple-retpolin  23003  23003  conditional jump   No     0         0        0     7f6f33d5000f _dl_start+0xbf (ld-2.28.so) -> 7f6f33d4fffb _dl_start+0xab (ld-2.28.so)
▶ 187836112203528  7    simple-retpolin  23003  23003  conditional jump   No     0         0        0     7f6f33d5000f _dl_start+0xbf (ld-2.28.so) -> 7f6f33d4fffb _dl_start+0xab (ld-2.28.so)
▶ 187836112203539  7    simple-retpolin  23003  23003  conditional jump   No     0         0        0     7f6f33d50025 _dl_start+0xd5 (ld-2.28.so) -> 7f6f33d50210 _dl_start+0x2c0 (ld-2.28.so)
▶ 187836112203539  7    simple-retpolin  23003  23003  conditional jump   No     0         0        0     7f6f33d5021a _dl_start+0x2ca (ld-2.28.so) -> 7f6f33d50360 _dl_start+0x410 (ld-2.28.so)
▶ 187836112203539  7    simple-retpolin  23003  23003  unconditional jump No     0         0        0     7f6f33d50377 _dl_start+0x427 (ld-2.28.so) -> 7f6f33d4ffff _dl_start+0xaf (ld-2.28.so)
▶ 187836112203539  7    simple-retpolin  23003  23003  conditional jump   No     0         0        0     7f6f33d5000f _dl_start+0xbf (ld-2.28.so) -> 7f6f33d4fffb _dl_start+0xab (ld-2.28.so)
▶ 187836112203562  7    simple-retpolin  23003  23003  conditional jump   No     0         0        0     7f6f33d5000f _dl_start+0xbf (ld-2.28.so) -> 7f6f33d4fffb _dl_start+0xab (ld-2.28.so)

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190520113728.14389-19-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 102 ++++++++++++++++++-----
 1 file changed, 83 insertions(+), 19 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 6fe553258ce5..a607235c8cd9 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -1369,11 +1369,11 @@ class FetchMoreRecordsBar():
 
 class BranchLevelTwoItem():
 
-	def __init__(self, row, text, parent_item):
+	def __init__(self, row, col, text, parent_item):
 		self.row = row
 		self.parent_item = parent_item
-		self.data = [""] * 8
-		self.data[7] = text
+		self.data = [""] * (col + 1)
+		self.data[col] = text
 		self.level = 2
 
 	def getParentItem(self):
@@ -1405,6 +1405,7 @@ class BranchLevelOneItem():
 		self.dbid = data[0]
 		self.level = 1
 		self.query_done = False
+		self.br_col = len(self.data) - 1
 
 	def getChildItem(self, row):
 		return self.child_items[row]
@@ -1485,7 +1486,7 @@ class BranchLevelOneItem():
 				while k < 15:
 					byte_str += "   "
 					k += 1
-				self.child_items.append(BranchLevelTwoItem(0, byte_str + " " + text, self))
+				self.child_items.append(BranchLevelTwoItem(0, self.br_col, byte_str + " " + text, self))
 				self.child_count += 1
 			else:
 				return
@@ -1536,16 +1537,37 @@ class BranchRootItem():
 	def getData(self, column):
 		return ""
 
+# Calculate instructions per cycle
+
+def CalcIPC(cyc_cnt, insn_cnt):
+	if cyc_cnt and insn_cnt:
+		ipc = Decimal(float(insn_cnt) / cyc_cnt)
+		ipc = str(ipc.quantize(Decimal(".01"), rounding=ROUND_HALF_UP))
+	else:
+		ipc = "0"
+	return ipc
+
 # Branch data preparation
 
-def BranchDataPrep(query):
-	data = []
-	for i in xrange(0, 8):
-		data.append(query.value(i))
+def BranchDataPrepBr(query, data):
 	data.append(tohex(query.value(8)).rjust(16) + " " + query.value(9) + offstr(query.value(10)) +
 			" (" + dsoname(query.value(11)) + ")" + " -> " +
 			tohex(query.value(12)) + " " + query.value(13) + offstr(query.value(14)) +
 			" (" + dsoname(query.value(15)) + ")")
+
+def BranchDataPrepIPC(query, data):
+	insn_cnt = query.value(16)
+	cyc_cnt = query.value(17)
+	ipc = CalcIPC(cyc_cnt, insn_cnt)
+	data.append(insn_cnt)
+	data.append(cyc_cnt)
+	data.append(ipc)
+
+def BranchDataPrep(query):
+	data = []
+	for i in xrange(0, 8):
+		data.append(query.value(i))
+	BranchDataPrepBr(query, data)
 	return data
 
 def BranchDataPrepWA(query):
@@ -1555,10 +1577,26 @@ def BranchDataPrepWA(query):
 	data.append("{:>19}".format(query.value(1)))
 	for i in xrange(2, 8):
 		data.append(query.value(i))
-	data.append(tohex(query.value(8)).rjust(16) + " " + query.value(9) + offstr(query.value(10)) +
-			" (" + dsoname(query.value(11)) + ")" + " -> " +
-			tohex(query.value(12)) + " " + query.value(13) + offstr(query.value(14)) +
-			" (" + dsoname(query.value(15)) + ")")
+	BranchDataPrepBr(query, data)
+	return data
+
+def BranchDataWithIPCPrep(query):
+	data = []
+	for i in xrange(0, 8):
+		data.append(query.value(i))
+	BranchDataPrepIPC(query, data)
+	BranchDataPrepBr(query, data)
+	return data
+
+def BranchDataWithIPCPrepWA(query):
+	data = []
+	data.append(query.value(0))
+	# Workaround pyside failing to handle large integers (i.e. time) in python3 by converting to a string
+	data.append("{:>19}".format(query.value(1)))
+	for i in xrange(2, 8):
+		data.append(query.value(i))
+	BranchDataPrepIPC(query, data)
+	BranchDataPrepBr(query, data)
 	return data
 
 # Branch data model
@@ -1572,10 +1610,20 @@ class BranchModel(TreeModel):
 		self.event_id = event_id
 		self.more = True
 		self.populated = 0
+		self.have_ipc = IsSelectable(glb.db, "samples", columns = "insn_count, cyc_count")
+		if self.have_ipc:
+			select_ipc = ", insn_count, cyc_count"
+			prep_fn = BranchDataWithIPCPrep
+			prep_wa_fn = BranchDataWithIPCPrepWA
+		else:
+			select_ipc = ""
+			prep_fn = BranchDataPrep
+			prep_wa_fn = BranchDataPrepWA
 		sql = ("SELECT samples.id, time, cpu, comm, pid, tid, branch_types.name,"
 			" CASE WHEN in_tx = '0' THEN 'No' ELSE 'Yes' END,"
 			" ip, symbols.name, sym_offset, dsos.short_name,"
 			" to_ip, to_symbols.name, to_sym_offset, to_dsos.short_name"
+			+ select_ipc +
 			" FROM samples"
 			" INNER JOIN comms ON comm_id = comms.id"
 			" INNER JOIN threads ON thread_id = threads.id"
@@ -1589,9 +1637,9 @@ class BranchModel(TreeModel):
 			" ORDER BY samples.id"
 			" LIMIT " + str(glb_chunk_sz))
 		if pyside_version_1 and sys.version_info[0] == 3:
-			prep = BranchDataPrepWA
+			prep = prep_fn
 		else:
-			prep = BranchDataPrep
+			prep = prep_wa_fn
 		self.fetcher = SQLFetcher(glb, sql, prep, self.AddSample)
 		self.fetcher.done.connect(self.Update)
 		self.fetcher.Fetch(glb_chunk_sz)
@@ -1600,13 +1648,23 @@ class BranchModel(TreeModel):
 		return BranchRootItem()
 
 	def columnCount(self, parent=None):
-		return 8
+		if self.have_ipc:
+			return 11
+		else:
+			return 8
 
 	def columnHeader(self, column):
-		return ("Time", "CPU", "Command", "PID", "TID", "Branch Type", "In Tx", "Branch")[column]
+		if self.have_ipc:
+			return ("Time", "CPU", "Command", "PID", "TID", "Branch Type", "In Tx", "Insn Cnt", "Cyc Cnt", "IPC", "Branch")[column]
+		else:
+			return ("Time", "CPU", "Command", "PID", "TID", "Branch Type", "In Tx", "Branch")[column]
 
 	def columnFont(self, column):
-		if column != 7:
+		if self.have_ipc:
+			br_col = 10
+		else:
+			br_col = 7
+		if column != br_col:
 			return None
 		return QFont("Monospace")
 
@@ -2114,10 +2172,10 @@ def GetEventList(db):
 
 # Is a table selectable
 
-def IsSelectable(db, table, sql = ""):
+def IsSelectable(db, table, sql = "", columns = "*"):
 	query = QSqlQuery(db)
 	try:
-		QueryExec(query, "SELECT * FROM " + table + " " + sql + " LIMIT 1")
+		QueryExec(query, "SELECT " + columns + " FROM " + table + " " + sql + " LIMIT 1")
 	except:
 		return False
 	return True
@@ -2854,6 +2912,12 @@ cd xed
 sudo ./mfile.py --prefix=/usr/local install
 sudo ldconfig
 </pre>
+<h3>Instructions per Cycle (IPC)</h3>
+If available, IPC information is displayed in columns 'insn_cnt', 'cyc_cnt' and 'IPC'.
+<p><b>Intel PT note:</b> The information applies to the blocks of code ending with, and including, that branch.
+Due to the granularity of timing information, the number of cycles for some code blocks will not be known.
+In that case, 'insn_cnt', 'cyc_cnt' and 'IPC' are zero, but when 'IPC' is displayed it covers the period
+since the previous displayed 'IPC'.
 <h3>Find</h3>
 Ctrl-F displays a Find bar which finds substrings by either an exact match or a regular expression match.
 Refer to Python documentation for the regular expression syntax.
