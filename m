Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9763BECE58D
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 09:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F2A121479
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 09:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570355837;
	bh=1mAeXC6xQdByjNElffMksG7pUEXmQ6BBlE4Xqu1qO78=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=N7CWCiGRVO23uSzglnGXLns0NhMY0wlK/OPyCKGHEbcnpLtMQOmjt23A56A2hFno6
	 lQyPuODyGnI64EkPs8gcp/6VbEbgDMMFtYNs69aVkqJC8lljch7y7+mvmdBBOy9sOW
	 0R7Ox9k7dCO/7WrxFOItD+HVExTHclF2y+wc+8cU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfJFJ5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 05:57:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbfJFJ5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 05:57:16 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3034120867;
        Sun,  6 Oct 2019 09:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570355835;
        bh=1mAeXC6xQdByjNElffMksG7pUEXmQ6BBlE4Xqu1qO78=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HU0qlJDotgC18EXMonSdnt2A+LuvrLk2ZFoZL5vRTKQ8UObIP59PwqEG5np9uHBuv
         uJ1E8LIhNtq8z8JUW6Zhwvea8p9Ym53jrrnGDy30AErUioddxyMZITv+dmjls8zhIC
         WkG6FtBnD37NfeQ2kgkGN1M5LZZYcfrZSP6VQu+I=
Date:   Sun, 6 Oct 2019 10:57:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 3/4] iio: pressure: bmp280: remove stray newline
Message-ID: <20191006105711.3b118d70@archlinux>
In-Reply-To: <20191002085759.13337-4-brgl@bgdev.pl>
References: <20191002085759.13337-1-brgl@bgdev.pl>
        <20191002085759.13337-4-brgl@bgdev.pl>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  2 Oct 2019 10:57:58 +0200
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Remove a stray newline from the probe callback.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Applied to the togreg branch of iio.git and pushed out as testing for
no particular reason (well for the other patches in that tree ;)

Thanks,

Jonathan

> ---
>  drivers/iio/pressure/bmp280-core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index f22400e1e98f..fdbd3bc27921 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -1131,7 +1131,6 @@ int bmp280_common_probe(struct device *dev,
>  	if (ret)
>  		goto out_runtime_pm_disable;
>  
> -
>  	return 0;
>  
>  out_runtime_pm_disable:

