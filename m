Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1F7C31E58
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E85B20657
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfFQLrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 07:47:37 -0400
Received: from foss.arm.com ([217.140.110.172]:46772 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbfFQLrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 07:47:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5F51344;
        Mon, 17 Jun 2019 04:47:36 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 831763F246;
        Mon, 17 Jun 2019 04:49:21 -0700 (PDT)
Date:   Mon, 17 Jun 2019 12:47:34 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] clocksource/arm_arch_timer: remove unused return type
Message-ID: <20190617114734.GK20984@e119886-lin.cambridge.arm.com>
References: <20190617093601.34511-1-andrew.murray@arm.com>
 <eb9532ff-8365-4287-ff43-045834dacdce@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb9532ff-8365-4287-ff43-045834dacdce@arm.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 10:45:24AM +0100, Marc Zyngier wrote:
> On 17/06/2019 10:36, Andrew Murray wrote:
> > The function 'arch_timer_set_evtstrm_feature' has no return statement
> > despite its prototype - let's change the function prototype to return
> > void. This matches the equivalent arm64 implementation.
> > 
> > fixes: 11e34eca5d0a ("clocksource/arm_arch_timer: Extract elf_hwcap use to arch-helper")
> 
> nit: tags start with a capital letter.

Thanks - I'll remember next time.

Andrew Murray

> 
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> > ---
> >  arch/arm/include/asm/arch_timer.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
> > index ae533caec1e9..99175812d903 100644
> > --- a/arch/arm/include/asm/arch_timer.h
> > +++ b/arch/arm/include/asm/arch_timer.h
> > @@ -125,7 +125,7 @@ static inline void arch_timer_set_cntkctl(u32 cntkctl)
> >  	isb();
> >  }
> >  
> > -static inline bool arch_timer_set_evtstrm_feature(void)
> > +static inline void arch_timer_set_evtstrm_feature(void)
> >  {
> >  	elf_hwcap |= HWCAP_EVTSTRM;
> >  }
> > 
> 
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> 	M.
> -- 
> Jazz is not dead. It just smells funny...
