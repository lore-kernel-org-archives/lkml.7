Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35913C48BE8
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 17:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C7420645
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 17:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732545AbfFXRhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 13:37:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39656 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729502AbfFXRhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 13:37:46 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hfSuT-0002VP-3j; Mon, 24 Jun 2019 19:37:41 +0200
Date:   Mon, 24 Jun 2019 19:37:40 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Catalin Marinas <catalin.marinas@arm.com>
cc:     Sudeep Holla <sudeep.holla@arm.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Weinberger <richard@nod.at>, jdike@addtoit.com,
        Steve Capper <Steve.Capper@arm.com>,
        Haibo Xu <haibo.xu@arm.com>, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 2/4] x86/entry: Simplify _TIF_SYSCALL_EMU handling
In-Reply-To: <20190624173008.GJ29120@arrakis.emea.arm.com>
Message-ID: <alpine.DEB.2.21.1906241936480.32342@nanos.tec.linutronix.de>
References: <20190523090618.13410-3-sudeep.holla@arm.com> <20190611145627.23229-1-sudeep.holla@arm.com> <20190624173008.GJ29120@arrakis.emea.arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jun 2019, Catalin Marinas wrote:
> On Tue, Jun 11, 2019 at 03:56:27PM +0100, Sudeep Holla wrote:
> > The usage of emulated and _TIF_SYSCALL_EMU flags in syscall_trace_enter
> > is more complicated than required.
> > 
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Acked-by: Oleg Nesterov <oleg@redhat.com>
> > Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  arch/x86/entry/common.c | 17 ++++++-----------
> >  1 file changed, 6 insertions(+), 11 deletions(-)
> > 
> > Hi Catalin,
> > 
> > I assume you can now pick up this patch.
> 
> I can, unless Thomas picks it up through the tip tree (there is no
> dependency on the other patches in this series, which I already queued
> via arm64).

Last time I checked I had no dependencies either. I'll recheck later
tonight.

Thanks,

	tglx
