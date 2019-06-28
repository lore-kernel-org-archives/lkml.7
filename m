Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451E5C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FA012083B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561725107;
	bh=zZkZzGRJTI052u3XTmNwGyu65cIWIOk5cn8MeOk0yx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FLs2j9Pave93rxms6Hden9sTeTUvzznv558Vki3nOx6fARv2PRy/DSi+1Hu8kkJ45
	 Q1YxXF3wc9YzOkmsl8lhrUXMjj0HBVLB9weTKlXCYsbOdlYmisXmhLrrykziCv+SGl
	 3Tshx4/PPu2i4gyr9L9PqoxJlolaUZsordPzksMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbfF1Map (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:30:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39130 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfF1Mai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=U92CTD6tuDy7j9b5xakGk2DqteV5CM69tWu7ZN/5THI=; b=X+SWOhGHuzja47Cp1iC4SSXUZz
        rClep8gUlq8pmON+93xpROdl8GUw0/uwgmRKnViYIZniZEU1/iYF5WsLy7WkUydtDqiTee31r8ZUw
        jXHEYjPfYDHD4cMIfvthheKeA4LoYUQNrt6lffvx7n4bkFTuvgtaXT8BfF/NQT7VCmcyd9TQyqQii
        n4Rjwg6bxcwRkezXN7PLCLD9AqWAU4g7Cixh41AUOhoXmVL1Dq4ZHoeZS/RyEUAS7QUYZkvQ3+vKA
        2bMRswQs0pdNztFiA8NgYl5Bh40zXXwuA7Q32m4mjvcz9tmZNnK0wfnzmVvFD+NJ2xB2Nt/mQAXcx
        XLYsqQcg==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgq1U-00055D-AE; Fri, 28 Jun 2019 12:30:36 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgq1S-0005S6-Ag; Fri, 28 Jun 2019 09:30:34 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 15/39] docs: early-userspace: move to driver-api guide
Date:   Fri, 28 Jun 2019 09:30:08 -0300
Message-Id: <e5889b2b00604491c6dc32c2f2a1d5afb9200ed8.1561724493.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561724493.git.mchehab+samsung@kernel.org>
References: <cover.1561724493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those documents describe a kAPI. So, add to the driver-api
book.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../{ => driver-api}/early-userspace/buffer-format.rst        | 0
 .../early-userspace/early_userspace_support.rst               | 0
 Documentation/{ => driver-api}/early-userspace/index.rst      | 2 --
 Documentation/driver-api/index.rst                            | 1 +
 Documentation/filesystems/nfs/nfsroot.txt                     | 2 +-
 Documentation/filesystems/ramfs-rootfs-initramfs.txt          | 4 ++--
 usr/Kconfig                                                   | 2 +-
 7 files changed, 5 insertions(+), 6 deletions(-)
 rename Documentation/{ => driver-api}/early-userspace/buffer-format.rst (100%)
 rename Documentation/{ => driver-api}/early-userspace/early_userspace_support.rst (100%)
 rename Documentation/{ => driver-api}/early-userspace/index.rst (95%)

diff --git a/Documentation/early-userspace/buffer-format.rst b/Documentation/driver-api/early-userspace/buffer-format.rst
similarity index 100%
rename from Documentation/early-userspace/buffer-format.rst
rename to Documentation/driver-api/early-userspace/buffer-format.rst
diff --git a/Documentation/early-userspace/early_userspace_support.rst b/Documentation/driver-api/early-userspace/early_userspace_support.rst
similarity index 100%
rename from Documentation/early-userspace/early_userspace_support.rst
rename to Documentation/driver-api/early-userspace/early_userspace_support.rst
diff --git a/Documentation/early-userspace/index.rst b/Documentation/driver-api/early-userspace/index.rst
similarity index 95%
rename from Documentation/early-userspace/index.rst
rename to Documentation/driver-api/early-userspace/index.rst
index 2b8eb6132058..6f20c3c560d8 100644
--- a/Documentation/early-userspace/index.rst
+++ b/Documentation/driver-api/early-userspace/index.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 ===============
 Early Userspace
 ===============
diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 97bab578ea72..d41d1c561f01 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -16,6 +16,7 @@ available subsections can be seen below.
 
    basics
    infrastructure
+   early-userspace/index
    pm/index
    clk
    device-io
diff --git a/Documentation/filesystems/nfs/nfsroot.txt b/Documentation/filesystems/nfs/nfsroot.txt
index 4862d3d77e27..ae4332464560 100644
--- a/Documentation/filesystems/nfs/nfsroot.txt
+++ b/Documentation/filesystems/nfs/nfsroot.txt
@@ -239,7 +239,7 @@ rdinit=<executable file>
   A description of the process of mounting the root file system can be
   found in:
 
-    Documentation/early-userspace/early_userspace_support.rst
+    Documentation/driver-api/early-userspace/early_userspace_support.rst
 
 
 
diff --git a/Documentation/filesystems/ramfs-rootfs-initramfs.txt b/Documentation/filesystems/ramfs-rootfs-initramfs.txt
index fa985909dbca..97d42ccaa92d 100644
--- a/Documentation/filesystems/ramfs-rootfs-initramfs.txt
+++ b/Documentation/filesystems/ramfs-rootfs-initramfs.txt
@@ -105,7 +105,7 @@ All this differs from the old initrd in several ways:
   - The old initrd file was a gzipped filesystem image (in some file format,
     such as ext2, that needed a driver built into the kernel), while the new
     initramfs archive is a gzipped cpio archive (like tar only simpler,
-    see cpio(1) and Documentation/early-userspace/buffer-format.rst).  The
+    see cpio(1) and Documentation/driver-api/early-userspace/buffer-format.rst).  The
     kernel's cpio extraction code is not only extremely small, it's also
     __init text and data that can be discarded during the boot process.
 
@@ -159,7 +159,7 @@ One advantage of the configuration file is that root access is not required to
 set permissions or create device nodes in the new archive.  (Note that those
 two example "file" entries expect to find files named "init.sh" and "busybox" in
 a directory called "initramfs", under the linux-2.6.* directory.  See
-Documentation/early-userspace/early_userspace_support.rst for more details.)
+Documentation/driver-api/early-userspace/early_userspace_support.rst for more details.)
 
 The kernel does not depend on external cpio tools.  If you specify a
 directory instead of a configuration file, the kernel's build infrastructure
diff --git a/usr/Kconfig b/usr/Kconfig
index 86e37e297278..a6b68503d177 100644
--- a/usr/Kconfig
+++ b/usr/Kconfig
@@ -18,7 +18,7 @@ config INITRAMFS_SOURCE
 	  When multiple directories and files are specified then the
 	  initramfs image will be the aggregate of all of them.
 
-	  See <file:Documentation/early-userspace/early_userspace_support.rst> for more details.
+	  See <file:Documentation/driver-api/early-userspace/early_userspace_support.rst> for more details.
 
 	  If you are not sure, leave it blank.
 
-- 
2.21.0

