Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFE2C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 717D72086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568989683;
	bh=5CohENLaSVwI/3mvvRdRfYW57Hjj1qpJy/OdZdDsQ/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=geT2kOgogBYgGwdCwFJxZW9nloy/FHVDZC8WN5A+7ZbfQgDDp/PNXLAQum2ZNC9Z/
	 wtJ2MnbCfLLaYu8/3JXCHeU4nV6SJI4BxfsO70tXmImvAm/MIQbN03v08z8/jAadgi
	 Odk3mx5sdy8H9hIE0ezGPAciiqC8eo/vROVW2oso=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389741AbfITO1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 10:27:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389256AbfITO0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:26:44 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21A3420C01;
        Fri, 20 Sep 2019 14:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568989604;
        bh=5CohENLaSVwI/3mvvRdRfYW57Hjj1qpJy/OdZdDsQ/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IYuQvUeCrhXy6+y7CqsyU0eHm8DoKNXJU6XQys7iNzjfkFv3qPyxMQNs7VON0PK/o
         WNr3b8xmciixsxkranGFHE21JBG6Dmp6bQ0Sg0D/6Qgg30/OraVbuV2I9BOEikGlYb
         UyoFY5L2K2GCLsXKfw0ZTKLYeErwr499DAW65+t4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 19/31] perf annotate: Add missing machine.h include directive
Date:   Fri, 20 Sep 2019 11:25:30 -0300
Message-Id: <20190920142542.12047-20-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190920142542.12047-1-acme@kernel.org>
References: <20190920142542.12047-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We use what is defined there, were getting it by luck, indirectly, fix
it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-56g4jshmktniundmiw7h845k@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-annotate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 4e4d2e76232e..553c651fa0a2 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -27,6 +27,7 @@
 #include "util/sort.h"
 #include "util/hist.h"
 #include "util/dso.h"
+#include "util/machine.h"
 #include "util/map.h"
 #include "util/session.h"
 #include "util/tool.h"
-- 
2.21.0

