Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A7AC072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 05:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B156020862
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 05:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbfEVFef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 01:34:35 -0400
Received: from smtprelay0019.hostedemail.com ([216.40.44.19]:34670 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726214AbfEVFef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 01:34:35 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 500BBC1DC8F;
        Wed, 22 May 2019 05:34:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: doll00_27cb72a1ea748
X-Filterd-Recvd-Size: 4246
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Wed, 22 May 2019 05:34:33 +0000 (UTC)
Message-ID: <3731f4dbabe0b9cab7ab1cce43901668fd874b0c.camel@perches.com>
Subject: Re: [PATCH] scripts/spelling.txt: drop "sepc" from the misspelling
 list
From:   Joe Perches <joe@perches.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 21 May 2019 22:34:24 -0700
In-Reply-To: <alpine.DEB.2.21.9999.1905212134310.23235@viisi.sifive.com>
References: <20190518210037.13674-1-paul.walmsley@sifive.com>
         <201b9ab622b8359225f3a3b673a05047ffce5744.camel@perches.com>
         <alpine.DEB.2.21.9999.1905191108180.10723@viisi.sifive.com>
         <20190521171422.c7ef965e39b27f6142788412@linux-foundation.org>
         <alpine.DEB.2.21.9999.1905212134310.23235@viisi.sifive.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-05-21 at 21:47 -0700, Paul Walmsley wrote:
> On Tue, 21 May 2019, Andrew Morton wrote:
> 
> > On Sun, 19 May 2019 11:24:22 -0700 (PDT) Paul Walmsley <paul.walmsley@sifive.com> wrote:
> > 
> > > On Sat, 18 May 2019, Joe Perches wrote:
> > > 
> > > > On Sat, 2019-05-18 at 14:00 -0700, Paul Walmsley wrote:
> > > > > The RISC-V architecture has a register named the "Supervisor Exception
> > > > > Program Counter", or "sepc".  This abbreviation triggers
> > > > > checkpatch.pl's misspelling detector, resulting in noise in the
> > > > > checkpatch output.  The risk that this noise could cause more useful
> > > > > warnings to be missed seems to outweigh the harm of an occasional
> > > > > misspelling of "spec".  Thus drop the "sepc" entry from the
> > > > > misspelling list.
> > > > 
> > > > I would agree if you first fixed the existing sepc/spec
> > > > and sepcific/specific typos.
> > > > 
> > > > arch/powerpc/kvm/book3s_xics.c:	 * a pending interrupt, this is a SW error and PAPR sepcifies
> > > > arch/unicore32/include/mach/regs-gpio.h: * Sepcial Voltage Detect Reg GPIO_GPIR.
> > > > drivers/scsi/lpfc/lpfc_init.c:		/* Stop any OneConnect device sepcific driver timers */
> > > > drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c:* OverView:	Read "sepcific bits" from BB register
> > > > drivers/net/wireless/realtek/rtlwifi/wifi.h:/* Ref: 802.11i sepc D10.0 7.3.2.25.1
> > > 
> > > Your agreement shouldn't be needed for the patch I sent.
> > 
> > I always find Joe's input to be very useful.
> > 
> > Here:
> > 
> > From: Andrew Morton <akpm@linux-foundation.org>
> > Subject: scripts-spellingtxt-drop-sepc-from-the-misspelling-list-fix
> > 
> > fix existing "sepc" instances, per Joe
> > 
> > Cc: Joe Perches <joe@perches.com>
> > Cc: Paul Walmsley <paul.walmsley@sifive.com>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> 
> Thanks Andrew.  Sorry that you had to do it.
> 
> Reviewed-by: Paul Walmsley <paul.walmsley@sifive.com>
> 
> What troubled me about Joe's message is that it seems like poor kernel 
> developer precedent to block a fix for static analysis false positives to 
> fix comment spelling errors -- particularly considering that four out of 
> five of them were unrelated to the actual patch in question.  While 
> comment spelling fixes are worthwhile, I think we should make sure that 
> the "tail doesn't wag the dog" by prioritizing code fixes first.

I don't believe there is any tail wagging occurring here.

There is no code 'fix' in the original proposed patch.

It is, as described, effectively a subsystem specific
static analysis false positive avoidance patch.  And the
static analysis tool's false positive report is not active
by default.

Any scripts/spelling.txt change like a sepc removal could
be overridden by using checkpatch's --codespell option.

btw:

I don't generally add acked-by or reviewed-by to patches
as I rather agree with Ted's position on these headers.

https://lore.kernel.org/lkml/20190521171618.GD2591@mit.edu/

> I will try to do better next time,

Thanks.


