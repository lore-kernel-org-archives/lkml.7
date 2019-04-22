Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20591C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 13:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA1820685
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 13:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555940003;
	bh=uNxua4uyxhO0zNIiA5f6pkkOxHGeyi+yhTrmq9RZ9CI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mNNvh9Ty3/2tt7+EYd5v/FMCqssnvpvh/h3XorY4UkzQdI2Ten/522mkugjAcOOuu
	 45nZMpqJs9cXx4DGfugZKycsQhg+9n9647JWgB8Vy2pv1SckYopYkJNkeN8Wse9Yqo
	 KHE6xThVsTaphrNxJ2yjsXOVtXXwvdT5ymrYoVIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfDVNdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 09:33:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37654 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbfDVN2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 09:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6IB4IkrGogi05Cu5+3RMnHJoai4Wblvx8D3/XA7H3lI=; b=hUGckjtiW+u2MW73r8hw6X8/wy
        46+Zk1MOYsWDdDhkpFp+eg2R00wUbIsUi5jcUKuc131uVubmpEZvN43sjtT6muENaXOH5dBdiNuQs
        kcRL62KBAD+29R+ppmAfsgWxWCJJ0hzREpJ/ABEa2e6bNEFr5sufsWRSodU9IsroSp5hcQmM3Nm18
        NKm22kyHt6hQ5DUFXLsuHTzQewYznZ5JBtcamO+Ne4jPERtjVxjf1KYCW5XCk5O1rKnN4FLciJaQN
        TdHsAFkh9AyByJFqf284bx0ZLpdRDjGVYdJpJDNhkZk7BC3ioWOuPk6AFpdnB5oV2KaCKbfYZjEAm
        dXPWlInw==;
Received: from 179.176.125.229.dynamic.adsl.gvt.net.br ([179.176.125.229] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIYza-0005Hb-SF; Mon, 22 Apr 2019 13:28:19 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hIYzT-0005nG-Li; Mon, 22 Apr 2019 10:28:11 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 47/79] docs: early-userspace: convert docs to ReST and rename to *.rst
Date:   Mon, 22 Apr 2019 10:27:36 -0300
Message-Id: <7a56735f8a86a8a2424a9a393261f244f4f77dbd.1555938376.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1555938375.git.mchehab+samsung@kernel.org>
References: <cover.1555938375.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The two files there describes a Kernel API feature, used to
support early userspace stuff. Prepare for moving them to
the kernel API book by converting to ReST format.

The conversion itself was quite trivial: just add/mark a few
titles as such, add a literal block markup, add a table markup
and a few blank lines, in order to make Sphinx to properly parse it.

At its new index.rst, let's add a :orphan: while this is not linked to
the main index.rst file, in order to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../{buffer-format.txt => buffer-format.rst}  | 19 +++++++++++++------
 .../{README => early_userspace_support.rst}   |  3 +++
 Documentation/early-userspace/index.rst       | 18 ++++++++++++++++++
 Documentation/filesystems/nfs/nfsroot.txt     |  2 +-
 .../filesystems/ramfs-rootfs-initramfs.txt    |  4 ++--
 usr/Kconfig                                   |  2 +-
 6 files changed, 38 insertions(+), 10 deletions(-)
 rename Documentation/early-userspace/{buffer-format.txt => buffer-format.rst} (91%)
 rename Documentation/early-userspace/{README => early_userspace_support.rst} (99%)
 create mode 100644 Documentation/early-userspace/index.rst

diff --git a/Documentation/early-userspace/buffer-format.txt b/Documentation/early-userspace/buffer-format.rst
similarity index 91%
rename from Documentation/early-userspace/buffer-format.txt
rename to Documentation/early-userspace/buffer-format.rst
index e1fd7f9dad16..7f74e301fdf3 100644
--- a/Documentation/early-userspace/buffer-format.txt
+++ b/Documentation/early-userspace/buffer-format.rst
@@ -1,8 +1,10 @@
-		       initramfs buffer format
-		       -----------------------
+=======================
+initramfs buffer format
+=======================
 
-		       Al Viro, H. Peter Anvin
-		      Last revision: 2002-01-13
+Al Viro, H. Peter Anvin
+
+Last revision: 2002-01-13
 
 Starting with kernel 2.5.x, the old "initial ramdisk" protocol is
 getting {replaced/complemented} with the new "initial ramfs"
@@ -18,7 +20,8 @@ archive can be compressed using gzip(1).  One valid version of an
 initramfs buffer is thus a single .cpio.gz file.
 
 The full format of the initramfs buffer is defined by the following
-grammar, where:
+grammar, where::
+
 	*	is used to indicate "0 or more occurrences of"
 	(|)	indicates alternatives
 	+	indicates concatenation
@@ -49,7 +52,9 @@ hexadecimal ASCII numbers fully padded with '0' on the left to the
 full width of the field, for example, the integer 4780 is represented
 by the ASCII string "000012ac"):
 
+============= ================== ==============================================
 Field name    Field size	 Meaning
