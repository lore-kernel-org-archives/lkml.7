Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D72C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 264B521655
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbfLLOBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:01:53 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:37145 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729567AbfLLOBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 09:01:52 -0500
Received: from mail-qt1-f173.google.com ([209.85.160.173]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N3bGP-1hfdeO18S3-010ZSZ for <linux-kernel@vger.kernel.org>; Thu, 12 Dec
 2019 15:01:51 +0100
Received: by mail-qt1-f173.google.com with SMTP id g17so2315588qtp.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 06:01:51 -0800 (PST)
X-Gm-Message-State: APjAAAWSqAZrBsQ9UD4HBo9CvGM4XmWYrmfqY3SsMOBKvF26xm0oZ8vA
        lEHz0kuFww9625o1H9hefxtlTLAYSHy/O06Yvqc=
X-Google-Smtp-Source: APXvYqzkeOEKDJDD9e0FU+o99pAokx+dAi91wJshp+kRii5ICBk5AliiSF00Tg1aRGR0INJ1C0cMEe+m5Gc1ISGhKoE=
X-Received: by 2002:ac8:768d:: with SMTP id g13mr7485750qtr.7.1576159310220;
 Thu, 12 Dec 2019 06:01:50 -0800 (PST)
MIME-Version: 1.0
References: <20191212135815.4176658-1-arnd@arndb.de>
In-Reply-To: <20191212135815.4176658-1-arnd@arndb.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 12 Dec 2019 15:01:34 +0100
X-Gmail-Original-Message-ID: <CAK8P3a32xAmiJpH0=EFUqbzkJz=MrFzZz1J2n9thqXQUGzRMKA@mail.gmail.com>
Message-ID: <CAK8P3a32xAmiJpH0=EFUqbzkJz=MrFzZz1J2n9thqXQUGzRMKA@mail.gmail.com>
Subject: Re: [PATCH] x86/platform/uv: avoid unused variable warning
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Mike Travis <mike.travis@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Hedi Berriche <hedi.berriche@hpe.com>,
        Justin Ernst <justin.ernst@hpe.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Russ Anderson <russ.anderson@hpe.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:DTL9TI+LraeThV8ca41FrvKST6QYipTVazU1t0HfFsO7HsnsRiB
 HBiosEFylsaB621EPnyZIqa0kM8lzzknQ77uzO5PU5HmFqPQDCQlSr52GQCsMorpOoIFXH/
 3EXPLzoUdhWeLlpsc8XTuhKqCIXULNMqfmGvZgnlzbLb1G8umFaD03qMmRu5IBFH8PbP5LI
 RV6b0BmaRN2mpXGtU9rVA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uYM0kjdZxN0=:XLhZMhzOrBfbsxAFrJJZ3K
 C6+DrEzBm7OcTfCJQkVGJU7M9DCi3ZvcXlBP0O+WmIoayDuALHQUzR4xGcXcvi0HR+noog6Cj
 jecB8svGdvyBsBO4FFiQmMNaAGMMdEYWeC4Ysai0X3BwY+3KGdlpWh4A71gPV65B4pWS+x9Nx
 KVByLoOuoxaPPerP6Ji87ZZ7JaRFx1Omo7IXAx4TEAKdHy+H6kfM3bYelaWc+iJ/gvVOIb8ik
 IJudmEICJx6XvJjcy1zfd2J56Ijh3H+FR9s4WIFA4naT4upYKQgHLg4fRzRuP9L+YMn6alVZ0
 HqMOSo/8gjLn8yrqNt5oHqcbV0O17dckDDlBOYl5URNc3nk8b2a+1TRJ91+RTUMki0DmK5xD8
 pSfkLsJI4jZPrUE3AmzndyOp/eVcp7mcKHTUN6v9pMlaRyyvAQi4qV2gPQnxRS6kUW2BqdcTj
 OHp0n5L9nGJP73IkDXSMXgRlZcbr8ElUqVSqSHrIyne1+0tl/weRvncym7BnnVR07kYdSAJ8e
 qYYA+L8Rfwh3YsHXyPGQ7wKhCGMqcSMgZ3DcqUEnAFhsbG0X8D7epwcrzXrsXhc+F03q9TYE8
 S4Ii/mh6trZypjpHmpkR54hywqNpeANISOytPVZwnvGRKT3obn5FdZNvvAoE3edpBrhbsoilW
 zakw4nY+xYIbj91/Ej8vmnAwfy5GOw4Znvb4YW7hpuMSm6jYlFB2lvOHicQnyfjNebLDfeRZv
 HR6yOhZtbnfykLzdLXuZufJEYFGhgKVylKIQ4ui8BsXQ8k4ZHC9g/tSqO5nBkE336vw8DX68L
 w3i99MEYOlSNPQ3h3RTvvE97yBrk27amk+2SJB0pENXVEWG7YJM0rSmj55s7GLEuQTBDRq5KY
 rsZwLdwSDLFJ3ioFqhsw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 2:58 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> When CONFIG_PROC_FS is disabled, the compiler warns about an
> unused variable:
>
> arch/x86/kernel/apic/x2apic_uv_x.c: In function 'uv_setup_proc_files':
> arch/x86/kernel/apic/x2apic_uv_x.c:1546:8: error: unused variable 'name' [-Werror=unused-variable]
>   char *name = hubless ? "hubless" : "hubbed";
>
> Simplify the code so this variable is no longer needed.
>
> Fixes: 8785968bce1c ("x86/platform/uv: Add UV Hubbed/Hubless Proc FS Files")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I noticed a second too late that this loses the oemid procfs file (annoyingly
I did not get a warning because gcc ignores unused static const variables)

Please wait for v2.

        Arnd
