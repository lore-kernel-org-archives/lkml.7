Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E094AC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 13:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9DC620818
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 13:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfEPNQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 09:16:35 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35892 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfEPNQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 09:16:35 -0400
Received: by mail-qk1-f194.google.com with SMTP id c14so2209791qke.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 06:16:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xbcsfs9fPhPAxid9VLXerkrXA7gIRwceIo40+cdxdOM=;
        b=SZpuGgXYZ8yVKTkrX3qZ4PDquXl9PYzb/Ar0cQUclrKNcTRgkstVIc/LG7u679ms1r
         IfICuo2wMMcmaYfQA8K9bPVaRtUxWX2akGeqBzznL+DnvPZvaeXBY/6//ob74NnZAnZR
         SEbsJOADQHzH8vSswU4XxMP9VB5CxkPrnIiPYTVMsn/oh2ANaQEy9PsOtvldOUe7OFIc
         6FgClPNaiB99ySPzgNVTLKkgwlLrzF3DlL10ZFB/iMzu1WvHm2g3n8ab9aITZ/e8Y2UQ
         J2KwE3HIA+1qtu0Uxtg9A2iPxSaiepwAEB2bh8L8ORne8YuyATdRh6HF2ov8ncK6LHZ8
         s2Hw==
X-Gm-Message-State: APjAAAV+CSbHSHu6UubbkHPgEYoE6cgYIe1IQMS4pmbpZSg2bMg8QMkB
        pVgZCCpM8jYKNBxmOW8ONh6l2A==
X-Google-Smtp-Source: APXvYqw9TWQ3IfH3iSJSDru28VPmlBF3K1DIMQfkSHuQda0F5JApl5cueYi9JH5aELT2HWEmikJyjg==
X-Received: by 2002:a05:620a:1116:: with SMTP id o22mr38219629qkk.23.1558012594687;
        Thu, 16 May 2019 06:16:34 -0700 (PDT)
Received: from ?IPv6:2601:602:9800:dae6::e443? ([2601:602:9800:dae6::e443])
        by smtp.gmail.com with ESMTPSA id d127sm2471936qkg.69.2019.05.16.06.16.32
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 06:16:32 -0700 (PDT)
Subject: Re: [PATCH] arm64: vdso: Explicitly add build-id option
To:     Will Deacon <will.deacon@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20190515194824.5641-1-labbott@redhat.com>
 <CAK7LNASZnRrSsZSrnw41kintGfmpyj3iz-Vjduk7w3k9iSih-w@mail.gmail.com>
 <20190516104619.GA29705@fuggles.cambridge.arm.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <fb9891e6-3bc4-5bef-6575-5c272082085e@redhat.com>
Date:   Thu, 16 May 2019 06:16:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516104619.GA29705@fuggles.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/19 3:46 AM, Will Deacon wrote:
> On Thu, May 16, 2019 at 01:58:56PM +0900, Masahiro Yamada wrote:
>> On Thu, May 16, 2019 at 4:51 AM Laura Abbott <labbott@redhat.com> wrote:
>>>
>>> Commit 691efbedc60d ("arm64: vdso: use $(LD) instead of $(CC) to
>>> link VDSO") switched to using LD explicitly. The --build-id option
>>> needs to be passed explicitly, similar to x86. Add this option.
>>>
>>> Fixes: 691efbedc60d ("arm64: vdso: use $(LD) instead of $(CC) to link VDSO")
>>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>>> ---
>>>   arch/arm64/kernel/vdso/Makefile | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
>>> index 744b9dbaba03..ca209103cd06 100644
>>> --- a/arch/arm64/kernel/vdso/Makefile
>>> +++ b/arch/arm64/kernel/vdso/Makefile
>>> @@ -13,6 +13,7 @@ targets := $(obj-vdso) vdso.so vdso.so.dbg
>>>   obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
>>>
>>>   ldflags-y := -shared -nostdlib -soname=linux-vdso.so.1 \
>>> +               $(call ld-option, --build-id) \
>>>                  $(call ld-option, --hash-style=sysv) -n -T
>>>
>>>   # Disable gcov profiling for VDSO code
>>
>>
>> I missed that. Sorry.
>>
>> You can add  --build-id without $(call ld-option,...)
>> because it is supported by our minimal version of toolchain.
>>
>> See commit log of 1e0221374e for example.
> 
> Ok, so I'm ok folding in the diff below on top?
> 
> Will
> 
> --->8
> 
> diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
> index ca209103cd06..fa230ff09aa1 100644
> --- a/arch/arm64/kernel/vdso/Makefile
> +++ b/arch/arm64/kernel/vdso/Makefile
> @@ -12,9 +12,8 @@ obj-vdso := gettimeofday.o note.o sigreturn.o
>   targets := $(obj-vdso) vdso.so vdso.so.dbg
>   obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
>   
> -ldflags-y := -shared -nostdlib -soname=linux-vdso.so.1 \
> -		$(call ld-option, --build-id) \
> -		$(call ld-option, --hash-style=sysv) -n -T
> +ldflags-y := -shared -nostdlib -soname=linux-vdso.so.1 --hash-style=sysv \
> +		--build-id -n -T
>   
>   # Disable gcov profiling for VDSO code
>   GCOV_PROFILE := n
> 

Looks good to me.

Thanks,
Laura
