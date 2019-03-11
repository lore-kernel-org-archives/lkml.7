Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16CEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6767C20857
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfCKN12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:27:28 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:37167 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbfCKNTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:36 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N7Qp1-1h0NNT1U6P-017mLe for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:34 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 051/114] fs: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:03 +0100
Message-Id: <1552310346-7629-52-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:X4Ue4hX2b9dUiniwWahe++4B3Ux+ofQAtnRmlM5SjCscIGamxXY
 ELioeAnoTrg6C4UXqpFDx66oVPymGJ6rs6mk3kpvQmzhsmfhSSwbPPtco+u9Ada7sJ6Jo5d
 aMe8vygqdpeW/vXBwlUHHjYL6uVgIeYI3EKO9KHhFYWuV6fS094bJ5K4kCCSGBdxmzJF9iP
 xZ1tyQ870Jf8SOOxCBxoQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LEojyefwLUk=:cloDDKvxooXbxan9PkqDDW
 K5p5MLpNt5IMlCkkR9NFAmzkykUjmAYbpahPnTUCaofodSpY123DAJQZ97xboOJ6HJbdfaKaC
 FfOk2YIBRbUTA6xLM0/h+RQUzYOvxwwEvoHAoWzCIPhhQIw+xamtVIMzvOtjJh2JWioZzTkLM
 YZUui8gCaFhrsjmGJcYMF+nm2cgRrwPFzdWEGU9oUDtS0a0NnOMEhKtp67bJNKaNxd8GvRqMm
 m8gpHQA98vs8VBuK7szWUXEQ543aUDPv5oUJ7WCBhPZzI6Kc/ht+VRTQPvNTD4DFvXTIPyMj8
 wRMJfiBdQ1ZPNywE9RGLAKKiSwWd6fRDzX/bHOA7Mb3um9MqA8q4fyT/xMxbmtddWI74/2bBB
 FIh98VbuSMoYTuFzOhW0szhHCnOk+J7pI3Rz5mVdF+5e+nDwXjlYg9DBY5D3mtO/Yp9x78RpD
 F594yMKwPrTpQBF8DFIj7HE8p3pab1hAWJD+QAK50nbw1YZg1jJQ4tKLA/DHG6jPfGQx9yxAE
 rJwyLZeu7M1t6tDkYN8/S7q+M86CkP7dSVM5eeBh7wxsV5BUKtnQNIAIolWw05EUUrHHcItkG
 nWnz/UQhCpJTqOYUl6FSCzvHcAO+foEYuHMOhGJCsQSOVwo6WP5nb30LaYZUX3jC0IfdUZXFA
 cRyluqQRj3YNlj+JB/9/nMqA9MQcNm1wPpRTqt24/nbe6anzqkxFTuUwtbG305uE3AkrWxEtp
 MgEv3CLulSv7vALToRPklOK1pKu9KMocsyv+Rg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 fs/9p/Kconfig              |  2 --
 fs/Kconfig                 |  6 +++---
 fs/autofs/Kconfig          | 36 ++++++++++++++++++------------------
 fs/nfs/Kconfig             |  6 +++---
 fs/notify/fanotify/Kconfig | 22 +++++++++++-----------
 fs/orangefs/Kconfig        |  4 ++--
 fs/proc/Kconfig            | 10 +++++-----
 fs/pstore/Kconfig          | 18 +++++++++---------
 fs/qnx6/Kconfig            |  2 +-
 fs/quota/Kconfig           |  2 +-
 fs/reiserfs/Kconfig        |  4 ++--
 fs/ubifs/Kconfig           |  4 ++--
 fs/ufs/Kconfig             |  4 ++--
 13 files changed, 59 insertions(+), 61 deletions(-)

diff --git a/fs/9p/Kconfig b/fs/9p/Kconfig
index e416057..f31e4c0 100644
--- a/fs/9p/Kconfig
+++ b/fs/9p/Kconfig
@@ -17,7 +17,6 @@ config 9P_FSCACHE
 	  Choose Y here to enable persistent, read-only local
 	  caching support for 9p clients using FS-Cache
 
-
 config 9P_FS_POSIX_ACL
 	bool "9P POSIX Access Control Lists"
 	select FS_POSIX_ACL
