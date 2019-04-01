Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C142BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BA1220857
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kLiEmnBm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbfDAOZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 10:25:48 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44921 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfDAOZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 10:25:47 -0400
Received: by mail-pf1-f193.google.com with SMTP id y13so4645488pfm.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 07:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A0A/Xk+iMrsnAE1oB84dEjb1gdH4QwsHq+IMH3dNJbE=;
        b=kLiEmnBmSfKY+9qgBey+36Ss1nq8xGLVc6iXUySpSui8lOAXe7CngSbiGwSeyqaUaW
         GaRvL0KH4wdHoRM01XqfFz45lPvRqVoUYIpSiafJkiIdElKIH1fy3RqZHeJjlM7yfoNf
         NeyfAoEQg5rBm5S5IhWY4aeVad3hX+EtHSahAWXS150CV2Hd/p8XoKMPp3N5dJkLL5VB
         3ozcEE365xpWOXHUZkooFuJqJmDLAwUbCsieJUKV0lxdWtgAsC5UDsu2JJe/qXASmg78
         NpknL30Eo71MhhecufQVq2JiF5hROTSsKDcHT4b4FFfxK90ewQOBTSqZRItUyc/OnR9t
         hGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A0A/Xk+iMrsnAE1oB84dEjb1gdH4QwsHq+IMH3dNJbE=;
        b=ieMOmij3hWwxjE1JhW7Hr+24MhnMC0P4T73Ocr/J6bObKnPPgcGY1ewhFCVPocoGJf
         5Nk8QzhiPPjJO5nYohFWR5dSuW9rrxuBtw65SVartIbQp72OhsqYtt6uMxCKRLh58F+E
         8+xTyuN57ejsn8NlVef/jjU6OcWkrtaVoqCWFrEg2wWPxwJjq089Ui5lKRSryPQDLFrM
         sMWZCtGIV/OoY6udrnFos6AeHRTLp+gYDdzKM6wpLrKzeJX6IL12UZPRXn9o7RuZSnqO
         pk/0XJ2FuHpMCyV5DI6nWkydxYCV6L5cbtuxfskNgYlyV+tEXxXAVDq9261LmL6dRwfX
         7Ilg==
X-Gm-Message-State: APjAAAW6QTn2l1Z8croYoDnSEkViyvSlVdWJu0U2VeGI+awcfrT4wpH7
        lMmu0QDVpcvejL3ZhXF5LdsQCA==
X-Google-Smtp-Source: APXvYqxOuXbhUgRh8yeVP4jsQnbf9CYU9bEJtBbOtWA1WwuBsCz6Syce1id5MKYAzzMflVmflfPCpQ==
X-Received: by 2002:a63:4f1c:: with SMTP id d28mr7912862pgb.144.1554128746962;
        Mon, 01 Apr 2019 07:25:46 -0700 (PDT)
Received: from [10.71.8.213] ([147.50.13.10])
        by smtp.googlemail.com with ESMTPSA id l184sm17051039pfc.98.2019.04.01.07.25.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 07:25:46 -0700 (PDT)
Subject: Re: [PATCH v2] Staging: greybus: usb: Fixed a coding style error
To:     Will Cunningham <wjcunningham7@gmail.com>, johan@kernel.org
Cc:     elder@kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        joe@perches.com
References: <20190401142208.GA12744@titus.pi.local>
From:   Alex Elder <elder@linaro.org>
Message-ID: <21036602-c062-8f32-ee81-7eb80f348982@linaro.org>
Date:   Mon, 1 Apr 2019 09:25:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190401142208.GA12744@titus.pi.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/19 9:22 AM, Will Cunningham wrote:
> Line was >80 characters.

This looks fine, but "tmp" is not a meaningful name.
That argument to gb_connection_create() is a cport id,
so "cport_id" would be a much better name for the variable.

It seems picky, but details like this make the code much
more understandable.

					-Alex


> Signed-off-by: Will Cunningham <wjcunningham7@gmail.com>
> ---
> Changes in v2:
>  - Created a tmp variable to shorten line length.
> ---
>  drivers/staging/greybus/usb.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/greybus/usb.c b/drivers/staging/greybus/usb.c
> index 1c246c73a085..c09793b48850 100644
> --- a/drivers/staging/greybus/usb.c
> +++ b/drivers/staging/greybus/usb.c
> @@ -163,14 +163,14 @@ static int gb_usb_probe(struct gbphy_device *gbphy_dev,
>  	struct gb_usb_device *gb_usb_dev;
>  	struct usb_hcd *hcd;
>  	int retval;
> +	u16 tmp;
>  
>  	hcd = usb_create_hcd(&usb_gb_hc_driver, dev, dev_name(dev));
>  	if (!hcd)
>  		return -ENOMEM;
>  
> -	connection = gb_connection_create(gbphy_dev->bundle,
> -					  le16_to_cpu(gbphy_dev->cport_desc->id),
> -					  NULL);
> +	tmp = le16_to_cpu(gbphy_dev->cport_desc->id);
> +	connection = gb_connection_create(gbphy_dev->bundle, tmp, NULL);
>  	if (IS_ERR(connection)) {
>  		retval = PTR_ERR(connection);
>  		goto exit_usb_put;
> 

