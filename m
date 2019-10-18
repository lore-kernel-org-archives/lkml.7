Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78218CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 506A0222C6
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xqFoqIt9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504805AbfJRHvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 03:51:42 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34330 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504779AbfJRHvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 03:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eCzyQp0N/0lsSk1d3IkTJatCuFiOdLMeuV/Po57Dr4E=; b=xqFoqIt9Im+GQEEEEPrdxZdwQs
        aLMiE/F92iT21XZfJnCF9/PAXy2bYpIdg4zQCTkArorYfqMPiGQcm/l4A+90s4CC6rJyYcuLH1rge
        rq4mBcNXbBIQp78usJvvTQ6vHL2myuTIVKx/MEVgpvfCoVWA1IUSlT7lBfwj/3Ar+c3bpKPi1Egm0
        prwcAWzEuZKRWEXjeEaRHrOiQJMZI7GuqbQxuan8N4axMzPeDeo+4DbyhvgIPQKFx9F2smwyhxOVN
        gX5bjLDCQfTdNpSeK/xKngAcWkEaTla/GgHRlpPoy91KgrDEhI/eAOjqqoxd4XWt5d9HFJfXYPA81
        PYlcDOxw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLN2b-0007mh-2L; Fri, 18 Oct 2019 07:51:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 87BB3301124;
        Fri, 18 Oct 2019 09:50:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 383A52B17810D; Fri, 18 Oct 2019 09:51:15 +0200 (CEST)
Message-Id: <20191018074634.055623110@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 18 Oct 2019 09:35:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, jeyu@kernel.org
Subject: [PATCH v4 02/16] x86/alternatives: Update int3_emulate_push() comment
References: <20191018073525.768931536@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the comment now that we've merged x86_32 support.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/text-patching.h |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -85,6 +85,9 @@ static inline void int3_emulate_push(str
 	 * stack where the break point happened, and the saving of
 	 * pt_regs. We can extend the original stack because of
 	 * this gap. See the idtentry macro's create_gap option.
+	 *
+	 * Similarly entry_32.S will have a gap on the stack for (any) hardware
+	 * exception and pt_regs; see FIXUP_FRAME.
 	 */
 	regs->sp -= sizeof(unsigned long);
 	*(unsigned long *)regs->sp = val;


