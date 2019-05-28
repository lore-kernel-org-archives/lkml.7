Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A7BC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 21:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0614821019
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 21:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="CYqS0GW3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfE1VXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 17:23:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52615 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfE1VXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 17:23:39 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4SLNOY72238115
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 28 May 2019 14:23:24 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4SLNOY72238115
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559078605;
        bh=sFL85BkR3BwWDzlLf/9dO1wJGhAZ/egSeVB/7e44pa8=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=CYqS0GW3kxhj+BFmFoScYcZlyMf+Wj0ma68I4TSMiNzRavghlJylb2YKOyTtIhBg2
         5RUjk9yqqIPq0R8+kKHSBJAq2lQGT1UlXvGYynVNIzY6QGqui00XPeBYYW5p+aQuhd
         UfE7oP7vBRccsbhCPPTyqLg5DcOfA6lEFRYrlnNQF4VYbJ1y5MRU4GbGDsRBtFkujC
         HgnyaJA3IbYMfDComBtKnZf+EFb3g+rcFSGFpWHJ1f1/Ck3bexUTlCRlXASJbCuR3v
         iB69G+fTcC614y2Mt9eVsSf452q4KdZkJ05qbCT9ymPJXjlc/8CcwAbuSz7KgcWQ5s
         8aCpODZH4+TEg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4SLNOvp2238112;
        Tue, 28 May 2019 14:23:24 -0700
Date:   Tue, 28 May 2019 14:23:24 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-knpqr1u2ffvz6641056z2mwu@git.kernel.org>
Cc:     jolsa@kernel.org, viro@zeniv.linux.org.uk, tglx@linutronix.de,
        acme@redhat.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
        adrian.hunter@intel.com, lclaudio@redhat.com, namhyung@kernel.org,
        mingo@kernel.org, dhowells@redhat.com, wangnan0@huawei.com
Reply-To: wangnan0@huawei.com, dhowells@redhat.com, namhyung@kernel.org,
          mingo@kernel.org, adrian.hunter@intel.com, hpa@zytor.com,
          lclaudio@redhat.com, acme@redhat.com,
          linux-kernel@vger.kernel.org, jolsa@kernel.org,
          tglx@linutronix.de, viro@zeniv.linux.org.uk
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools include UAPI: Update copy of files related
 to new fspick, fsmount, fsconfig, fsopen, move_mount and open_tree syscalls
Git-Commit-ID: fba29f1820ddd42e63c38049028422dac2d86596
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

Commit-ID:  fba29f1820ddd42e63c38049028422dac2d86596
Gitweb:     https://git.kernel.org/tip/fba29f1820ddd42e63c38049028422dac2d86596
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 20 May 2019 12:03:30 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 09:49:03 -0300

tools include UAPI: Update copy of files related to new fspick, fsmount, fsconfig, fsopen, move_mount and open_tree syscalls

Copy the headers changed by these csets:

  d8076bdb56af ("uapi: Wire up the mount API syscalls on non-x86 arches [ver #2]")
  9c8ad7a2ff0b ("uapi, x86: Fix the syscall numbering of the mount API syscalls [ver #2]")
  cf3cba4a429b ("vfs: syscall: Add fspick() to select a superblock for reconfiguration")
  93766fbd2696 ("vfs: syscall: Add fsmount() to create a mount for a superblock")
  ecdab150fddb ("vfs: syscall: Add fsconfig() for configuring and managing a context")
  24dcb3d90a1f ("vfs: syscall: Add fsopen() to prepare for superblock creation")
  2db154b3ea8e ("vfs: syscall: Add move_mount(2) to move mounts around")
  a07b20004793 ("vfs: syscall: Add open_tree(2) to reference or clone a mount")

We need to create tables for all the flags argument in the new syscalls,
in followup patches.

This silences these perf build warnings:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/mount.h' differs from latest version at 'include/uapi/linux/mount.h'
  diff -u tools/include/uapi/linux/mount.h include/uapi/linux/mount.h
  Warning: Kernel ABI header at 'tools/perf/arch/x86/entry/syscalls/syscall_64.tbl' differs from latest version at 'arch/x86/entry/syscalls/syscall_64.tbl'
  diff -u tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl
  Warning: Kernel ABI header at 'tools/include/uapi/asm-generic/unistd.h' differs from latest version at 'include/uapi/asm-generic/unistd.h'
  diff -u tools/include/uapi/asm-generic/unistd.h include/uapi/asm-generic/unistd.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: David Howells <dhowells@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-knpqr1u2ffvz6641056z2mwu@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/asm-generic/unistd.h           | 14 ++++-
 tools/include/uapi/linux/fcntl.h                  |  2 +
 tools/include/uapi/linux/mount.h                  | 62 +++++++++++++++++++++++
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl |  6 +++
 4 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index dee7292e1df6..a87904daf103 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -832,9 +832,21 @@ __SYSCALL(__NR_io_uring_setup, sys_io_uring_setup)
 __SYSCALL(__NR_io_uring_enter, sys_io_uring_enter)
 #define __NR_io_uring_register 427
 __SYSCALL(__NR_io_uring_register, sys_io_uring_register)
+#define __NR_open_tree 428
+__SYSCALL(__NR_open_tree, sys_open_tree)
+#define __NR_move_mount 429
+__SYSCALL(__NR_move_mount, sys_move_mount)
+#define __NR_fsopen 430
+__SYSCALL(__NR_fsopen, sys_fsopen)
+#define __NR_fsconfig 431
+__SYSCALL(__NR_fsconfig, sys_fsconfig)
+#define __NR_fsmount 432
+__SYSCALL(__NR_fsmount, sys_fsmount)
+#define __NR_fspick 433
+__SYSCALL(__NR_fspick, sys_fspick)
 
 #undef __NR_syscalls
