Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36F1C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 06:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F7820644
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 06:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="O0xVAwPt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfHPGph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 02:45:37 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53152 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfHPGph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 02:45:37 -0400
Received: from zn.tnic (p200300EC2F0A920041519BC41B2ACCA3.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:9200:4151:9bc4:1b2a:cca3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 307A51EC074B;
        Fri, 16 Aug 2019 08:45:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565937936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=yoiKixPe5qr94uGkb8tkzi///jkObvb6JYyEAla0DjE=;
        b=O0xVAwPtn9ffg8o8RxBw/t0wIiKzBpv0igzPdnKXaTs45O9vreIMwSE55EnGOaf+yarp3L
        QGGogq9l8ts/nBcSxLmTD9SVcRzeUalJD5wbIYV59q46WUtckjT1/d/OspA9P4unNe0+YH
        TP1mce8yB+bIkNWK3rUHxtuN5jW3WpY=
Date:   Fri, 16 Aug 2019 08:46:25 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS, x86/CPU: Tony Luck will maintain
 asm/intel-family.h
Message-ID: <20190816064625.GD18980@zn.tnic>
References: <20190814234030.30817-1-tony.luck@intel.com>
 <20190815075822.GC15313@zn.tnic>
 <20190815172159.GA4935@agluck-desk2.amr.corp.intel.com>
 <20190815175455.GJ15313@zn.tnic>
 <20190815183055.GA6847@agluck-desk2.amr.corp.intel.com>
 <alpine.DEB.2.21.1908152217070.1908@nanos.tec.linutronix.de>
 <20190815224704.GA10025@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190815224704.GA10025@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 03:47:05PM -0700, Luck, Tony wrote:
> On Thu, Aug 15, 2019 at 10:22:07PM +0200, Thomas Gleixner wrote:
> > On Thu, 15 Aug 2019, Luck, Tony wrote:
> > > On Thu, Aug 15, 2019 at 07:54:55PM +0200, Borislav Petkov wrote:
> > So we should document the list of valid and usable ones and either fixup
> > broken ones or document that they are historic ballast and not to be used
> > for new ones. Otherwise you end up with the same discussions again.
> 
> This version is a lot more specific (but still allows future
> flexibility). I see a world of bike-shedding if I try to come
> up with a naming scheme to fix previous questionable naming
> choices ... I'm not going to open that can of worms.
> 
> -Tony
> 
> From 093bf8cd02f4c7a3fa256c2cf7302014190e2840 Mon Sep 17 00:00:00 2001
> From: Tony Luck <tony.luck@intel.com>
> Date: Thu, 15 Aug 2019 11:16:24 -0700
> Subject: [PATCH] x86/cpu: Explain Intel model naming convention
> 
> Dave Hansen spelled out the rules in an e-mail:
> 
>  https://lkml.kernel.org/r/91eefbe4-e32b-d762-be4d-672ff915db47@intel.com
> 
> Copy those right into the <asm/intel-family.h> file to
> make it easy for people to find them.
> 
> Suggested-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/include/asm/intel-family.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
> index 0278aa66ef62..fe7c205233f1 100644
> --- a/arch/x86/include/asm/intel-family.h
> +++ b/arch/x86/include/asm/intel-family.h
> @@ -11,6 +11,21 @@
>   * While adding a new CPUID for a new microarchitecture, add a new
>   * group to keep logically sorted out in chronological order. Within
>   * that group keep the CPUID for the variants sorted by model number.
> + *
> + * The defined symbol names have the following form:
> + *	INTEL_FAM6{OPTFAMILY}_{MICROARCH}{OPTDIFF}

I think you want to have the underscores in the template:

	INTEL_FAM6_{OPTFAMILY}_{MICROARCH}_{OPTDIFF}

but no need to resend if this is the only issue - I'll fix it up when
applying.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
