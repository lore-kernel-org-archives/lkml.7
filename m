Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4729CC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 17:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 259CD2053B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 17:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730874AbfIQRSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 13:18:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45570 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbfIQRSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 13:18:37 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 536293680A
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 17:18:36 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id f10so1124332wmh.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 10:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CzdzjDs1PS5s1r26tWjnHvjUliGuiGe3yhX4kLQL7+c=;
        b=n8a+Xi5Nxrun1KF+AtgWuNI5plc+1rJzo7dea5z+HhLXeMOye6iOQMd9I9IL4pWurh
         7cimocsaYZwRrPJQrRhYnqNrRipcrAdgWGcXvnZzMbicubtpcfHeg+uMN1HZqfjFhkk0
         mVpuwZPbLTXeZkJZEzrgguId7CtV4MsRvpbj4GUKqZCbpbVy2JdxYFnmMFlmzwigm7WT
         fDlSKYy/NldYFHLjxlS+sUevYqtxR+D5Oo+ZdcAUGwUwZ+6T6CHiolhJegeztuyXzqRh
         ETD+l82085TBxs6AbYhFmGHluSjK/EhwUC802O+JFQAT+fu3QjWL4uEpcf0qGpsOmAfD
         MGMA==
X-Gm-Message-State: APjAAAWnr1H/NLPT5Ue/SCrdPwfaOefrr6i1U1oNLktywwWH8grIgB3R
        gYU1hYXNVn9+//xYCCWN/1ZkQRb8mQmv5/3Cq/myoRXE3NYFPAUpkhdSUFYkcn4gOmpgT6q3Y79
        6Y1W7Bihufm0j7wEUup75Q25V
X-Received: by 2002:a05:600c:2052:: with SMTP id p18mr4341224wmg.13.1568740714968;
        Tue, 17 Sep 2019 10:18:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyZJ8SQPxCUeDeSltgjjv/+2lWN6pyzNKs4z2B/WxLTQIkeThwpFZrZjf+Y9TYVkv4mFihBKg==
X-Received: by 2002:a05:600c:2052:: with SMTP id p18mr4341206wmg.13.1568740714697;
        Tue, 17 Sep 2019 10:18:34 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c46c:2acb:d8d2:21d8? ([2001:b07:6468:f312:c46c:2acb:d8d2:21d8])
        by smtp.gmail.com with ESMTPSA id s12sm4981466wra.82.2019.09.17.10.18.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2019 10:18:34 -0700 (PDT)
Subject: Re: [PATCH] kvm: x86: Use DEFINE_DEBUGFS_ATTRIBUTE for debugfs files
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        up2wing@gmail.com, wang.liang82@zte.com.cn,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1563780839-14739-1-git-send-email-wang.yi59@zte.com.cn>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <31eec57f-2bc8-0ea0-e5fb-6b21ce902aae@redhat.com>
Date:   Tue, 17 Sep 2019 19:18:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1563780839-14739-1-git-send-email-wang.yi59@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/07/19 09:33, Yi Wang wrote:
> We got these coccinelle warning:
> ./arch/x86/kvm/debugfs.c:23:0-23: WARNING: vcpu_timer_advance_ns_fops
> should be defined with DEFINE_DEBUGFS_ATTRIBUTE
> ./arch/x86/kvm/debugfs.c:32:0-23: WARNING: vcpu_tsc_offset_fops should
> be defined with DEFINE_DEBUGFS_ATTRIBUTE
> ./arch/x86/kvm/debugfs.c:41:0-23: WARNING: vcpu_tsc_scaling_fops should
> be defined with DEFINE_DEBUGFS_ATTRIBUTE
> ./arch/x86/kvm/debugfs.c:49:0-23: WARNING: vcpu_tsc_scaling_frac_fops
> should be defined with DEFINE_DEBUGFS_ATTRIBUTE
> 
> Use DEFINE_DEBUGFS_ATTRIBUTE() rather than DEFINE_SIMPLE_ATTRIBUTE()
> to fix this.
> 
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>

It sucks though that you have to use a function with "unsafe" in the name.

Greg, is the patch doing the right thing?

Paolo

