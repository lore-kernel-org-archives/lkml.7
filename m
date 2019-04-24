Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17427C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F06218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbfDXJHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:07:25 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51906 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbfDXJHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:07:25 -0400
Received: by mail-wm1-f66.google.com with SMTP id 4so3590205wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 02:07:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rz+GYtqgldMYK3PobWaTcPCrbBeBFXQ6BGTMl9sOxPg=;
        b=KV6eCR5C34Qy4NTGpVpvM3O/pDWDOjx3fKJo5cIqcTl3fJyJjbWTsRjYPoZXLpfoWq
         D2bT5V3GvY/0vWInZgGkGWwbSMdzAo/AbZ475nJ9KDXRFx3mk9glhFdwZqAn2kkrqi4G
         rW60oixM6+0ZYtn8wucXj5TjCSPe5Zv+oi1csUD/bpj5FkTl+qEy9mZtvo2KHjqQCqf8
         H665MNgWVk7XYG0rvuJukrsOf+ifEd3xF+ChVpkpsP8ytNw2sj5ORpsK6OZzHIaqPydy
         4nSJwb5FRYFds7nYRBf7o+jAoZexIOfo9OXEBILnyhSRZkeRogWvxa3CPMjWFYEGgzGI
         T4Aw==
X-Gm-Message-State: APjAAAXDs0nEDRXaWOsgC9+xPO5Z34TsCG4Hn5/rMKL+sQxWXbUdKRtR
        IvkqZU8op3erhrChoJXHozE8BpStv+09l316Da4=
X-Google-Smtp-Source: APXvYqzsl5BIWuGViFFuJJRMhJ+DXwESY4sG0eIl63gl9NTqJyTh80rU9Vs0h5ATXckFig1qe8FzAj71BO60OcC5DdE=
X-Received: by 2002:a1c:3845:: with SMTP id f66mr5385802wma.97.1556096843472;
 Wed, 24 Apr 2019 02:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190424000227.3085-1-atish.patra@wdc.com> <20190424000227.3085-2-atish.patra@wdc.com>
In-Reply-To: <20190424000227.3085-2-atish.patra@wdc.com>
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Wed, 24 Apr 2019 10:07:12 +0100
Message-ID: <CAPKp9uZNEdL=Jt7vsxMBo72WR=ArefB6Vi7fLxnxMwAfUT3JOw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] RISC-V: Add RISC-V specific arch_match_cpu_phys_id
To:     Atish Patra <atish.patra@wdc.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Johan Hovold <johan@kernel.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 1:03 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> OF/DT core has a hook for architecture specific logical cpuid to hartid
> mapping. By implementing this, we can pass the logical cpu id to cpu
> node parsing functions.
>
> Fix the instances where logical cpuid is expected as an argument in
> of_get_cpu_node.
>

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/kernel/cpu.c | 3 +--
>  arch/riscv/kernel/smp.c | 5 +++++
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index cf2fca12414a..c8d2a3223099 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -136,8 +136,7 @@ static void c_stop(struct seq_file *m, void *v)
>  static int c_show(struct seq_file *m, void *v)
>  {
>         unsigned long cpu_id = (unsigned long)v - 1;
> -       struct device_node *node = of_get_cpu_node(cpuid_to_hartid_map(cpu_id),
> -                                                  NULL);

I assume it work working just fine as you are doing cpu to hartid
conversion here and
weak implementation of arch_match_cpu_phys_id does direct match.

> +       struct device_node *node = of_get_cpu_node(cpu_id, NULL);
>         const char *compat, *isa, *mmu;
>
>         seq_printf(m, "processor\t: %lu\n", cpu_id);
> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> index 0c41d07ec281..94db72662f60 100644
> --- a/arch/riscv/kernel/smp.c
> +++ b/arch/riscv/kernel/smp.c
> @@ -70,6 +70,11 @@ void riscv_cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out)
>         for_each_cpu(cpu, in)
>                 cpumask_set_cpu(cpuid_to_hartid_map(cpu), out);
>  }
> +
> +bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
> +{
> +       return phys_id == cpuid_to_hartid_map(cpu);
> +}
>  /* Unsupported */
>  int setup_profiling_timer(unsigned int multiplier)
>  {
> --
> 2.21.0
>
