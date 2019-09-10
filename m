Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EE0C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 11:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A10882084D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 11:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731524AbfIJLqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 07:46:53 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39305 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729304AbfIJLqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 07:46:52 -0400
Received: by mail-ed1-f65.google.com with SMTP id u6so16772504edq.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 04:46:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=abgaMe6ZZ95gWMUy3hnBn63QDEWfYInzgOcZ2MI8v94=;
        b=tftMnhBJScOV8S3EmVcpxBEYVwD+kjSOjjJnwjAszAVqSj6dW3geoaHbPqD30vr9In
         B34ec4xjvm6BWlbqScNbwNS4F975qVfgKj77tvBAX81Mx9OLOVkxIHTgjKYgEZwn87HU
         Pfq0HOEIriPMB6bH+/A0NYJPc8F5GaEH2o0oXzW3b2kH8Mh0pKTSI8+DWnspiNdcC7XG
         RgfypAQqbD1RZzEiuyz5EA48EPM6rtJiXGVCPF0CvkFRrNwwvbX3YVawSMNIbhZKbL1+
         CkDA7H6RGNFthFkMiT2TENiFzI0ytmsamjsSm7suEkEqU7XVr1sk03to65M/wfegFi7b
         AYDQ==
X-Gm-Message-State: APjAAAUjUu+zrOeKIgKHifmmoOHl4SRrZ4HnMVEh+42sO5xnxdxgsodh
        AiA2TePTKfChivC4j0vbWWo=
X-Google-Smtp-Source: APXvYqzec2pfMLAxkhhovJ45V9gaVPv8RRuMLY7VMY/ZkxobyGPpBpSQQBrFTGvFv0X4GFnIClIdFw==
X-Received: by 2002:aa7:d28d:: with SMTP id w13mr29796008edq.264.1568116011004;
        Tue, 10 Sep 2019 04:46:51 -0700 (PDT)
Received: from [10.10.2.174] (bran.ispras.ru. [83.149.199.196])
        by smtp.gmail.com with ESMTPSA id p4sm3408685edc.38.2019.09.10.04.46.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2019 04:46:50 -0700 (PDT)
Reply-To: efremov@linux.com
Subject: Re: [RESEND PATCH] MAINTAINERS: Update path to physmap-versatile.c
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20190813061024.15428-1-efremov@linux.com>
 <20190813063251.21842-1-efremov@linux.com>
 <CACRpkdZRW1fpjf=vQbuDdSC1ZU9o2tq2C2bL0GonQbnPWc06-A@mail.gmail.com>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <a406a875-b267-9653-ced5-4afee0056975@linux.com>
Date:   Tue, 10 Sep 2019 14:46:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdZRW1fpjf=vQbuDdSC1ZU9o2tq2C2bL0GonQbnPWc06-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/13/19 10:20 AM, Linus Walleij wrote:
> On Tue, Aug 13, 2019 at 8:33 AM Denis Efremov <efremov@linux.com> wrote:
> 
>> Update MAINTAINERS record to reflect the filename change
>> from physmap_of_versatile.c to physmap-versatile.c
>>
>> Cc: Boris Brezillon <bbrezillon@kernel.org>
>> Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Fixes: 6ca15cfa0788 ("mtd: maps: Rename physmap_of_{versatile, gemini} into physmap-{versatile, gemini}")
>> Signed-off-by: Denis Efremov <efremov@linux.com>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Yours,
> Linus Walleij
> 

Could someone take this fix through his tree?

Thanks,
Denis