@@ -29,7 +28,6 @@ config 9P_FS_POSIX_ACL
 
 endif
 
-
 config 9P_FS_SECURITY
 	bool "9P Security Labels"
 	depends on 9P_FS
diff --git a/fs/Kconfig b/fs/Kconfig
index 2557506..11bcc80 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -6,7 +6,7 @@ menu "File systems"
 
 # Use unaligned word dcache accesses
 config DCACHE_WORD_ACCESS
-       bool
+	bool
 
 if BLOCK
 
@@ -90,8 +90,8 @@ config FILE_LOCKING
 	default y
 	help
 	  This option enables standard file locking support, required
-          for filesystems like NFS and for the flock() system
-          call. Disabling this option saves about 11k.
+	  for filesystems like NFS and for the flock() system
+	  call. Disabling this option saves about 11k.
 
 config MANDATORY_FILE_LOCKING
 	bool "Enable Mandatory file locking"
diff --git a/fs/autofs/Kconfig b/fs/autofs/Kconfig
index eaebcd4..bd07b75 100644
--- a/fs/autofs/Kconfig
+++ b/fs/autofs/Kconfig
@@ -2,30 +2,30 @@ config AUTOFS4_FS
 	tristate "Old Kconfig name for Kernel automounter support"
 	select AUTOFS_FS
 	help
-	   This name exists for people to just automatically pick up the
-	   new name of the autofs Kconfig option. All it does is select
-	   the new option name.
+	  This name exists for people to just automatically pick up the
+	  new name of the autofs Kconfig option. All it does is select
+	  the new option name.
 
-	   It will go away in a release or two as people have
-	   transitioned to just plain AUTOFS_FS.
+	  It will go away in a release or two as people have
+	  transitioned to just plain AUTOFS_FS.
 
 config AUTOFS_FS
 	tristate "Kernel automounter support (supports v3, v4 and v5)"
 	default n
 	help
-	   The automounter is a tool to automatically mount remote file systems
-	   on demand. This implementation is partially kernel-based to reduce
-	   overhead in the already-mounted case; this is unlike the BSD
-	   automounter (amd), which is a pure user space daemon.
+	  The automounter is a tool to automatically mount remote file systems
+	  on demand. This implementation is partially kernel-based to reduce
+	  overhead in the already-mounted case; this is unlike the BSD
+	  automounter (amd), which is a pure user space daemon.
 
-	   To use the automounter you need the user-space tools from
-	   <https://www.kernel.org/pub/linux/daemons/autofs/>; you also want
-	   to answer Y to "NFS file system support", below.
+	  To use the automounter you need the user-space tools from
+	  <https://www.kernel.org/pub/linux/daemons/autofs/>; you also want
+	  to answer Y to "NFS file system support", below.
 
-	   To compile this support as a module, choose M here: the module will be
-	   called autofs.
+	  To compile this support as a module, choose M here: the module will be
+	  called autofs.
 
-	   If you are not a part of a fairly large, distributed network or
-	   don't have a laptop which needs to dynamically reconfigure to the
-	   local network, you probably do not need an automounter, and can say
-	   N here.
+	  If you are not a part of a fairly large, distributed network or
+	  don't have a laptop which needs to dynamically reconfigure to the
+	  local network, you probably do not need an automounter, and can say
+	  N here.
diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index 5f93cfa..62304a0 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -147,10 +147,10 @@ config NFS_V4_1_MIGRATION
 	default n
 	help
 	  This option makes the NFS client advertise to NFSv4.1 servers that
-          it can support NFSv4 migration.
+	  it can support NFSv4 migration.
 
-          The NFSv4.1 pieces of the Linux NFSv4 migration implementation are
-          still experimental.  If you are not an NFSv4 developer, say N here.
+	  The NFSv4.1 pieces of the Linux NFSv4 migration implementation are
+	  still experimental.  If you are not an NFSv4 developer, say N here.
 
 config NFS_V4_SECURITY_LABEL
 	bool
diff --git a/fs/notify/fanotify/Kconfig b/fs/notify/fanotify/Kconfig
index 735bfb2..154e509 100644
--- a/fs/notify/fanotify/Kconfig
+++ b/fs/notify/fanotify/Kconfig
@@ -5,12 +5,12 @@ config FANOTIFY
 	select EXPORTFS
 	default n
 	---help---
