Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2351C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C30BA2075B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfFEUac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 16:30:32 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:58296 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFEUac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 16:30:32 -0400
Received: from svr-orw-mbx-01.mgc.mentorg.com ([147.34.90.201])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1hYcYB-0007fT-CH from George_Davis@mentor.com ; Wed, 05 Jun 2019 13:30:23 -0700
Received: from localhost (147.34.91.1) by svr-orw-mbx-01.mgc.mentorg.com
 (147.34.90.201) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Wed, 5 Jun
 2019 13:30:21 -0700
From:   "George G. Davis" <george_davis@mentor.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        "George G. Davis" <george_davis@mentor.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andi Kleen <ak@linux.intel.com>, Jann Horn <jannh@google.com>,
        Nadav Amit <namit@vmware.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] treewide: trivial: fix s/poped/popped/ typo
Date:   Wed, 5 Jun 2019 16:30:10 -0400
Message-ID: <1559766612-12178-2-git-send-email-george_davis@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559766612-12178-1-git-send-email-george_davis@mentor.com>
References: <1559766612-12178-1-git-send-email-george_davis@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SVR-ORW-MBX-05.mgc.mentorg.com (147.34.90.205) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a couple of s/poped/popped/ typos.

Cc: Jiri Kosina <trivial@kernel.org>
Signed-off-by: George G. Davis <george_davis@mentor.com>
---
 Documentation/arm/mem_alignment | 2 +-
 arch/x86/kernel/kprobes/core.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/arm/mem_alignment b/Documentation/arm/mem_alignment
index 6335fcacbba9..e110e2781039 100644
--- a/Documentation/arm/mem_alignment
+++ b/Documentation/arm/mem_alignment
@@ -1,4 +1,4 @@
-Too many problems poped up because of unnoticed misaligned memory access in
+Too many problems popped up because of unnoticed misaligned memory access in
 kernel code lately.  Therefore the alignment fixup is now unconditionally
 configured in for SA11x0 based targets.  According to Alan Cox, this is a
 bad idea to configure it out, but Russell King has some good reasons for
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 6afd8061dbae..d3243d93daf4 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -813,7 +813,7 @@ __used __visible void *trampoline_handler(struct pt_regs *regs)
 			continue;
 		/*
 		 * Return probes must be pushed on this hash list correct
-		 * order (same as return order) so that it can be poped
+		 * order (same as return order) so that it can be popped
 		 * correctly. However, if we find it is pushed it incorrect
 		 * order, this means we find a function which should not be
 		 * probed, because the wrong order entry is pushed on the
-- 
2.7.4

