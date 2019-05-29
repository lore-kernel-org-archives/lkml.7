Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25043C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC1F218C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559137012;
	bh=3Elkhk5b4dBoao1Zqh+mo49CzbC3LLPZd9K936MyXuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HA7zbzQV33y2NYlokC0ahACQRMEmZdbyF9D/060j4Mo3bNE7J9MsCLfLHUjVZGcEQ
	 cCSJLZOKXe4wiMk9P6qUhouzUWlHupZUu3mHzHx44t0W3QA20YUiAgQXEY08pAPwSc
	 DO0iSYUNflY2nt/etSw27Gfb7gcKjPevk9FKeJlU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfE2Ngv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 09:36:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:51786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbfE2Ngs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:36:48 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.211.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA3C62190E;
        Wed, 29 May 2019 13:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559137008;
        bh=3Elkhk5b4dBoao1Zqh+mo49CzbC3LLPZd9K936MyXuc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VZFuSrytVdUYfeyQegEuHSbTjKKnn/NeF+QdOiWE1TBE2ZEjgtYjwhCgt2kOyR+2i
         02zwOYM8CBCbfZUiqjYMyufYz2RwX5ahhYj6uDqXtlEGPGwyCCwNVUhYW7F1c0L23P
         eGp4RzQu/uxOCq0om6/7dhrM+PvxDfEKpPWbHNNU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 07/41] perf augmented_raw_syscalls: Fix up comment
Date:   Wed, 29 May 2019 10:35:31 -0300
Message-Id: <20190529133605.21118-8-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190529133605.21118-1-acme@kernel.org>
References: <20190529133605.21118-1-acme@kernel.org>
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

