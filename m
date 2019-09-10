Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478B8C49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 17:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 235CB2168B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 17:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394233AbfIJROL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 13:14:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43254 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394158AbfIJROL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 13:14:11 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9B73E11A28
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 17:14:10 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id t185so134209wmg.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 10:14:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BCqrYLSI1x2vXUSlIGEoq1ChjiQwc4Zws90ZJqi8ccI=;
        b=m9MdEcOqWaVCj5tiYbN90vDM8yEWBOTbUwYJY7KH7mFqGl7yuH5/NS+h+h8b6gt9mf
         xX2KQcbhb/6AoyN4kNLhl+pFcykDXoSOaNpNc2g7W/gEJvTV1Q5Si6QPUYyYCKdbdSJp
         2XnuKS65+GEuJZGWpF/qcMdMhf7as9T/Rk3nBfs701jk3AZLRGd9BXusMkfInlS8Wl3Q
         WiODeRV4uOnlscF45QJOej7YQGu5eC9zDlb8QeinQbyfGdL+ij5H6hf7JY+jl5wm98hO
         RMUVNdCcppGS2Phi4cvz5V8GENJ52UQxEXHwOmR/l+HQFqx1VS75kj9yRYOxIiK8dVl1
         aAmw==
X-Gm-Message-State: APjAAAWygQPyiEJw9x109uo3+l7RO3zxhuZy32p2qmIkoKt9GYuCOrjm
        Tx8o+kQHuQyYcIpdAFpOZHstAN7RouOFMcPIGedlqFYYAEr2H/o6nvFsEjUrcD24ns8t1/U+dTm
        gcS61S0l4AlVXOg9+j71SrXkd
X-Received: by 2002:adf:ec49:: with SMTP id w9mr21262645wrn.130.1568135649157;
        Tue, 10 Sep 2019 10:14:09 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwxuHBW8Sghnoq2IMRwlRuvA2mK/kxks8RiqabkQT0RFMAX/1ZPWVVqWjntSC5HdNc7inQLdg==
X-Received: by 2002:adf:ec49:: with SMTP id w9mr21262621wrn.130.1568135648872;
        Tue, 10 Sep 2019 10:14:08 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1435:25df:c911:3338? ([2001:b07:6468:f312:1435:25df:c911:3338])
        by smtp.gmail.com with ESMTPSA id l1sm21635551wrb.1.2019.09.10.10.14.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2019 10:14:08 -0700 (PDT)
Subject: Re: [PATCH v3] doc: kvm: Fix return description of KVM_SET_MSRS
To:     Xiaoyao Li <xiaoyao.li@intel.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190905005737.131067-1-xiaoyao.li@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <0f4d8b77-2c42-f5b5-1cba-9cc26c5fd935@redhat.com>
Date:   Tue, 10 Sep 2019 19:14:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190905005737.131067-1-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/19 02:57, Xiaoyao Li wrote:
> Userspace can use ioctl KVM_SET_MSRS to update a set of MSRs of guest.
> This ioctl set specified MSRs one by one. If it fails to set an MSR,
> e.g., due to setting reserved bits, the MSR is not supported/emulated by
> KVM, etc..., it stops processing the MSR list and returns the number of
> MSRs have been set successfully.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>

Queued, thanks.

Paolo

> ---
> v3:
>   refine the description based on Sean's comment.  
> 
> v2:
>   elaborate the changelog and description of ioctl KVM_SET_MSRS based on
>   Sean's comments.
> ---
>  Documentation/virt/kvm/api.txt | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/virt/kvm/api.txt b/Documentation/virt/kvm/api.txt
> index 2d067767b617..24541e52e96e 100644
> --- a/Documentation/virt/kvm/api.txt
> +++ b/Documentation/virt/kvm/api.txt
> @@ -586,7 +586,7 @@ Capability: basic
>  Architectures: x86
>  Type: vcpu ioctl
>  Parameters: struct kvm_msrs (in)
> -Returns: 0 on success, -1 on error
> +Returns: number of msrs successfully set (see below), -1 on error
>  
>  Writes model-specific registers to the vcpu.  See KVM_GET_MSRS for the
>  data structures.
> @@ -595,6 +595,11 @@ Application code should set the 'nmsrs' member (which indicates the
>  size of the entries array), and the 'index' and 'data' members of each
>  array entry.
>  
> +It tries to set the MSRs in array entries[] one by one. If setting an MSR
> +fails, e.g., due to setting reserved bits, the MSR isn't supported/emulated
> +by KVM, etc..., it stops processing the MSR list and returns the number of
> +MSRs that have been set successfully.
> +
>  
>  4.20 KVM_SET_CPUID
>  
> 

