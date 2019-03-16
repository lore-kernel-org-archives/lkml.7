Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7245FC4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 18:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45A3E218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 18:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552761418;
	bh=JRy4/LlN+M/2emxw+uMISN8talfwYN8kYC4PyVZ7wko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=2FfudEQjx+1sTancjhbZY4PP0TYkDX7YmxsScZipaDoyHFE5SzBcog0pHeytLQrXz
	 5ckOeAFdEROWgCkQpN0RiJmqpiROQ1ujJ26psOx/G1wfzu96mmzgZBH2GthMNCzA7S
	 KuJVJMynU65WjB08UwO6u6wu6GKn95yX1sumCQQ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfCPSg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 14:36:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:46248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726376AbfCPSg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 14:36:56 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 343B3218A1;
        Sat, 16 Mar 2019 18:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552761416;
        bh=JRy4/LlN+M/2emxw+uMISN8talfwYN8kYC4PyVZ7wko=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PquzAfqYU/nqhoFMsK5mYAAaLf61+ow7aTyXKfZIdhAuH2htPDpt8/rKy0NJC/nw2
         dfPRc2WbYJJY/fT+QAI6MCnp/SAHNoXbxC+hB0gK0hRyw+PGU2GZaE7cqi/YiXUohX
         5wjsPd/GgWf/afNoMA3xiOsECgcbpD5d6Gpu91CU=
Date:   Sat, 16 Mar 2019 18:36:50 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH v4 2/7] staging: iio: ad5933: organize includes
Message-ID: <20190316183650.4ce97b18@archlinux>
In-Reply-To: <20190316150650.jke4uqgnf5w6s3cv@smtp.gmail.com>
References: <20190316150650.jke4uqgnf5w6s3cv@smtp.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Mar 2019 12:06:50 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Organize includes to list them in lexicographic order.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Applied. Thanks

> ---
>  .../staging/iio/impedance-analyzer/ad5933.c    | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index 05e2185bfdae..c2a7a59e469c 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -6,22 +6,22 @@
>   * Licensed under the GPL-2.
>   */
>  
> -#include <linux/interrupt.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
>  #include <linux/device.h>
> -#include <linux/kernel.h>
> -#include <linux/sysfs.h>
> +#include <linux/err.h>
>  #include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/sysfs.h>
>  #include <linux/types.h>
> -#include <linux/err.h>
> -#include <linux/delay.h>
> -#include <linux/module.h>
> -#include <linux/clk.h>
>  
> -#include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
>  #include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
>  #include <linux/iio/kfifo_buf.h>
> +#include <linux/iio/sysfs.h>
>  
>  /* AD5933/AD5934 Registers */
>  #define AD5933_REG_CONTROL_HB		0x80	/* R/W, 1 byte */

