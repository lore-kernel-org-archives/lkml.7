Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F3FC04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 08:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E6A3206BF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 08:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="KxW2xJWU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbfERI5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 04:57:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36389 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbfERI5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 04:57:33 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I8vJbi1733397
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 01:57:19 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I8vJbi1733397
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558169839;
        bh=Pe25pnwcAbIHS/VRHhNmr3tKFQkKyLVvLOTn2hTnXbw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=KxW2xJWULbFhGC+CUmI72tyglvCdXZpwPkj+5uT/VMjDoLSVukv6C4WBd5TrCV1F/
         nFlxGqUCel1aNF9gP+wqchvhWNeGvx6pXy5121w6GXDQkyqe7TYiPA0uINP6dHQau/
         qDIOuDrlBf4G2gbQEwKSTRiUwFphb2hS1aNc5tf0HdXIiokWhDtqgxtfo6rXWhYJnA
         eMzRr4O9S+c4g5p21J8U70w32rlsVTHnJYTifZQa/SJ8IuI209D9XNiT+T4xa26uO/
         n3zAx91p5splhe5ujPAuWn2413yGmZMu67a1C6Ph6jZQEEuN+D6Yj7EMRzli4+2SeR
         rENvTPh5qq0uA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I8vITE1733394;
        Sat, 18 May 2019 01:57:18 -0700
Date:   Sat, 18 May 2019 01:57:18 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-9bc4e4bfe6169343a8f019cd5d7843a558b78363@git.kernel.org>
Cc:     hpa@zytor.com, jolsa@redhat.com, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, acme@redhat.com, tglx@linutronix.de,
        mingo@kernel.org
Reply-To: tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
          jolsa@redhat.com, linux-kernel@vger.kernel.org,
          adrian.hunter@intel.com, acme@redhat.com
In-Reply-To: <20190503120828.25326-6-adrian.hunter@intel.com>
References: <20190503120828.25326-6-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf scripts python: exported-sql-viewer.py: Add
 context menu
Git-Commit-ID: 9bc4e4bfe6169343a8f019cd5d7843a558b78363
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

Commit-ID:  9bc4e4bfe6169343a8f019cd5d7843a558b78363
Gitweb:     https://git.kernel.org/tip/9bc4e4bfe6169343a8f019cd5d7843a558b78363
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Fri, 3 May 2019 15:08:27 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:47 -0300

perf scripts python: exported-sql-viewer.py: Add context menu

Add a context menu (right-click) that provides options for copying to
clipboard, including, for trees, the ability to copy only the cell under
the mouse pointer.

Committer testing:

  $ python ~acme/libexec/perf-core/scripts/python/exported-sql-viewer.py ~/c/adrian.hunter/simple-retpoline.db

  Simply right click and pick "Copy selection", that at this point has
  just the first line, not expanded, then see what was copied by pressing
  shift+control+v on a terminal:

Call Path,Object,Count,Time (ns),Time (%),Branch Count,Branch Count (%)
▶ simple-retpolin,,,,,,

  Ditto after expanding, i.e. the selection continues to be just one
  line:

Call Path           Object   Count   Time (ns)   Time (%)   Branch Count   Branch Count (%)
▼ simple-retpolin

   Now select all the lines with the mouse and control+shift+v again:

Call Path                     Object             Count   Time (ns)   Time (%)   Branch Count   Branch Count (%)
  ▼ 14503:14503
    ▼ _start                  ld-2.28.so             1      156267      100.0          10602              100.0
      ▶ unknown               unknown                1        2276        1.5              1                0.0
      ▶ _dl_start             ld-2.28.so             1      137047       87.7          10088               95.2
      ▶ _dl_init              ld-2.28.so             1        9142        5.9            326                3.1
      ▼ _start                simple-retpoline       1        7457        4.8            182                1.7
        ▶ unknown             unknown                1         805       10.8              1                0.5
        ▶ __libc_start_main   libc-2.28.so           1        6347       85.1            179               98.4

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190503120828.25326-6-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 41 ++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index baa2b220238a..affd80ebcae0 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -887,6 +887,8 @@ class TreeWindowBase(QMdiSubWindow):
 		self.view.setSelectionMode(QAbstractItemView.ContiguousSelection)
 		self.view.CopyCellsToClipboard = CopyTreeCellsToClipboard
 
+		self.context_menu = TreeContextMenu(self.view)
+
 	def DisplayFound(self, ids):
 		if not len(ids):
 			return False
@@ -1660,6 +1662,8 @@ class BranchWindow(QMdiSubWindow):
 
 		self.ResizeColumnsToContents()
 
+		self.context_menu = TreeContextMenu(self.view)
+
 		self.find_bar = FindBar(self, self, True)
 
 		self.finder = ChildDataItemFinder(self.model.root)
@@ -2469,6 +2473,39 @@ def CopyCellsToClipboardHdr(view):
 def CopyCellsToClipboardCSV(view):
 	CopyCellsToClipboard(view, True, True)
 
+# Context menu
+
+class ContextMenu(object):
+
+	def __init__(self, view):
+		self.view = view
+		self.view.setContextMenuPolicy(Qt.CustomContextMenu)
+		self.view.customContextMenuRequested.connect(self.ShowContextMenu)
+
+	def ShowContextMenu(self, pos):
+		menu = QMenu(self.view)
+		self.AddActions(menu)
+		menu.exec_(self.view.mapToGlobal(pos))
+
+	def AddCopy(self, menu):
+		menu.addAction(CreateAction("&Copy selection", "Copy to clipboard", lambda: CopyCellsToClipboardHdr(self.view), self.view))
+		menu.addAction(CreateAction("Copy selection as CS&V", "Copy to clipboard as CSV", lambda: CopyCellsToClipboardCSV(self.view), self.view))
+
+	def AddActions(self, menu):
+		self.AddCopy(menu)
+
+class TreeContextMenu(ContextMenu):
+
+	def __init__(self, view):
+		super(TreeContextMenu, self).__init__(view)
+
+	def AddActions(self, menu):
+		i = self.view.currentIndex()
+		text = str(i.data()).strip()
+		if len(text):
+			menu.addAction(CreateAction('Copy "' + text + '"', "Copy to clipboard", lambda: QApplication.clipboard().setText(text), self.view))
+		self.AddCopy(menu)
+
 # Table window
 
 class TableWindow(QMdiSubWindow, ResizeColumnsToContentsBase):
@@ -2492,6 +2529,8 @@ class TableWindow(QMdiSubWindow, ResizeColumnsToContentsBase):
 
 		self.ResizeColumnsToContents()
 
+		self.context_menu = ContextMenu(self.view)
+
 		self.find_bar = FindBar(self, self, True)
 
 		self.finder = ChildDataItemFinder(self.data_model)
@@ -2608,6 +2647,8 @@ class TopCallsWindow(QMdiSubWindow, ResizeColumnsToContentsBase):
 		self.view.setSelectionMode(QAbstractItemView.ContiguousSelection)
 		self.view.CopyCellsToClipboard = CopyTableCellsToClipboard
 
+		self.context_menu = ContextMenu(self.view)
+
 		self.ResizeColumnsToContents()
 
 		self.find_bar = FindBar(self, self, True)
