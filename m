Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A25EC2D0D2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 17:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFFD720715
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 17:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577122338;
	bh=2rDgXwuhvZDpIhLSEhOfmXGzaHSH8W7rnF14GxUhkqc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=OQhNRORBz4Sjrcbds05kjuDPUd1ZYxjViPgJtsQzQTGIBfHY0kxwiJh6XkM6IZEUC
	 9lPQiCAu5v3OQPdgXIO7dZCgQ6Wa/IpWDRdbNahT0fwDvBXVmqUTBY4K6EXrcSeUIV
	 h5mRuVe8ok9wfapdn98Co23bSl/5rI3EI4cpHZJE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfLWRcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 12:32:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:57406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbfLWRcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 12:32:17 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBC27206CB;
        Mon, 23 Dec 2019 17:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577122336;
        bh=2rDgXwuhvZDpIhLSEhOfmXGzaHSH8W7rnF14GxUhkqc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t4kwWoL0Xs+RDGoxhIqMxDkt6SM14omwRZj1EwM1Mmea9kn5Cj/yCgGvrDVDps2uB
         CePJ6iaLMf5Z+v4pine5eG4RrsGfifYbTG3U2hal9BT6OKSOn4zhUPeLq8kxMwHFOk
         YW/cjbKxg0V5dK3Xc4wsXMYkT2++jtVLfJVx9yL4=
Date:   Mon, 23 Dec 2019 17:32:12 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] iio: buffer-dmaengine: Add module information
Message-ID: <20191223173212.58608ffe@archlinux>
In-Reply-To: <20191211104147.13368-1-alexandru.ardelean@analog.com>
References: <20191211104147.13368-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Dec 2019 12:41:47 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Lars-Peter Clausen <lars@metafoo.de>
> 
> Make sure that the industrialio-buffer-dmaengine has proper license
> information so it can be build as a module and loaded without tainting the
> kernel.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied,

Thanks,

Jonathan

> ---
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> index b7b5a934e9b2..e0b92f3dec0e 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> @@ -10,6 +10,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/spinlock.h>
>  #include <linux/err.h>
> +#include <linux/module.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/buffer.h>
> @@ -206,3 +207,7 @@ void iio_dmaengine_buffer_free(struct iio_buffer *buffer)
>  	iio_buffer_put(buffer);
>  }
>  EXPORT_SYMBOL_GPL(iio_dmaengine_buffer_free);
> +
> +MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
> +MODULE_DESCRIPTION("DMA buffer for the IIO framework");
> +MODULE_LICENSE("GPL");

