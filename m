Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194EDC04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0822206BF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="S9DNnoiE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbfERJBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 05:01:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59943 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfERJBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:01:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I90mWd1733954
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 02:00:48 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I90mWd1733954
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558170049;
        bh=kZ62Onjx5tEGDDWfNWUoBXgkfeT2sxDeA/RVCkkUNd4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=S9DNnoiEQkH8f8dnc93pP1Y1ms1ZW2oDwmfB+Q7d43b54hCdkKNGAPnM9ez2sPdNm
         +itLCe8751JDtc0DISrbuyQTnB9ww6UHA9jj9d7mfgDTC/LWAooKqTIeaC34X73Mxe
         L4c+QG/0tv7+vY3xJT5DqgQZcO4iSh3tvBzaVHg+E5K8p0tpzWB/x+k4KtaXFatM/B
         OwsmWXeqZXr84AQP8F6nz+xTrujPEMTm5dtMj1SqHLu8F2X7012D2Fwpd70PCQyt3X
         knb7n28ALSSfxAc8ZAWqq1yY9c3twgDFhSMkyq5FZa8vKlmoz+LghlWFhwoYW9i3dv
         y9V6W+Bbv+U0w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I90lKg1733951;
        Sat, 18 May 2019 02:00:47 -0700
Date:   Sat, 18 May 2019 02:00:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tzvetomir Stoyanov <tipbot@zytor.com>
Message-ID: <tip-f7dff58a8b5a35a65379cdc76fe11c168f9ef198@git.kernel.org>
Cc:     rostedt@goodmis.org, namhyung@kernel.org, tglx@linutronix.de,
        acme@redhat.com, jolsa@redhat.com, akpm@linux-foundation.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        tstoyanov@vmware.com, hpa@zytor.com
Reply-To: rostedt@goodmis.org, namhyung@kernel.org, jolsa@redhat.com,
          tglx@linutronix.de, acme@redhat.com, akpm@linux-foundation.org,
          tstoyanov@vmware.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, hpa@zytor.com
In-Reply-To: <20190510200106.263630606@goodmis.org>
References: <20190510200106.263630606@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib traceevent: Add support for man pages
 with multiple names
Git-Commit-ID: f7dff58a8b5a35a65379cdc76fe11c168f9ef198
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

Commit-ID:  f7dff58a8b5a35a65379cdc76fe11c168f9ef198
Gitweb:     https://git.kernel.org/tip/f7dff58a8b5a35a65379cdc76fe11c168f9ef198
Author:     Tzvetomir Stoyanov <tstoyanov@vmware.com>
AuthorDate: Fri, 10 May 2019 15:56:09 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:47 -0300

tools lib traceevent: Add support for man pages with multiple names

Added support for man pages with multiple names, used to combine the
description of several APIs into one page.

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lore.kernel.org/linux-trace-devel/20190503091119.23399-3-tstoyanov@vmware.com
Link: http://lkml.kernel.org/r/20190510200106.263630606@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/Documentation/asciidoc.conf | 35 ++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/tools/lib/traceevent/Documentation/asciidoc.conf b/tools/lib/traceevent/Documentation/asciidoc.conf
index 1b03c63fb73a..07595717f06e 100644
--- a/tools/lib/traceevent/Documentation/asciidoc.conf
+++ b/tools/lib/traceevent/Documentation/asciidoc.conf
@@ -74,12 +74,41 @@ template::[header-declarations]
 <refmeta>
 <refentrytitle>{mantitle}</refentrytitle>
 <manvolnum>{manvolnum}</manvolnum>
-<refmiscinfo class="source">trace-cmd</refmiscinfo>
+<refmiscinfo class="source">libtraceevent</refmiscinfo>
 <refmiscinfo class="version">{libtraceevent_version}</refmiscinfo>
-<refmiscinfo class="manual">trace-cmd Manual</refmiscinfo>
+<refmiscinfo class="manual">libtraceevent Manual</refmiscinfo>
 </refmeta>
 <refnamediv>
-  <refname>{manname}</refname>
+  <refname>{manname1}</refname>
+  <refname>{manname2}</refname>
+  <refname>{manname3}</refname>
+  <refname>{manname4}</refname>
+  <refname>{manname5}</refname>
+  <refname>{manname6}</refname>
+  <refname>{manname7}</refname>
+  <refname>{manname8}</refname>
+  <refname>{manname9}</refname>
+  <refname>{manname10}</refname>
+  <refname>{manname11}</refname>
+  <refname>{manname12}</refname>
+  <refname>{manname13}</refname>
+  <refname>{manname14}</refname>
+  <refname>{manname15}</refname>
+  <refname>{manname16}</refname>
+  <refname>{manname17}</refname>
+  <refname>{manname18}</refname>
+  <refname>{manname19}</refname>
+  <refname>{manname20}</refname>
+  <refname>{manname21}</refname>
+  <refname>{manname22}</refname>
+  <refname>{manname23}</refname>
+  <refname>{manname24}</refname>
+  <refname>{manname25}</refname>
+  <refname>{manname26}</refname>
+  <refname>{manname27}</refname>
+  <refname>{manname28}</refname>
+  <refname>{manname29}</refname>
+  <refname>{manname30}</refname>
   <refpurpose>{manpurpose}</refpurpose>
 </refnamediv>
 endif::backend-docbook[]
