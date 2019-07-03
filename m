Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138CBC06513
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA86B218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbfGCOO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:14:26 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39239 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfGCOO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:14:26 -0400
Received: by mail-wm1-f65.google.com with SMTP id z23so2580219wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 07:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WEU9J4f4LicY5+G8hi8mfSV2AgtX7u94Zg0dhqNyNTY=;
        b=NtxZZ137IiBpNdHB6ZWz/ZYhD98kGDXsrJwGEdHb2iYtjX9CG1I9iwtOIbOozfWifH
         NAru6OC/3kPwsEtS5IKAYITxjoHIFQR+h2ZaAmnn0C1R1F+WNLHyBZdwe6JV9rsX0cjF
         Q28OspJjqJGA6s1JSA5MwMJ8K6+/eGFHxbIcRR/5xzQfYpOMlQBRL20WjrU9qhcZYm+Q
         Tpu72CFe0cVXWhILLEHEm9LTfDe9lcTK5hplSXOan/Q7uQJrHIxbF4F8YNMTlOlrqg4x
         5sAzUM4hf2iuJY0SHTOttKrnjCjVOP8i+KoWaG/Nj3QSZLjn2uajewl69oLyT5gMVGBL
         culQ==
X-Gm-Message-State: APjAAAWl0woSPllA25Pl974gvIJBpdfRqzKIXTHliDUufA5/MGwvt9u5
        E3dXkNL8fpGdN7uj2lIBh8WIsw==
X-Google-Smtp-Source: APXvYqxWJTH50ot0zo+dXmDmM1jQCcRtivVoVxZbuVBIWGJ9ZjIgNO8eZw3CTYU6sbPTVLyKRiVoDw==
X-Received: by 2002:a1c:770d:: with SMTP id t13mr8092226wmi.79.1562163263930;
        Wed, 03 Jul 2019 07:14:23 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:6c1d:63cc:b81d:e1a9? ([2001:b07:6468:f312:6c1d:63cc:b81d:e1a9])
        by smtp.gmail.com with ESMTPSA id q7sm1819496wrx.6.2019.07.03.07.14.23
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 07:14:23 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] KVM: LAPIC: remove the trailing newline used in
 the fmt parameter of TP_printk
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <1560474949-20497-1-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b76ce740-69ea-c290-28f8-d2d8a683bdbd@redhat.com>
Date:   Wed, 3 Jul 2019 16:14:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1560474949-20497-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/19 03:15, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> The trailing newlines will lead to extra newlines in the trace file
> which looks like the following output, so remove it.
> 
> qemu-system-x86-15695 [002] ...1 15774.839240: kvm_hv_timer_state: vcpu_id 0 hv_timer 1
> 
> qemu-system-x86-15695 [002] ...1 15774.839309: kvm_hv_timer_state: vcpu_id 0 hv_timer 1
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/kvm/trace.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
> index 4d47a26..b5c831e 100644
> --- a/arch/x86/kvm/trace.h
> +++ b/arch/x86/kvm/trace.h
> @@ -1365,7 +1365,7 @@ TRACE_EVENT(kvm_hv_timer_state,
>  			__entry->vcpu_id = vcpu_id;
>  			__entry->hv_timer_in_use = hv_timer_in_use;
>  			),
> -		TP_printk("vcpu_id %x hv_timer %x\n",
> +		TP_printk("vcpu_id %x hv_timer %x",
>  			__entry->vcpu_id,
>  			__entry->hv_timer_in_use)
>  );
> 

Queued 2/2, thanks.

Paolo
