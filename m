Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0F0C04AA7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 05:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5233A2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 05:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfEOFQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 01:16:17 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45244 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfEOFQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 01:16:16 -0400
Received: by mail-pf1-f193.google.com with SMTP id s11so708374pfm.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 22:16:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CaPoBfwvfHYoUlv6FfiwdTonkmXQ3Vz27zElYB+X6NY=;
        b=U8RqSBAfIbiu33ICtqhz9mVFjFwlSwFsaG6ZxcLLUj8287E2qpEjqsNf7+wgsNklOO
         DePkMoL0WQ7/9byZg83otNGNiDzPGD2N26P8tY/Q/t+yr90EhHkERUbVtLRClkbJ02m3
         LaR9sEx8WxfLzPg026gYT4caNU1XPVVhrXx6+r/kHkSXOXy/KrmNlW02RhZNhyldM/Wh
         kRuzRacQUDfYJmhBBEfYPBgpj3tkoMxd8tRgy4f0fEMCdndjPtKbCtkvCpfewNC+2IND
         fxlz4M6YjMnZ051n9TuokNHpYEOgQwyJ3DTbq8T84K3Jl3TXhgq8ZDvZK+JIGva5nLb8
         1+PQ==
X-Gm-Message-State: APjAAAUcJv4A+gRZqWoVmbaNPbcg3evXq5Kaskmf6IZ/vA7PEqU+I8lM
        UA0GUZ9q5Ce8tzaifhg0Ei2kSg==
X-Google-Smtp-Source: APXvYqy7c4aMXqBtV8RsQz37cPVhnwGAI6b96xSjxoKpUb2R5qSgsCxWAkkxEB8uTYJPawwWOM0xxw==
X-Received: by 2002:a63:d4c:: with SMTP id 12mr28791554pgn.30.1557897374744;
        Tue, 14 May 2019 22:16:14 -0700 (PDT)
Received: from localhost.localdomain ([106.215.121.117])
        by smtp.gmail.com with ESMTPSA id 135sm1321765pfb.97.2019.05.14.22.16.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 22:16:13 -0700 (PDT)
Subject: Re: [PATCH 4/4] kdump: update Documentation about crashkernel on
 arm64
To:     Chen Zhou <chenzhou10@huawei.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, akpm@linux-foundation.org,
        ard.biesheuvel@linaro.org, rppt@linux.ibm.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, ebiederm@xmission.com
Cc:     wangkefeng.wang@huawei.com, linux-mm@kvack.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        takahiro.akashi@linaro.org, horms@verge.net.au,
        linux-arm-kernel@lists.infradead.org,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        Bhupesh SHARMA <bhupesh.linux@gmail.com>
References: <20190507035058.63992-1-chenzhou10@huawei.com>
 <20190507035058.63992-5-chenzhou10@huawei.com>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <de5b827f-5db2-2280-b848-c5c887b9bb58@redhat.com>
Date:   Wed, 15 May 2019 10:46:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190507035058.63992-5-chenzhou10@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2019 09:20 AM, Chen Zhou wrote:
> Now we support crashkernel=X,[high,low] on arm64, update the
> Documentation.
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> ---
>   Documentation/admin-guide/kernel-parameters.txt | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 268b10a..03a08aa 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -705,7 +705,7 @@
>   			memory region [offset, offset + size] for that kernel
>   			image. If '@offset' is omitted, then a suitable offset
>   			is selected automatically.
> -			[KNL, x86_64] select a region under 4G first, and
> +			[KNL, x86_64, arm64] select a region under 4G first, and
>   			fall back to reserve region above 4G when '@offset'
>   			hasn't been specified.
>   			See Documentation/kdump/kdump.txt for further details.
> @@ -718,14 +718,14 @@
>   			Documentation/kdump/kdump.txt for an example.
>   
>   	crashkernel=size[KMG],high
> -			[KNL, x86_64] range could be above 4G. Allow kernel
> +			[KNL, x86_64, arm64] range could be above 4G. Allow kernel
>   			to allocate physical memory region from top, so could
>   			be above 4G if system have more than 4G ram installed.
>   			Otherwise memory region will be allocated below 4G, if
>   			available.
>   			It will be ignored if crashkernel=X is specified.
>   	crashkernel=size[KMG],low
> -			[KNL, x86_64] range under 4G. When crashkernel=X,high
> +			[KNL, x86_64, arm64] range under 4G. When crashkernel=X,high
>   			is passed, kernel could allocate physical memory region
>   			above 4G, that cause second kernel crash on system
>   			that require some amount of low memory, e.g. swiotlb
> 

IMO, it is a good time to update 'Documentation/kdump/kdump.txt' with 
this patchset itself for both x86_64 and arm64, where we still specify 
only the old format for 'crashkernel' boot-argument:

Section: Boot into System Kernel
          =======================

On arm64, use "crashkernel=Y[@X]".  Note that the start address of
the kernel, X if explicitly specified, must be aligned to 2MiB (0x200000).
...

We can update this to add the new crashkernel=size[KMG],low or 
crashkernel=size[KMG],high format as well.

Thanks,
Bhupesh
