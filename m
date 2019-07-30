Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFFEC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5236520679
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="0hmtHVf8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388508AbfG3TBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 15:01:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48041 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387996AbfG3TBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 15:01:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UJ0pdq3337594
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 12:00:51 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UJ0pdq3337594
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564513252;
        bh=qrZYFGsBVQbjdrd7QO9zhXhS11tYt3g8Fb4xfWgjLHM=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=0hmtHVf8M3XVb5o2Hk8xRgGsO6gyN0Y+ZkpUJvUlmClqvNQhEHVLFQGN7Io8wtTCY
         0Ph0c5LnD+vjSIm9p+U9QSObvDGkeeARG7KdmB8rVwQBttEYTk+g4nLCfsYmqRsu4D
         pw8zXO9T8gVycviXwrbnz9TGbGxz9eoKsMquq6rwJANCV8xrJ5w+9hgyQm6wEFVrnW
         Uwvd040iqHas9ZVhFgynbFw1ZcE4EJ45jIJY+Q1c1eE0BEcHeZC+QEWSsCgNHOTW0C
         nV01fUxWTU6Y5kZla9Ao3/oqZhcK9dQsdPuw7OPlTi5rNkyVlf0B3b2JKebiQWifvE
         qoR6jOkxoTnOw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UJ0p1u3337591;
        Tue, 30 Jul 2019 12:00:51 -0700
Date:   Tue, 30 Jul 2019 12:00:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-0a64d7091efde161a7d0fa385ed5c3bdb72ecdf9@git.kernel.org>
Cc:     ak@linux.intel.com, namhyung@kernel.org, mingo@kernel.org,
        alexey.budankov@linux.intel.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, tglx@linutronix.de, mpetlan@redhat.com,
        peterz@infradead.org, acme@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org
Reply-To: tglx@linutronix.de, hpa@zytor.com,
          alexander.shishkin@linux.intel.com, acme@redhat.com,
          peterz@infradead.org, mpetlan@redhat.com, jolsa@kernel.org,
          ak@linux.intel.com, namhyung@kernel.org,
          linux-kernel@vger.kernel.org, alexey.budankov@linux.intel.com,
          mingo@kernel.org
In-Reply-To: <20190721112506.12306-72-jolsa@kernel.org>
References: <20190721112506.12306-72-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] libperf: Add install targets
Git-Commit-ID: 0a64d7091efde161a7d0fa385ed5c3bdb72ecdf9
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

Commit-ID:  0a64d7091efde161a7d0fa385ed5c3bdb72ecdf9
Gitweb:     https://git.kernel.org/tip/0a64d7091efde161a7d0fa385ed5c3bdb72ecdf9
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:58 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:46 -0300

libperf: Add install targets

Add install targets (mostly copied from tools/lib/bpf), it's now
possible to install libperf with:

  $ make DESTDIR=/tmp/krava  install
    INSTALL  libperf.a
    INSTALL  libperf.so
    INSTALL  libperf.so.0
    INSTALL  libperf.so.0.0.1
    INSTALL  headers
    INSTALL  libperf.pc

  $ find /tmp/krava/
  /tmp/krava/
  /tmp/krava/include
  /tmp/krava/include/perf
  /tmp/krava/include/perf/evsel.h
  /tmp/krava/include/perf/evlist.h
  /tmp/krava/include/perf/threadmap.h
  /tmp/krava/include/perf/cpumap.h
  /tmp/krava/include/perf/core.h
  /tmp/krava/lib64
  /tmp/krava/lib64/pkgconfig
  /tmp/krava/lib64/pkgconfig/libperf.pc
  /tmp/krava/lib64/libperf.so.0.0.1
  /tmp/krava/lib64/libperf.so.0
  /tmp/krava/lib64/libperf.so
  /tmp/krava/lib64/libperf.a

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-72-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/Makefile                            | 69 +++++++++++++++++++++-
 .../lib/libperf.pc.template}                       |  7 +--
 2 files changed, 70 insertions(+), 6 deletions(-)

diff --git a/tools/perf/lib/Makefile b/tools/perf/lib/Makefile
index cd571ec648ad..f1b3d4c6d5f0 100644
--- a/tools/perf/lib/Makefile
+++ b/tools/perf/lib/Makefile
@@ -14,9 +14,31 @@ srctree := $(patsubst %/,%,$(dir $(srctree)))
 #$(info Determined 'srctree' to be $(srctree))
 endif
 
+INSTALL = install
+
+# Use DESTDIR for installing into a different root directory.
+# This is useful for building a package. The program will be
+# installed in this directory as if it was the root directory.
+# Then the build tool can move it later.
+DESTDIR ?=
+DESTDIR_SQ = '$(subst ','\'',$(DESTDIR))'
+
 include $(srctree)/tools/scripts/Makefile.include
 include $(srctree)/tools/scripts/Makefile.arch
 
