Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8A1C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 13:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DBBC20823
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 13:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfCCN7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 08:59:09 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35120 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfCCN7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 08:59:09 -0500
Received: by mail-ed1-f67.google.com with SMTP id g19so2086212edp.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 05:59:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1g7WmbIgGMF+ZkOJeJdv5PZ97homHTJNsn0FYdrtAGw=;
        b=S7m3KSbBPFuuNU8mOYDrnjjxfh9JAoqAe2JvzMc4ejwQVIg+rd1N69xy/etjoxCGhT
         m9etiBmXccy/jsNBGNdFTpksPwmFSqBllogJ4HL5/EQZby+hLErQzTbXUcRQos/ER+Gw
         bo8Hw4K3sfwnUObX+z3o+657wTnhfaHlZDCMczUHElDpAKJCRmuuWvrnEQMjoRYlETLh
         oS1ahP+FqA9EVWOhgOhRioUWGrWn158Aq7pU8m9ENJspBVFMGW7sH+12g562DziTgJrA
         hIAlWrgDm7Zqc0DVFk1t8dwHIQhOxUXNzjRfa8EkYJpnb0sY4ZN7eT3fklhIKHeXd+Ak
         ET/A==
X-Gm-Message-State: APjAAAX4jiRE4cdYCcOlJCZST4XglFcWqDl9dymRkiQH1ZjGNpT/AGum
        1bJvpL5L457C+aQaUgAqWxym4A==
X-Google-Smtp-Source: APXvYqy5InKS9YeWAWL8T/9eqgZtWz9X9C9wvZ12QL7U3aXfq9G+6WxZ7qViKxH+DwYZYfycJxOxwg==
X-Received: by 2002:a50:b107:: with SMTP id k7mr11750275edd.165.1551621547410;
        Sun, 03 Mar 2019 05:59:07 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id h8sm1251160edb.36.2019.03.03.05.59.06
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 05:59:06 -0800 (PST)
Subject: Re: [PATCH v2] platform/x86: touchscreen_dmi: Add info for the CHUWI
 Hi10 Air tablet
To:     Christian Oder <me@myself5.de>
Cc:     andy@infradead.org, dvhart@infradead.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <c6b0c2ef-eed9-ffae-e974-92260d5356aa@redhat.com>
 <20190303134727.6680-1-me@myself5.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f4937ec1-9dac-0810-7386-a15ec5d306ae@redhat.com>
Date:   Sun, 3 Mar 2019 14:59:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190303134727.6680-1-me@myself5.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

On 03-03-19 14:47, Christian Oder wrote:
> Add  touchscreen info for the CHUWUI Hi10 Air tablet.
> 
> Signed-off-by: Christian Oder <me@myself5.de>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> - added review tag

A quick note for any patches you may submit in the future, there
is no need to send a v2 just to add someones Reviewed-by or Acked-by,
these will be picked up automatically by the subsys-maintainer when
they add the patch to their tree.

Regards,

Hans

> 
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
