Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5ABAC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD794206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbfH0OlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 10:41:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60642 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbfH0OlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 10:41:14 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A372C5AFF8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 14:41:13 +0000 (UTC)
Received: by mail-ed1-f70.google.com with SMTP id w15so11766867edv.17
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 07:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gtdqTXHgEELwWUsXLxRHC6cx9mr0AwttNY4k7nCwF+k=;
        b=WI4JVV0pkRoHHfXAjsVB2R0bjP2p0rnW+/zeAB0qkDFgQTA6odNIJCuvV/zcVFe09i
         qoYIPbV5Yq16mhO9MMkIizIg7i9xt8ZkgsArIWjGOMYZRM3qgcWAtlLETi44o6kui9GS
         vv9uNZ4AmW3ovVBQbxbWfO9m84W379mYZsuUn8Zs1wvmWAkFFJWFcAH4K4DfcCwoXaw9
         9uSiit3C6H2dKfUWr36QHFHd7/Os2sBErv/MN1ryJdVR1cPDw8f4Fmtu2jMybQoPsNZh
         GwOe4/5nm+M9OPi5a7UsGxYpHiiDPFuDeRKEB7CBMa6LrovtUVAlcWeFrznSjuEkkHa/
         1GbA==
X-Gm-Message-State: APjAAAVLReNlPtbTuE5oIMqn9yiM3GARbISZzdGS8fsqWQzE9lbDvnFv
        UchDJ4wvqifWnCIkmJNhvNuHRgjkmhuQaRImn7ZSuIohcbMfb+XjQ2ofziNMSsXh1tlCRzGlT0Y
        l4/ThOkXsvhRwiXk83HcKY3sH
X-Received: by 2002:a17:906:340e:: with SMTP id c14mr22089091ejb.170.1566916872397;
        Tue, 27 Aug 2019 07:41:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqynw6BbBD3aNJREt1fPM6mq6f2J04TiNskAW6/Pd//C0qQosTZwmoYfCM80zR14ROg5Ndb7Qg==
X-Received: by 2002:a17:906:340e:: with SMTP id c14mr22089062ejb.170.1566916872122;
        Tue, 27 Aug 2019 07:41:12 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id bq19sm3651230ejb.33.2019.08.27.07.41.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2019 07:41:11 -0700 (PDT)
Subject: Re: [PATCH] gpiolib: acpi: Add gpiolib_acpi_run_edge_events_on_boot
 option and blacklist
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Daniel Drake <drake@endlessm.com>,
        Ian W MORRISON <ianwmorrison@gmail.com>
References: <20190823215255.7631-1-hdegoede@redhat.com>
 <20190826091110.GY30120@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f606adbc-07e1-e926-333f-48bac8eee2ad@redhat.com>
Date:   Tue, 27 Aug 2019 16:41:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826091110.GY30120@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 26-08-19 11:11, Andy Shevchenko wrote:
> On Fri, Aug 23, 2019 at 11:52:55PM +0200, Hans de Goede wrote:
>> Another day; another DSDT bug we need to workaround...
>>
>> Since commit ca876c7483b6 ("gpiolib-acpi: make sure we trigger edge events
>> at least once on boot") we call _AEI edge handlers at boot.
>>
>> In some rare cases this causes problems. One example of this is the Minix
>> Neo Z83-4 mini PC, this device has a clear DSDT bug where it has some copy
>> and pasted code for dealing with Micro USB-B connector host/device role
>> switching, while the mini PC does not even have a micro-USB connector.
>> This code, which should not be there, messes with the DDC data pin from
>> the HDMI connector (switching it to GPIO mode) breaking HDMI support.
>>
>> To avoid problems like this, this commit adds a new
>> gpiolib_acpi_run_edge_events_on_boot kernel commandline option which
>> can be "on", "off", or "auto" (default).
>>
>> In auto mode the default is on and a DMI based blacklist is used,
>> the initial version of this blacklist contains the Minix Neo Z83-4
>> fixing the HDMI being broken on this device.
> 
>> +static int gpiolib_acpi_run_edge_events_on_boot = -1;
>> +
>> +static int __init gpiolib_acpi_run_edge_events_on_boot_setup(char *arg)
>> +{
> 
>> +	if (!strcmp(arg, "on"))
>> +		gpiolib_acpi_run_edge_events_on_boot = 1;
>> +	else if (!strcmp(arg, "off"))
>> +		gpiolib_acpi_run_edge_events_on_boot = 0;
> 
> kstrtobool() ?
> 
>> +	else if (!strcmp(arg, "auto"))
>> +		gpiolib_acpi_run_edge_events_on_boot = -1;
>> +
>> +	return 1;
>> +}
> 
>> +
>> +__setup("gpiolib_acpi_run_edge_events_on_boot=",
>> +        gpiolib_acpi_run_edge_events_on_boot_setup);
> 
> Can't we use module_param() ?
> The resulting option would be 'gpiolib_acpi.foo=...'

I was expecting that would not work, since gpiolib is a bool
not a tristate, but it seems that if there is no module-name
to use as prefix for module-parameters the kernel simply uses
the .c file name, so this works and yes, this is better then
using __setup, will fix for v2.

>> +{
> 
>> +	if (gpiolib_acpi_run_edge_events_on_boot == -1) {
>> +		if (dmi_check_system(run_edge_events_on_boot_blacklist))
>> +			gpiolib_acpi_run_edge_events_on_boot = 0;
>> +		else
>> +			gpiolib_acpi_run_edge_events_on_boot = 1;
>> +	}
> 
> Can we run this at an initcall once and use variable instead of calling a
> method below?

I was a bit worried about init ordering, but I've checked and dmi_setup()
is done as a core_initcall, so we can do this once as a postcore_initcall
which should be early enough, will fix for v2.

> 
>> +	return gpiolib_acpi_run_edge_events_on_boot;
>> +}
>> +
>>   static void acpi_gpiochip_request_irq(struct acpi_gpio_chip *acpi_gpio,
>>   				      struct acpi_gpio_event *event)
>>   {
>> @@ -170,10 +211,13 @@ static void acpi_gpiochip_request_irq(struct acpi_gpio_chip *acpi_gpio,
>>   	event->irq_requested = true;
>>   
>>   	/* Make sure we trigger the initial state of edge-triggered IRQs */
>> -	value = gpiod_get_raw_value_cansleep(event->desc);
>> -	if (((event->irqflags & IRQF_TRIGGER_RISING) && value == 1) ||
>> -	    ((event->irqflags & IRQF_TRIGGER_FALLING) && value == 0))
>> -		event->handler(event->irq, event);
>> +	if (acpi_gpiochip_run_edge_events_on_boot() &&
>> +	    (event->irqflags & (IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING))) {
>> +		value = gpiod_get_raw_value_cansleep(event->desc);
>> +		if (((event->irqflags & IRQF_TRIGGER_RISING) && value == 1) ||
>> +		    ((event->irqflags & IRQF_TRIGGER_FALLING) && value == 0))
>> +			event->handler(event->irq, event);
>> +	}
> 

Regards,

Hans
