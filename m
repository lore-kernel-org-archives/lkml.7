Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1C4C31E40
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 14:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DED6206C1
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 14:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfHCOQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 10:16:43 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37809 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbfHCOQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 10:16:43 -0400
Received: by mail-ed1-f68.google.com with SMTP id w13so74924083eds.4
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2019 07:16:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vbKcpktamOEnlA0qNqnc/w2735gi7G17BJHK0idUG/w=;
        b=p14GV9DP9Cuous8tfRGy/tQYreoZNRwxAtAUxxHB7GeFEvWsw8BbiLTaI/8TKjpBlD
         I0slwk/+PBp1fJnSseHytNned7oaYD7iU6KG3QzrDY1SFJ1TN+Io+Y7UPTLqpQjcejaf
         EvnSW4wzOc5M/CEhjhmV8ICrSaqDy5IoQtqFTs3JRa8ya46HBuKCxvaUoehlzkoxE3O8
         A97vXaKKGeiqqUfT+xhzCD29KHLPNmRiUW0SqZFNRYzVjwUtq3ty+yzv4dHqKs/7LkgX
         Evj1BVxRizsez97PJFqFbWyUwpZv1p0cwLY6qFsUnmlIUvvewQYCmdIP7WJx7wh8L/8f
         +ZCw==
X-Gm-Message-State: APjAAAXcurJ1+nV5MZD/SkKumLhyLub1kjah7V0/p9ljZ6ztiC8vU84T
        xzWP9E2qdZw0trQzdYpNQOPYekKfrTk=
X-Google-Smtp-Source: APXvYqwtLECPm/zSSRGyPy9t8lacqRtMGr7zWFmp/ap4I1TvbwfhW8Zps0Kfh4Pka5jx4+uk4hj1ig==
X-Received: by 2002:a17:906:3d69:: with SMTP id r9mr55137822ejf.28.1564841801189;
        Sat, 03 Aug 2019 07:16:41 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id m32sm18744055edc.89.2019.08.03.07.16.39
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Aug 2019 07:16:40 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: silead_dmi: Add touchscreen platform data
 for the Chuwi Surbook Mini tablet.
To:     Giang Le <ohaibuzzle@gmail.com>
Cc:     dvhart@infradead.org, andy@infradead.org,
        linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190803141222.9460-1-ohaibuzzle@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3c8b8c8c-0674-9fb2-a28e-ceaea58fcece@redhat.com>
Date:   Sat, 3 Aug 2019 16:16:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190803141222.9460-1-ohaibuzzle@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03-08-19 16:12, Giang Le wrote:

Hmm, could have used a somewhat more verbose commit message above
the Signed-off-by line, but I guess there is not that much to write
about this patch.

> Signed-off-by: Giang Le <ohaibuzzle@gmail.com>

Patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



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
