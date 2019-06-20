Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD56AC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 12:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FDB52080C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 12:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kzQX+mLC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731700AbfFTMNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 08:13:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34376 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfFTMN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 08:13:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=INLoN7fo8QBg41xd5vTCQxjRIjhqdZgqFMwFhcZAuno=; b=kzQX+mLCvcIWem20bLKq8tllh
        1wIjXEATGMItzi2s4k6mxcxl/0PbaVVA0mOlX04MM5IdfpOHRW5TkkZGEVD7SvmSoUA/oLfkta/IY
        hswgcR/no8eUgw6j/ZQXnpNtaW4SR7qlg+eUWONBdx9e9s9XBhk+FrdflxqbfHre3aeUK3BjvmTEH
        NY3+aqZTjtOARNwhzaM+YRwFGGKQTeUjDtdEUFoTehMTehIxR+dOB8JtMw4LyMguLYxbEIAatOEB4
        c2dEGifXqkK42pWBHQNkVElYfFK12IByRIQfn6n89mfn2eIE16dwfbQKb/uMYiGp/da72s3XNf2Gw
        mMeAyRAFw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdvwM-0003gl-Ov; Thu, 20 Jun 2019 12:13:18 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C1BB7209CCE6C; Thu, 20 Jun 2019 14:13:16 +0200 (CEST)
Date:   Thu, 20 Jun 2019 14:13:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Vince Weaver <vincent.weaver@maine.edu>,
        syzbot <syzbot+10189b9b0f8c4664badd@syzkaller.appspotmail.com>,
        acme@kernel.org, acme@redhat.com,
        alexander.shishkin@linux.intel.com, bp@alien8.de,
        eranian@google.com, hpa@zytor.com, jolsa@kernel.org,
        jolsa@redhat.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        mingo@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, torvalds@linux-foundation.org, x86@kernel.org
Subject: Re: WARNING in perf_reg_value
Message-ID: <20190620121316.GV3436@hirez.programming.kicks-ass.net>
References: <000000000000734545058bb27ebb@google.com>
 <alpine.DEB.2.21.1906191605380.10498@macbook-air>
 <8ec677d7-f891-1c8b-33bd-16506974fafb@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ec677d7-f891-1c8b-33bd-16506974fafb@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 05:15:32PM -0400, Liang, Kan wrote:
> Here are the patches posted.
> https://lkml.org/lkml/2019/5/28/1022

How many times do I have to tell that lkml.org links are frigging
useless?

Now I have to copy/paste them into a browser, pray the site works today,
and then copy paste the subject back into my mua and hopefully find the
thread.

If you'd used the canonical form, I'd instantly have a msgid and I
could've search for that directly, without having to have to touch a
browser or hope the interweb actually works.


