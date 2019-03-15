Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5671C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA0D0218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfCORre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 13:47:34 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36958 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbfCORrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 13:47:33 -0400
Received: by mail-ed1-f66.google.com with SMTP id m12so8329672edv.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 10:47:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Pp3A12zd+PUrgXhFsAEJuEbNmGZ0frIIie8AVokCIYY=;
        b=CZbjWtmYHkX0KAQLlSxWhwSOx2CaVhU39QSFHG2atDwlAg7G6NoLO3pGRsjZ7PYayU
         3VyxqDP2rKEmkysUgL47WV7DD069JObRG2WnAMIGqTSXigjd1jLy/Fuj0mFB0VBVfr6v
         gRWauoaiDF8rThGUH7Cdvj8BfgMNZAWQFy+keB0UEluJTKdHdAYj3TEhHR+nBO3gIAfQ
         MKFhbIut8ozBJifbuMGbJNm18vi3ihyN3Pk5E1a+fdGXquu1j6p7nj5mj7RaipfRCz47
         tuHBfpxTtE8qCW0tn1mLVdylf6pvrmpV/SDH8C7HpHPiGk5ANI0wG5G3lBsqBxkDIJuF
         W87g==
X-Gm-Message-State: APjAAAXPCR/LlOvhraFIZoxVZ1u6AX1siAiyBb/NATXzR4uyH3tN6sn3
        dOzFYTP6tRgVnqHqBcfWIIgYwJewvQ8=
X-Google-Smtp-Source: APXvYqx1oV6Nw+cO7cUFqBm+t8vtkpbFjq7/MHH1xx74FMZ6q18AXW+aJZZ4RBBnFSRfYDan9kqMPQ==
X-Received: by 2002:a17:906:5014:: with SMTP id s20mr3006256ejj.174.1552672051231;
        Fri, 15 Mar 2019 10:47:31 -0700 (PDT)
Received: from dhcp-44-202.space.revspace.nl ([2a01:4f8:1c0c:6c86:46e0:a7ad:5246:f04d])
        by smtp.gmail.com with ESMTPSA id g3sm802170edh.83.2019.03.15.10.47.30
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 10:47:30 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: touchscreen_dmi: Add info for Myria MY8307
 2-in-1
To:     Gabriel Lazar <gabriel.lazar@com.utcluj.ro>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190315133113.21215-1-gabriel.lazar@com.utcluj.ro>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <12a67eb2-18ff-dd9f-4c48-4d01a01a2aa7@redhat.com>
Date:   Fri, 15 Mar 2019 18:47:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190315133113.21215-1-gabriel.lazar@com.utcluj.ro>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/15/19 2:31 PM, Gabriel Lazar wrote:
> Add touchscreen platform data for the Myrya MY8307 2-in-1 laptop.
> 
> Signed-off-by: Gabriel Lazar <gabriel.lazar@com.utcluj.ro>

Patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>   drivers/platform/x86/touchscreen_dmi.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
> index 2d56ff7c8230..3319f0cbb558 100644
> --- a/drivers/platform/x86/touchscreen_dmi.c
> +++ b/drivers/platform/x86/touchscreen_dmi.c
> @@ -265,6 +265,23 @@ static const struct ts_dmi_data jumper_ezpad_mini3_data = {
>   	.properties	= jumper_ezpad_mini3_props,
>   };
>   
> +static const struct property_entry myria_my8307_props[] = {
> +	PROPERTY_ENTRY_U32("touchscreen-size-x", 1720),
> +	PROPERTY_ENTRY_U32("touchscreen-size-y", 1140),
> +	PROPERTY_ENTRY_BOOL("touchscreen-inverted-x"),
> +	PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
> +	PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
> +	PROPERTY_ENTRY_STRING("firmware-name", "gsl1680-myria-my8307.fw"),
> +	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
> +	PROPERTY_ENTRY_BOOL("silead,home-button"),
> +	{ }
> +};
> +
> +static const struct ts_dmi_data myria_my8307_data = {
> +	.acpi_name	= "MSSL1680:00",
> +	.properties	= myria_my8307_props,
> +};
> +
>   static const struct property_entry onda_obook_20_plus_props[] = {
>   	PROPERTY_ENTRY_U32("touchscreen-size-x", 1728),
>   	PROPERTY_ENTRY_U32("touchscreen-size-y", 1148),
> @@ -690,6 +707,14 @@ static const struct dmi_system_id touchscreen_dmi_table[] = {
>   			DMI_MATCH(DMI_PRODUCT_NAME, "FlexBook edge11 - M-FBE11"),
>   		},
>   	},
> +	{
> +		/* Myria MY8307 */
> +		.driver_data = (void *)&myria_my8307_data,
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Complet Electro Serv"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "MY8307"),
> +		},
> +	},
>   	{
>   		/* Onda oBook 20 Plus */
>   		.driver_data = (void *)&onda_obook_20_plus_data,
> 
