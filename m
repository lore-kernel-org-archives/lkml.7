Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F554C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F4302054F
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eU0yjtPR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbfHTPa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 11:30:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58558 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfHTPaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 11:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Je378vFHdi1Tf06mBZJmIdghCHzz8cxecMdko4qmwZM=; b=eU0yjtPRgag+6UfSljJ4ztBxG
        s7cPd9MHgQpMrqgM28sIfb/jG9MFXsK1VKeRQp1Qf01S0gau8ufvv57qr2JcyTy8iVo/+ZlRiCHAh
        GwEpbN15wIJ2WbJi2fvME3OlZ3jSb7+IUaWzklZXKeyMcMagxlxjDBzCbY0szaLiOwfJkZobzJQZ0
        tqXpHay5QDk/O/sMw2501YVN1hwHzJ2ftmPBVTIRE0FDNIBzvwbME9uQVLX3SE0kWciUJDCOCMgea
        1bVpyL/vJOqWoafQ37wmXh9frlXV4qZNU1SNg8gfi69wpgAGdAxbtVktbTzKaF+DXKba3Fwt56zyT
        Sci1zQ43Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i065y-0008Ae-TK; Tue, 20 Aug 2019 15:30:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B31BD3075FF;
        Tue, 20 Aug 2019 17:30:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E908820A21FC3; Tue, 20 Aug 2019 17:30:48 +0200 (CEST)
Date:   Tue, 20 Aug 2019 17:30:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS, x86/CPU: Tony Luck will maintain
 asm/intel-family.h
Message-ID: <20190820153048.GX2332@hirez.programming.kicks-ass.net>
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
> On Thu, 15 Aug 2019, Luck, Tony wrote:
> > On Thu, Aug 15, 2019 at 07:54:55PM +0200, Borislav Petkov wrote:
> > @@ -11,6 +11,21 @@
> >   * While adding a new CPUID for a new microarchitecture, add a new
> >   * group to keep logically sorted out in chronological order. Within
> >   * that group keep the CPUID for the variants sorted by model number.
> > + *
> > + * HOWTO Build an INTEL_FAM6_ definition:
> > + * 
> > + * 1. Start with INTEL_FAM6_
> > + * 2. If not Core-family, add a note about it, like "ATOM".  There are only
> > + *    two options for this (Xeon Phi and Atom).  It is exceedingly unlikely
> > + *    that you are adding a cpu which needs a new option here.
> > + * 3. Add the processor microarchitecture, not the platform name
> > + * 4. Add a short differentiator if necessary.  Add an _X to differentiate
> > + *    Server from Client.
> 
> We have the following existing _SHORT variants:

> _PLUS

That one isn't actually a _SHORT, the uarch is called 'Goldmont Plus'.
