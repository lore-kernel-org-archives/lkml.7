Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21938C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA273206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="A/Z1UCRu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388577AbfG2VaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:30:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42273 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbfG2VaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:30:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6TLU9Q52940848
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 29 Jul 2019 14:30:09 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6TLU9Q52940848
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564435810;
        bh=hzGhLpR2fcVwu+IlVksH3f8Q3dephyCErzWfeOqEbSU=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=A/Z1UCRueTVzBhDe1ah39y5byu8sD2VdNR1+gnQgnXowFfLD98BSQeZTY5aWWBQL6
         W6P4GJmzdUcsNGe0heu0l518sRk2UqemSVAHF/3FAI6a8mEQyvnNQHKw1NFJtoVJCC
         b7hqus+Dy+0ZLPQKjkR5559xYk2kptiR9QAmg2s1Q1h/6aHzKzyXr19+Ez6ZVIxeyL
         Mgxb6wukIJM18cahCHaTt/lfUO7OzqhKKv1mMpHftCjybFn0yYkFjV+g+ZgSAWEtid
         5QXeLSCdg85SOOruGYnYVCv26cZoyw0d6SUJHYpeFSoxeBAvfeazca8VkBSp8acEuL
         oxXQ+gqLhcv1A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6TLU9X62940845;
        Mon, 29 Jul 2019 14:30:09 -0700
Date:   Mon, 29 Jul 2019 14:30:09 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-fzqvzni9megaurmsp0k4vy27@git.kernel.org>
Cc:     adrian.hunter@intel.com, hpa@zytor.com, hch@lst.de,
        acme@redhat.com, namhyung@kernel.org, linux-kernel@vger.kernel.org,
        aneesh.kumar@linux.ibm.com, mingo@kernel.org, tglx@linutronix.de,
        jolsa@kernel.org, lclaudio@redhat.com
Reply-To: lclaudio@redhat.com, jolsa@kernel.org, tglx@linutronix.de,
          aneesh.kumar@linux.ibm.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
          hpa@zytor.com, hch@lst.de, acme@redhat.com, namhyung@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools headers UAPI: Update tools's copy of mman.h
 headers
Git-Commit-ID: b830f94f7303a49d509d5b1bb34ecb2e648b23c4
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

Commit-ID:  b830f94f7303a49d509d5b1bb34ecb2e648b23c4
Gitweb:     https://git.kernel.org/tip/b830f94f7303a49d509d5b1bb34ecb2e648b23c4
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 26 Jul 2019 12:49:00 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 09:02:58 -0300

tools headers UAPI: Update tools's copy of mman.h headers

To pick up the changes from:

  8aa3c927ec10 ("mm/mmap: move common defines to mman-common.h")
  22fcea6f85f2 ("mm: move MAP_SYNC to asm-generic/mman-common.h")
  0bf5f9492389 ("mm: fix the MAP_UNINITIALIZED flag")

To address the following perf build warnings:

  Warning: Kernel ABI header at 'tools/include/uapi/asm-generic/mman-common.h' differs from latest version at 'include/uapi/asm-generic/mman-common.h'
  diff -u tools/include/uapi/asm-generic/mman-common.h include/uapi/asm-generic/mman-common.h
  Warning: Kernel ABI header at 'tools/include/uapi/asm-generic/mman.h' differs from latest version at 'include/uapi/asm-generic/mman.h'
  diff -u tools/include/uapi/asm-generic/mman.h include/uapi/asm-generic/mman.h

That ends up just moving a bit the auto-generated code->string tables:

  $ tools/perf/trace/beauty/mmap_flags.sh > before
  $ cp include/uapi/asm-generic/mman.h tools/include/uapi/asm-generic/mman.h
  $ cp include/uapi/asm-generic/mman-common.h tools/include/uapi/asm-generic/mman-common.h
  $ tools/perf/trace/beauty/mmap_flags.sh > after
  $ diff -u before after
  --- before 2019-07-26 12:45:02.948335904 -0300
  +++ after 2019-07-26 12:48:05.342893539 -0300
  @@ -4,15 +4,15 @@
          [ilog2(0x02) + 1] = "PRIVATE",
          [ilog2(0x10) + 1] = "FIXED",
          [ilog2(0x20) + 1] = "ANONYMOUS",
  +       [ilog2(0x008000) + 1] = "POPULATE",
  +       [ilog2(0x010000) + 1] = "NONBLOCK",
  +       [ilog2(0x020000) + 1] = "STACK",
  +       [ilog2(0x040000) + 1] = "HUGETLB",
  +       [ilog2(0x080000) + 1] = "SYNC",
          [ilog2(0x100000) + 1] = "FIXED_NOREPLACE",
          [ilog2(0x0100) + 1] = "GROWSDOWN",
          [ilog2(0x0800) + 1] = "DENYWRITE",
          [ilog2(0x1000) + 1] = "EXECUTABLE",
          [ilog2(0x2000) + 1] = "LOCKED",
          [ilog2(0x4000) + 1] = "NORESERVE",
  -       [ilog2(0x8000) + 1] = "POPULATE",
  -       [ilog2(0x10000) + 1] = "NONBLOCK",
  -       [ilog2(0x20000) + 1] = "STACK",
  -       [ilog2(0x40000) + 1] = "HUGETLB",
  -       [ilog2(0x80000) + 1] = "SYNC",
   };
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-fzqvzni9megaurmsp0k4vy27@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/powerpc/include/uapi/asm/mman.h   |  4 ----
 tools/arch/sparc/include/uapi/asm/mman.h     |  4 ----
 tools/include/uapi/asm-generic/mman-common.h | 15 +++++++++------
 tools/include/uapi/asm-generic/mman.h        | 10 ++++------
 4 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/tools/arch/powerpc/include/uapi/asm/mman.h b/tools/arch/powerpc/include/uapi/asm/mman.h