+============= ================== ==============================================
 c_magic	      6 bytes		 The string "070701" or "070702"
 c_ino	      8 bytes		 File inode number
 c_mode	      8 bytes		 File mode and permissions
@@ -65,6 +70,7 @@ c_rmin	      8 bytes		 Minor part of device node reference
 c_namesize    8 bytes		 Length of filename, including final \0
 c_chksum      8 bytes		 Checksum of data field if c_magic is 070702;
 				 otherwise zero
+============= ================== ==============================================
 
 The c_mode field matches the contents of st_mode returned by stat(2)
 on Linux, and encodes the file type and file permissions.
@@ -82,7 +88,8 @@ If the filename is "TRAILER!!!" this is actually an end-of-archive
 marker; the c_filesize for an end-of-archive marker must be zero.
 
 
-*** Handling of hard links
+Handling of hard links
+======================
 
 When a nondirectory with c_nlink > 1 is seen, the (c_maj,c_min,c_ino)
 tuple is looked up in a tuple buffer.  If not found, it is entered in
diff --git a/Documentation/early-userspace/README b/Documentation/early-userspace/early_userspace_support.rst
similarity index 99%
rename from Documentation/early-userspace/README
rename to Documentation/early-userspace/early_userspace_support.rst
index 955d667dc87e..3deefb34046b 100644
--- a/Documentation/early-userspace/README
+++ b/Documentation/early-userspace/early_userspace_support.rst
@@ -1,3 +1,4 @@
+=======================
 Early userspace support
 =======================
 
@@ -26,6 +27,7 @@ archive to be used as the image or have the kernel build process build
 the image from specifications.
 
 CPIO ARCHIVE method
+-------------------
 
 You can create a cpio archive that contains the early userspace image.
 Your cpio archive should be specified in CONFIG_INITRAMFS_SOURCE and it
@@ -34,6 +36,7 @@ CONFIG_INITRAMFS_SOURCE and directory and file names are not allowed in
 combination with a cpio archive.
 
 IMAGE BUILDING method
+---------------------
 
 The kernel build process can also build an early userspace image from
 source parts rather than supplying a cpio archive.  This method provides
diff --git a/Documentation/early-userspace/index.rst b/Documentation/early-userspace/index.rst
new file mode 100644
index 000000000000..2b8eb6132058
--- /dev/null
+++ b/Documentation/early-userspace/index.rst
@@ -0,0 +1,18 @@
+:orphan:
+
+===============
+Early Userspace
+===============
+
+.. toctree::
+    :maxdepth: 1
+
+    early_userspace_support
+    buffer-format
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/filesystems/nfs/nfsroot.txt b/Documentation/filesystems/nfs/nfsroot.txt
index d2963123eb1c..4862d3d77e27 100644
--- a/Documentation/filesystems/nfs/nfsroot.txt
+++ b/Documentation/filesystems/nfs/nfsroot.txt
@@ -239,7 +239,7 @@ rdinit=<executable file>
   A description of the process of mounting the root file system can be
   found in:
 
-    Documentation/early-userspace/README
+    Documentation/early-userspace/early_userspace_support.rst
 
 
 
diff --git a/Documentation/filesystems/ramfs-rootfs-initramfs.txt b/Documentation/filesystems/ramfs-rootfs-initramfs.txt
index 79637d227e85..fa985909dbca 100644
--- a/Documentation/filesystems/ramfs-rootfs-initramfs.txt
+++ b/Documentation/filesystems/ramfs-rootfs-initramfs.txt
@@ -105,7 +105,7 @@ All this differs from the old initrd in several ways:
   - The old initrd file was a gzipped filesystem image (in some file format,
     such as ext2, that needed a driver built into the kernel), while the new
     initramfs archive is a gzipped cpio archive (like tar only simpler,
-    see cpio(1) and Documentation/early-userspace/buffer-format.txt).  The
+    see cpio(1) and Documentation/early-userspace/buffer-format.rst).  The
     kernel's cpio extraction code is not only extremely small, it's also
     __init text and data that can be discarded during the boot process.
 
@@ -159,7 +159,7 @@ One advantage of the configuration file is that root access is not required to
 set permissions or create device nodes in the new archive.  (Note that those
 two example "file" entries expect to find files named "init.sh" and "busybox" in
 a directory called "initramfs", under the linux-2.6.* directory.  See
-Documentation/early-userspace/README for more details.)
+Documentation/early-userspace/early_userspace_support.rst for more details.)
 
 The kernel does not depend on external cpio tools.  If you specify a
 directory instead of a configuration file, the kernel's build infrastructure
diff --git a/usr/Kconfig b/usr/Kconfig
index 43658b8a975e..86e37e297278 100644
--- a/usr/Kconfig
+++ b/usr/Kconfig
@@ -18,7 +18,7 @@ config INITRAMFS_SOURCE
 	  When multiple directories and files are specified then the
 	  initramfs image will be the aggregate of all of them.
 
-	  See <file:Documentation/early-userspace/README> for more details.
+	  See <file:Documentation/early-userspace/early_userspace_support.rst> for more details.
 
 	  If you are not sure, leave it blank.
 
-- 
2.20.1

