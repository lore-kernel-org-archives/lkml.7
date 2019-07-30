Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BA9C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174892064A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="BEkqk5EC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbfG3S0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:26:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43491 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfG3S0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:26:53 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UIPdhD3329703
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:25:40 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UIPdhD3329703
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564511140;
        bh=o7YUERV5UcgrDolXx8bdO0m0RzSFYJomDQBxU6bukb4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=BEkqk5EC8lzT77KhXKWDY3t11n/Ny17/M6/o9cIgRKKfcPD2c1AWLPW9z/qQuENdX
         u5Qe78yEK2Qd3/M+ewSQs/9W4nuFbjr3IKVSiVxaaI4qF+v4WMsENXWfeH4xXZ6Mxi
         Xn7WrQeQphQDd2BaQ3Q1K5XzHBwyf0YjV3Uko88KjclUfE046G6Wz91fLNc6uWrxLH
         B2J/cZrIxm4oMnoPhkDKvKpzg7TzNqtyGGUINWkwo2ISzt07vAqKbk94lcanDvxlPa
         +92nBb2qDNy+omZlT62uY02Byflwg4kwfdzUR5nIW0lmYZ8UibY7zo+mAB4ZEeccwR
         kT9upC95FPQuQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UIPdEw3329700;
        Tue, 30 Jul 2019 11:25:39 -0700
Date:   Tue, 30 Jul 2019 11:25:39 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-a429dcb8feb60b8500fed81e2275c1944e3091fc@git.kernel.org>
Cc:     alexey.budankov@linux.intel.com,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        jolsa@kernel.org, ak@linux.intel.com, namhyung@kernel.org,
        acme@redhat.com, hpa@zytor.com, mpetlan@redhat.com,
        mingo@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Reply-To: acme@redhat.com, hpa@zytor.com, mpetlan@redhat.com,
          peterz@infradead.org, linux-kernel@vger.kernel.org,
          mingo@kernel.org, alexander.shishkin@linux.intel.com,
          tglx@linutronix.de, jolsa@kernel.org,
          alexey.budankov@linux.intel.com, ak@linux.intel.com,
          namhyung@kernel.org
In-Reply-To: <20190721112506.12306-26-jolsa@kernel.org>
References: <20190721112506.12306-26-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] libperf: Add libperf to the python.so build
Git-Commit-ID: a429dcb8feb60b8500fed81e2275c1944e3091fc
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

Commit-ID:  a429dcb8feb60b8500fed81e2275c1944e3091fc
Gitweb:     https://git.kernel.org/tip/a429dcb8feb60b8500fed81e2275c1944e3091fc
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:12 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:44 -0300

libperf: Add libperf to the python.so build

Link libperf.a with python.so.

Committer testing:

Continues to work:

  # perf test python
  18: 'import perf' in python                               : Ok
  #

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-26-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 1 +
 tools/perf/util/setup.py | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 6e7e7d44ffac..67512a12276b 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -307,6 +307,7 @@ LIBBPF = $(BPF_PATH)libbpf.a
 LIBSUBCMD = $(SUBCMD_PATH)libsubcmd.a
 
 LIBPERF = $(LIBPERF_PATH)libperf.a
+export LIBPERF
 
 # python extension build directories
 PYTHON_EXTBUILD     := $(OUTPUT)python_ext_build/
diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index a1a68a2fa917..d48f9cd58964 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -48,6 +48,7 @@ build_lib = getenv('PYTHON_EXTBUILD_LIB')
 build_tmp = getenv('PYTHON_EXTBUILD_TMP')
 libtraceevent = getenv('LIBTRACEEVENT')
 libapikfs = getenv('LIBAPI')
+libperf = getenv('LIBPERF')
 
 ext_sources = [f.strip() for f in open('util/python-ext-sources')
 				if len(f.strip()) > 0 and f[0] != '#']
@@ -64,7 +65,7 @@ perf = Extension('perf',
 		  include_dirs = ['util/include'],
 		  libraries = extra_libraries,
 		  extra_compile_args = cflags,
-		  extra_objects = [libtraceevent, libapikfs],
+		  extra_objects = [libtraceevent, libapikfs, libperf],
                  )
 
 setup(name='perf',