-#define __NR_syscalls 428
+#define __NR_syscalls 434
 
 /*
  * 32 bit systems traditionally used different
diff --git a/tools/include/uapi/linux/fcntl.h b/tools/include/uapi/linux/fcntl.h
index a2f8658f1c55..1d338357df8a 100644
--- a/tools/include/uapi/linux/fcntl.h
+++ b/tools/include/uapi/linux/fcntl.h
@@ -91,5 +91,7 @@
 #define AT_STATX_FORCE_SYNC	0x2000	/* - Force the attributes to be sync'd with the server */
 #define AT_STATX_DONT_SYNC	0x4000	/* - Don't sync attributes with the server */
 
+#define AT_RECURSIVE		0x8000	/* Apply to the entire subtree */
+
 
 #endif /* _UAPI_LINUX_FCNTL_H */
diff --git a/tools/include/uapi/linux/mount.h b/tools/include/uapi/linux/mount.h
index 3f9ec42510b0..96a0240f23fe 100644
--- a/tools/include/uapi/linux/mount.h
+++ b/tools/include/uapi/linux/mount.h
@@ -55,4 +55,66 @@
 #define MS_MGC_VAL 0xC0ED0000
 #define MS_MGC_MSK 0xffff0000
 
+/*
+ * open_tree() flags.
+ */
+#define OPEN_TREE_CLONE		1		/* Clone the target tree and attach the clone */
+#define OPEN_TREE_CLOEXEC	O_CLOEXEC	/* Close the file on execve() */
+
+/*
+ * move_mount() flags.
+ */
+#define MOVE_MOUNT_F_SYMLINKS		0x00000001 /* Follow symlinks on from path */
+#define MOVE_MOUNT_F_AUTOMOUNTS		0x00000002 /* Follow automounts on from path */
+#define MOVE_MOUNT_F_EMPTY_PATH		0x00000004 /* Empty from path permitted */
+#define MOVE_MOUNT_T_SYMLINKS		0x00000010 /* Follow symlinks on to path */
+#define MOVE_MOUNT_T_AUTOMOUNTS		0x00000020 /* Follow automounts on to path */
+#define MOVE_MOUNT_T_EMPTY_PATH		0x00000040 /* Empty to path permitted */
+#define MOVE_MOUNT__MASK		0x00000077
+
+/*
+ * fsopen() flags.
+ */
+#define FSOPEN_CLOEXEC		0x00000001
+
+/*
+ * fspick() flags.
+ */
+#define FSPICK_CLOEXEC		0x00000001
+#define FSPICK_SYMLINK_NOFOLLOW	0x00000002
+#define FSPICK_NO_AUTOMOUNT	0x00000004
+#define FSPICK_EMPTY_PATH	0x00000008
+
+/*
+ * The type of fsconfig() call made.
+ */
+enum fsconfig_command {
+	FSCONFIG_SET_FLAG	= 0,	/* Set parameter, supplying no value */
+	FSCONFIG_SET_STRING	= 1,	/* Set parameter, supplying a string value */
+	FSCONFIG_SET_BINARY	= 2,	/* Set parameter, supplying a binary blob value */
+	FSCONFIG_SET_PATH	= 3,	/* Set parameter, supplying an object by path */
+	FSCONFIG_SET_PATH_EMPTY	= 4,	/* Set parameter, supplying an object by (empty) path */
+	FSCONFIG_SET_FD		= 5,	/* Set parameter, supplying an object by fd */
+	FSCONFIG_CMD_CREATE	= 6,	/* Invoke superblock creation */
+	FSCONFIG_CMD_RECONFIGURE = 7,	/* Invoke superblock reconfiguration */
+};
+
+/*
+ * fsmount() flags.
+ */
+#define FSMOUNT_CLOEXEC		0x00000001
+
+/*
+ * Mount attributes.
+ */
+#define MOUNT_ATTR_RDONLY	0x00000001 /* Mount read-only */
+#define MOUNT_ATTR_NOSUID	0x00000002 /* Ignore suid and sgid bits */
+#define MOUNT_ATTR_NODEV	0x00000004 /* Disallow access to device special files */
+#define MOUNT_ATTR_NOEXEC	0x00000008 /* Disallow program execution */
+#define MOUNT_ATTR__ATIME	0x00000070 /* Setting on how atime should be updated */
+#define MOUNT_ATTR_RELATIME	0x00000000 /* - Update atime relative to mtime/ctime. */
+#define MOUNT_ATTR_NOATIME	0x00000010 /* - Do not update access times. */
+#define MOUNT_ATTR_STRICTATIME	0x00000020 /* - Always perform atime updates */
+#define MOUNT_ATTR_NODIRATIME	0x00000080 /* Do not update directory access times */
+
 #endif /* _UAPI_LINUX_MOUNT_H */
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index 92ee0b4378d4..b4e6f9e6204a 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -349,6 +349,12 @@
 425	common	io_uring_setup		__x64_sys_io_uring_setup
 426	common	io_uring_enter		__x64_sys_io_uring_enter
 427	common	io_uring_register	__x64_sys_io_uring_register
+428	common	open_tree		__x64_sys_open_tree
+429	common	move_mount		__x64_sys_move_mount
+430	common	fsopen			__x64_sys_fsopen
+431	common	fsconfig		__x64_sys_fsconfig
+432	common	fsmount			__x64_sys_fsmount
+433	common	fspick			__x64_sys_fspick
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
