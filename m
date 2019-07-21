Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342B8C76195
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 17:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A3D32147A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 17:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563729152;
	bh=4gliWQDIsy0LeosbL7KpJajk6ahJM7qvmcIXZDx35hE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=YDnIXlkRKnqkLLx1OeRsTo136kiQ5RqxYTYWVXYWWX0fMrO2toxnGL7XeZ1jT92XQ
	 YZm8Sk7h5etMsf6PwCjZw3/dVRyqDYiEgW0SlkyZ7/eJLNES7C+jK5rv900Oh3fIn2
	 3z0LNIcMAmSpLq5ZnUNFywsr/6mD5TemFhvn6RSg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfGURMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 13:12:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:48316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbfGURMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 13:12:30 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9445C20823;
        Sun, 21 Jul 2019 17:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563729149;
        bh=4gliWQDIsy0LeosbL7KpJajk6ahJM7qvmcIXZDx35hE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0jEOVhcuwYt2tsFJP/KD5qJCb7/+LrT3NQFtf02guN+BZ6V+nnSoYxqfF+qYpqolT
         h3OET8gh7ZmsCzAoDcBPI29o8OZv+hRSktY4buK93CkkAZBtpHZk77iRXMjJ0+/Jwv
         R19JgI6FQ8vK84ctdnFVRNfV7YgvXLAijIHR88kc=
Date:   Sun, 21 Jul 2019 18:12:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        broonie@kernel.org, dpfrey@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: light: apds9960: Fix a typo
Message-ID: <20190721181224.4ba408d0@archlinux>
In-Reply-To: <20190721104918.30253-1-christophe.jaillet@wanadoo.fr>
References: <20190721104918.30253-1-christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Jul 2019 12:49:18 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> s/ADPS9960/APDS9960/
> (P and D switched)
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Applied. Thanks

Jonathan

> ---
>  drivers/iio/light/apds9960.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
> index b09b8b60bd83..c5dfb9a6b5a1 100644
> --- a/drivers/iio/light/apds9960.c
> +++ b/drivers/iio/light/apds9960.c
> @@ -1135,5 +1135,5 @@ static struct i2c_driver apds9960_driver = {
>  module_i2c_driver(apds9960_driver);
>  
>  MODULE_AUTHOR("Matt Ranostay <matt.ranostay@konsulko.com>");
> -MODULE_DESCRIPTION("ADPS9960 Gesture/RGB/ALS/Proximity sensor");
> +MODULE_DESCRIPTION("APDS9960 Gesture/RGB/ALS/Proximity sensor");
>  MODULE_LICENSE("GPL");

