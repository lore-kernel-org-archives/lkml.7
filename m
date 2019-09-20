Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62821C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3812120882
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568989643;
	bh=R2+G+1Ve7Q70gRh6szXdH57LdUwHMIc/ZQxUMZ9BlOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AzfyibRX6ZegeyYCAbAHGh3H+fvcPp0bm6VVIOEKfn4QpadMg8glXTCC56lY93AHc
	 CE63qMKNo4TNUrZ2qM2pIKn635bS0KW1os9mp2RxlUCoAz1QxPOpcop/zM2ikO5buG
	 sjOVzn1UwGJt1ye6A7FcqQQoabfneLt1k6b04/i0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389765AbfITO1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 10:27:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:39600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389294AbfITO0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:26:47 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0B5B208C3;
        Fri, 20 Sep 2019 14:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568989606;
        bh=R2+G+1Ve7Q70gRh6szXdH57LdUwHMIc/ZQxUMZ9BlOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K1prNJ1oeoNBTiGWRQqcpMjf1uyTuqXp//kYH8ppgl4WsHF9fqwlHIHaSXacX3LZ9
         VqgJS5dXpqAHbFfxuQuVx9dF7qXUW6hp30j/A9iD6CeX9F8iZPXb2KY1SV2OJfhPCe
         AHImI2+jokMsua4mx284o7TkzOyk7Ta/KWvGSPAE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 20/31] perf sched: Add missing event.h include directive
Date:   Fri, 20 Sep 2019 11:25:31 -0300
Message-Id: <20190920142542.12047-21-acme@kernel.org>
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
Link: https://lkml.kernel.org/n/tip-e1cdt9557ctpvs3jb9c16qe6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-sched.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 511e19a7aafa..f0b828c201cc 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -24,6 +24,7 @@
 #include "util/trace-event.h"
 
 #include "util/debug.h"
+#include "util/event.h"
 
 #include <linux/kernel.h>
 #include <linux/log2.h>
-- 
2.21.0

