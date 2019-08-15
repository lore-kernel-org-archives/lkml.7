Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDF6C433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95313208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="xlIim6ph"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730891AbfHOJbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 05:31:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47611 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfHOJbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 05:31:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7F9SWQ62273959
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 15 Aug 2019 02:28:33 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7F9SWQ62273959
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565861314;
        bh=ryZsENnTKlkD3MhgZfN5F/AhUx06fgs5gjf28SuFcho=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=xlIim6ph/XraYsvm/QQ9iMwJ8uyrMTONm41dNZr/BqgdZXgR2q8P3hzMdG8a982Jn
         b7cYYVr9jdEV8NvESxqDthIuBBJvnKSnc4eQTyCyKupKvlOjnyzSvDidlCRxn8uIn4
         RVvcn7f85jiXemVHfWFJkQO+R7dxFBBcW9rPZwkwrwqzmsZQo4MI9NYQfYriCO2M4q
         4bOEb7Dqu42csk4CBymF8tMy5P+4M32gnub/AOvoCbeywE13OQXE1MLMeqko2Bps6k
         FAL3UXxp+H1BCcwQoDdbkTFSzGb/cuWcEsf4M0Lyr3XcIv50ds5QGKE5lesvLAeatC
         M/yqgvIcPL5mg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7F9SWx22273956;
        Thu, 15 Aug 2019 02:28:32 -0700
Date:   Thu, 15 Aug 2019 02:28:32 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-hhnbjdo8r67054of9zm2kxtl@git.kernel.org>
Cc:     alexey.budankov@linux.intel.com, jmorris@namei.org, hpa@zytor.com,
        namhyung@kernel.org, suzuki.poulose@arm.com, mingo@kernel.org,
        ilubashe@akamai.com, tglx@linutronix.de, acme@redhat.com,
        mathieu.poirier@linaro.org, jolsa@kernel.org,
        adrian.hunter@intel.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org
Reply-To: namhyung@kernel.org, mingo@kernel.org, suzuki.poulose@arm.com,
          ilubashe@akamai.com, tglx@linutronix.de, jmorris@namei.org,
          alexey.budankov@linux.intel.com, hpa@zytor.com,
          adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
          peterz@infradead.org, linux-kernel@vger.kernel.org,
          acme@redhat.com, jolsa@kernel.org, mathieu.poirier@linaro.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf ftrace: Improve error message about capability
 to use ftrace
Git-Commit-ID: 73e5de70dca00344cb48e018131a4cadec0fabf0
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

Commit-ID:  73e5de70dca00344cb48e018131a4cadec0fabf0
Gitweb:     https://git.kernel.org/tip/73e5de70dca00344cb48e018131a4cadec0fabf0
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 12 Aug 2019 17:27:11 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 14 Aug 2019 10:59:59 -0300

perf ftrace: Improve error message about capability to use ftrace

If we link against libcap, then we can state that CAP_SYS_ADMIN is
needed, if not, fallback to telling the user it needs to be root, as was
before linking against libcap.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Igor Lubashev <ilubashe@akamai.com>
Cc: James Morris <jmorris@namei.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Link: https://lkml.kernel.org/n/tip-hhnbjdo8r67054of9zm2kxtl@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-ftrace.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 01a5bb58eb04..1367bb5046a7 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -284,7 +284,13 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 	};
 
 	if (!perf_cap__capable(CAP_SYS_ADMIN)) {
-		pr_err("ftrace only works for root!\n");
+		pr_err("ftrace only works for %s!\n",
+#ifdef HAVE_LIBCAP_SUPPORT
+		"users with the SYS_ADMIN capability"
+#else
+		"root"
+#endif
+		);
 		return -1;
 	}
 
