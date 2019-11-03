Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6DFCA9ED0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 10:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13AA521655
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 10:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572777345;
	bh=V3w2RQvuOUnnJYU5IDKOWV9dQd+Cdb53j/pGq/VNGSA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=l2WDK+zpgKn5QnvfrBDYGRGB3kdtzxlIvTY4t5VQ++KwEz9I77aNK+Cb65vtf82Pc
	 XqUYiEWopE7WHsa8R8eJfMby0Y0Mrc8z8u32jOwtRQFfxSOjpFY4iC+mNhnjc2NsG5
	 PMIB8uWUPwUp29qxWwuN8TZsMuxfsHjOqPjieZTM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfKCKfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 05:35:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:54310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727380AbfKCKfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 05:35:43 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B020F214E0;
        Sun,  3 Nov 2019 10:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572777343;
        bh=V3w2RQvuOUnnJYU5IDKOWV9dQd+Cdb53j/pGq/VNGSA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UJPep7gXP3wzwn7D6R1yPWO9x1iFseKhiH/vQloWkAlt0aAI/KIh9SZhAxMl044ho
         dTxn7OfUdVVy5dbMn9yba6zfsXCY1yReo2exiUTQYrhS//xFAmZ6OwKnavD8ERQ2n5
         6UtoLE2R4zP+NbsjgU7QaBTmZqShX3R2ITjyaKHQ=
Date:   Sun, 3 Nov 2019 10:35:38 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dragos.bogdan@analog.com>
Subject: Re: [PATCH 06/10] iio: imu: adis16480: fix indentation of return
 statement
Message-ID: <20191103103538.36a6dc39@archlinux>
In-Reply-To: <20191101093505.9408-7-alexandru.ardelean@analog.com>
References: <20191101093505.9408-1-alexandru.ardelean@analog.com>
        <20191101093505.9408-7-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Nov 2019 11:35:01 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This is just a minor indentation/alignment fix for the default case of a
> switch statement.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied,

Thanks,

Jonathan

> ---
>  drivers/iio/imu/adis16480.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> index 86801f3c5f0d..d199d3d3c4bd 100644
> --- a/drivers/iio/imu/adis16480.c
> +++ b/drivers/iio/imu/adis16480.c
> @@ -459,7 +459,7 @@ static int adis16480_get_calibbias(struct iio_dev *indio_dev,
>  		*bias = sign_extend32(val32, 31);
>  		break;
>  	default:
> -			ret = -EINVAL;
> +		ret = -EINVAL;
>  	}
>  
>  	if (ret)

