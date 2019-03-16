Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFC4C4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 17:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C60218FE
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 17:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552758520;
	bh=zfqvj9JtB7otT6UyUIVwQiBiy9Z2CzQtb6MaUrFW2Gc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=tywB8e97Cu6LxZmtQRbrEUnunlMRAhywhxvS2VHOs4JM0FdVYjRJcHUT9DFi8kEGK
	 7Q5NoqDd0VASrj34ctXkzsq19M3xLK2Ykx2P5XTwWer4tJTsfnVg7KFHOqv7kD8aLY
	 eR+vB4Svr4822NW7HWvS7VzGP3cwpE+Oz7XvuG1k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfCPRsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 13:48:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:60084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726549AbfCPRsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 13:48:38 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B770A218D0;
        Sat, 16 Mar 2019 17:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552758518;
        bh=zfqvj9JtB7otT6UyUIVwQiBiy9Z2CzQtb6MaUrFW2Gc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r2NjMQWxQt2vn10NVzP288IzgW3+ZVOHh+960kz6PBXkD8F7lNjXEz+rY0ddHpldj
         FdFIWjVHTfIIrLmy28xYkG43MELF3roTaMJ+TxuEBdXg4nqjIe98ICINtcLPNer9po
         fNPvJFF7M0QVsB5JnziVGmbeWbG68YIHL3BuLhRk=
Date:   Sat, 16 Mar 2019 17:48:31 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Renato Lui Geh <renatogeh@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        giuliano.belinassi@usp.br, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 02/11] staging: iio: ad7780: add missing switch
 default case
Message-ID: <20190316174831.04bd818a@archlinux>
In-Reply-To: <84375be9b21a30dde736e47a7e2f72c1aedf7e92.1552700652.git.renatogeh@gmail.com>
References: <cover.1552700652.git.renatogeh@gmail.com>
        <84375be9b21a30dde736e47a7e2f72c1aedf7e92.1552700652.git.renatogeh@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2019 23:12:53 -0300
Renato Lui Geh <renatogeh@gmail.com> wrote:

> This patch simply adds a missing switch default case in read_raw.
> 
> Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
Applied,

Thanks,

Jonathan

> ---
>  drivers/staging/iio/adc/ad7780.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
> index 07e5e35c92a3..f4cd7bc3e02f 100644
> --- a/drivers/staging/iio/adc/ad7780.c
> +++ b/drivers/staging/iio/adc/ad7780.c
> @@ -118,6 +118,8 @@ static int ad7780_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_OFFSET:
>  		*val = -(1 << (chan->scan_type.realbits - 1));
>  		return IIO_VAL_INT;
> +	default:
> +		break;
>  	}
>  
>  	return -EINVAL;

