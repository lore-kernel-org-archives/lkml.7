Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F1FC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D91F6208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405227AbfITQXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 12:23:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52800 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404861AbfITQVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 12:21:12 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iBLee-00045f-AR; Fri, 20 Sep 2019 18:21:08 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2AF221C0E30;
        Fri, 20 Sep 2019 18:20:59 +0200 (CEST)
Date:   Fri, 20 Sep 2019 16:20:59 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf hist: Add missing 'struct branch_stack'
 forward declaration
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-srzphk0ehptfn3zqmpkgsi65@git.kernel.org>
References: <tip-srzphk0ehptfn3zqmpkgsi65@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156899645912.24167.15903506056860617686.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     3793d4de06fac8dcd25bf91386cf88415dbe99ad
Gitweb:        https://git.kernel.org/tip/3793d4de06fac8dcd25bf91386cf88415dbe99ad
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Wed, 18 Sep 2019 10:09:54 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 20 Sep 2019 09:19:22 -03:00

perf hist: Add missing 'struct branch_stack' forward declaration

Its needed, was being obtained indirectly, fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-srzphk0ehptfn3zqmpkgsi65@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/hist.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 34803e3..6a186b6 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -15,6 +15,7 @@ struct addr_location;
 struct map_symbol;
 struct mem_info;
 struct branch_info;
+struct branch_stack;
 struct block_info;
 struct symbol;
 struct ui_progress;
