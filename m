Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC02C32751
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 22:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B734F2070D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 22:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730867AbfHEWZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 18:25:45 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45639 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729999AbfHEWZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 18:25:45 -0400
Received: by mail-wr1-f65.google.com with SMTP id f9so6979742wre.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 15:25:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v3ukfwq9sao2HM0nnFsoZLetdOCEK73QpJzj1XGgANk=;
        b=CsJ1It6FqMV+vbiAJEqNTy6e9itTD60wiiACXOZs/UAwMKbjVZ7oZsDWdOeTOei98O
         0y/a53odJRC3ROPcWXKX9VVR9ZAdUjTr+FaIj305Hz5zEtPEasojczQaTlTfcZN2Xsjo
         k5pNiNvxR0jXxgkawDuRB5vVZM+TZHsdC2ysJRu4jLxksgDtftvC+zztWkIpI0L4E2y8
         /+Ar0D28Slmp7stK485adGlFjvixilnukInzBHEKpA7Y/yn4to6RtAxkGoXbtRL3HiEO
         edF6TfKgTZOegylJJIvzcidsgbMqEKMA3zFhehZZciz/45u7Imw/HTQk5NK4OqwthkwB
         S3rw==
X-Gm-Message-State: APjAAAXYSkrk1+3lNmQkq6zSjs6r82/2fk7N2COvAS6HSkkkn5/Um77R
        k3KiWBlVgnRzeM2obl2qmwMp/Q==
X-Google-Smtp-Source: APXvYqzz5YzWQFCn36Ny3wpPCgDBusnxRHYPl+zcFffP+AJIbLVyU62LwGkwgu054MJW7P5er0Tggg==
X-Received: by 2002:adf:f088:: with SMTP id n8mr245425wro.58.1565043942911;
        Mon, 05 Aug 2019 15:25:42 -0700 (PDT)
Received: from [192.168.0.24] ([181.120.177.224])
        by smtp.gmail.com with ESMTPSA id t185sm78372904wma.11.2019.08.05.15.25.38
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 15:25:42 -0700 (PDT)
Subject: Re: [PATCH RFC] modpost: Support I2C Aliases from OF tables
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-renesas-soc@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
References: <20190710193918.31135-1-kieran.bingham+renesas@ideasonboard.com>
 <0e1b6e0b-1c94-4b00-7fda-c2a303ee3816@redhat.com>
 <20190731194419.GB4084@kunai>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <f4a78e93-6aaa-bc72-cf94-06fc2574451c@redhat.com>
Date:   Tue, 6 Aug 2019 00:25:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731194419.GB4084@kunai>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Wolfram,

On 7/31/19 9:44 PM, Wolfram Sang wrote:
> Hi Javier,
> 
> thank you for providing the extra information.
> 
> (And Kieran, thanks for the patch!)
> 
>> The other option is to remove i2c_of_match_device() and don't make OF match
>> to fallback to i2c_of_match_device_sysfs(). This is what happens in the ACPI
>> case, since i2c_device_match() just calls acpi_driver_match_device() directly
>> and doesn't have a wrapper function that fallbacks to sysfs matching.
>>
>> In this case an I2C device ID table would be required if the devices have to
>> be instantiated through sysfs. That way the I2C table would be used both for
>> auto-loading and also to match the device when it doesn't have an of_node.
> 
> That would probably mean that only a minority of drivers will not add an I2C
> device ID table because it is easy to add an you get the sysfs feature?
>

I believe so yes.
 
> Then we are back again with the situation that most drivers will have
> multiple tables. With the minor change that the I2C device id table is
> not required anymore by the core, but it will be just very useful to
> have? Or?
>

Yes, it won't be needed anymore if you are only instantiating all your devices
from your firmware interface (e.g: OF, ACPI).

>> If the former is the correct way to solve this then the patch looks good to me.
>>
>> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> For this actual patch from Kieran, I'd like to hear an opinion from the
> people maintaining modpost. The aproach looks okay to me, yet I can't
> tell how "easy" we are with adding new types like 'i2c_of'.
>

As Masahiro-san mentioned, this approach will still require to add a new macro
MODULE_DEVICE_TABLE(i2c_of, bar_of_match) so the OF device table is used twice.

One to expose the "of:N*T*Cfoo,bar" and another one to expose it as "i2c:bar".

I expect that many developers would miss adding this macro for new drivers that
are DT-only and so sysfs instantiation would not work there. So whatever is the
approach taken we should clearly document all this so drivers authors are aware.

> Thanks everyone,
> 
>    Wolfram
> 

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
