Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B7BC433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84CED208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="iCkxwcgg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730987AbfHOJ0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 05:26:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33329 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbfHOJ0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 05:26:42 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7F9QFO32273546
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 15 Aug 2019 02:26:15 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7F9QFO32273546
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565861176;
        bh=CEdv23Vqx5irCbXcpPnAkTHtVCRcdd6g1utuqbVtqO8=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=iCkxwcggo/XYQFuKTJYmTrFaf9m2TmidLdWvD6MK3ExWHVrxib+OXfhCoe/KPw3ES
         h7LnAZ56x2YTOJ44j/8Cfmk7661fwXolFY2K4JWercQXrWMMdTQ9+YzGa55QGV6oc0
         O/KIJf+tz1fconAd52ZKY9xFdZdHP5JlPRZ+CLVqYhwg+t/w2AoL75RIRyCUL8Carm
         +0oQ2Yr1Nxj4cCK6LKIFxB+uBg93kEkK3ZXYlaN8jtvWppRIAu6Q1p546zjUdp1kHu
         d0QJYq5V82lWYnu/xips2+JB+VAgs7E+Q/3ciswfGaPKMkOKqb9Rq/8D4uaYBEbvGc
         gqVlM8Fdew71A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7F9QEo62273543;
        Thu, 15 Aug 2019 02:26:14 -0700
Date:   Thu, 15 Aug 2019 02:26:14 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-eknnvp22elznj0cl5a39hc4v@git.kernel.org>
Cc:     mathieu.poirier@linaro.org, alexander.shishkin@linux.intel.com,
        suzuki.poulose@arm.com, peterz@infradead.org, namhyung@kernel.org,
        mingo@kernel.org, tglx@linutronix.de, acme@redhat.com,
        jolsa@kernel.org, hpa@zytor.com, ilubashe@akamai.com,
        linux-kernel@vger.kernel.org, alexey.budankov@linux.intel.com,
        jmorris@namei.org
Reply-To: namhyung@kernel.org, peterz@infradead.org,
          suzuki.poulose@arm.com, tglx@linutronix.de, mingo@kernel.org,
          mathieu.poirier@linaro.org, alexander.shishkin@linux.intel.com,
          alexey.budankov@linux.intel.com, jmorris@namei.org,
          linux-kernel@vger.kernel.org, jolsa@kernel.org, acme@redhat.com,
          ilubashe@akamai.com, hpa@zytor.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Add NO_LIBCAP=1 to the minimal build
 test
Git-Commit-ID: 97993bd6eb89bf08649c01d4d57453feca4314f8
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

Commit-ID:  97993bd6eb89bf08649c01d4d57453feca4314f8
Gitweb:     https://git.kernel.org/tip/97993bd6eb89bf08649c01d4d57453feca4314f8
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 12 Aug 2019 16:43:08 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 14 Aug 2019 10:59:59 -0300

perf tools: Add NO_LIBCAP=1 to the minimal build test

We need to add these so that we test building without all selectable
features.

Acked-by: Igor Lubashev <ilubashe@akamai.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: James Morris <jmorris@namei.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Link: https://lkml.kernel.org/n/tip-eknnvp22elznj0cl5a39hc4v@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/make | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 5363a12a8b9b..70c48475896d 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -108,6 +108,7 @@ make_minimal        += NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1
 make_minimal        += NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1
 make_minimal        += NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1
 make_minimal        += NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1
+make_minimal        += NO_LIBCAP=1
 
 # $(run) contains all available tests
 run := make_pure
