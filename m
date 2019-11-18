Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FEEC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 12:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE816206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 12:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="FbQlhGrR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfKRMqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 07:46:40 -0500
Received: from mail.skyhub.de ([5.9.137.197]:47120 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbfKRMqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 07:46:40 -0500
Received: from zn.tnic (p200300EC2F27B5005CDE11504E48EE16.dip0.t-ipconnect.de [IPv6:2003:ec:2f27:b500:5cde:1150:4e48:ee16])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 043391EC0985;
        Mon, 18 Nov 2019 13:46:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1574081199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=AyEbdiVjIhaVoZ+hFYJXdILWhiJ5cKwcAo4gqgco3dc=;
        b=FbQlhGrR1KWy7WWrVgd2t8KA+3Or33VzlNvsbeK0BkOnTzFzlVKl+yd1XJA9MbxU+Tw6TI
        rtOctafy71vURQI2mSPeiDx/GdYT+mo0AFwCOs9tIkyGT98I3QDjvJ4aBes8QVujE70Ov4
        AvcNzHLjJ9bXryIEf1AafhwO5vwmUuE=
Date:   Mon, 18 Nov 2019 13:46:34 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Robert Richter <rrichter@marvell.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        x86-ml <x86@kernel.org>
Subject: Re: [tip: x86/cleanups] x86: Fix typos in comments
Message-ID: <20191118124633.GA6363@zn.tnic>
References: <20191118070012.27850-1-caoj.fnst@cn.fujitsu.com>
 <157406828172.12247.4218858363680758865.tip-bot2@tip-bot2>
 <20191118121027.GA74767@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191118121027.GA74767@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 01:10:27PM +0100, Ingo Molnar wrote:
> Beyond the typo, this whole paragraph is hard to read and inconsistent 
> throughout.
> 
> How about something like this, on top? [ Feel free to backmerge, but can 
> do a separate commit too - in which case I'll probably read the rest of 
> the file too ;-) ]
> 
> Thanks,
> 
> 	Ingo
> 
>  arch/x86/kernel/setup.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index d398afd206b8..e9fa944d4ed8 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -468,15 +468,15 @@ static void __init memblock_x86_reserve_range_setup_data(void)
>  /*
>   * Keep the crash kernel below this limit.
>   *
> - * On 32 bits earlier kernels would limit the kernel to the low 512 MiB
> + * Earlier 32-bits kernels would limit the kernel to the low 512 MB range
>   * due to mapping restrictions.
>   *
> - * On 64bit, kdump kernel need be restricted to be under 64TB, which is
> + * 64-bit kdump kernels need to be restricted to be under 64 TB, which is
>   * the upper limit of system RAM in 4-level paging mode. Since the kdump
> - * jumping could be from 5-level to 4-level, the jumping will fail if
> - * kernel is put above 64TB, and there's no way to detect the paging mode
> - * of the kernel which will be loaded for dumping during the 1st kernel
> - * bootup.
> + * jump could be from 5-level paging to 4-level paging, the jump will fail if
> + * the kernel is put above 64 TB, and during the 1st kernel bootup there's
> + * no good way to detect the paging mode of the target kernel which will be
> + * loaded for dumping.
>   */
>  #ifdef CONFIG_X86_32
>  # define CRASH_ADDR_LOW_MAX	SZ_512M

Yap, sure.

Except that tglx committed another patch ontop of x86/cleanups in the
meantime. I leave it up to you to decide what to do. I'd backmerge and
rebase but this is just me.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