> ---
>  arch/x86/kvm/debugfs.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kvm/debugfs.c b/arch/x86/kvm/debugfs.c
> index 329361b..24016fb 100644
> --- a/arch/x86/kvm/debugfs.c
> +++ b/arch/x86/kvm/debugfs.c
> @@ -20,7 +20,7 @@ static int vcpu_get_timer_advance_ns(void *data, u64 *val)
>  	return 0;
>  }
>  
> -DEFINE_SIMPLE_ATTRIBUTE(vcpu_timer_advance_ns_fops, vcpu_get_timer_advance_ns, NULL, "%llu\n");
> +DEFINE_DEBUGFS_ATTRIBUTE(vcpu_timer_advance_ns_fops, vcpu_get_timer_advance_ns, NULL, "%llu\n");
>  
>  static int vcpu_get_tsc_offset(void *data, u64 *val)
>  {
> @@ -29,7 +29,7 @@ static int vcpu_get_tsc_offset(void *data, u64 *val)
>  	return 0;
>  }
>  
> -DEFINE_SIMPLE_ATTRIBUTE(vcpu_tsc_offset_fops, vcpu_get_tsc_offset, NULL, "%lld\n");
> +DEFINE_DEBUGFS_ATTRIBUTE(vcpu_tsc_offset_fops, vcpu_get_tsc_offset, NULL, "%lld\n");
>  
>  static int vcpu_get_tsc_scaling_ratio(void *data, u64 *val)
>  {
> @@ -38,7 +38,7 @@ static int vcpu_get_tsc_scaling_ratio(void *data, u64 *val)
>  	return 0;
>  }
>  
> -DEFINE_SIMPLE_ATTRIBUTE(vcpu_tsc_scaling_fops, vcpu_get_tsc_scaling_ratio, NULL, "%llu\n");
> +DEFINE_DEBUGFS_ATTRIBUTE(vcpu_tsc_scaling_fops, vcpu_get_tsc_scaling_ratio, NULL, "%llu\n");
>  
>  static int vcpu_get_tsc_scaling_frac_bits(void *data, u64 *val)
>  {
> @@ -46,20 +46,20 @@ static int vcpu_get_tsc_scaling_frac_bits(void *data, u64 *val)
>  	return 0;
>  }
>  
> -DEFINE_SIMPLE_ATTRIBUTE(vcpu_tsc_scaling_frac_fops, vcpu_get_tsc_scaling_frac_bits, NULL, "%llu\n");
> +DEFINE_DEBUGFS_ATTRIBUTE(vcpu_tsc_scaling_frac_fops, vcpu_get_tsc_scaling_frac_bits, NULL, "%llu\n");
>  
>  int kvm_arch_create_vcpu_debugfs(struct kvm_vcpu *vcpu)
>  {
>  	struct dentry *ret;
>  
> -	ret = debugfs_create_file("tsc-offset", 0444,
> +	ret = debugfs_create_file_unsafe("tsc-offset", 0444,
>  							vcpu->debugfs_dentry,
>  							vcpu, &vcpu_tsc_offset_fops);
>  	if (!ret)
>  		return -ENOMEM;
>  
>  	if (lapic_in_kernel(vcpu)) {
> -		ret = debugfs_create_file("lapic_timer_advance_ns", 0444,
> +		ret = debugfs_create_file_unsafe("lapic_timer_advance_ns", 0444,
>  								vcpu->debugfs_dentry,
>  								vcpu, &vcpu_timer_advance_ns_fops);
>  		if (!ret)
> @@ -67,12 +67,12 @@ int kvm_arch_create_vcpu_debugfs(struct kvm_vcpu *vcpu)
>  	}
>  
>  	if (kvm_has_tsc_control) {
> -		ret = debugfs_create_file("tsc-scaling-ratio", 0444,
> +		ret = debugfs_create_file_unsafe("tsc-scaling-ratio", 0444,
>  							vcpu->debugfs_dentry,
>  							vcpu, &vcpu_tsc_scaling_fops);
>  		if (!ret)
>  			return -ENOMEM;
> -		ret = debugfs_create_file("tsc-scaling-ratio-frac-bits", 0444,
> +		ret = debugfs_create_file_unsafe("tsc-scaling-ratio-frac-bits", 0444,
>  							vcpu->debugfs_dentry,
>  							vcpu, &vcpu_tsc_scaling_frac_fops);
>  		if (!ret)
> 

