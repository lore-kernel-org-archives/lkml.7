Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EA0C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 20:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE207208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 20:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfFYUbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 16:31:17 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44578 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfFYUbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 16:31:16 -0400
Received: by mail-ed1-f68.google.com with SMTP id k8so29009080edr.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 13:31:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ouCYZW6j2F9X9UEJz8UhFdPaz7qXxTi0skUGUYVPJg8=;
        b=Rih6DhfVYzjSLN/jrAm1AEv9ZSVtPBLL3khJI+RiRZMkIOtbYCUEjaHWG6Jm1UMlC5
         YQUl0CRX+aNXzBL3niHKFLWFhg23BlLVomNyEjHPyVdniu362EUfeXjno0mZwJDiykmL
         crF3BF/uBdpq6YPmfnujq14wdIfypNsxyIsNYBXKO5ZPZwIg/CCf9feFEDLHQswSR9CX
         VjOdzwpKjV13/cE1TKyYF8Aqk7UFHtY8S/qdyfjnPV6JaHjTzSp5CTjv1HxIT8bcGkcM
         aPAxpZ+4ri/d9FR3A+s84bUqOVKOAWzhq5rHPryxm/LNdIz9kKUDD2i40ukZ2ZkRH/PR
         tYkw==
X-Gm-Message-State: APjAAAUy/hL+OoHV3rsefmrt07mJJwIqqjTklOyFw20kHoG9uuUZmHrQ
        dc5h8QrWwyLsJW8QojfZv1HXhSuGau0=
X-Google-Smtp-Source: APXvYqyL122t/uCNJpHnytCFoUf/GBY/eGn/znXIiwaj9GqmlBtdCqFtAzPv5mdjJZBYRas4njeaWg==
X-Received: by 2002:aa7:c692:: with SMTP id n18mr486235edq.220.1561494674353;
        Tue, 25 Jun 2019 13:31:14 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id g16sm5070792edc.76.2019.06.25.13.31.13
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 13:31:13 -0700 (PDT)
Subject: Re: [PATCH v1] platform/x86: intel_int0002_vgpio: Get rid of custom
 ICPU() macro
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190619145050.13876-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <bebb9c22-186d-8bd1-a12d-c97f22f2487a@redhat.com>
Date:   Tue, 25 Jun 2019 22:31:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190619145050.13876-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19-06-19 16:50, Andy Shevchenko wrote:
> Replace custom grown macro with generic INTEL_CPU_FAM6() one.
> 
> No functional change intended.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>   drivers/platform/x86/intel_int0002_vgpio.c | 22 +++++++---------------
>   1 file changed, 7 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel_int0002_vgpio.c b/drivers/platform/x86/intel_int0002_vgpio.c
> index 1694a9aec77c..d9542c661ddc 100644
> --- a/drivers/platform/x86/intel_int0002_vgpio.c
> +++ b/drivers/platform/x86/intel_int0002_vgpio.c
> @@ -51,17 +51,6 @@
>   #define GPE0A_STS_PORT			0x420
>   #define GPE0A_EN_PORT			0x428
>   
> -#define BAYTRAIL			0x01
> -#define CHERRYTRAIL			0x02
> -
> -#define ICPU(model, data) { X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, data }
> -
> -static const struct x86_cpu_id int0002_cpu_ids[] = {
> -	ICPU(INTEL_FAM6_ATOM_SILVERMONT, BAYTRAIL), /* Valleyview, Bay Trail  */
> -	ICPU(INTEL_FAM6_ATOM_AIRMONT, CHERRYTRAIL), /* Braswell, Cherry Trail */
> -	{}
> -};
> -
>   /*
>    * As this is not a real GPIO at all, but just a hack to model an event in
>    * ACPI the get / set functions are dummy functions.
> @@ -157,6 +146,12 @@ static struct irq_chip int0002_cht_irqchip = {
>   	 */
>   };
>   
> +static const struct x86_cpu_id int0002_cpu_ids[] = {
> +	INTEL_CPU_FAM6(ATOM_SILVERMONT, int0002_byt_irqchip),	/* Valleyview, Bay Trail  */
> +	INTEL_CPU_FAM6(ATOM_AIRMONT, int0002_cht_irqchip),	/* Braswell, Cherry Trail */
> +	{}
> +};
> +
>   static int int0002_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
> @@ -210,10 +205,7 @@ static int int0002_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>   
> -	if (cpu_id->driver_data == BAYTRAIL)
> -		irq_chip = &int0002_byt_irqchip;
> -	else
> -		irq_chip = &int0002_cht_irqchip;
> +	irq_chip = (struct irq_chip *)cpu_id->driver_data;
>   
>   	ret = gpiochip_irqchip_add(chip, irq_chip, 0, handle_edge_irq,
>   				   IRQ_TYPE_NONE);
> 
