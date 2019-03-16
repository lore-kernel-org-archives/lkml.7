Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F9CC4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 16:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DA1D21905
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 16:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552752761;
	bh=/5b+ANOtHKOwvgHuTR8zgKIPb4vTZpgq83bW+EK0ACY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Kadd4XOmdI78R8gVpbZbOPRQ3BKXFJGht8bm6M5Inb6BXEHkdnIsYbdWpSlJ1so5r
	 q6yPDRb+hj1RsrVIKvjGL7K3WCplYX5AkxXwj8UD+K9y0U6yf1LFXTRgauZstgWlOG
	 z8e8lVerJpX6wcce7mQsfF5WPaLGoWw/wgmU7nUM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfCPQMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 12:12:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:34554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbfCPQMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 12:12:39 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C155A2075C;
        Sat, 16 Mar 2019 16:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552752759;
        bh=/5b+ANOtHKOwvgHuTR8zgKIPb4vTZpgq83bW+EK0ACY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1HJzc9b0hbHNRmxRfDcJfv5c8wdYa7Z0MydNKiZe43O4Xt+P9wIaKKafKEZZS9KZk
         xwY9pyz2wYdU69UPRxW7jOZdCx9kCbcecOBmiOP3BG+tgGv3WU7I6np/bC8edKPpL7
         ALEFID7jVqNBRmk4t2U9TdPu0F2IXFOZTsH8PO6A=
Date:   Sat, 16 Mar 2019 16:12:33 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@collabora.com,
        Hartmut Knaack <knaack.h@gmx.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH] iio: cros_ec: Add kernel-doc for
 cros_ec_sensors_read_lpc
Message-ID: <20190316161233.3c46bce5@archlinux>
In-Reply-To: <20190313114050.11625-1-enric.balletbo@collabora.com>
References: <20190313114050.11625-1-enric.balletbo@collabora.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2019 12:40:50 +0100
Enric Balletbo i Serra <enric.balletbo@collabora.com> wrote:

> From: Gwendal Grignou <gwendal@chromium.org>
> 
> Document cros_ec_sensors_read_lpc, adding an additional note to explain
> that this is the safe function for reading the EC data.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Applied,

Thanks

Jonathan

> ---
> 
>  .../iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index c770a2a809d7..eb7b0edd5da4 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -268,6 +268,17 @@ static int cros_ec_sensors_read_data_unsafe(struct iio_dev *indio_dev,
>  	return 0;
>  }
>  
> +/**
> + * cros_ec_sensors_read_lpc() - read acceleration data from EC shared memory.
> + * @indio_dev: pointer to IIO device.
> + * @scan_mask: bitmap of the sensor indices to scan.
> + * @data: location to store data.
> + *
> + * Note: this is the safe function for reading the EC data. It guarantees
> + * that the data sampled was not modified by the EC while being read.
> + *
> + * Return: 0 on success, -errno on failure.
> + */
>  int cros_ec_sensors_read_lpc(struct iio_dev *indio_dev,
>  			     unsigned long scan_mask, s16 *data)
>  {

