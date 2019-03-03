Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB8AC43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 10:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB4320836
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 10:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbfCCKzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 05:55:21 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43090 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfCCKzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 05:55:21 -0500
Received: by mail-ed1-f66.google.com with SMTP id m35so1867299ede.10
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 02:55:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WHAwhMpx2m+oJRSB2MMhjyYbjce7WYmvuTi22pvgook=;
        b=XLT1YJ1DTg8TyRRgiz8wxJ4UL/Eiog/jI09n453cauLTEFbjdnhgFerBfqiZLo3GWV
         eXTVWh2kDUwzKJEo3ueaTlFDlqTMykQPK4e+fGIYjySvbtjdczjJeCiNneaitygweoK9
         JV/k22OTiM/uZ09ETjox086AqAkE9t6DTJMAFC6/nNgqu7i4oqdKdwvy/W2i1GUE0OxF
         RIk7Hht0ADi5Eqf5m1ON79ABiKVqnoq+kscQ5B9e9KRFrcWTvGZ2FGnksWzTxa0qXMMu
         H+gsGUr/hwLS/t5TIXfR9gdIa4uYorZo6Q0sOcvHF8XXWRVn2q/JGbN2vQkW6FJukrpk
         suPA==
X-Gm-Message-State: APjAAAV+xIgeg3cgQijJIp62ocru3wagiHe3lCamIZmdti9t6f96y1L0
        g8WABvQSbEXY52DssyLkBdgEOhgpaSc=
X-Google-Smtp-Source: APXvYqznrb8Qz9LRrbOTMJ77NNYOxHH7bT2nfUeFa8OKnpvDB3vcba/27Fn1N/a/SL1TL/SM3IW9qg==
X-Received: by 2002:a17:906:a4c4:: with SMTP id cc4mr9199223ejb.198.1551610518931;
        Sun, 03 Mar 2019 02:55:18 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id a51sm1133790edd.57.2019.03.03.02.55.17
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 02:55:18 -0800 (PST)
Subject: Re: [PATCH] platform/x86: touchscreen_dmi: Add info for the CHUWI
 Hi10 Air tablet
To:     me@myself5.de
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190301164002.6031-1-me@myself5.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c6b0c2ef-eed9-ffae-e974-92260d5356aa@redhat.com>
Date:   Sun, 3 Mar 2019 11:55:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190301164002.6031-1-me@myself5.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 01-03-19 17:40, me@myself5.de wrote:
> From: Christian Oder <me@myself5.de>
> 
> Add  touchscreen info for the CHUWUI Hi10 Air tablet.
> 
> Signed-off-by: Christian Oder <me@myself5.de>

Thank you for the patch, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>   drivers/platform/x86/touchscreen_dmi.c | 27 ++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
> index 167a156e3cc7..2d56ff7c8230 100644
> --- a/drivers/platform/x86/touchscreen_dmi.c
> +++ b/drivers/platform/x86/touchscreen_dmi.c
> @@ -72,6 +72,25 @@ static const struct ts_dmi_data chuwi_hi8_pro_data = {
>   	.properties	= chuwi_hi8_pro_props,
>   };
>   
> +static const struct property_entry chuwi_hi10_air_props[] = {
> +	PROPERTY_ENTRY_U32("touchscreen-size-x", 1981),
> +	PROPERTY_ENTRY_U32("touchscreen-size-y", 1271),
> +	PROPERTY_ENTRY_U32("touchscreen-min-x", 99),
> +	PROPERTY_ENTRY_U32("touchscreen-min-y", 9),
> +	PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
> +	PROPERTY_ENTRY_U32("touchscreen-fuzz-x", 5),
> +	PROPERTY_ENTRY_U32("touchscreen-fuzz-y", 4),
> +	PROPERTY_ENTRY_STRING("firmware-name", "gsl1680-chuwi-hi10-air.fw"),
> +	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
> +	PROPERTY_ENTRY_BOOL("silead,home-button"),
> +	{ }
> +};
> +
> +static const struct ts_dmi_data chuwi_hi10_air_data = {
> +	.acpi_name	= "MSSL1680:00",
> +	.properties	= chuwi_hi10_air_props,
> +};
> +
>   static const struct property_entry chuwi_vi8_props[] = {
>   	PROPERTY_ENTRY_U32("touchscreen-min-x", 4),
>   	PROPERTY_ENTRY_U32("touchscreen-min-y", 6),
> @@ -546,6 +565,14 @@ static const struct dmi_system_id touchscreen_dmi_table[] = {
>   			DMI_MATCH(DMI_PRODUCT_NAME, "X1D3_C806N"),
>   		},
>   	},
> +	{
> +		/* Chuwi Hi10 Air */
> +		.driver_data = (void *)&chuwi_hi10_air_data,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Hampoo"),
> +			DMI_MATCH(DMI_PRODUCT_SKU, "P1W6_C109D_B"),
> +		},
> +	},
>   	{
>   		/* Chuwi Vi8 (CWI506) */
>   		.driver_data = (void *)&chuwi_vi8_data,
> 
