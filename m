Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E2CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2C74218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfCORjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 13:39:10 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35069 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfCORjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 13:39:09 -0400
Received: by mail-ed1-f65.google.com with SMTP id d6so7736397eds.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 10:39:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vCtb49PtJNstoPaUjgMNaiUp4uSrPrhnAQC71NYBR1g=;
        b=hPEiiTnutSOyu0hz+lN5tm7xdMJQAN05+WvVPMp+dmqbN+85fKVMDNbhodLUO9Y1WP
         3EaRyq+LhaC5++fuyPN+VMImu/BXwGLwPth6VlJ+U+GcaXxUacJzxTr0D/cVbTu5ggCy
         U/08h6OkOg5XSLjjKa8esKreZkxoGat1vT+0AfdkzD/iGnnZ4OvOWi1RKfphQ/81q/gG
         6/W49MfpnEtwYECuLNdq6zO2j+F80lOEBjN+j8zS8nnBil/uCRafcJnre7b9clniLVk0
         MUv+sg3VCvhaYIQN+ogWGKBzl6YWKXeCPJjqTwDQHIYD/D8EIZbOss8BpOyqq5a3MVee
         m/aQ==
X-Gm-Message-State: APjAAAWDztpWEtCu6EwfIwNf737DgI5aMOOEyDk3EdDO1D3lDKk5oZ4W
        hRBP87liwMmZNmXSfiCKjUqgyvp1yuU=
X-Google-Smtp-Source: APXvYqzVy+vIBX7lhL60oXas0AkNN1ZbouucjWV7Pj0HsypK2PKdXSsiAcoTgLUP/QLx7mE3CukDEQ==
X-Received: by 2002:a17:906:c34e:: with SMTP id ci14mr790181ejb.140.1552671546853;
        Fri, 15 Mar 2019 10:39:06 -0700 (PDT)
Received: from dhcp-44-202.space.revspace.nl ([2a01:4f8:1c0c:6c86:46e0:a7ad:5246:f04d])
        by smtp.gmail.com with ESMTPSA id s3sm265040ejk.17.2019.03.15.10.39.05
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 10:39:05 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: touchscreen_dmi: Add info for Myria MY8307
 2-in-1
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gabriel Lazar <gabriel.lazar@com.utcluj.ro>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-input <linux-input@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190315133113.21215-1-gabriel.lazar@com.utcluj.ro>
 <CAHp75VeQ=6zD5tVV_gVE4S3CDWaYgQ0Lpqq57bxjQjqJYerUAQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <8082b51a-32e9-3e39-969d-9121d2901ba1@redhat.com>
Date:   Fri, 15 Mar 2019 18:39:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VeQ=6zD5tVV_gVE4S3CDWaYgQ0Lpqq57bxjQjqJYerUAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/15/19 6:33 PM, Andy Shevchenko wrote:
> On Fri, Mar 15, 2019 at 3:31 PM Gabriel Lazar
> <gabriel.lazar@com.utcluj.ro> wrote:
>>
>> Add touchscreen platform data for the Myrya MY8307 2-in-1 laptop.
> 
> You sent one patch twice or two patches?
> Please, clarify this by sending v2 with correct subject line(s) and
> amount of patches.

Gabriel send the same patch twice, the first version came from
his yahoo email address, which vger bounced (but the direct addressed
people received), so he send a second copy from his other email address.

Regards,

Hans




> 
>>
>> Signed-off-by: Gabriel Lazar <gabriel.lazar@com.utcluj.ro>
>> ---
>>   drivers/platform/x86/touchscreen_dmi.c | 25 +++++++++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>>
>> diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
>> index 2d56ff7c8230..3319f0cbb558 100644
>> --- a/drivers/platform/x86/touchscreen_dmi.c
>> +++ b/drivers/platform/x86/touchscreen_dmi.c
>> @@ -265,6 +265,23 @@ static const struct ts_dmi_data jumper_ezpad_mini3_data = {
>>          .properties     = jumper_ezpad_mini3_props,
>>   };
>>
>> +static const struct property_entry myria_my8307_props[] = {
>> +       PROPERTY_ENTRY_U32("touchscreen-size-x", 1720),
>> +       PROPERTY_ENTRY_U32("touchscreen-size-y", 1140),
>> +       PROPERTY_ENTRY_BOOL("touchscreen-inverted-x"),
>> +       PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
>> +       PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
>> +       PROPERTY_ENTRY_STRING("firmware-name", "gsl1680-myria-my8307.fw"),
>> +       PROPERTY_ENTRY_U32("silead,max-fingers", 10),
>> +       PROPERTY_ENTRY_BOOL("silead,home-button"),
>> +       { }
>> +};
>> +
>> +static const struct ts_dmi_data myria_my8307_data = {
>> +       .acpi_name      = "MSSL1680:00",
>> +       .properties     = myria_my8307_props,
>> +};
>> +
>>   static const struct property_entry onda_obook_20_plus_props[] = {
>>          PROPERTY_ENTRY_U32("touchscreen-size-x", 1728),
>>          PROPERTY_ENTRY_U32("touchscreen-size-y", 1148),
>> @@ -690,6 +707,14 @@ static const struct dmi_system_id touchscreen_dmi_table[] = {
>>                          DMI_MATCH(DMI_PRODUCT_NAME, "FlexBook edge11 - M-FBE11"),
>>                  },
>>          },
>> +       {
>> +               /* Myria MY8307 */
>> +               .driver_data = (void *)&myria_my8307_data,
>> +               .matches = {
>> +                       DMI_MATCH(DMI_SYS_VENDOR, "Complet Electro Serv"),
>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "MY8307"),
>> +               },
>> +       },
>>          {
>>                  /* Onda oBook 20 Plus */
>>                  .driver_data = (void *)&onda_obook_20_plus_data,
>> --
>> 2.21.0
>>
> 
> 
