Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2D5C18E7D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1247220868
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbfEVKMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 06:12:51 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38094 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728625AbfEVKMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 06:12:50 -0400
Received: by mail-ed1-f65.google.com with SMTP id w11so3038003edl.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 03:12:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UOism6/WliJKlizbO03ANyTQDbU6zepiLVCCA7yr4no=;
        b=EAS95erR7zgHxD4l5HzxyFuQQ8ARELbdgIvHR0nzpi4iGxU06B2BuetVQBOljGGcbY
         0G/Rt9R4gwLCV0ZOBbIFAU+Snu0oDyKF/K1ecxjXW+7+dh19pdu2Qn4ldIDDush7aFtz
         IJ4rxWlD1jJBXsBDQFEqqB4QLqWiFTPm2ahYJqA/N9Rq5pYgGNWMEoTTq15LYCThaLaq
         mnUpETDx0S51EmtOhsSjchICziOAEtk6cohh70Q67W63BFsWtf2Vri/gJFFq9qZxXdqC
         jBGbE9LwcTB3iaELva2bdBdKOrNyzbWl7ppno5FxD+enIBk59BS3brq2Tw/wd1626J2C
         LnAg==
X-Gm-Message-State: APjAAAVGcG9FQV9Zvg8cO7bEVB5eDk12kbDJczhty9k6Iro9NVke4+tS
        QG0u0Rjb/v2xruoGxiFSRczX6CbClzU=
X-Google-Smtp-Source: APXvYqzNhVaVxR8CohHDUn6M+ULJOxCah+OGJx2vJUGm8rsFFDe+YEXiuua+IT83U0iTKfsg0KunhA==
X-Received: by 2002:a17:906:6c1:: with SMTP id v1mr13388705ejb.266.1558519969205;
        Wed, 22 May 2019 03:12:49 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id u1sm2617873ejz.92.2019.05.22.03.12.48
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 03:12:48 -0700 (PDT)
Subject: Re: [PATCH] input: silead: Add MSSL0017 to acpi_device_id.
To:     Danct12 <danct12@disroot.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190522045455.15769-1-danct12@disroot.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <6c18472f-bedd-6e6d-121c-8a311495c3c3@redhat.com>
Date:   Wed, 22 May 2019 12:12:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190522045455.15769-1-danct12@disroot.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22-05-19 06:54, Danct12 wrote:
> On Chuwi Hi10 Plus, the Silead device id is MSSL0017.
> 
> Signed-off-by: Danct12 <danct12@disroot.org>

Patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>   drivers/input/touchscreen/silead.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/touchscreen/silead.c b/drivers/input/touchscreen/silead.c
> index 09241d4cdebc..06f0eb04a8fd 100644
> --- a/drivers/input/touchscreen/silead.c
> +++ b/drivers/input/touchscreen/silead.c
> @@ -617,6 +617,7 @@ static const struct acpi_device_id silead_ts_acpi_match[] = {
>   	{ "MSSL1680", 0 },
>   	{ "MSSL0001", 0 },
>   	{ "MSSL0002", 0 },
> +	{ "MSSL0017", 0 },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(acpi, silead_ts_acpi_match);
> 
