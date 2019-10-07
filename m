Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F51DC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E7421655
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bnabp4md"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbfJGLZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 07:25:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50196 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbfJGLXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:23:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eCzyQp0N/0lsSk1d3IkTJatCuFiOdLMeuV/Po57Dr4E=; b=Bnabp4mdDNCnduoGw7pmgNOhYR
        fTAeiTytwGPZ21mKGgn7/tbChxRgHFWWOu2wqCbmDjG8MJudhL50jJQHbUZi8j0zppodtrzMriskn
        qHwxxpO4FFMkfnScdNrPukxoUq4fYwgY7Tk711k0C//OlOYFDao2eVRvlqoHnHOxfGmzmlgqljyVt
        PecHnu61XXQQy0gaRM+hEuY6DhSC5qMFQrTV9imLYP+kuOe0eFsCMNEOgZjyDJjjSbpTlDiTtI5RV
        d+HjCxbsHRopEfWwwcNzkN/IH+QmdrA+5K83NjYvAus4FXQRY1hOEUDYs0QKHk/R8dKqDrNQ6bp8d
        GWXBWIEg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHR6w-0003GN-Ed; Mon, 07 Oct 2019 11:23:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 878F0305FB6;
        Mon,  7 Oct 2019 13:22:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6E1B420244F88; Mon,  7 Oct 2019 13:23:26 +0200 (CEST)
Message-Id: <20191007081944.93986386.2@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 07 Oct 2019 10:17:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com
Subject: [PATCH v3 2/6] x86/alternatives: Update int3_emulate_push() comment
References: <20191007081716.07616230.8@infradead.org>
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


