Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918F3C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 15:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 658CA21721
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 15:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfGBPh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 11:37:58 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:46811 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfGBPh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 11:37:57 -0400
Received: from [10.30.1.20] (lneuilly-657-1-5-103.w81-250.abo.wanadoo.fr [81.250.144.103])
        (Authenticated sender: alex@ghiti.fr)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id A808B24000E;
        Tue,  2 Jul 2019 15:37:39 +0000 (UTC)
Subject: Re: [PATCH v3 1/2] x86, arm64: Move ARCH_WANT_HUGE_PMD_SHARE config
 in arch/Kconfig
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Hanjun Guo <guohanjun@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Will Deacon <will.deacon@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
References: <20190701175900.4034-1-alex@ghiti.fr>
 <20190701175900.4034-2-alex@ghiti.fr>
 <alpine.DEB.2.21.9999.1907011146550.3867@viisi.sifive.com>
From:   Alexandre Ghiti <alex@ghiti.fr>
Message-ID: <8678d648-2ead-61dd-0d03-277e81355fd7@ghiti.fr>
Date:   Tue, 2 Jul 2019 17:37:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.9999.1907011146550.3867@viisi.sifive.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: fr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/19 8:51 PM, Paul Walmsley wrote:
> Catalin, Palmer,
>
> On Mon, 1 Jul 2019, Alexandre Ghiti wrote:
>
>> ARCH_WANT_HUGE_PMD_SHARE config was declared in both architectures:
>> move this declaration in arch/Kconfig and make those architectures
>> select it.
>>
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> Since the change from v2 to v3 was minor (the removal of the "config
> ARCH_WANT_HUGE_PMD_SHARE" line from the arm64 port), I'm planning to
> apply your Reviewed-by:s and acks from
>
> https://lore.kernel.org/linux-riscv/20190603172723.GH63283@arrakis.emea.arm.com/
>
> https://lore.kernel.org/linux-riscv/mhng-4d1d4acb-f65f-4ed4-bc86-85a14b7c3e16@palmer-si-x1e/


Ingo acked this patch too in that case. Sorry for that, I was unsure if 
I could add them.

Thanks for your answer,

Alex


>
> If there's any objection, please let me know as soon as possible.
>
>
> - Paul
