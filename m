Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D804AC04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 08:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA9F20872
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 08:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="LBD/HNJF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbfERItC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 04:49:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46363 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfERItC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 04:49:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I8mPjq1731865
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 01:48:25 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I8mPjq1731865
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558169306;
        bh=c84VOG927arrQiYWVDPzoCWqjYqqB8ZFryhbVYEK+xo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=LBD/HNJFffwkOk7oEk5KXuV5uV8WUOACdq5clyLweGLgbE9FlaRYDHryvS4N/YnDw
         OtF3wYG4WPxtKSS8sndpq7TyUYerEtGDGM/0S3UxUPS2ZWwTb/OkDzLzR0DbqI0DBe
         kNgiTAFMTOC7M9yC/266hQPEUAYhjdMl+Y4MLtkna6w88O8KqxYOk9oDOeBvNJQFQ9
         SYu9ipKBKnAkjqoqMryJb/FA6TaOFJFUjaIAHfIk4Xf3cEDa2z4l+KSClCUG6Z7y/Y
         sPfKycrJk2OUTGNdtli6V/6lCTi/F6naCD5UxC2Czk7W4ZkGfeO8SgaShrH+6bX6j2
         ULhLMWS5hFGsg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I8mOtN1731862;
        Sat, 18 May 2019 01:48:24 -0700
Date:   Sat, 18 May 2019 01:48:24 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tzvetomir Stoyanov <tipbot@zytor.com>
Message-ID: <tip-53dbabfe50262eeebb56ce18789c3c885f15e6ac@git.kernel.org>
Cc:     acme@redhat.com, mingo@kernel.org, rostedt@goodmis.org,
        tglx@linutronix.de, tstoyanov@vmware.com, jolsa@redhat.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, jolsa@redhat.com, linux-kernel@vger.kernel.org,
          acme@redhat.com, mingo@kernel.org, tglx@linutronix.de,
          tstoyanov@vmware.com, rostedt@goodmis.org
In-Reply-To: <20190329144546.5819-1-tstoyanov@vmware.com>
References: <20190418211556.5a12adc3@oasis.local.home>
        <20190329144546.5819-1-tstoyanov@vmware.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib traceevent: Remove hard coded install
 paths from pkg-config file
Git-Commit-ID: 53dbabfe50262eeebb56ce18789c3c885f15e6ac
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

Commit-ID:  53dbabfe50262eeebb56ce18789c3c885f15e6ac
Gitweb:     https://git.kernel.org/tip/53dbabfe50262eeebb56ce18789c3c885f15e6ac
Author:     Tzvetomir Stoyanov <tstoyanov@vmware.com>
AuthorDate: Thu, 18 Apr 2019 21:15:56 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:46 -0300

tools lib traceevent: Remove hard coded install paths from pkg-config file

Install directories of header and library files are hard coded in
pkg-config template file.

They must be configurable, the Makefile should set them on the
compilation / install stage.

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190418211556.5a12adc3@oasis.local.home
Link: http://lkml.kernel.org/r/20190329144546.5819-1-tstoyanov@vmware.com
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/Makefile                  | 13 +++++++++----
 tools/lib/traceevent/libtraceevent.pc.template |  4 ++--
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/lib/traceevent/Makefile b/tools/lib/traceevent/Makefile
index 941761d9923d..34cf33a4f001 100644
--- a/tools/lib/traceevent/Makefile
+++ b/tools/lib/traceevent/Makefile
@@ -50,6 +50,9 @@ man_dir = $(prefix)/share/man
 man_dir_SQ = '$(subst ','\'',$(man_dir))'
 pkgconfig_dir ?= $(word 1,$(shell $(PKG_CONFIG) 		\
 			--variable pc_path pkg-config | tr ":" " "))
+includedir_relative = traceevent
+includedir = $(prefix)/include/$(includedir_relative)
+includedir_SQ = '$(subst ','\'',$(includedir))'
 
 export man_dir man_dir_SQ INSTALL
 export DESTDIR DESTDIR_SQ
@@ -279,6 +282,8 @@ define do_install_pkgconfig_file
 		cp -f ${PKG_CONFIG_FILE}.template ${PKG_CONFIG_FILE}; 		\
 		sed -i "s|INSTALL_PREFIX|${1}|g" ${PKG_CONFIG_FILE}; 		\
 		sed -i "s|LIB_VERSION|${EVENT_PARSE_VERSION}|g" ${PKG_CONFIG_FILE}; \
+		sed -i "s|LIB_DIR|${libdir}|g" ${PKG_CONFIG_FILE}; \
+		sed -i "s|HEADER_DIR|$(includedir)|g" ${PKG_CONFIG_FILE}; \
 		$(call do_install,$(PKG_CONFIG_FILE),$(pkgconfig_dir),644); 	\
 	else 									\
 		(echo Failed to locate pkg-config directory) 1>&2;		\
@@ -300,10 +305,10 @@ install_pkgconfig:
 
 install_headers:
 	$(call QUIET_INSTALL, headers) \
-		$(call do_install,event-parse.h,$(prefix)/include/traceevent,644); \
-		$(call do_install,event-utils.h,$(prefix)/include/traceevent,644); \
-		$(call do_install,trace-seq.h,$(prefix)/include/traceevent,644); \
-		$(call do_install,kbuffer.h,$(prefix)/include/traceevent,644)
+		$(call do_install,event-parse.h,$(DESTDIR)$(includedir_SQ),644); \
+		$(call do_install,event-utils.h,$(DESTDIR)$(includedir_SQ),644); \
+		$(call do_install,trace-seq.h,$(DESTDIR)$(includedir_SQ),644); \
+		$(call do_install,kbuffer.h,$(DESTDIR)$(includedir_SQ),644)
 
 install: install_lib
 
diff --git a/tools/lib/traceevent/libtraceevent.pc.template b/tools/lib/traceevent/libtraceevent.pc.template
index 42e4d6cb6b9e..86384fcd57f1 100644
--- a/tools/lib/traceevent/libtraceevent.pc.template
+++ b/tools/lib/traceevent/libtraceevent.pc.template
@@ -1,6 +1,6 @@
 prefix=INSTALL_PREFIX
-libdir=${prefix}/lib64
-includedir=${prefix}/include/traceevent
+libdir=LIB_DIR
+includedir=HEADER_DIR
 
 Name: libtraceevent
 URL: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