index f33105bc5ca6..8601d824a9c6 100644
--- a/tools/arch/powerpc/include/uapi/asm/mman.h
+++ b/tools/arch/powerpc/include/uapi/asm/mman.h
@@ -4,12 +4,8 @@
 #define MAP_DENYWRITE	0x0800
 #define MAP_EXECUTABLE	0x1000
 #define MAP_GROWSDOWN	0x0100
-#define MAP_HUGETLB	0x40000
 #define MAP_LOCKED	0x80
-#define MAP_NONBLOCK	0x10000
 #define MAP_NORESERVE   0x40
-#define MAP_POPULATE	0x8000
-#define MAP_STACK	0x20000
 #include <uapi/asm-generic/mman-common.h>
 /* MAP_32BIT is undefined on powerpc, fix it for perf */
 #define MAP_32BIT	0
diff --git a/tools/arch/sparc/include/uapi/asm/mman.h b/tools/arch/sparc/include/uapi/asm/mman.h
index 38920eed8cbf..7b94dccc843d 100644
--- a/tools/arch/sparc/include/uapi/asm/mman.h
+++ b/tools/arch/sparc/include/uapi/asm/mman.h
@@ -4,12 +4,8 @@
 #define MAP_DENYWRITE	0x0800
 #define MAP_EXECUTABLE	0x1000
 #define MAP_GROWSDOWN	0x0200
-#define MAP_HUGETLB	0x40000
 #define MAP_LOCKED      0x100
-#define MAP_NONBLOCK	0x10000
 #define MAP_NORESERVE   0x40
-#define MAP_POPULATE	0x8000
-#define MAP_STACK	0x20000
 #include <uapi/asm-generic/mman-common.h>
 /* MAP_32BIT is undefined on sparc, fix it for perf */
 #define MAP_32BIT	0
diff --git a/tools/include/uapi/asm-generic/mman-common.h b/tools/include/uapi/asm-generic/mman-common.h
index abd238d0f7a4..63b1f506ea67 100644
--- a/tools/include/uapi/asm-generic/mman-common.h
+++ b/tools/include/uapi/asm-generic/mman-common.h
@@ -19,15 +19,18 @@
 #define MAP_TYPE	0x0f		/* Mask for type of mapping */
 #define MAP_FIXED	0x10		/* Interpret addr exactly */
 #define MAP_ANONYMOUS	0x20		/* don't use a file */
-#ifdef CONFIG_MMAP_ALLOW_UNINITIALIZED
-# define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be uninitialized */
-#else
-# define MAP_UNINITIALIZED 0x0		/* Don't support this flag */
-#endif
 
-/* 0x0100 - 0x80000 flags are defined in asm-generic/mman.h */
+/* 0x0100 - 0x4000 flags are defined in asm-generic/mman.h */
+#define MAP_POPULATE		0x008000	/* populate (prefault) pagetables */
+#define MAP_NONBLOCK		0x010000	/* do not block on IO */
+#define MAP_STACK		0x020000	/* give out an address that is best suited for process/thread stacks */
+#define MAP_HUGETLB		0x040000	/* create a huge page mapping */
+#define MAP_SYNC		0x080000 /* perform synchronous page faults for the mapping */
 #define MAP_FIXED_NOREPLACE	0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
 
+#define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be
+					 * uninitialized */
+
 /*
  * Flags for mlock
  */
diff --git a/tools/include/uapi/asm-generic/mman.h b/tools/include/uapi/asm-generic/mman.h
index 36c197fc44a0..406f7718f9ad 100644
--- a/tools/include/uapi/asm-generic/mman.h
+++ b/tools/include/uapi/asm-generic/mman.h
@@ -9,13 +9,11 @@
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_LOCKED	0x2000		/* pages are locked */
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
-#define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
-#define MAP_NONBLOCK	0x10000		/* do not block on IO */
-#define MAP_STACK	0x20000		/* give out an address that is best suited for process/thread stacks */
-#define MAP_HUGETLB	0x40000		/* create a huge page mapping */
-#define MAP_SYNC	0x80000		/* perform synchronous page faults for the mapping */
 
-/* Bits [26:31] are reserved, see mman-common.h for MAP_HUGETLB usage */
+/*
+ * Bits [26:31] are reserved, see asm-generic/hugetlb_encode.h
+ * for MAP_HUGETLB usage
+ */
 
 #define MCL_CURRENT	1		/* lock all current mappings */
 #define MCL_FUTURE	2		/* lock all future mappings */
