Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23F5C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 16:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D252087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 16:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rd4H5QU7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbfHTQLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 12:11:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34234 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbfHTQLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 12:11:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6e2KgZgbZ3qIodpzGZbEcgVwSZBb+XMPoBZ1c8CPPPA=; b=rd4H5QU7KQBM7P99eMk/UWi2M
        SbEAvkd8AUYu3CYYvQvjmtLWycFu/kwfGGJsNB+xIXm7FcrzwoYLs2wsVL/eS1JMnRjA6HCDgpX2L
        aFNWhbkX+p61S0CtAOUouzDW3uQVlyedwuHmrKow1am0SAKs9qpryXCxdN/Yo3/+tOFdCFmNonTrB
        6lzqHqjBBgIywejkrMHRie3DxnF4dA/uyBBBGpJByeXhj2zU2gSECodxRGFCfmdCRGZPWDqD80ZT1
        x6Z1V5YyDiayFrhf+Hhid94OZaNv0n59/VfhlYx5Ar5n8vYcSn+p/8puFoiEyLMOFiFdBET8gbicg
        pCM6np0jg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i06in-0006ZP-IT; Tue, 20 Aug 2019 16:10:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4A1FD307456;
        Tue, 20 Aug 2019 18:10:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9100020A21FC5; Tue, 20 Aug 2019 18:10:55 +0200 (CEST)
Date:   Tue, 20 Aug 2019 18:10:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS, x86/CPU: Tony Luck will maintain
 asm/intel-family.h
Message-ID: <20190820161055.GZ2332@hirez.programming.kicks-ass.net>
References: <20190814234030.30817-1-tony.luck@intel.com>
 <20190815075822.GC15313@zn.tnic>
 <20190815172159.GA4935@agluck-desk2.amr.corp.intel.com>
 <20190815175455.GJ15313@zn.tnic>
 <20190815183055.GA6847@agluck-desk2.amr.corp.intel.com>
 <alpine.DEB.2.21.1908152217070.1908@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1908152217070.1908@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 10:22:07PM +0200, Thomas Gleixner wrote:

> We have the following existing _SHORT variants:
> 
> _G
> _EP
> _EX
> _CORE
> _ULT
> _GT3E
> _XEON_D
> _MOBILE
> _DESKTOP
> _NNPI
> _MID
> _TABLET
> _PLUS

Your list is missing: _L and _X.

_X is the generic 'server'

And we have only MEROM_L, which, afaict, is a mobile variant of MEROM.
Now, I just send out patches doing s/_MOBILE/_ULT/, so I suppose this
then should be MEROM_ULT.

Or we go the other way and do: s/_ULT/_MOBILE/, in which case this
becomes: MEROM_MOBILE.

No strong feelings either way.
