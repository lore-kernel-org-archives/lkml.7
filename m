Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CE0C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 08:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9002B206BF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 08:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="c7EkDU8F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbfERI6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 04:58:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57181 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbfERI6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 04:58:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I8w2eJ1733490
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 01:58:02 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I8w2eJ1733490
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558169882;
        bh=SDKoDq2qW2W/HKU6A0ZbXbUxtPXAQtvimFJkIDTqsJ4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=c7EkDU8F836jgFToF6StC4sTrS2bydUeGtR3i+bDCKrVA7ZfmXU0q55QS41iXuhCl
         KMle4GnufHmU8FbDaW5sQ1ofpMuND4tujTBxN6am1+EpOF/48lbgaaIKfXCAI1pQZ9
         rx6lRexNj5vbPwCG0GXHt6yxLYPMAU4Y+LGNOl1dK0RO8REaq4df7kk1uNLLZJXGqm
         3V6hVVQfv4gzrtWXyEQRu+ypTVSC+nTBMxB74fX5noav1jkNVWRODblTYxdiVFRoAL
         4CvOiG84QsYRB4FDdQsRm9XHy+s/mGrxfFzPm4ncvhY225Z+7Njg44cVGz5g88lpA/
         LgqVAfPAjvGVw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I8w1nk1733484;
        Sat, 18 May 2019 01:58:01 -0700
Date:   Sat, 18 May 2019 01:58:01 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-b62d18aba1109506c1926ab7b564c4ac3bd48786@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, jolsa@redhat.com,
        hpa@zytor.com, acme@redhat.com, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, acme@redhat.com, adrian.hunter@intel.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          mingo@kernel.org, jolsa@redhat.com
In-Reply-To: <20190503120828.25326-7-adrian.hunter@intel.com>
References: <20190503120828.25326-7-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf scripts python: exported-sql-viewer.py: Add
 'About' dialog box
Git-Commit-ID: b62d18aba1109506c1926ab7b564c4ac3bd48786
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

Commit-ID:  b62d18aba1109506c1926ab7b564c4ac3bd48786
Gitweb:     https://git.kernel.org/tip/b62d18aba1109506c1926ab7b564c4ac3bd48786
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Fri, 3 May 2019 15:08:28 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:47 -0300

perf scripts python: exported-sql-viewer.py: Add 'About' dialog box

With support for Python 2 or 3 and PySide 1 or 2 (Qt 4 or 5), it is
useful to see what versions are in use. Add an 'About' dialog box that
displays Python, PySide, Qt and database server (SQLite or PostgreSQL)
version numbers.

Committer testing:

  $ python ~acme/libexec/perf-core/scripts/python/exported-sql-viewer.py ~/c/adrian.hunter/simple-retpoline.db

  Then go to 'Help', then 'About', select all the lines with the mouse
  press 'Control+C', then, on the same terminal press control+shift+V
  which shows my current environment:

Python version:     2.7.16
PySide version:     1
Qt version:         4.8.7
SQLite version:     3.26.0

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190503120828.25326-7-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 59 ++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index affd80ebcae0..affed7d149be 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -2913,6 +2913,60 @@ class HelpOnlyWindow(QMainWindow):
 
 		self.setCentralWidget(self.text)
 
+# PostqreSQL server version
+
+def PostqreSQLServerVersion(db):
+	query = QSqlQuery(db)
+	QueryExec(query, "SELECT VERSION()")
+	if query.next():
+		v_str = query.value(0)
+		v_list = v_str.strip().split(" ")
+		if v_list[0] == "PostgreSQL" and v_list[2] == "on":
+			return v_list[1]
+		return v_str
+	return "Unknown"
+
+# SQLite version
+
+def SQLiteVersion(db):
+	query = QSqlQuery(db)
+	QueryExec(query, "SELECT sqlite_version()")
+	if query.next():
+		return query.value(0)
+	return "Unknown"
+
+# About dialog
+
+class AboutDialog(QDialog):
+
+	def __init__(self, glb, parent=None):
+		super(AboutDialog, self).__init__(parent)
+
+		self.setWindowTitle("About Exported SQL Viewer")
+		self.setMinimumWidth(300)
+
+		pyside_version = "1" if pyside_version_1 else "2"
+
+		text = "<pre>"
+		text += "Python version:     " + sys.version.split(" ")[0] + "\n"
+		text += "PySide version:     " + pyside_version + "\n"
+		text += "Qt version:         " + qVersion() + "\n"
+		if glb.dbref.is_sqlite3:
+			text += "SQLite version:     " + SQLiteVersion(glb.db) + "\n"
+		else:
+			text += "PostqreSQL version: " + PostqreSQLServerVersion(glb.db) + "\n"
+		text += "</pre>"
+
+		self.text = QTextBrowser()
+		self.text.setHtml(text)
+		self.text.setReadOnly(True)
+		self.text.setOpenExternalLinks(True)
+
+		self.vbox = QVBoxLayout()
+		self.vbox.addWidget(self.text)
+
+		self.setLayout(self.vbox);
+
 # Font resize
 
 def ResizeFont(widget, diff):
@@ -3010,6 +3064,7 @@ class MainWindow(QMainWindow):
 
 		help_menu = menu.addMenu("&Help")
 		help_menu.addAction(CreateAction("&Exported SQL Viewer Help", "Helpful information", self.Help, self, QKeySequence.HelpContents))
+		help_menu.addAction(CreateAction("&About Exported SQL Viewer", "About this application", self.About, self))
 
 	def Try(self, fn):
 		win = self.mdi_area.activeSubWindow()
@@ -3095,6 +3150,10 @@ class MainWindow(QMainWindow):
 	def Help(self):
 		HelpWindow(self.glb, self)
 
+	def About(self):
+		dialog = AboutDialog(self.glb, self)
+		dialog.exec_()
+
 # XED Disassembler
 
 class xed_state_t(Structure):
