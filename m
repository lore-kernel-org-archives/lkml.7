Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5921FC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 13:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB7A21D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 13:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391568AbfIYNbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 09:31:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40866 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391511AbfIYNbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 09:31:33 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 95616C05AA52
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 13:31:32 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id 4so2064245wmj.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 06:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1HbTRgs4ZwTBdvJESliM5GK5A8G5L+4nogU+I4sznOA=;
        b=GvlazequDB3s8ei9743LhT2P42XdWqaBsFKCDvbTUquxZ0/fC70TcvuH4J3+Lwtcp2
         d7IutmuKf5SCLo2oXvyqvn9Pq/lVi5083HF/RLjJ7l/TYC7fFONWRYzD6URKg2ApCARi
         BGu84PaO3Kuqw0d6tznj+l8jz/rZRWM5nCvjoAXM4et5IA0zf12DGLQQm/0k64kksB7s
         Mg/EaWuZ7fEie3G9kjcuKshkQTfmjGg1CBPy0QW96aBUm0ELzALrM8eA8czfS4rCmD7f
         tRUMw2idAgQdF+ykmN+//pKpG8bgWNozxNhldTjcbe18NIYoI4n8SK7sOsIvmUbbyEKQ
         taow==
X-Gm-Message-State: APjAAAV4Cb1+Tf7deE6vhwoRQLbgd/HROHIpUPGV+x8RiQuwYAnaMywt
        l9ysWZgGNGhRBFRCVN3xqAbqV0wk7lwahENtq1RlOUsn8d/4lZrcp4Yht4bKHnNrhkEc6JkN3nc
        /ry0s56cdxRZpT8yX32Uz6Hyi
X-Received: by 2002:adf:e392:: with SMTP id e18mr9131927wrm.87.1569418291259;
        Wed, 25 Sep 2019 06:31:31 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwAwrqt6cqOZT+pbnFbG1k738GvnZ33vFNLMbkxyi7H/nPq5zKKsf7SGWlbYT53E8q7HgKA0A==
X-Received: by 2002:adf:e392:: with SMTP id e18mr9131904wrm.87.1569418290977;
        Wed, 25 Sep 2019 06:31:30 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36? ([2001:b07:6468:f312:9520:22e6:6416:5c36])
        by smtp.gmail.com with ESMTPSA id g185sm6562186wme.10.2019.09.25.06.31.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2019 06:31:30 -0700 (PDT)
Subject: Re: [PATCH v2] KVM: vmx: fix build warnings in
 hv_enable_direct_tlbflush() on i386
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
References: <20190925133035.7576-1-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ed9d9b67-0d2b-fc08-e5f3-5a8dcca0ef1c@redhat.com>
Date:   Wed, 25 Sep 2019 15:31:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190925133035.7576-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/19 15:30, Vitaly Kuznetsov wrote:
> The following was reported on i386:
> 
>   arch/x86/kvm/vmx/vmx.c: In function 'hv_enable_direct_tlbflush':
>   arch/x86/kvm/vmx/vmx.c:503:10: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
> 
> pr_debugs() in this function are  more or less useless, let's just
> remove them. evmcs->hv_vm_id can use 'unsigned long' instead of 'u64'.
> 
> Also, simplify the code a little bit.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index a7c9922e3905..d5b978068209 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -495,23 +495,19 @@ static int hv_enable_direct_tlbflush(struct kvm_vcpu *vcpu)
>  	 * Synthetic VM-Exit is not enabled in current code and so All
>  	 * evmcs in singe VM shares same assist page.
>  	 */
> -	if (!*p_hv_pa_pg) {
> +	if (!*p_hv_pa_pg)
>  		*p_hv_pa_pg = kzalloc(PAGE_SIZE, GFP_KERNEL);
> -		if (!*p_hv_pa_pg)
> -			return -ENOMEM;
> -		pr_debug("KVM: Hyper-V: allocated PA_PG for %llx\n",
> -		       (u64)&vcpu->kvm);
> -	}
> +
> +	if (!*p_hv_pa_pg)
> +		return -ENOMEM;
>  
>  	evmcs = (struct hv_enlightened_vmcs *)to_vmx(vcpu)->loaded_vmcs->vmcs;
>  
>  	evmcs->partition_assist_page =
>  		__pa(*p_hv_pa_pg);
> -	evmcs->hv_vm_id = (u64)vcpu->kvm;
> +	evmcs->hv_vm_id = (unsigned long)vcpu->kvm;
>  	evmcs->hv_enlightenments_control.nested_flush_hypercall = 1;
>  
> -	pr_debug("KVM: Hyper-V: enabled DIRECT flush for %llx\n",
> -		 (u64)vcpu->kvm);
>  	return 0;
>  }
>  
> 

Queued, thanks.

Paolo
