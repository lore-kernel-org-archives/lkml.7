Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EE1C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 22:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C462085A
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 22:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="c2kIbGdS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731481AbfCaWPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 18:15:02 -0400
Received: from mout.gmx.net ([212.227.17.22]:47657 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731326AbfCaWPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 18:15:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1554070496;
        bh=HHvs9uqx8QYaZFKoKrmmeCrfLmR1vDbZqrxg6Mjlo24=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=c2kIbGdS1/gQsfzSFOIto+cAk+YTWCHGEbh4e6UyKbnVRi7MZGloOErvKTDzO4Enj
         20SjVUyCumV9LlOAsq1Fqok86wyzgeee5poq/Y54CGwYifHKNg6lMDDtEz6MLD3ZHT
         ByubWUpLGpEuNgIdDXbJvdrmLwhLcAMaKuZKPS0I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mb31L-1hUqoV15Lf-00KiXQ; Mon, 01
 Apr 2019 00:14:56 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Martin Kepplinger <martink@posteo.de>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: kernel-docs: Move vfs.txt under "Docs at the Linux Kernel tree"
Date:   Mon,  1 Apr 2019 00:14:37 +0200
Message-Id: <20190331221439.22892-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O7KTsPp0xlclYLPwAx6k/3FXWHdDBaLXdvujS7atYdGU4twfpWM
 MquGgtNEo6lSTUCV0ZeNoyuRTtXb735cNwdo09XDiJPFcdliy+JvHZesFzgwqu4Zge2tJ9W
 0L0yGfNdDpCkLBf2C6bJaCyO7Rp5z9c7RbvJOofo+eKXe3IT4jkObQM7ytGS5bzZbzLcI9S
 wzIQroQmwf1scp5e1mWrw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G6eYhcGZFLY=:PFRJacDhlpjBsVdbWk6L/f
 7zRapPTdVWTuzCbJ4k97vvRrN6jYOLpC+ehaNi3H7QvkunGBcLb8esbyaWG1+d+qNVVF9Dx4S
 kxQK/Y+2P74m+2GccrGZtDVukX7UvBtXkfZmNucb9vdxIxuY4M9YOSkSWQ/jKDm0Qj2xUhZwz
 pqk1trvhOBptVA5xDdBcfH8/aQTAcl9zfOniBCnVQcZ/xIQtczIXhqUPeaV9MkmIWWdndr+7l
 Kb0sYw9aW2hMJDw/5E0CmcDsyXeJIWXRIP541MQkaXd9sI6brSkTCQT1QWzuFUm76IS3ORm73
 Rr9g04dEEwExd9jyWbWGUUc2HtmiZP9jJ9lrE5eoKgBi9u/YaYhm9pcUHyFspMhurYXC6oO0e
 i/P6mizw5VvWVA6gjSxGW12hmLajY2cp7sReVp8EHsmM0Pn6c/Dm0K6RI1owyJNTlWjGprqnw
 nOuCBWwxFKLZqZel2fRHl0nGxwksPSL1XdvvUbaPsnubbtvb5TDvvWkbmy/W6+7WT68JfIiR1
 Jcq8oKj2tHR39mi2Isbn11K/oUdg90Scn0D6ltczqP3VrRAw1kU4O7DwZqvj+7WxRSDlDMZLE
 OnfbTEXGrU2671wGx7s6JzgHSJhNWgbgd+qbg7DiCd1L4d/yTJ9FFoxhgEmkwk1Xfu/l1YGmt
 gZflE1ygia4FEkE6f0t46vFIAGcfTgELJ3dL3gbXLRHrx2ecM/vgcqzh20/IG/RaMw85McZmL
 MHVdCzML+jYKEelx2cdnrlrjETjfYLS7/D/2Czrtcq/Pl3xfJ0R+y3IasHh+C9kGZwYoDp6Iv
 KF2gZCJD5dD4KeSa+iuCWCEMp9sT/V0n0aeYx6y9vJxIHLszEw1NpdMwBRx2QzwYJ36kEW7fQ
 3Ezgi3ySudOKg35IIw9R7cVjPLHSO6T5AReO+bMxACo0hajqJLLrJ1WUOlowNrx4tTNeM5Kw2
 m8R3fnHPpUQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's unnecessary to point to an external mirror of the Documentation
directory. Also, drop the date field, because in-kernel documentation is
continually updated.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

Alternatively, we might drop this entry of the list entirely, because
Documentation/ is already covered.
=2D--
 Documentation/process/kernel-docs.rst | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process=
/kernel-docs.rst
index ab12dddc773e..92488e59943d 100644
=2D-- a/Documentation/process/kernel-docs.rst
+++ b/Documentation/process/kernel-docs.rst
@@ -52,6 +52,17 @@ The Sphinx books should be built with ``make {htmldocs =
| pdfdocs | epubdocs}``.
         (including this document itself) have been moved there, and might
         be more up to date than the web version.

+    * Title: **Overview of the Virtual File System**
+
+      :Author: Richard Gooch.
+      :Location: Documentation/filesystems/vfs.txt
+      :Keywords: VFS, File System, mounting filesystems, opening files,
+        dentries, dcache.
+      :Description: Brief introduction to the Linux Virtual File System.
+        What is it, how it works, operations taken when opening a file or
+        mounting a file system and description of important data
+        structures explaining the purpose of each of their entries.
+
 On-line docs
 ------------

@@ -95,18 +106,6 @@ On-line docs
         [...]. This paper examines some common problems for
         submitting larger changes and some strategies to avoid problems.

-    * Title: **Overview of the Virtual File System**
-
-      :Author: Richard Gooch.
-      :URL: http://www.mjmwired.net/kernel/Documentation/filesystems/vfs.=
txt
-      :Date: 2007
-      :Keywords: VFS, File System, mounting filesystems, opening files,
-        dentries, dcache.
-      :Description: Brief introduction to the Linux Virtual File System.
-        What is it, how it works, operations taken when opening a file or
-        mounting a file system and description of important data
-        structures explaining the purpose of each of their entries.
-
     * Title: **Linux Device Drivers, Third Edition**

       :Author: Jonathan Corbet, Alessandro Rubini, Greg Kroah-Hartman
=2D-
2.20.1

