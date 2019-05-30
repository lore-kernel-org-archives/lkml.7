Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45C2C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7300F25808
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="XwJSIKV6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbfE3IG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 04:06:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59231 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfE3IG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:06:27 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4U86EVe2903463
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 30 May 2019 01:06:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4U86EVe2903463
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559203575;
        bh=+FvU1uFEZulDV63/GZtu9PRRpymFz/0yNiQYk4SA3Y8=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=XwJSIKV6Uor0iygRQ22XzcDRBZIXEXLzL1iCtYoCEnEUrpW2ZqNGy18R67Z4ywPr2
         7uTfXWM7LwHdPMdgj9gUIakSp6biNu394fuuNQwe5fYPi291IDGeF0+ukQoslVAmFT
         +oq5sJXUNyMERfqmdEhUJCA/2ZpynkfKhxCShIMt7BBXgopmxH/N8XN1HOjLVYaOkc
         RB9zEQwEZSkBvxu15ncgDKAzhkobNYeIyC7LXHL/wh80UYdvuNunaxeX25VHiZH4i5
         nYQ7KARvVeKP2Ag7KeYCV5Lm4VQlh1Ly7SW/RY5N6kjWU8EIuNf6kCNg4kxkBtTJc2
         ss9QN7kSfqG/A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4U86DdD2903458;
        Thu, 30 May 2019 01:06:13 -0700
Date:   Thu, 30 May 2019 01:06:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-8tqy34xhpg8gwnaiv74xy93w@git.kernel.org>
Cc:     acme@redhat.com, lclaudio@redhat.com, adrian.hunter@intel.com,
        mingo@kernel.org, jolsa@kernel.org, brendan.d.gregg@gmail.com,
        amir73il@gmail.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, torvalds@linux-foundation.org,
        tglx@linutronix.de
Reply-To: acme@redhat.com, lclaudio@redhat.com, adrian.hunter@intel.com,
          jolsa@kernel.org, mingo@kernel.org, brendan.d.gregg@gmail.com,
          amir73il@gmail.com, hpa@zytor.com, namhyung@kernel.org,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
          tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Beautify 'sync_file_range' arguments
Git-Commit-ID: a9a187a749f95dda24302aae5c9a0b6b9ee74c99
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

Commit-ID:  a9a187a749f95dda24302aae5c9a0b6b9ee74c99
Gitweb:     https://git.kernel.org/tip/a9a187a749f95dda24302aae5c9a0b6b9ee74c99
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 21 May 2019 21:47:07 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 18:37:43 -0300

perf trace: Beautify 'sync_file_range' arguments

Use existing beautifiers for the first arg, fd, assigned using the
heuristic that looks for syscall arg names and associates SCA_FD with
'fd' named argumes, and wire up the recently introduced sync_file_range
flags table generator.

Now it should be possible to just use:

   perf trace -e sync_file_range