+ifeq ($(LP64), 1)
+  libdir_relative = lib64
+else
+  libdir_relative = lib
+endif
+
+prefix ?=
+libdir = $(prefix)/$(libdir_relative)
+
+# Shell quotes
+libdir_SQ = $(subst ','\'',$(libdir))
+libdir_relative_SQ = $(subst ','\'',$(libdir_relative))
+
 ifeq ("$(origin V)", "command line")
   VERBOSE = $(V)
 endif
@@ -49,6 +71,8 @@ override CFLAGS += -fvisibility=hidden
 all:
 
 export srctree OUTPUT CC LD CFLAGS V
+export DESTDIR DESTDIR_SQ
+
 include $(srctree)/tools/build/Makefile.include
 
 VERSION_SCRIPT := libperf.map
@@ -60,6 +84,9 @@ VERSION       = $(LIBPERF_VERSION).$(LIBPERF_PATCHLEVEL).$(LIBPERF_EXTRAVERSION)
 LIBPERF_SO := $(OUTPUT)libperf.so.$(VERSION)
 LIBPERF_A  := $(OUTPUT)libperf.a
 LIBPERF_IN := $(OUTPUT)libperf-in.o
+LIBPERF_PC := $(OUTPUT)libperf.pc
+
+LIBPERF_ALL := $(LIBPERF_A) $(OUTPUT)libperf.so*
 
 $(LIBPERF_IN): FORCE
 	$(Q)$(MAKE) $(build)=libperf
@@ -74,14 +101,52 @@ $(LIBPERF_SO): $(LIBPERF_IN)
 	@ln -sf $(@F) $(OUTPUT)libperf.so.$(LIBPERF_VERSION)
 
 
-libs: $(LIBPERF_A) $(LIBPERF_SO)
+libs: $(LIBPERF_A) $(LIBPERF_SO) $(LIBPERF_PC)
 
 all: fixdep
 	$(Q)$(MAKE) libs
 
 clean:
 	$(call QUIET_CLEAN, libperf) $(RM) $(LIBPERF_A) \
-                *.o *~ *.a *.so *.so.$(VERSION) *.so.$(LIBPERF_VERSION) .*.d .*.cmd LIBPERF-CFLAGS
+                *.o *~ *.a *.so *.so.$(VERSION) *.so.$(LIBPERF_VERSION) .*.d .*.cmd LIBPERF-CFLAGS $(LIBPERF_PC)
+
+$(LIBPERF_PC):
+	$(QUIET_GEN)sed -e "s|@PREFIX@|$(prefix)|" \
+		-e "s|@LIBDIR@|$(libdir_SQ)|" \
+		-e "s|@VERSION@|$(VERSION)|" \
+		< libperf.pc.template > $@
+
+define do_install_mkdir
+	if [ ! -d '$(DESTDIR_SQ)$1' ]; then             \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$1'; \
+	fi
+endef
+
+define do_install
+	if [ ! -d '$(DESTDIR_SQ)$2' ]; then             \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$2'; \
+	fi;                                             \
+	$(INSTALL) $1 $(if $3,-m $3,) '$(DESTDIR_SQ)$2'
+endef
+
+install_lib: libs
+	$(call QUIET_INSTALL, $(LIBPERF_ALL)) \
+		$(call do_install_mkdir,$(libdir_SQ)); \
+		cp -fpR $(LIBPERF_ALL) $(DESTDIR)$(libdir_SQ)
+
+install_headers:
+	$(call QUIET_INSTALL, headers) \
+		$(call do_install,include/perf/core.h,$(prefix)/include/perf,644); \
+		$(call do_install,include/perf/cpumap.h,$(prefix)/include/perf,644); \
+		$(call do_install,include/perf/threadmap.h,$(prefix)/include/perf,644); \
+		$(call do_install,include/perf/evlist.h,$(prefix)/include/perf,644); \
+		$(call do_install,include/perf/evsel.h,$(prefix)/include/perf,644);
+
+install_pkgconfig: $(LIBPERF_PC)
+	$(call QUIET_INSTALL, $(LIBPERF_PC)) \
+		$(call do_install,$(LIBPERF_PC),$(libdir_SQ)/pkgconfig,644)
+
+install: install_lib install_headers install_pkgconfig
 
 FORCE:
 
diff --git a/tools/lib/bpf/libbpf.pc.template b/tools/perf/lib/libperf.pc.template
similarity index 64%
copy from tools/lib/bpf/libbpf.pc.template
copy to tools/perf/lib/libperf.pc.template
index ac17fcef2108..117e4a237b55 100644
--- a/tools/lib/bpf/libbpf.pc.template
+++ b/tools/perf/lib/libperf.pc.template
@@ -4,9 +4,8 @@ prefix=@PREFIX@
 libdir=@LIBDIR@
 includedir=${prefix}/include
 
-Name: libbpf
-Description: BPF library
+Name: libperf
+Description: perf library
 Version: @VERSION@
-Libs: -L${libdir} -lbpf
-Requires.private: libelf
+Libs: -L${libdir} -lperf
 Cflags: -I${includedir}
