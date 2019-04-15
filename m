Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1524AC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7D26206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555332169;
	bh=3ehra9pEjwB3wD+TJShFg941dUD/gYPSzElQ/xEu8IE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=faSy5v+lhNin9IyDsmhyM7bKjv9GbEQUGMthyT4gpASrVeg+ALSyTpp0ap5eBPB2T
	 2kn+rSCeQ8rQH1lDaNYpjOmqPtVB6rPAlzpgD+aBWcPtBNv4ZEUHC6HcQty4Gi9vo6
	 DdtJWTcCUWSjtZjWd6vIGTJua5psfeFNxbEgt9yA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfDOMms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:42:48 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37115 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfDOMms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:42:48 -0400
Received: by mail-lf1-f65.google.com with SMTP id o19so8628545lfl.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 05:42:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QevlROqKMtYbw13+04VcNevca+AxhD9oes9cw+EzX30=;
        b=aAUaGGFGO6thfsapCzqaDl5Fwg6Zgmwp/viI1eQo64d9+6R2AfJ/HdnamnHU39IOoj
         HQjIidp3D6zA3xLC1vw3tHjjq5c6D1/hrmYW4y37aOMR0NS8T+VI0LNjtgKWXta2Gv12
         KYBmkxwQrlQAQibWroMgy3oJcy4vi4eh9EiEdua5U/BI+zHr9jzYvo0nRTHnBai0dCnh
         68oqJF8JwjcKBOJS+s5IyqSbO8wh23bsZhA+ZQYR8oz6QA7gOtqt8iO9G2vop3n6KfOT
         SWfpMf3XGN1odxi4YK4XZ95AK4wqO3o3Q2bq5HTZ2zQaPmrhwsTFq90yM4489Yj1J40P
         mzoA==
X-Gm-Message-State: APjAAAVpnPX2GekoRKIUCDhstdpPTsYJFH58wtP/MJ3xVgBzHkZiWJQk
        +HEF1I3d1wH9fqDOKexh5t6uorLE
X-Google-Smtp-Source: APXvYqz47ahLZrOArrbwxxieNUvBBzcakkVhJfvSutQA2hfbG/+o6NMFvv2pu+ZhXpo4vPqAAc7w2g==
X-Received: by 2002:a19:ae0a:: with SMTP id f10mr38294485lfc.118.1555332165894;
        Mon, 15 Apr 2019 05:42:45 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id o12sm6770089lfl.66.2019.04.15.05.42.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 05:42:45 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1hG0wk-0000aT-Ly; Mon, 15 Apr 2019 14:42:50 +0200
Date:   Mon, 15 Apr 2019 14:42:50 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Will Cunningham <wjcunningham7@gmail.com>
Cc:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: greybus: usb: Fixed a coding style error
Message-ID: <20190415124250.GA775@localhost>
References: <20190331053040.GA12974@titus.pi.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190331053040.GA12974@titus.pi.local>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 01:30:40AM -0400, Will Cunningham wrote:
> Line was >80 characters.
> 
> Signed-off-by: Will Cunningham <wjcunningham7@gmail.com>
> ---
>  drivers/staging/greybus/usb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/greybus/usb.c b/drivers/staging/greybus/usb.c
> index 1c246c73a085..5b4cbec88159 100644
> --- a/drivers/staging/greybus/usb.c
> +++ b/drivers/staging/greybus/usb.c
> @@ -169,8 +169,8 @@ static int gb_usb_probe(struct gbphy_device *gbphy_dev,
>  		return -ENOMEM;
>  
>  	connection = gb_connection_create(gbphy_dev->bundle,
> -					  le16_to_cpu(gbphy_dev->cport_desc->id),
> -					  NULL);
> +				le16_to_cpu(gbphy_dev->cport_desc->id),
> +				NULL);

As others have already pointed out in this thread, there's no need to
fix anything here.

The 80 column rule is not absolute in any way, and having a line be 81
characters if that improves readability is just fine.

Johan
