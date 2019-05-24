Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEEEC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712B721773
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732012AbfEXSTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 14:19:07 -0400
Received: from foss.arm.com ([217.140.101.70]:48396 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727346AbfEXSTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 14:19:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9A97A78;
        Fri, 24 May 2019 11:19:06 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D81AF3F703;
        Fri, 24 May 2019 11:19:05 -0700 (PDT)
Date:   Fri, 24 May 2019 19:19:03 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [GIT PULL] arm64: Second round of fixes for -rc2
Message-ID: <20190524181903.GB9697@fuggles.cambridge.arm.com>
References: <20190524174357.GC9120@fuggles.cambridge.arm.com>
 <CAHk-=wijeJ5OjswsUkm0Fns=0kd7kgRo98uPsJE3HQfwP5mBRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wijeJ5OjswsUkm0Fns=0kd7kgRo98uPsJE3HQfwP5mBRA@mail.gmail.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 11:14:02AM -0700, Linus Torvalds wrote:
> Only tangentially relevant to this pull request:
> 
> On Fri, May 24, 2019 at 10:44 AM Will Deacon <will.deacon@arm.com> wrote:
> >
> > - Add workaround for Cortex-A76 CPU erratum #1463225
> > - Handle Cortex-A76/Neoverse-N1 erratum #1418040 w/ existing workaround
> 
> could you perhaps talk to somebody inside ARM about making the errata
> documentation publicly available?
> 
> I'm not sure why it seems to want an account at arm.com, and as a
> result some pretty fundamental development tools ("let me google
> that") don't work.

We recently removed a whole bunch of click-through/registration things
for our documentation, so I'm surprised that it's still the case for
the errata document (but it does appear to be).

I'll see if this can be fixed. After all, we end up descibing the thing
in the Kconfig text anyway...

Cheers,

Will
