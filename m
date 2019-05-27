Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE9FC072B1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 22:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F3021670
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 22:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558996699;
	bh=3Elkhk5b4dBoao1Zqh+mo49CzbC3LLPZd9K936MyXuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tlc1ea0YVCfrienSXfvhFWpdnXYqSQMTzbRVrcKKdaq+mjawroTsmr8swnd4xSUma
	 ZJ+bueyc05DpzRJiAdWIf7jAZnV3yTRyKOUhyIZT6N17ZPpxlaNB5xTzctQc+4vkTU
	 C86Sb2heoHDcUbL4XoH5EDCeeDCrmq49wceJmsc0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfE0WiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 18:38:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:44022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727591AbfE0WiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 18:38:16 -0400
Received: from quaco.ghostprotocols.net (179-240-171-7.3g.claro.net.br [179.240.171.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FA682133F;
        Mon, 27 May 2019 22:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558996695;
        bh=3Elkhk5b4dBoao1Zqh+mo49CzbC3LLPZd9K936MyXuc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=slq55AYjRU8Hno+uijxvQqNZespVVQcKjvhl0RfDAnIKjniasu0FrPl1qvRRR38am
         8DGMq3tFz2BdAUkFLiD1e5VUK9V45cyugsjRVfgi65aqxr8FeW8V0mwAMpcede8uMD
         /imR9Asc64sAHk0mefmneuHSYfgtEW/JJNgH2Jmg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 08/44] perf augmented_raw_syscalls: Fix up comment
Date:   Mon, 27 May 2019 19:36:54 -0300
Message-Id: <20190527223730.11474-9-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190527223730.11474-1-acme@kernel.org>
References: <20190527223730.11474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Cut'n'paste error, the second comment is about the syscalls that have as
its second arg a string.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-zo5s6rloy42u41acsf6q3pvi@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_raw_syscalls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 2422894a8194..b292e763f3c7 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -87,7 +87,7 @@ struct augmented_filename {
 #define SYS_SYMLINKAT          266
 #define SYS_MEMFD_CREATE       319
 
-/* syscalls where the first arg is a string */
+/* syscalls where the second arg is a string */
 
 #define SYS_PWRITE64            18
 #define SYS_EXECVE              59
-- 
2.20.1

