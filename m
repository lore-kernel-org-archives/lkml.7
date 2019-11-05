Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7788C49EAB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C9522190F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388455AbfKEKQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 05:16:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54662 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388252AbfKEKQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 05:16:49 -0500
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0CAFA85365
        for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2019 10:16:48 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id l3so3626646wrx.21
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 02:16:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6YtyP3d7GKpXhJ6iYMKzsdpoIP+eq3/ULbzl9sQyXQs=;
        b=nq1RtvZui1Elq00nusWoSbrHGUHJcxz4swVlkWMPPhfbXNzgOk9l4Pl8FL1OqK7JOT
         l1T88yBofU/Rlmc/4E3UZG096dT/laxOEFJ3CBahz2ZFi54RlbiSQZNG4gBMohzt8KJX
         N2dO1gO30qLwZ3j8gyjGYJJyRimwld/c1iMGTEUZYJz9BpeDMhxDrxxyYZ5+kt72hTde
         7Pzqijl94ldKv/8JWzhcxiuliEES5cbt4EweErW3MqzqV3Bk9tMuaQZa9Sl1h9wmNOwU
         1qs07aH8kyekJ7mLFo2F4gj+wF+HgI/9Hatkj3D3PfvdLOc04Uvv5oKa294EyH9HHMud
         zFQQ==
X-Gm-Message-State: APjAAAWnmIdb/cye2+tUn3oOtaYHtr1UcSV5nAWl8z1B04vGwoIFGLSz
        G6wouXUoPTA+Vil0PTgJQEdD1mTddmMtcqR0RnKrKH9hD266jPu34fLxdkcTuG91PRT6dQKAtqs
        TCvitkBC9KwZwUXEzOmEsgTJX
X-Received: by 2002:a7b:c444:: with SMTP id l4mr3340048wmi.21.1572949006662;
        Tue, 05 Nov 2019 02:16:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqxSugFwDORDpXlrwFVvaxhfFpS6c5x8NYGUS1Dg05584PC5BTDigbHHMSor4ZJ+ODtZhvK2dg==
X-Received: by 2002:a7b:c444:: with SMTP id l4mr3340025wmi.21.1572949006357;
        Tue, 05 Nov 2019 02:16:46 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:4051:461:136e:3f74? ([2001:b07:6468:f312:4051:461:136e:3f74])
        by smtp.gmail.com with ESMTPSA id s13sm18919608wmc.28.2019.11.05.02.16.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2019 02:16:45 -0800 (PST)
Subject: Re: [PATCH 07/13] KVM: monolithic: x86: remove __init section prefix
 from kvm_x86_cpu_has_kvm_support
To:     Andrea Arcangeli <aarcange@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <20191104230001.27774-1-aarcange@redhat.com>
 <20191104230001.27774-8-aarcange@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <232b6fcf-c441-7d85-00a4-43187e3393a6@redhat.com>
Date:   Tue, 5 Nov 2019 11:16:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191104230001.27774-8-aarcange@redhat.com>
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
> accurate static analysis at build time. This also allows to build
> without CONFIG_SECTION_MISMATCH_WARN_ONLY=n.
> 
> The __init needs to be removed on vmx despite it's only svm calling it
> from kvm_x86_hardware_enable which is eventually called by
> hardware_enable_nolock() or there's a (potentially false positive)
> warning (false positive because this function isn't called in the vmx
> case). If this isn't needed the right cleanup isn't to put it in the
> __init section, but to drop it. As long as it's defined in vmx as a
> kvm_x86 operation, it's expectable that might eventually be called at
> runtime while hot plugging new CPUs.
> 
> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> ---
>  arch/x86/include/asm/kvm_host.h | 4 ++--
>  arch/x86/kvm/vmx/vmx.c          | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 2b03ec80f6d7..2ddc61fdcd09 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -998,7 +998,7 @@ struct kvm_lapic_irq {
>  	bool msi_redir_hint;
>  };
>  
> -extern __init int kvm_x86_cpu_has_kvm_support(void);
> +extern int kvm_x86_cpu_has_kvm_support(void);
>  extern __init int kvm_x86_disabled_by_bios(void);
>  extern int kvm_x86_hardware_enable(void);
>  extern void kvm_x86_hardware_disable(void);
> @@ -1190,7 +1190,7 @@ extern bool kvm_x86_apic_init_signal_blocked(struct kvm_vcpu *vcpu);
>  extern int kvm_x86_enable_direct_tlbflush(struct kvm_vcpu *vcpu);
>  
>  struct kvm_x86_ops {
> -	int (*cpu_has_kvm_support)(void);          /* __init */
> +	int (*cpu_has_kvm_support)(void);
>  	int (*disabled_by_bios)(void);             /* __init */
>  	int (*hardware_enable)(void);
>  	void (*hardware_disable)(void);
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index e406707381a4..87e5d7276ea4 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -2178,7 +2178,7 @@ void kvm_x86_cache_reg(struct kvm_vcpu *vcpu, enum kvm_reg reg)
>  	}
>  }
>  
> -__init int kvm_x86_cpu_has_kvm_support(void)
> +int kvm_x86_cpu_has_kvm_support(void)
>  {
>  	return cpu_has_vmx();
>  }
> 

I think we should eliminate all the complications in cpu_has_svm(), so
that svm_hardware_enable can use it.  I'll post a patch.

Paolo
