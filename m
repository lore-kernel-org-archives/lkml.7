Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C64C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B165C21881
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="vdaC4eMy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfGCOJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:09:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37409 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCOJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:09:33 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63E99Yq3321564
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:09:09 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63E99Yq3321564
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562162950;
        bh=1eoJ0QGsrHwgwR2jReijN4Wh3qyj5OE0NS7fZKi35qI=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=vdaC4eMygm5eywbaANreDsXxewnaxwMeYtfoQkweUZHYoHaDWyBIWYFuSfB3VnT1z
         3lBCbokS3lYExT6e+gkwdAATc42caqtUBcynYwj0i08LCm3n3IuDbXGUJwq70zsC6k
         d7Ynf1knfZzIb5TjhPREALe1qMgYu/2HDYJ7D7K1az8aoSIrEGmDZq7j/W6TXBl7G3
         o1fRjdIjyMiO7/sU127hVLWVRqvu/QQHWvP8TWMpJkIauj0ez0CG0HA5sF/tlnVBhw
         JmjbtA+sntK+JfGUrRj3vRSamaShwaVUM76du066koMXVN603Nr5Fyzipjs8YDwwVa
         7x4sgPk5+Qs0g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63E99S93321561;
        Wed, 3 Jul 2019 07:09:09 -0700
Date:   Wed, 3 Jul 2019 07:09:09 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-1e567f8tn8m4ii7dy1w9dp39@git.kernel.org>
Cc:     hpa@zytor.com, acme@redhat.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, tglx@linutronix.de, jolsa@kernel.org,
        namhyung@kernel.org, adrian.hunter@intel.com
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org,
          tglx@linutronix.de, jolsa@kernel.org, acme@redhat.com,
          hpa@zytor.com, namhyung@kernel.org, adrian.hunter@intel.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf ctype: Remove unused 'graph_line' variable
Git-Commit-ID: 828e27a899156047758628a97eedeb2b8df41670
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

Commit-ID:  828e27a899156047758628a97eedeb2b8df41670
Gitweb:     https://git.kernel.org/tip/828e27a899156047758628a97eedeb2b8df41670
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 25 Jun 2019 16:04:17 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 25 Jun 2019 16:04:17 -0300

perf ctype: Remove unused 'graph_line' variable

Not being used at all anywhere.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-1e567f8tn8m4ii7dy1w9dp39@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/ctype.c      | 4 ----
 tools/perf/util/sane_ctype.h | 1 -
 2 files changed, 5 deletions(-)

diff --git a/tools/perf/util/ctype.c b/tools/perf/util/ctype.c
index ee4c1e8ed54b..8d90bf8d0d70 100644
--- a/tools/perf/util/ctype.c
+++ b/tools/perf/util/ctype.c
@@ -31,10 +31,6 @@ unsigned char sane_ctype[256] = {
 	/* Nothing in the 128.. range */
 };
 
-const char *graph_line =
-	"_____________________________________________________________________"
-	"_____________________________________________________________________"
-	"_____________________________________________________________________";
 const char *graph_dotted_line =
 	"---------------------------------------------------------------------"
 	"---------------------------------------------------------------------"
diff --git a/tools/perf/util/sane_ctype.h b/tools/perf/util/sane_ctype.h
index c2b42ff9ff32..894594fdedfb 100644
--- a/tools/perf/util/sane_ctype.h
+++ b/tools/perf/util/sane_ctype.h
@@ -2,7 +2,6 @@
 #ifndef _PERF_SANE_CTYPE_H
 #define _PERF_SANE_CTYPE_H
 
-extern const char *graph_line;
 extern const char *graph_dotted_line;
 extern const char *spaces;
 extern const char *dots;
