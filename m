Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5975C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 11:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB2620828
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 11:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I/6Bzk7j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfCSLUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 07:20:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47690 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfCSLUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 07:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Fh7rcqcXfOkcU7J+zm2CRA/4m4kFmrIF8SCzX7YClT0=; b=I/6Bzk7j5PtTnAY/8RsNi+JmI
        dEHXMjaRyj8EBlsP9g//Qm4BR42YXWdAif+oqB1dVdin+gk0L8mR/CoYACLhnYxbt/lOuVsm7yCKY
        eW0E6pQuLiNt/AcYuPi12AV0ACPUNsJn0PZ1mftDFNG2zgfSOgBqpJ1fsprywGzV8oNKOagELRjv+
        ZC3NyKhzxerhQvwpkBboBLgD4L3u7p27OG4ZkaYCts19LXoQABoLKg/12T2xdTp8UYH95Zg8af95j
        Dls1KljTvMOVyh/8Vfxh94ax2pghMSnTTmK4gtiHmJwHivp4lCg7sC/EDwOg1FUQ1g5YcXiqE2Foe
        OT4DmuGfA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h6Cn6-0002LB-Ov; Tue, 19 Mar 2019 11:20:20 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 49875203C06F3; Tue, 19 Mar 2019 12:20:19 +0100 (CET)
Date:   Tue, 19 Mar 2019 12:20:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, luto@kernel.org,
        bp@alien8.de, dvlasenk@redhat.com, linux-kernel@vger.kernel.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: Re: [PATCH 00/25] objtool: UACCESS validation v4
Message-ID: <20190319112019.GB6058@hirez.programming.kicks-ass.net>
References: <20190318153840.906404905@infradead.org>
 <20190318235707.wdaldl2354fxmbab@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318235707.wdaldl2354fxmbab@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 06:57:07PM -0500, Josh Poimboeuf wrote:
> For the objtool bits:
> 
> Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

Thanks!

I'll go fold the PUSHF/POPF bits into the AC patch then.
