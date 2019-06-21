Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D209CC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09772166E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561138848;
	bh=FL42HRIkynlf5B218/KBo3nT/+5L0TGZCKqZ5DgCUzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mdp7s5Vvj5PBWX/4FR3PdXe5iVUOzZMZHjUb0ekH+4YpB61UsYXaQNuSdCTUgUqX/
	 9c0eroJfAdxQOGBxWop33VSim6kSN7thIGWEQ07+sCyE7fv9uhCmPvbaYF6tW9KDhC
	 KGtGRZ3H1NlvyssijPKYKOT+06Qr6QEwRZlyY5t0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfFURkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 13:40:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:59864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbfFURkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 13:40:46 -0400
Received: from quaco.ghostprotocols.net (187-26-104-93.3g.claro.net.br [187.26.104.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF18A208CA;
        Fri, 21 Jun 2019 17:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561138846;
        bh=FL42HRIkynlf5B218/KBo3nT/+5L0TGZCKqZ5DgCUzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ASVUHpvSttaQSpn4dvYOFvJw0rYQ0KFulbNQmizhswGEI+9OJYA1l+HtNCiEOWWt1
         ++XkdpLu5QxMYf+4NpJ1T3VXM3RVnie/Z+luNLg2ZdBHLl2tTen02qMVdsugQygmMf
         E1RAMS+jKxo8bspt/TNosJyc4L8uW/HKf2QLfh5U=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 17/25] tools build feature tests: Add missing SPDX headers
Date:   Fri, 21 Jun 2019 14:38:23 -0300
Message-Id: <20190621173831.13780-18-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190621173831.13780-1-acme@kernel.org>
References: <20190621173831.13780-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-3h6fa866w6ao0wsbyqz9nrm8@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/feature/test-fortify-source.c | 1 +
 tools/build/feature/test-hello.c          | 1 +
 tools/build/feature/test-setns.c          | 1 +
 3 files changed, 3 insertions(+)

diff --git a/tools/build/feature/test-fortify-source.c b/tools/build/feature/test-fortify-source.c
index c9f398d87868..c8a57194f9f2 100644
--- a/tools/build/feature/test-fortify-source.c
+++ b/tools/build/feature/test-fortify-source.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 
 int main(void)
diff --git a/tools/build/feature/test-hello.c b/tools/build/feature/test-hello.c
index c9f398d87868..c8a57194f9f2 100644
--- a/tools/build/feature/test-hello.c
+++ b/tools/build/feature/test-hello.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 
 int main(void)
diff --git a/tools/build/feature/test-setns.c b/tools/build/feature/test-setns.c
index 4a1581ae7a55..2757c201ed50 100644
--- a/tools/build/feature/test-setns.c
+++ b/tools/build/feature/test-setns.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #define _GNU_SOURCE
 #include <sched.h>
 
-- 
2.20.1

