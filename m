Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77ADCC04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A17C217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558596621;
	bh=ujhlpZ5mKhOsSZaVmr89iXdVz9pfrd/drTOvs0yhvHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CQBdugyyJPhyBb5o3+tZaL69t1gtBzPgNuCj8OAmMvUVBxI+xLKy5bA+2LjhskDii
	 de25mnlWXfqSUWi9ar4VtTa4h8gzEPdM99V1kDzsZfcnkN89P44PGiCr/jRrkoDdmu
	 Mi4htz7vo4FoqkPNOhvcGY6OJW/A1UEQ2n1ivdbc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbfEWHaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 03:30:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:36500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726237AbfEWHaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 03:30:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37FD0217D7;
        Thu, 23 May 2019 07:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558596618;
        bh=ujhlpZ5mKhOsSZaVmr89iXdVz9pfrd/drTOvs0yhvHU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EsvtVZ34uzPG9EKYWQ/ck6dXWDhMiNMaXUy8RgTWicMVfjzv0Gq3d9hWEpnS2c7f7
         A4ZmOoJqYgDymznW3xADriW5o0blaYk9VcKquaWaELMQqX0h9LKp9NFONr13IUwTA1
         kdCREoeiugAkVh3XXRIT1f25qbrKID00URKXlSAk=
Date:   Thu, 23 May 2019 09:30:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Shobhit Kukreti <shobhitkukreti@yahoo.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: cleanup to adhere with linux coding style
Message-ID: <20190523073016.GA14393@kroah.com>
References: <20190523010619.GA23217@t-1000>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523010619.GA23217@t-1000>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 06:06:22PM -0700, Shobhit Kukreti wrote:
> The linux coding style emphasizes on a limit of 80 characters
> per line. Cleaned up several over 80 character warnings in following files:
> 
> pi433_if.c
> pi433_if.h
> rf69.c
> 
> Signed-off-by: Shobhit Kukreti <shobhitkukreti@yahoo.com>
> ---
>  drivers/staging/pi433/pi433_if.c | 15 ++++---
>  drivers/staging/pi433/pi433_if.h | 25 +++++++----
>  drivers/staging/pi433/rf69.c     | 89 ++++++++++++++++++++++++----------------
>  3 files changed, 78 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
> index c889f0b..07715c9 100644
> --- a/drivers/staging/pi433/pi433_if.c
> +++ b/drivers/staging/pi433/pi433_if.c
> @@ -439,8 +439,7 @@ pi433_receive(void *data)
>  		/* wait for RSSI level to become high */
>  		dev_dbg(dev->dev, "rx: going to wait for high RSSI level");
>  		retval = wait_event_interruptible(dev->rx_wait_queue,
> -						  rf69_get_flag(dev->spi,
> -								rssi_exceeded_threshold));
> +			rf69_get_flag(dev->spi,	rssi_exceeded_threshold));

Ick, no.  The original code is fine here, this makes it much harder to
understand what is going on here, right?

>  		if (retval) /* wait was interrupted */
>  			goto abort;
>  		dev->interrupt_rx_allowed = false;
> @@ -475,7 +474,7 @@ pi433_receive(void *data)
>  	/* length byte enabled? */
>  	if (dev->rx_cfg.enable_length_byte == OPTION_ON) {
>  		retval = wait_event_interruptible(dev->fifo_wait_queue,
> -						  dev->free_in_fifo < FIFO_SIZE);
> +					dev->free_in_fifo < FIFO_SIZE);

Same for this, and all the other changes you made.  The 80 column "rule"
is just a strong hint.  There are other ways to remove it instead of
just moving code to the left like you did here, if you really want to
fix these warnings up.

thanks,

greg k-h
