Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7607CC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E2C2147A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfDCJKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:10:54 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39719 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfDCJKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:10:53 -0400
Received: by mail-ed1-f66.google.com with SMTP id p20so14192387eds.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 02:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4HTh0QlprI/1gUI5iisXQZRq97dzpssTQCwcM79z+aM=;
        b=AYFvx0cEEm6GspJ5CsMB5kss8IfZoUt3ImcJ3U2NJIZBN5/W8pgps3msK2eE4iMA95
         XiEUOSTCdfirSjkl7GQ/JVFPCQ0bd10qPHYIQAsnB86lSRwPps7u1TNnuDMjGmzd4BOa
         I2E9DmUdoIEX+RvUYTXYxEwnBinzHNj6oflzm0NnQkSJF3LuprfoQxqB+CWJusoabWxJ
         pVlGcld9Lo3ejNYNga61N4u7CWUCB5WV0xTDXIuNvNLfn9N5XXcG5eHG8RTu3P/+fwyl
         KBo3jsqxcyqa1cuTOx/nK1RQ4ylPLuHFsDbZfrKfUZkDJ4AU+D6D3R+/OgZlHSjB2sjY
         qqyg==
X-Gm-Message-State: APjAAAUYoFijwvp++0O4J0QGJ7imDLY/wB/t6tGLJkqhfDyN8uJ/kzU7
        AtcnXIiWv3nEK8FRxF9h04z/qqjn6dM=
X-Google-Smtp-Source: APXvYqyACpFmITg8EvoarcnAAuIN5wM26LTVuXu23a06nlTHZlLTirpcME0z6EoUDrnGoK1sC6Jtag==
X-Received: by 2002:a50:ad23:: with SMTP id y32mr42649768edc.90.1554282651621;
        Wed, 03 Apr 2019 02:10:51 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id r23sm1781322eja.71.2019.04.03.02.10.50
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 02:10:50 -0700 (PDT)
Subject: Re: [PATCH] iio: accel: add missing sensor for some 2-in-1 based
 ultrabooks
To:     =?UTF-8?Q?Lu=c3=ads_Ferreira?= <luis@aurorafoss.org>,
        jic23@kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stephan Gerhold <stephan@gerhold.net>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190402160433.15810-1-luis@aurorafoss.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <55a52a4e-01d1-2f4c-25e3-0047537bef86@redhat.com>
Date:   Wed, 3 Apr 2019 11:10:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190402160433.15810-1-luis@aurorafoss.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02-04-19 18:04, Luís Ferreira wrote:
> Some ultrabooks, like Teclast F6 Pro, use KIOX010A sensor on display
> and KIOX020A sensor on keyboard base, to detect tablet mode or screen
> orientation.

I deliberately left out the KIOX020A id for now, because currently
userspace cannot really deal with having 2 sensors.

See:
https://github.com/systemd/systemd/issues/6557
https://github.com/hadess/iio-sensor-proxy/issues/166

Basically we need to come up with a convention to (optionally) indicate
the sensors location with a udev attribute set by:
/lib/udev/hwdb.d/60-sensor.hwdb

And then patch iio-sensor-proxy to consume that attribute and ignore
the one which has e.g. ACCEL_LOCATION=keyboard in its udev properties

Ignoring would be a first step, maybe later it can do something useful
with it, see e.g. :  https://github.com/alesguzik/linux_detect_tablet_mode

IMHO we really should minimally get code in place for iio-sensor-proxy
to ignore the keyboard accelerometer before merging this patch.

I realize that having the code in place will not magically get it on
all users machines, but I believe this is the minimum which needs to
happen before we push this out and potentially breaks people screen
rotation.

I've had working on this on my TODO list for a long long time now,
but -ENOTIME. If you have some time to work on this then that would
be great.

Regards,

Hans




> 
> Signed-off-by: Luís Ferreira <luis@aurorafoss.org>
> ---
>   drivers/iio/accel/kxcjk-1013.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index 7096e577b23f..9a5e445facc1 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -1492,6 +1492,7 @@ static const struct acpi_device_id kx_acpi_match[] = {
>   	{"KIOX0009", KXTJ21009},
>   	{"KIOX000A", KXCJ91008},
>   	{"KIOX010A", KXCJ91008}, /* KXCJ91008 inside the display of a 2-in-1 */
> +	{"KIOX020A", KXCJ91008},
>   	{"KXTJ1009", KXTJ21009},
>   	{"KXJ2109",  KXTJ21009},
>   	{"SMO8500",  KXCJ91008},
> 
