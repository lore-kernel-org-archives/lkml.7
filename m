Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DDDC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36AB620842
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZaTvkAmL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfHMHUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 03:20:50 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40202 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfHMHUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 03:20:50 -0400
Received: from zn.tnic (p200300EC2F0D240075AA4C13F769B7E7.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:2400:75aa:4c13:f769:b7e7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6A2541EC0716;
        Tue, 13 Aug 2019 09:20:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565680849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ncz1fwT1iKmHjX/WSZFWPFgUiMV0MvcnFYjOmmqJtuY=;
        b=ZaTvkAmL4CJlDfXNk44+DBmikaxTz4qHDMXQhHyMWSgMD9C68w1ib7WB8vMNV6JmYZpYjp
        ZP6C+9OVehPdj5TpB1rdQBxQmeVRAq/h99idIMKoOlYlwXpmSHF6s5tftk+/YZOtcrQwnW
        sZy6+2QRD+0Ehe2z8kWwh7EINccnrew=
Date:   Tue, 13 Aug 2019 09:21:25 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kyung Min Park <kyung.min.park@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/cpu: Add Atom Tremont (Elkhart Lake)
Message-ID: <20190813072124.GA16770@zn.tnic>
References: <1565671419-5257-1-git-send-email-kyung.min.park@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1565671419-5257-1-git-send-email-kyung.min.park@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 09:43:38PM -0700, Kyung Min Park wrote:
> Add the Atom Tremont model number to the Intel family list.
> 
> Signed-off-by: Kyung Min Park <kyung.min.park@intel.com>
> ---
>  arch/x86/include/asm/intel-family.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
> index 0278aa6..02d675d 100644
> --- a/arch/x86/include/asm/intel-family.h
> +++ b/arch/x86/include/asm/intel-family.h
> @@ -79,6 +79,7 @@
>  #define INTEL_FAM6_ATOM_GOLDMONT_PLUS	0x7A /* Gemini Lake */
>  
>  #define INTEL_FAM6_ATOM_TREMONT_X	0x86 /* Jacobsville */
> +#define INTEL_FAM6_ATOM_TREMONT		0x96 /* Elkhart Lake */
>  
>  /* Xeon Phi */
>  
> -- 

Did you have a look at this thread before sending this patch?

https://lkml.kernel.org/r/20190808101045.19239-1-rajneesh.bhardwaj@linux.intel.com

Either way, please do a second patch summing up the naming scheme
explanations. And send this patch adding the model number together with
its first user patchset.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
