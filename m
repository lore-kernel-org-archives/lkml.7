Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AD9C433FF
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 09:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3797A2087C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 09:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388100AbfHCJRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 05:17:31 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35728 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387945AbfHCJRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 05:17:31 -0400
Received: by mail-ed1-f65.google.com with SMTP id w20so74444516edd.2
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2019 02:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zCAo0bW/EBZ1iOue6uy5MuAsehAgp7TUATruNfkX3ts=;
        b=GskAnzWxSQBPMBc27t51vQg4IZ6Z4FwJ9OLcxQTu47raNjJwZ66+7LhB+Kr/D/fm8F
         mgGLe7CoCE6sXdbUF3s8juCbTD2WoksH+ThSdWdBMcpqgpM9TRLxqROYbJUlR/dar3Ch
         U32rHNOHDRFuCe+tnBMEzGgYNzkNUJlMlPihSU5fO3uW13gpl1v0mAk9mTAwE4LMoJ/R
         NsQOZHqylQyXSS5ZM1XqlDlaPoT09RXsbk/hTYP37S/dS3RzUQadMkdz5YnfbetRVjnr
         HqQcN70joBLwz/UhqwhJN6l+wtZJqknyzGq3gzp6bxpXwuMu3e5lx9DAlO35+rA+o26J
         db5A==
X-Gm-Message-State: APjAAAVBeUSfdCR1iavXHrOuXuQDpVhwN26ZRDMcick174BudJOmG60Z
        4yT2JGPQTdyfRP0CBq1ERx22IpPg3KQ=
X-Google-Smtp-Source: APXvYqwiMWfjBJfkN7zoW2xVGOqSjLXzz2mk9b2gU2O1rj/QUfZyw+Fu+GUWy7m3r621vHk15MGSVg==
X-Received: by 2002:a17:906:470a:: with SMTP id y10mr93492995ejq.115.1564823849209;
        Sat, 03 Aug 2019 02:17:29 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id p1sm13462126ejo.77.2019.08.03.02.17.27
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Aug 2019 02:17:28 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: silead_dmi: Add touchscreen platform data
 for the Chuwi Surbook Mini tablet
To:     ohaibuzzle@gmail.com
Cc:     dvhart@infradead.org, andy@infradead.org,
        linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190803012238.4099-1-ohaibuzzle@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <42805a0c-21c4-6940-4179-e492c2ee5782@redhat.com>
Date:   Sat, 3 Aug 2019 11:17:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190803012238.4099-1-ohaibuzzle@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Buzzle",

To submit patches to the Linux kernel you need to use your real-name and
provide a Signed-off-by: line with your real name, see:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html

Regards,

Hans

On 03-08-19 03:22, ohaibuzzle@gmail.com wrote:
> From: Buzzle <ohaibuzzle@gmail.com>
> 
> ---
>   drivers/platform/x86/touchscreen_dmi.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
> index 4370e4add83a..72535b0268eb 100644
> --- a/drivers/platform/x86/touchscreen_dmi.c
> +++ b/drivers/platform/x86/touchscreen_dmi.c
> @@ -136,6 +136,22 @@ static const struct ts_dmi_data chuwi_vi10_data = {
>   	.properties     = chuwi_vi10_props,
>   };
>   
> +static const struct property_entry chuwi_surbook_mini_props[] = {
> +	PROPERTY_ENTRY_U32("touchscreen-min-x", 88),
> +	PROPERTY_ENTRY_U32("touchscreen-min-y", 13),
> +	PROPERTY_ENTRY_U32("touchscreen-size-x", 2040),
> +	PROPERTY_ENTRY_U32("touchscreen-size-y", 1524),
> +	PROPERTY_ENTRY_STRING("firmware-name", "gsl1680-chuwi-surbook-mini.fw"),
> +	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
> +	PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
> +	{ }
> +};
> +
> +static const struct ts_dmi_data chuwi_surbook_mini_data = {
> +	.acpi_name      = "MSSL1680:00",
> +	.properties     = chuwi_surbook_mini_props,
> +};
> +
>   static const struct property_entry connect_tablet9_props[] = {
>   	PROPERTY_ENTRY_U32("touchscreen-min-x", 9),
>   	PROPERTY_ENTRY_U32("touchscreen-min-y", 10),
> @@ -646,6 +662,14 @@ static const struct dmi_system_id touchscreen_dmi_table[] = {
>   			DMI_MATCH(DMI_PRODUCT_NAME, "S165"),
>   		},
>   	},
> +	{
> +		/* Chuwi Surbook Mini (CWI540) */
> +		.driver_data = (void *)&chuwi_surbook_mini_data,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Hampoo"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "C3W6_AP108_4G"),
> +		},
> +	},
>   	{
>   		/* Connect Tablet 9 */
>   		.driver_data = (void *)&connect_tablet9_data,
> 
