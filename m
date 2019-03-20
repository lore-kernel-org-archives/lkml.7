Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9380C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 23:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9550A218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 23:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553125030;
	bh=gG2iKCeWscUvUIf07huDC9Y72Ah0Z90Pl30uhhrzxCI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HLJAXETxCfhONWCZsf+sAZbU2K3GZTTligRTZiMRb6jQOjz+UHZrecvtl/BTxG4Z7
	 5KSSGHl+IWJKsTb+zEimY/00YJcrECw8b3t+L/4R2CqhIXIV+oz7s8WxXuplCy2OXX
	 G3m/5PUHxUEexEsnEcMXvlCOIR/NtsIrZpoEMyfc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbfCTXhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 19:37:09 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45793 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfCTXhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 19:37:08 -0400
Received: by mail-ed1-f66.google.com with SMTP id m16so3474350edd.12;
        Wed, 20 Mar 2019 16:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ushezcBHXWI6B6QX5Mtp0NVcZN/Sz1kfM0fpYGf14CU=;
        b=jKO3wib2HwaJzXGdQbXLJgaoSmVhe90wXbFSMVz73En//1ewgG3TqRYG0srErsudv1
         pBDTrwUEw2F3/y74czooMbs1ak5ppMeZYCK7fluqOqF4O/j9dvr4UUP9oaR0Bc2RxeMM
         /pHKQJNjS8+fY/q5WTm8G1d1Po//mGBACFLoeJ5dNCa6MZqu8xH/mC3yPvgB/vY/sKUo
         gnQEUNDWQZZR0yJsFNIXlKw2uqNocnHqkipog6K7yQ5L+F9qsB9f4JbJobQihcM9+AsF
         P4h6Vvb3BIVE/VT3WrBN59yas7qIQSKMevgXMUIYAOs8EPudCYpTu1aFNGf4B1a9ddL4
         ZH6w==
X-Gm-Message-State: APjAAAVtmKzYskWgXPbSNIrlyNvCK7HcHwDWUATNA3KHWaGt/ynNFxEa
        R9iTg6o/SyfE7QLeSIxjy0IzkRsLdCwsqzE18p9ynQ==
X-Google-Smtp-Source: APXvYqz++R+/GdBRojULH4zPAbG+3babyd18AmltFRWtyso/FMYBEtpnJWZR8efanqTSytMU9G2/K2Pbbt09rSmlKLk=
X-Received: by 2002:a50:b8e2:: with SMTP id l89mr393297ede.140.1553125026988;
 Wed, 20 Mar 2019 16:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180817163442.10065-1-calvin.walton@kepstin.ca> <20180817163442.10065-3-calvin.walton@kepstin.ca>
In-Reply-To: <20180817163442.10065-3-calvin.walton@kepstin.ca>
From:   Len Brown <lenb@kernel.org>
Date:   Wed, 20 Mar 2019 19:36:55 -0400
Message-ID: <CAJvTdKmXSQyY-Jdv7OkseHEE-76oDPLeJ8v8ShApDRKqWsukSQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] [WIP] tools/power turbostat: Also read package
 power on AMD F17h (Zen)
To:     Calvin Walton <calvin.walton@kepstin.ca>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Calvin,
I'm inclined to apply this -- because it will not break anything,
and it would at least enable testing by people, who have this hardware.

thoughts?
-Len

On Fri, Aug 17, 2018 at 12:35 PM Calvin Walton <calvin.walton@kepstin.ca> wrote:
>
> The package power can also be read from an MSR. It's not clear exactly
> what is included, and whether it's aggregated over all nodes or
> reported separately.
>
> It does look like this is reported separately per CCX (I get a single
> value on the Ryzen R7 1700), but it might be reported separately per-
> die (node?) on larger processors. If that's the case, it would have to
> be recorded per node and aggregated for the socket.
>
> Note that although Zen has these MSRs reporting power, it looks like
> the actual RAPL configuration (power limits, configured TDP) is done
> through PCI configuration space. I have not yet found any public
> documentation for this.
>
> Signed-off-by: Calvin Walton <calvin.walton@kepstin.ca>
> ---
>  tools/power/x86/turbostat/turbostat.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index 89d4e2e75774..675c894b8595 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -1973,6 +1973,11 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
>                         return -16;
>                 p->rapl_dram_perf_status = msr & 0xFFFFFFFF;
>         }
> +       if (do_rapl & RAPL_AMD_F17H) {
> +               if (get_msr(cpu, MSR_PKG_ENERGY_STAT, &msr))
> +                       return -13;
> +               p->energy_pkg = msr & 0xFFFFFFFF;
> +       }
>         if (DO_BIC(BIC_PkgTmp)) {
>                 if (get_msr(cpu, MSR_IA32_PACKAGE_THERM_STATUS, &msr))
>                         return -17;
> @@ -3986,10 +3991,13 @@ void rapl_probe_amd(unsigned int family, unsigned int model)
>         switch (family) {
>         case 0x17: /* Zen, Zen+ */
>                 do_rapl = RAPL_AMD_F17H | RAPL_PER_CORE_ENERGY;
> -               if (rapl_joules)
> +               if (rapl_joules) {
> +                       BIC_PRESENT(BIC_Pkg_J);
>                         BIC_PRESENT(BIC_Cor_J);
> -               else
> +               } else {
> +                       BIC_PRESENT(BIC_PkgWatt);
>                         BIC_PRESENT(BIC_CorWatt);
> +               }
>                 break;
>         default:
>                 return;
> --
> 2.18.0
>


-- 
Len Brown, Intel Open Source Technology Center