As root and see all sync_file_range syscalls with its args beautified.

  Doing a syscall strace like session looking for this syscall, then run
  postgresql's initdb command:

  # perf trace -e sync_file_range
  <SNIP>
  initdb/1332 sync_file_range(6</var/lib/pgsql/data/global/1260_fsm>, 0, 0, SYNC_FILE_RANGE_WRITE) = 0
  initdb/1332 sync_file_range(6</var/lib/pgsql/data/global/1260_fsm>, 0, 0, SYNC_FILE_RANGE_WRITE) = 0
  initdb/1332 sync_file_range(5</var/lib/pgsql/data/global>, 0, 0, SYNC_FILE_RANGE_WRITE) = 0
  initdb/1332 sync_file_range(5</var/lib/pgsql/data/global>, 0, 0, SYNC_FILE_RANGE_WRITE) = 0
  initdb/1332 sync_file_range(5</var/lib/pgsql/data/global>, 0, 0, SYNC_FILE_RANGE_WRITE) = 0
  initdb/1332 sync_file_range(5</var/lib/pgsql/data/global>, 0, 0, SYNC_FILE_RANGE_WRITE) = 0
  initdb/1332 sync_file_range(5</var/lib/pgsql/data/global>, 0, 0, SYNC_FILE_RANGE_WRITE) = 0
  initdb/1332 sync_file_range(5</var/lib/pgsql/data/global>, 0, 0, SYNC_FILE_RANGE_WRITE) = 0
  initdb/1332 sync_file_range(5</var/lib/pgsql/data/global>, 0, 0, SYNC_FILE_RANGE_WRITE) = 0
  initdb/1332 sync_file_range(5</var/lib/pgsql/data/global>, 0, 0, SYNC_FILE_RANGE_WRITE) = 0
  initdb/1332 sync_file_range(7</var/lib/pgsql/data/base/1/2682>, 0, 0, SYNC_FILE_RANGE_WRITE) = 0
  initdb/1332 sync_file_range(6</var/lib/pgsql/data/global/1260_fsm>, 0, 0, SYNC_FILE_RANGE_WRITE) = 0
  initdb/1332 sync_file_range(7</var/lib/pgsql/data/base/1/2682>, 0, 0, SYNC_FILE_RANGE_WRITE) = 0
  initdb/1332 sync_file_range(6</var/lib/pgsql/data/global/1260_fsm>, 0, 0, SYNC_FILE_RANGE_WRITE) = 0
  initdb/1332 sync_file_range(5</var/lib/pgsql/data/global>, 0, 0, SYNC_FILE_RANGE_WRITE) = 0
  initdb/1332 sync_file_range(5</var/lib/pgsql/data/global>, 0, 0, SYNC_FILE_RANGE_WRITE) = 0
  initdb/1332 sync_file_range(5</var/lib/pgsql/data/global>, 0, 0, SYNC_FILE_RANGE_WRITE) = 0
  initdb/1332 sync_file_range(5</var/lib/pgsql/data/global>, 0, 0, SYNC_FILE_RANGE_WRITE) = 0
  initdb/1332 sync_file_range(4</var/lib/pgsql/data>, 0, 0, SYNC_FILE_RANGE_WRITE) = 0
  initdb/1332 sync_file_range(4</var/lib/pgsql/data>, 0, 0, SYNC_FILE_RANGE_WRITE) = 0
  ^C
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-8tqy34xhpg8gwnaiv74xy93w@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf                  | 12 ++++++++++--
 tools/perf/builtin-trace.c                |  2 ++
 tools/perf/trace/beauty/Build             |  1 +
 tools/perf/trace/beauty/beauty.h          |  3 +++
 tools/perf/trace/beauty/sync_file_range.c | 31 +++++++++++++++++++++++++++++++
 5 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 326ca5d6a7ef..92b5236c0000 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -549,6 +549,12 @@ arch_errno_tbl := $(srctree)/tools/perf/trace/beauty/arch_errno_names.sh
 $(arch_errno_name_array): $(arch_errno_tbl)
 	$(Q)$(SHELL) '$(arch_errno_tbl)' $(CC) $(arch_errno_hdr_dir) > $@
 
+sync_file_range_arrays := $(beauty_outdir)/sync_file_range_arrays.c
+sync_file_range_tbls := $(srctree)/tools/perf/trace/beauty/sync_file_range.sh
+
+$(sync_file_range_arrays): $(linux_uapi_dir)/fs.h $(sync_file_range_tbls)
+	$(Q)$(SHELL) '$(sync_file_range_tbls)' $(linux_uapi_dir) > $@
+
 all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS)
 
 # Create python binding output directory if not already present
@@ -671,7 +677,8 @@ prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioc
 	$(usbdevfs_ioctl_array) \
 	$(x86_arch_prctl_code_array) \
 	$(rename_flags_array) \
-	$(arch_errno_name_array)
+	$(arch_errno_name_array) \
+	$(sync_file_range_arrays)
 
 $(OUTPUT)%.o: %.c prepare FORCE
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=$(build-dir) $@
@@ -970,7 +977,8 @@ clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clea
 		$(OUTPUT)$(usbdevfs_ioctl_array) \
 		$(OUTPUT)$(x86_arch_prctl_code_array) \
 		$(OUTPUT)$(rename_flags_array) \