-	   Say Y here to enable fanotify support.  fanotify is a file access
-	   notification system which differs from inotify in that it sends
-	   an open file descriptor to the userspace listener along with
-	   the event.
+	  Say Y here to enable fanotify support.  fanotify is a file access
+	  notification system which differs from inotify in that it sends
+	  an open file descriptor to the userspace listener along with
+	  the event.
 
-	   If unsure, say Y.
+	  If unsure, say Y.
 
 config FANOTIFY_ACCESS_PERMISSIONS
 	bool "fanotify permissions checking"
@@ -18,10 +18,10 @@ config FANOTIFY_ACCESS_PERMISSIONS
 	depends on SECURITY
 	default n
 	---help---
-	   Say Y here is you want fanotify listeners to be able to make permissions
-	   decisions concerning filesystem events.  This is used by some fanotify
-	   listeners which need to scan files before allowing the system access to
-	   use those files.  This is used by some anti-malware vendors and by some
-	   hierarchical storage management systems.
+	  Say Y here is you want fanotify listeners to be able to make permissions
+	  decisions concerning filesystem events.  This is used by some fanotify
+	  listeners which need to scan files before allowing the system access to
+	  use those files.  This is used by some anti-malware vendors and by some
+	  hierarchical storage management systems.
 
-	   If unsure, say N.
+	  If unsure, say N.
diff --git a/fs/orangefs/Kconfig b/fs/orangefs/Kconfig
index 1554c02..fe78723 100644
--- a/fs/orangefs/Kconfig
+++ b/fs/orangefs/Kconfig
@@ -2,5 +2,5 @@ config ORANGEFS_FS
 	tristate "ORANGEFS (Powered by PVFS) support"
 	select FS_POSIX_ACL
 	help
-	   Orange is a parallel file system designed for use on high end
-	   computing (HEC) systems.
+	  Orange is a parallel file system designed for use on high end
+	  computing (HEC) systems.
diff --git a/fs/proc/Kconfig b/fs/proc/Kconfig
index 817c02b..22bf579 100644
--- a/fs/proc/Kconfig
+++ b/fs/proc/Kconfig
@@ -41,8 +41,8 @@ config PROC_VMCORE
 	bool "/proc/vmcore support"
 	depends on PROC_FS && CRASH_DUMP
 	default y
-        help
-        Exports the dump image of crashed kernel in ELF format.
+	help
+	  Exports the dump image of crashed kernel in ELF format.
 
 config PROC_VMCORE_DEVICE_DUMP
 	bool "Device Hardware/Firmware Log Collection"
@@ -79,14 +79,14 @@ config PROC_SYSCTL
 	  limited in memory.
 
 config PROC_PAGE_MONITOR
- 	default y
+	default y
 	depends on PROC_FS && MMU
 	bool "Enable /proc page monitoring" if EXPERT
- 	help
+	help
 	  Various /proc files exist to monitor process memory utilization:
 	  /proc/pid/smaps, /proc/pid/clear_refs, /proc/pid/pagemap,
 	  /proc/kpagecount, and /proc/kpageflags. Disabling these
-          interfaces will reduce the size of the kernel by approximately 4kb.
+	  interfaces will reduce the size of the kernel by approximately 4kb.
 
 config PROC_CHILDREN
 	bool "Include /proc/<pid>/task/<tid>/children file"
diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index 0d19d19..df1d029 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -3,15 +3,15 @@ config PSTORE
 	select CRYPTO if PSTORE_COMPRESS
 	default n
 	help
-	   This option enables generic access to platform level
-	   persistent storage via "pstore" filesystem that can
-	   be mounted as /dev/pstore.  Only useful if you have
-	   a platform level driver that registers with pstore to
-	   provide the data, so you probably should just go say "Y"
-	   (or "M") to a platform specific persistent store driver
-	   (e.g. ACPI_APEI on X86) which will select this for you.
-	   If you don't have a platform persistent store driver,
-	   say N.
+	  This option enables generic access to platform level
+	  persistent storage via "pstore" filesystem that can
+	  be mounted as /dev/pstore.  Only useful if you have
+	  a platform level driver that registers with pstore to
+	  provide the data, so you probably should just go say "Y"
+	  (or "M") to a platform specific persistent store driver
+	  (e.g. ACPI_APEI on X86) which will select this for you.
+	  If you don't have a platform persistent store driver,
+	  say N.
 
 config PSTORE_DEFLATE_COMPRESS
 	tristate "DEFLATE (ZLIB) compression"
