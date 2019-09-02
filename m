Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B850C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 10:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E6A20820
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 10:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="FVBxRGDh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730934AbfIBKbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 06:31:23 -0400
Received: from mx-rz-2.rrze.uni-erlangen.de ([131.188.11.21]:54097 "EHLO
        mx-rz-2.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730643AbfIBKbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 06:31:22 -0400
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 46MR6X0BZ1zPp5C;
        Mon,  2 Sep 2019 12:25:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1567419908; bh=I3UwAI9LB9qZ85yuzau8JaXQCnLkltzgAxZ7dPcfTcQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
         Subject;
        b=FVBxRGDhbIgQtGjT/Z/qmNqxaz0pmziQY/raWSdG+DURsJlIgPpT9jGa/SfiRVo0v
         eqrDvIcI0URyzoJwAo/1DkJoYnOUCERxa9OcSH8iirB1Ey/23obN1C+yq6hBTDKkxG
         LlCKbFMcD+OjokA64+hDDPwmGErXvS5w5xvZCipx6ZZVzsLdZF3Ibh0TLim8ywlxPZ
         QAjkXBPTgu6FYCa5ZJBnLfa05I8LUrKxnGdXdCRyAvAgpOw1gCF4H//rnK4W8LLZmU
         rcGgjnDlZKJjfK19PWvEUaHaF1vdadCXj19n8GOBopkmOkWWX3I3eOpxU2vvxK4EYu
         ApMoNkzoPqJyg==
X-Virus-Scanned: amavisd-new at boeck2.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2003:ec:6bcd:9e00:70b1:65fc:7ed4:76a
Received: from Marco-E580.fritz.box (p200300EC6BCD9E0070B165FC7ED4076A.dip0.t-ipconnect.de [IPv6:2003:ec:6bcd:9e00:70b1:65fc:7ed4:76a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX18gE6I9hTuqvmafa1hHUN7bfqNKdu965Pk=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 46MR6N4dlkzPp4x;
        Mon,  2 Sep 2019 12:25:00 +0200 (CEST)
From:   Marco Ammon <marco.ammon@fau.de>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        trivial@kernel.org, Marco Ammon <marco.ammon@fau.de>
Subject: [PATCH 3/3] x86: kprobes: fix typo in comment
Date:   Mon,  2 Sep 2019 12:24:36 +0200
Message-Id: <20190902102436.27396-3-marco.ammon@fau.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190902102436.27396-1-marco.ammon@fau.de>
References: <20190902102436.27396-1-marco.ammon@fau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the comment for arch_prepare_optimized_kprobe, "instuction" should
actually be "instruction". This patch fixes the typo.

Signed-off-by: Marco Ammon <marco.ammon@fau.de>
---
 arch/x86/kernel/kprobes/opt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 9d4aedece363..282d559121d6 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -403,7 +403,7 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op,
 			   (u8 *)op->kp.addr + op->optinsn.size);
 	len += RELATIVEJUMP_SIZE;
 
-	/* We have to use text_poke for instuction buffer because it is RO */
+	/* We have to use text_poke for instruction buffer because it is RO */
 	text_poke(slot, buf, len);
 	ret = 0;
 out:
-- 
2.23.0

