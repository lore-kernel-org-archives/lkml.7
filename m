Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E245C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 669832070B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbfHSPrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 11:47:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48562 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728001AbfHSPrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:47:32 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EF00611A04
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 15:47:31 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id u21so661732wml.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 08:47:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2BwM2gt3XIGDnUE55uPuC8VdXnMb+eICOKFQy2JHSEs=;
        b=J88LXLjQCfXEaeraN2LLtJlNDNGXCfx8jGezHWzSD98uYrch5ZE56ZeRM+xGdiZuHj
         5+rHnnsrhIlp4mixgNs9618vSlRHmDL41sKl6em++eaD1eqeJy5fUv5WfIVpQJYNHSQT
         TjDxjeH6GvQsrZjwzdVXW94FnS+0SEabgq7B6JJvxR4zmBg+dclCUbv4XD9hfkhhmbuH
         Ctd8D/Pnm1wQ7rnJCG7n5mYSAT8sZYn+Z30jtH+IQwaGwKH4k7SeTOThFf7D5DRkGctM
         RWSOtEG5MnrEZ3TK2jnS8lZhusYdqYXvXlVq3Hb2ejIPD/ay6GP1BWJmM89KbiBXKEdi
         vlKw==
X-Gm-Message-State: APjAAAVU7DZKEedKEgz2n3hcOa9WYjZiH7+0Beraxgfiv1acTrJQCFJI
        8MKtQ5x6wKCugVWzGOMXbg54hOpO+Yf+fxQONW7Za3XyQCrepE+qZzGISnByAOKU1Fh2Yknmtgs
        YNr3o1DuCNdGt2G5APgA4rxDN
X-Received: by 2002:a5d:554e:: with SMTP id g14mr14753994wrw.68.1566229650310;
        Mon, 19 Aug 2019 08:47:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyGMz2v0XkLO/bFG03vaFvUHs7obmKDn0vgSAOYGGIjh7PUOHC2RWmyZLFjgAEMZj4po38oyQ==
X-Received: by 2002:a5d:554e:: with SMTP id g14mr14753954wrw.68.1566229650010;
        Mon, 19 Aug 2019 08:47:30 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8033:56b6:f047:ba4f? ([2001:b07:6468:f312:8033:56b6:f047:ba4f])
        by smtp.gmail.com with ESMTPSA id o11sm13245215wmh.46.2019.08.19.08.47.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2019 08:47:29 -0700 (PDT)
Subject: Re: [PATCH] KVM: VMX: Fix and tweak the comments for VM-Enter
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190815200931.18260-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <aa33f0e1-e999-08b0-8826-0b88f4681561@redhat.com>
Date:   Mon, 19 Aug 2019 17:47:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815200931.18260-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/19 22:09, Sean Christopherson wrote:
> Fix an incorrect/stale comment regarding the vmx_vcpu pointer, as guest
> registers are now loaded using a direct pointer to the start of the
> register array.
> 
> Opportunistically add a comment to document why the vmx_vcpu pointer is
> needed, its consumption via 'call vmx_update_host_rsp' is rather subtle.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/vmx/vmenter.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
> index 4010d519eb8c..751a384c2eb0 100644
> --- a/arch/x86/kvm/vmx/vmenter.S
> +++ b/arch/x86/kvm/vmx/vmenter.S
> @@ -94,7 +94,7 @@ ENDPROC(vmx_vmexit)
>  
>  /**
>   * __vmx_vcpu_run - Run a vCPU via a transition to VMX guest mode
> - * @vmx:	struct vcpu_vmx *
> + * @vmx:	struct vcpu_vmx * (forwarded to vmx_update_host_rsp)
>   * @regs:	unsigned long * (to guest registers)
>   * @launched:	%true if the VMCS has been launched
>   *
> @@ -151,7 +151,7 @@ ENTRY(__vmx_vcpu_run)
>  	mov VCPU_R14(%_ASM_AX), %r14
>  	mov VCPU_R15(%_ASM_AX), %r15
>  #endif
> -	/* Load guest RAX.  This kills the vmx_vcpu pointer! */
> +	/* Load guest RAX.  This kills the @regs pointer! */
>  	mov VCPU_RAX(%_ASM_AX), %_ASM_AX
>  
>  	/* Enter guest mode */
> 

Queued, thanks.

Paolo