-		$(OUTPUT)$(arch_errno_name_array)
+		$(OUTPUT)$(arch_errno_name_array) \
+		$(OUTPUT)$(sync_file_range_arrays)
 	$(QUIET_SUBDIR0)Documentation $(QUIET_SUBDIR1) clean
 
 #
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 3a2ab68a8b85..54b2d0fd0d02 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -912,6 +912,8 @@ static struct syscall_fmt {
 	  .arg = { [0] = { .scnprintf = SCA_FILENAME, /* specialfile */ }, }, },
 	{ .name	    = "symlinkat",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* dfd */ }, }, },
+	{ .name	    = "sync_file_range",
+	  .arg = { [3] = { .scnprintf = SCA_SYNC_FILE_RANGE_FLAGS, /* flags */ }, }, },
 	{ .name	    = "tgkill",
 	  .arg = { [2] = { .scnprintf = SCA_SIGNUM, /* sig */ }, }, },
 	{ .name	    = "tkill",
diff --git a/tools/perf/trace/beauty/Build b/tools/perf/trace/beauty/Build
index 338c61b8ed22..afa75a76f6b8 100644
--- a/tools/perf/trace/beauty/Build
+++ b/tools/perf/trace/beauty/Build
@@ -16,3 +16,4 @@ perf-y += renameat.o
 perf-y += sockaddr.o
 perf-y += socket.o
 perf-y += statx.o
+perf-y += sync_file_range.o
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 9385d1cb121a..7e06605f7c76 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -201,6 +201,9 @@ size_t syscall_arg__scnprintf_statx_flags(char *bf, size_t size, struct syscall_
 size_t syscall_arg__scnprintf_statx_mask(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_STATX_MASK syscall_arg__scnprintf_statx_mask
 
+size_t syscall_arg__scnprintf_sync_file_range_flags(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_SYNC_FILE_RANGE_FLAGS syscall_arg__scnprintf_sync_file_range_flags
+
 size_t open__scnprintf_flags(unsigned long flags, char *bf, size_t size, bool show_prefix);
 
 void syscall_arg__set_ret_scnprintf(struct syscall_arg *arg,
diff --git a/tools/perf/trace/beauty/sync_file_range.c b/tools/perf/trace/beauty/sync_file_range.c
new file mode 100644
index 000000000000..1c425f04047d
--- /dev/null
+++ b/tools/perf/trace/beauty/sync_file_range.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: LGPL-2.1
+/*
+ * trace/beauty/sync_file_range.c
+ *
+ *  Copyright (C) 2019, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+ */
+
+#include "trace/beauty/beauty.h"
+#include <linux/log2.h>
+#include <uapi/linux/fs.h>
+
+static size_t sync_file_range__scnprintf_flags(unsigned long flags, char *bf, size_t size, bool show_prefix)
+{
+#include "trace/beauty/generated/sync_file_range_arrays.c"
+       static DEFINE_STRARRAY(sync_file_range_flags, "SYNC_FILE_RANGE_");
+       size_t printed = 0;
+
+       if ((flags & SYNC_FILE_RANGE_WRITE_AND_WAIT) == SYNC_FILE_RANGE_WRITE_AND_WAIT) {
+               printed += scnprintf(bf + printed, size - printed, "%s%s", show_prefix ? "SYNC_FILE_RANGE_" : "", "WRITE_AND_WAIT");
+	       flags &= ~SYNC_FILE_RANGE_WRITE_AND_WAIT;
+       }
+
+       return printed + strarray__scnprintf_flags(&strarray__sync_file_range_flags, bf + printed, size - printed, show_prefix, flags);
+}
+
+size_t syscall_arg__scnprintf_sync_file_range_flags(char *bf, size_t size, struct syscall_arg *arg)
+{
+	unsigned long flags = arg->val;
+
+	return sync_file_range__scnprintf_flags(flags, bf, size, arg->show_string_prefix);
+}
