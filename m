Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B15C49EAB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8C4321929
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbfKEKQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 05:16:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:2985 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388283AbfKEKQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 05:16:23 -0500
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 77B0283F40
        for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2019 10:16:22 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id d140so6999109wmd.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 02:16:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uZAUo/E5wcRqgEhwSboeuriam4SODw3m8iem1VMN08Q=;
        b=VVE8hzM5c8Yo1L0BuRRWzoI9gwY6VgXX5it11mtWIQR+HSjcQemCKuNF0CBwYMUtw/
         iKEwdb3XdKsVOPXJulhyc3YCfjxX1H8Vhzw/mnzJIVbH6qqkv5hW0lKMXgmGzw04P9uA
         a3YLFEGvoAteZpwc2de2zbLIQIDy6PZnV5LJE4rVT20kSYMyvO+bB2CkihbcyUhBRPgq
         Jxtg2wpQqMHL/h+wjeA2HLKxHrl3ZCMNVBwOxajuHkI6NWtDi1HWjrz1yuWRD8JuGGRQ
         zvn5eQXZBmad58vkFETNHSauPRF2TP6xX/letU4UTw8H/3w4CGGQOgOuohSdNMb7O1uL
         j8sA==
X-Gm-Message-State: APjAAAW2fDGkXNtzDm0ehsXBuMVZ9CRIfw/PPNl9IsiuOf6zUYWV6E9Q
        Jhkk5rFGN50jXbP6Wp05qF9Zmt/avmp6/LV0sOiTRwhOnGLxM6ZnkbGWl0s3vesr6ug9t3AqV35
        U0edPvbAgQ1PxnFmExg4DXg8O
X-Received: by 2002:a1c:a556:: with SMTP id o83mr3277641wme.165.1572948980956;
        Tue, 05 Nov 2019 02:16:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqzyFMQsgBm/VEPGNe2YJOVIorFff0eZiFyatDw2cYmXr4NB9b/QQ3W6fXWBvdvZukVGMHuC7g==
X-Received: by 2002:a1c:a556:: with SMTP id o83mr3277615wme.165.1572948980663;
        Tue, 05 Nov 2019 02:16:20 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:4051:461:136e:3f74? ([2001:b07:6468:f312:4051:461:136e:3f74])
        by smtp.gmail.com with ESMTPSA id b3sm12440889wmj.44.2019.11.05.02.16.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2019 02:16:20 -0800 (PST)
Subject: Re: [PATCH 06/13] KVM: monolithic: x86: remove __exit section prefix
 from machine_unsetup
To:     Andrea Arcangeli <aarcange@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <20191104230001.27774-1-aarcange@redhat.com>
 <20191104230001.27774-7-aarcange@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ccd2b1dc-ab23-2607-6f07-5429e7601282@redhat.com>
Date:   Tue, 5 Nov 2019 11:16:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191104230001.27774-7-aarcange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/19 23:59, Andrea Arcangeli wrote:
> Adjusts the section prefixes of some KVM x86 code function because
> with the monolithic KVM model the section checker can now do a more
> accurate static analysis at build time and it found a potentially
> kernel crashing bug. This also allows to build without
> CONFIG_SECTION_MISMATCH_WARN_ONLY=n.
> 
> The __exit removed from machine_unsetup is because
> kvm_arch_hardware_unsetup() is called by kvm_init() which is in the
> __init section. It's not allowed to call a function located in the
> __exit section and dropped during the kernel link from the __init
> section or the kernel will crash if that call is made.
> 
> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> ---
>  arch/x86/include/asm/kvm_host.h | 4 ++--
>  arch/x86/kvm/svm.c              | 2 +-
>  arch/x86/kvm/vmx/vmx.c          | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index b36dd3265036..2b03ec80f6d7 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1004,7 +1004,7 @@ extern int kvm_x86_hardware_enable(void);
>  extern void kvm_x86_hardware_disable(void);
>  extern __init int kvm_x86_check_processor_compatibility(void);
>  extern __init int kvm_x86_hardware_setup(void);
> -extern __exit void kvm_x86_hardware_unsetup(void);
> +extern void kvm_x86_hardware_unsetup(void);
>  extern bool kvm_x86_cpu_has_accelerated_tpr(void);
>  extern bool kvm_x86_has_emulated_msr(int index);
>  extern void kvm_x86_cpuid_update(struct kvm_vcpu *vcpu);
> @@ -1196,7 +1196,7 @@ struct kvm_x86_ops {
>  	void (*hardware_disable)(void);
>  	int (*check_processor_compatibility)(void);/* __init */
>  	int (*hardware_setup)(void);               /* __init */
> -	void (*hardware_unsetup)(void);            /* __exit */
> +	void (*hardware_unsetup)(void);
>  	bool (*cpu_has_accelerated_tpr)(void);
>  	bool (*has_emulated_msr)(int index);
>  	void (*cpuid_update)(struct kvm_vcpu *vcpu);
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index 1705608246fb..4ce102f6f075 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -1412,7 +1412,7 @@ __init int kvm_x86_hardware_setup(void)
>  	return r;
>  }
>  
> -__exit void kvm_x86_hardware_unsetup(void)
> +void kvm_x86_hardware_unsetup(void)
>  {
>  	int cpu;
>  
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 9c5f0c67b899..e406707381a4 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7737,7 +7737,7 @@ __init int kvm_x86_hardware_setup(void)
>  	return r;
>  }
>  
> -__exit void kvm_x86_hardware_unsetup(void)
> +void kvm_x86_hardware_unsetup(void)
>  {
>  	if (nested)
>  		nested_vmx_hardware_unsetup();
> 

Queued, thanks.

Paolo
