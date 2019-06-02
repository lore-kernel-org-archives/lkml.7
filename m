Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9282C282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 17:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC1027988
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 17:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559495672;
	bh=XhgP32rmdsWxmUTRcXv8U1Z/e+VjjTogQh8d84QWsqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fkbP0fUie0N9y+46NuVUexG4Oy/7cMtoF/J4jymqDw0st5eAOpAYHmHggH16LMD4P
	 oyHcdAy85s455jFCtZs+CgBCDKXdtwu9LxQv89yuX8jEdfupfkYTkjj9kdCECwsULY
	 kICqsp2QDa4eEwsG1YOLmOAH6dv3VeJAOdQTAxV8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfFBROb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 13:14:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:54344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbfFBROb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 13:14:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D6C427988;
        Sun,  2 Jun 2019 17:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559495669;
        bh=XhgP32rmdsWxmUTRcXv8U1Z/e+VjjTogQh8d84QWsqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kQ2T+JYP3lY0tbU2I/sEF+6i1kqq36UvOKXfzebPY2QmUW4CZAuqJWfGA6O7I7ZdZ
         PN8lnfi+Z1uD1U7uJicJ7tBYzh4vZoKARXMctfzH2RWFlCWKwW0GjevPvHB/SIdDvT
         fI9Er7zq+R5WnJh8URoFzOdSnHJwHqpWfNl1G7AM=
Date:   Sun, 2 Jun 2019 19:14:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Deepak Mishra <linux.dkm@gmail.com>
Cc:     linux-kernel@vger.kernel.org, joe@perches.com, wlanfae@realtek.com,
        Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        himadri18.07@gmail.com, straube.linux@gmail.com
Subject: Re: [PATCH v2 8/9] staging: rtl8712: fixed enable_rx_ff0_filter as
 bool and CamelCase
Message-ID: <20190602171427.GE19671@kroah.com>
References: <cover.1559470737.git.linux.dkm@gmail.com>
 <7b32a7cf85ef0c3f6d2ba82480a1f8d0ad651779.1559470738.git.linux.dkm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b32a7cf85ef0c3f6d2ba82480a1f8d0ad651779.1559470738.git.linux.dkm@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 02, 2019 at 03:55:37PM +0530, Deepak Mishra wrote:
> This patch fixes CamelCase blnEnableRxFF0Filter by renaming it
> to enable_rx_ff0_filter in drv_types.h and related files rtl871x_cmd.c
> xmit_linux.c
> It was reported by checkpatch.pl
> 
> This fix also makes enable_rx_ff0_filter a bool and uses true false than
> previously used u8 as suggested by joe@perches.com
> 
> Signed-off-by: Deepak Mishra <linux.dkm@gmail.com>
> ---
>  drivers/staging/rtl8712/drv_types.h   | 2 +-
>  drivers/staging/rtl8712/rtl871x_cmd.c | 2 +-
>  drivers/staging/rtl8712/xmit_linux.c  | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/drv_types.h b/drivers/staging/rtl8712/drv_types.h
> index ddab6514a549..e3e2b32e964e 100644
> --- a/drivers/staging/rtl8712/drv_types.h
> +++ b/drivers/staging/rtl8712/drv_types.h
> @@ -164,7 +164,7 @@ struct _adapter {
>  	struct iw_statistics iwstats;
>  	int pid; /*process id from UI*/
>  	struct work_struct wk_filter_rx_ff0;
> -	u8 blnEnableRxFF0Filter;
> +	bool enable_rx_ff0_filter;
>  	spinlock_t lockRxFF0Filter;
>  	const struct firmware *fw;
>  	struct usb_interface *pusb_intf;
> diff --git a/drivers/staging/rtl8712/rtl871x_cmd.c b/drivers/staging/rtl8712/rtl871x_cmd.c
> index 05a78ac24987..6a8d58d97873 100644
> --- a/drivers/staging/rtl8712/rtl871x_cmd.c
> +++ b/drivers/staging/rtl8712/rtl871x_cmd.c
> @@ -238,7 +238,7 @@ u8 r8712_sitesurvey_cmd(struct _adapter *padapter,
>  	mod_timer(&pmlmepriv->scan_to_timer,
>  		  jiffies + msecs_to_jiffies(SCANNING_TIMEOUT));
>  	padapter->ledpriv.LedControlHandler(padapter, LED_CTL_SITE_SURVEY);
> -	padapter->blnEnableRxFF0Filter = 0;
> +	padapter->enable_rx_ff0_filter = false;
>  	return _SUCCESS;
>  }
>  
> diff --git a/drivers/staging/rtl8712/xmit_linux.c b/drivers/staging/rtl8712/xmit_linux.c
> index e65a51c7f372..9fa1abcf5e50 100644
> --- a/drivers/staging/rtl8712/xmit_linux.c
> +++ b/drivers/staging/rtl8712/xmit_linux.c
> @@ -103,11 +103,11 @@ void r8712_SetFilter(struct work_struct *work)
>  	r8712_write8(padapter, 0x117, newvalue);
>  
>  	spin_lock_irqsave(&padapter->lockRxFF0Filter, irqL);
> -	padapter->blnEnableRxFF0Filter = 1;
> +	padapter->enable_rx_ff0_filter = true;
>  	spin_unlock_irqrestore(&padapter->lockRxFF0Filter, irqL);
>  	do {
>  		msleep(100);
> -	} while (padapter->blnEnableRxFF0Filter == 1);
> +	} while (padapter->enable_rx_ff0_filter == true);

That is horrible, and I'm amazed it ever even works.  Please fix this
properly, spinning on a random variable is not how you do
synchronization in the kernel.

thanks,

greg k-h
