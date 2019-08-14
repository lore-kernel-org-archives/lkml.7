Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA54C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39FA62083B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfHNMlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 08:41:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40246 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfHNMly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 08:41:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id c3so2694143wrd.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 05:41:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7qa+OQc+EfgC/AsxQHiSyd8uUAoFVOGXxd9MGXVO4gQ=;
        b=JJabtwVSSLGSiBooC+jN2PvAnzqFadg5gX/oPY/gDt6C8MgcdZiUq131kv7va6Jxyp
         eP239f+qmBUGnK72WTD9CuD/Vaw/H4WvMbRU4KQKJbHZFCiOJCKbZBZJnwppNdb7SKBi
         dvwdyTMQ4x8J0FbMBcHmitpQ39DYiet1/2gaPrjTzX01JKayrxz4j2371hJsFB6gRwyt
         IiIYv8U1RnGsuvtpvTeR/rkxbcwpPUZwveeWwfSuJlcFqOW5a6oLsYMr8U6rPlxrMMft
         +tyvl8DErmJTnpckbjC7J0abNBKoKE9JtRw0tSlyeoJ2PWu5NG0cnZJtxtQr6RKZ3VUV
         GFaQ==
X-Gm-Message-State: APjAAAX1PaYgFwIaBIrHMBXKN102vYGpaSPF6QgmyScXq6lhN18Dk+4F
        Q2Fozn20hxQzRvCx5SQxUU87lQ==
X-Google-Smtp-Source: APXvYqyFfdmqgMJPuWJLiLxbPu3wBmT00xVThG/XUqZUJSxYCcYrkDMswuc970cUCzcCLjdzY5jv+w==
X-Received: by 2002:a5d:528d:: with SMTP id c13mr51718475wrv.247.1565786512550;
        Wed, 14 Aug 2019 05:41:52 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id a26sm3507255wmg.45.2019.08.14.05.41.51
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 05:41:51 -0700 (PDT)
Subject: Re: [PATCH] KVM : remove redundant assignment of var new_entry
To:     Miaohe Lin <linmiaohe@huawei.com>, joro@8bytes.org,
        rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mingfangsen@huawei.com
References: <20190812023300.20153-1-linmiaohe@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ce3a477a-d323-32ce-b950-470e50e0811d@redhat.com>
Date:   Wed, 14 Aug 2019 14:41:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190812023300.20153-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/08/19 04:33, Miaohe Lin wrote:
> new_entry is reassigned a new value next line. So
> it's redundant and remove it.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  arch/x86/kvm/svm.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index d685491fce4d..e3d3b2128f2b 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -1714,7 +1714,6 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
>  	if (!entry)
>  		return -EINVAL;
>  
> -	new_entry = READ_ONCE(*entry);
>  	new_entry = __sme_set((page_to_phys(svm->avic_backing_page) &
>  			      AVIC_PHYSICAL_ID_ENTRY_BACKING_PAGE_MASK) |
>  			      AVIC_PHYSICAL_ID_ENTRY_VALID_MASK);
> 

Queued, thanks.

Paolo