diff --git a/fs/qnx6/Kconfig b/fs/qnx6/Kconfig
index edbba5c..92b192a 100644
--- a/fs/qnx6/Kconfig
+++ b/fs/qnx6/Kconfig
@@ -6,7 +6,7 @@ config QNX6FS_FS
 	  QNX 6 (also called QNX RTP).
 	  Further information is available at <http://www.qnx.com/>.
 	  Say Y if you intend to mount QNX hard disks or floppies formatted
-          with a mkqnx6fs.
+	  with a mkqnx6fs.
 	  However, keep in mind that this currently is a readonly driver!
 
 	  To compile this file system support as a module, choose M here: the
diff --git a/fs/quota/Kconfig b/fs/quota/Kconfig
index 4a09975..e042a90 100644
--- a/fs/quota/Kconfig
+++ b/fs/quota/Kconfig
@@ -46,7 +46,7 @@ config QUOTA_DEBUG
 
 # Generic support for tree structured quota files. Selected when needed.
 config QUOTA_TREE
-	 tristate
+	tristate
 
 config QFMT_V1
 	tristate "Old quota format support"
diff --git a/fs/reiserfs/Kconfig b/fs/reiserfs/Kconfig
index 86e71c0..e355709 100644
--- a/fs/reiserfs/Kconfig
+++ b/fs/reiserfs/Kconfig
@@ -10,7 +10,7 @@ config REISERFS_FS
 
 	  In general, ReiserFS is as fast as ext2, but is very efficient with
 	  large directories and small files.  Additional patches are needed
-	  for NFS and quotas, please see 
+	  for NFS and quotas, please see
 	  <https://reiser4.wiki.kernel.org/index.php/Main_Page> for links.
 
 	  It is more easily extended to have features currently found in
@@ -19,7 +19,7 @@ config REISERFS_FS
 	  plugins consistent with our motto ``It takes more than a license to
 	  make source code open.''
 
-	  Read <https://reiser4.wiki.kernel.org/index.php/Main_Page> 
+	  Read <https://reiser4.wiki.kernel.org/index.php/Main_Page>
 	  to learn more about reiserfs.
 
 	  Sponsored by Threshold Networks, Emusic.com, and Bigstorage.com.
diff --git a/fs/ubifs/Kconfig b/fs/ubifs/Kconfig
index 9da2f13..b69eec0 100644
--- a/fs/ubifs/Kconfig
+++ b/fs/ubifs/Kconfig
@@ -28,8 +28,8 @@ config UBIFS_FS_LZO
 	bool "LZO compression support" if UBIFS_FS_ADVANCED_COMPR
 	default y
 	help
-	   LZO compressor is generally faster than zlib but compresses worse.
-	   Say 'Y' if unsure.
+	  LZO compressor is generally faster than zlib but compresses worse.
+	  Say 'Y' if unsure.
 
 config UBIFS_FS_ZLIB
 	bool "ZLIB compression support" if UBIFS_FS_ADVANCED_COMPR
diff --git a/fs/ufs/Kconfig b/fs/ufs/Kconfig
index 0bf6e16..13e0e71 100644
--- a/fs/ufs/Kconfig
+++ b/fs/ufs/Kconfig
@@ -10,8 +10,8 @@ config UFS_FS
 	  experimental "UFS file system write support", below. Please read the
 	  file <file:Documentation/filesystems/ufs.txt> for more information.
 
-          The recently released UFS2 variant (used in FreeBSD 5.x) is
-          READ-ONLY supported.
+	  The recently released UFS2 variant (used in FreeBSD 5.x) is
+	  READ-ONLY supported.
 
 	  Note that this option is generally not needed for floppies, since a
 	  good portable way to transport files and directories between unixes
-- 
1.9.1

