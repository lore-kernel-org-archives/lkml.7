Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B160C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 10:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67AEE21734
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 10:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgABKmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 05:42:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:57050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728044AbgABKmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 05:42:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1955621655;
        Thu,  2 Jan 2020 10:42:48 +0000 (UTC)
Date:   Thu, 2 Jan 2020 11:42:47 +0100
From:   Greg KH <greg@kroah.com>
To:     linux-kernel@vger.kernel.org
Cc:     yonghan.ye@unisoc.com, stable-commits@vger.kernel.org
Subject: Re: Patch "serial: sprd: Use readable macros instead of magic
 number" has been added to the 4.19-stable tree
Message-ID: <20200102104247.GA3927938@kroah.com>
References: <20200102022406.2ADD8215A4@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200102022406.2ADD8215A4@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 01, 2020 at 09:24:05PM -0500, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     serial: sprd: Use readable macros instead of magic number
> 
> to the 4.19-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      serial-sprd-use-readable-macros-instead-of-magic-num.patch
> and it can be found in the queue-4.19 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit b8917f323e25835c0ac8d02cba9253bcd79040cf
> Author: Yonghan Ye <yonghan.ye@unisoc.com>
> Date:   Wed Dec 4 20:00:07 2019 +0800
> 
>     serial: sprd: Use readable macros instead of magic number
>     
>     [ Upstream commit 2b5a997386b0594e671a32c7e429cf59ac8fc54c ]
>     
>     Define readable macros instead of magic number to make code more readable.
>     
>     Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>     Acked-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
> index 2774af86763e..c6cad45cd34b 100644
> --- a/drivers/tty/serial/sprd_serial.c
> +++ b/drivers/tty/serial/sprd_serial.c
> @@ -294,6 +294,9 @@ static irqreturn_t sprd_handle_irq(int irq, void *dev_id)
>  	if (ims & SPRD_IMSR_TIMEOUT)
>  		serial_out(port, SPRD_ICLR, SPRD_ICLR_TIMEOUT);
>  
> +	if (ims & SPRD_IMSR_BREAK_DETECT)
> +		serial_out(port, SPRD_ICLR, SPRD_IMSR_BREAK_DETECT);
> +
>  	if (ims & (SPRD_IMSR_RX_FIFO_FULL |
>  		SPRD_IMSR_BREAK_DETECT | SPRD_IMSR_TIMEOUT))
>  		sprd_rx(port);

Something went wrong here.  The above patch does not match the
description of the original commit and changelog at all.

I'll go drop this patch from all stable trees now.

thanks,

greg k-h
