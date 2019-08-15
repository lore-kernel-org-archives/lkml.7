Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA35C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 20:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EFB521744
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 20:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731595AbfHOUWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 16:22:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40796 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730986AbfHOUWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 16:22:12 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hyMG8-0005Yt-FK; Thu, 15 Aug 2019 22:22:08 +0200
Date:   Thu, 15 Aug 2019 22:22:07 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Luck, Tony" <tony.luck@intel.com>
cc:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS, x86/CPU: Tony Luck will maintain
 asm/intel-family.h
In-Reply-To: <20190815183055.GA6847@agluck-desk2.amr.corp.intel.com>
Message-ID: <alpine.DEB.2.21.1908152217070.1908@nanos.tec.linutronix.de>
References: <20190814234030.30817-1-tony.luck@intel.com> <20190815075822.GC15313@zn.tnic> <20190815172159.GA4935@agluck-desk2.amr.corp.intel.com> <20190815175455.GJ15313@zn.tnic> <20190815183055.GA6847@agluck-desk2.amr.corp.intel.com>
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

On Thu, 15 Aug 2019, Luck, Tony wrote:
> On Thu, Aug 15, 2019 at 07:54:55PM +0200, Borislav Petkov wrote:
> @@ -11,6 +11,21 @@
>   * While adding a new CPUID for a new microarchitecture, add a new
>   * group to keep logically sorted out in chronological order. Within
>   * that group keep the CPUID for the variants sorted by model number.
> + *
> + * HOWTO Build an INTEL_FAM6_ definition:
> + * 
> + * 1. Start with INTEL_FAM6_
> + * 2. If not Core-family, add a note about it, like "ATOM".  There are only
> + *    two options for this (Xeon Phi and Atom).  It is exceedingly unlikely
> + *    that you are adding a cpu which needs a new option here.
> + * 3. Add the processor microarchitecture, not the platform name
> + * 4. Add a short differentiator if necessary.  Add an _X to differentiate
> + *    Server from Client.

We have the following existing _SHORT variants:

_G
_EP
_EX
_CORE
_ULT
_GT3E
_XEON_D
_MOBILE
_DESKTOP
_NNPI
_MID
_TABLET
_PLUS

So we should document the list of valid and usable ones and either fixup
broken ones or document that they are historic ballast and not to be used
for new ones. Otherwise you end up with the same discussions again.

Thanks,

	tglx
