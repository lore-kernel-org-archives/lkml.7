Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17784C76188
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E04F22085A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563708507;
	bh=48PMq+2GTrvpn/bF4B19ZrzA4mysFpzOAVtslwzpgOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Fvg7AZCLbRl+9aWOh2DONyIDD528SDhaBvdSGqgpVV1W2SPFSI95tIgZV2jXxPe/s
	 z9ocCwY+2NNgy0bHkoZ0znb+In532Cf+bCfPg9db+NvlnAALE4JHtEX+SP0LkalqT8
	 PCH8DuGA0tXd2qL6kIUYThVGNZV4iazqFECd8hLk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfGUL2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 07:28:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56362 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbfGUL2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:28:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 189124E908;
        Sun, 21 Jul 2019 11:28:25 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A1B15D9D3;
        Sun, 21 Jul 2019 11:28:20 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 26/79] libperf: Add perf/core.h header
Date:   Sun, 21 Jul 2019 13:24:13 +0200
Message-Id: <20190721112506.12306-27-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Sun, 21 Jul 2019 11:28:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding perf/core.h header to be used in header files
coming in following patches.

Link: http://lkml.kernel.org/n/tip-4gcruaobuhxfyaa88j2gxmor@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/include/perf/core.h | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 tools/perf/lib/include/perf/core.h

diff --git a/tools/perf/lib/include/perf/core.h b/tools/perf/lib/include/perf/core.h
new file mode 100644
index 000000000000..e2e4b43c9131
--- /dev/null
+++ b/tools/perf/lib/include/perf/core.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_CORE_H
+#define __LIBPERF_CORE_H
+
+#ifndef LIBPERF_API
+#define LIBPERF_API __attribute__((visibility("default")))
+#endif
+
+#endif /* __LIBPERF_CORE_H */
-- 
2.21.0

