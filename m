Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DC2CA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 16:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2429320679
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 16:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390758AbfJ2Q7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 12:59:19 -0400
Received: from foss.arm.com ([217.140.110.172]:54704 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390606AbfJ2Q7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 12:59:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E566625;
        Tue, 29 Oct 2019 09:59:18 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E621F3F71F;
        Tue, 29 Oct 2019 09:59:15 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@arm.com,
        catalin.marinas@arm.com, deller@gmx.de, duwe@suse.de,
        James.Bottomley@HansenPartnership.com, james.morse@arm.com,
        jeyu@kernel.org, jpoimboe@redhat.com, jthierry@redhat.com,
        linux-parisc@vger.kernel.org, mark.rutland@arm.com,
        mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
        svens@stackframe.org, takahiro.akashi@linaro.org, will@kernel.org
Subject: [PATCHv2 6/8] arm64: asm-offsets: add S_FP
Date:   Tue, 29 Oct 2019 16:58:30 +0000
Message-Id: <20191029165832.33606-7-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191029165832.33606-1-mark.rutland@arm.com>
References: <20191029165832.33606-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So that assembly code can more easily manipulate the FP (x29) within a
pt_regs, add an S_FP asm-offsets definition.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/asm-offsets.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 214685760e1c..a5bdce8af65b 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -56,6 +56,7 @@ int main(void)
   DEFINE(S_X24,			offsetof(struct pt_regs, regs[24]));
   DEFINE(S_X26,			offsetof(struct pt_regs, regs[26]));
   DEFINE(S_X28,			offsetof(struct pt_regs, regs[28]));
+  DEFINE(S_FP,			offsetof(struct pt_regs, regs[29]));
   DEFINE(S_LR,			offsetof(struct pt_regs, regs[30]));
   DEFINE(S_SP,			offsetof(struct pt_regs, sp));
   DEFINE(S_PSTATE,		offsetof(struct pt_regs, pstate));
-- 
2.11.0

