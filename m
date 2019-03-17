Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C24C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 11:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F362184C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 11:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552821825;
	bh=oEjOm13wzXktK/qqg7j5Spwww/291uTBU5GuuaZG4kY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AztsWP+pCMujpo4rD82zFOh2G3dKFrqIn10XGAevHTAY+0CtjH7BG8z3NLK4CuM42
	 NgsDT9/RemgqaHCgsFqigPzj8J7xWJC2zHG6Q1Wxn3pO6oZM9QFr03Dc15FGY/fD1t
	 0WWcs9Wksbp3qH4umAhgoefCm/azY66lcmQ3WKNE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfCQLXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 07:23:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:59054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbfCQLXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 07:23:44 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBB1B21738;
        Sun, 17 Mar 2019 11:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552821823;
        bh=oEjOm13wzXktK/qqg7j5Spwww/291uTBU5GuuaZG4kY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uWrcJpMMZWG/C2g2CUL69531Gm6A4kZU0WNRABgvwYNPASOyu23QGLnTnf/GUek+C
         5sc/TKMsN4BACqYEnsUUU34e3uPf46z4Q+AbMJooFYTkZpadfVPc9i0q8fe36Y2Bya
         hWshpXlxXak+6X/AexmLHKy2JvARwH5Zz4SIoiN8=
Date:   Sun, 17 Mar 2019 12:23:39 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ignacio Losiggio <iglosiggio@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ignacio Losiggio <iglosiggio@dc.uba.ar>
Subject: Re: [PATCH] staging: gdm724x: Fix alignment in gdm_mux
Message-ID: <20190317112339.GD4614@kroah.com>
References: <20190309175614.15354-1-iglosiggio@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190309175614.15354-1-iglosiggio@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 09, 2019 at 02:56:14PM -0300, Ignacio Losiggio wrote:
> This patch modifies the alignment and linebreaks in gdm_mux in order to make
> the code more concise.

"concise"?

For some of these, there is no real change needed, it's all up to the
author's "taste", so they are not needed.

> 
> Signed-off-by: Ignacio Losiggio <iglosiggio@dc.uba.ar>
> ---
>  drivers/staging/gdm724x/gdm_mux.c | 35 ++++++++++++++-----------------
>  drivers/staging/gdm724x/gdm_mux.h |  2 +-
>  2 files changed, 17 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/staging/gdm724x/gdm_mux.c b/drivers/staging/gdm724x/gdm_mux.c
> index e2a050ba6fbb..be13de12ce9f 100644
> --- a/drivers/staging/gdm724x/gdm_mux.c
> +++ b/drivers/staging/gdm724x/gdm_mux.c
> @@ -164,8 +164,7 @@ static int up_to_host(struct mux_rx *r)
>  
>  		total_len = ALIGN(MUX_HEADER_SIZE + payload_size, 4);
>  
> -		if (len - packet_size_sum <
> -			total_len) {
> +		if (len - packet_size_sum < total_len) {

This is good.

>  			pr_err("invalid payload : %d %d %04x\n",
>  			       payload_size, len, packet_type);
>  			break;
> @@ -178,11 +177,10 @@ static int up_to_host(struct mux_rx *r)
>  		}
>  
>  		ret = r->callback(mux_header->data,
> -				payload_size,
> -				index,
> -				mux_dev->tty_dev,
> -				RECV_PACKET_PROCESS_CONTINUE
> -				);
> +		                  payload_size,
> +				  index,
> +				  mux_dev->tty_dev,
> +				  RECV_PACKET_PROCESS_CONTINUE);

Shouldn't you make some of these lines longer to make less lines?

>  		if (ret == TO_HOST_BUFFER_REQUEST_FAIL) {
>  			r->offset += packet_size_sum;
>  			break;
> @@ -191,11 +189,10 @@ static int up_to_host(struct mux_rx *r)
>  		packet_size_sum += total_len;
>  		if (len - packet_size_sum <= MUX_HEADER_SIZE + 2) {
>  			ret = r->callback(NULL,
> -					0,
> -					index,
> -					mux_dev->tty_dev,
> -					RECV_PACKET_PROCESS_COMPLETE
> -					);
> +					  0,
> +					  index,
> +					  mux_dev->tty_dev,
> +					  RECV_PACKET_PROCESS_COMPLETE);

Same here.

>  			break;
>  		}
>  	}
> @@ -376,8 +373,8 @@ static int gdm_mux_send(void *priv_dev, void *data, int len, int tty_index,
>  	mux_header->packet_type = __cpu_to_le16(packet_type[tty_index]);
>  
>  	memcpy(t->buf + MUX_HEADER_SIZE, data, len);
> -	memset(t->buf + MUX_HEADER_SIZE + len, 0, total_len - MUX_HEADER_SIZE -
> -	       len);
> +	memset(t->buf + MUX_HEADER_SIZE + len, 0,
> +	       total_len - MUX_HEADER_SIZE - len);

this is good.

>  
>  	t->len = total_len;
>  	t->callback = cb;
> @@ -418,8 +415,7 @@ static int gdm_mux_send_control(void *priv_dev, int request, int value,
>  			      2,
>  			      buf,
>  			      len,
> -			      5000
> -			     );
> +			      5000);

Again, you can shorten the number of lines needed here.

>  
>  	if (ret < 0)
>  		pr_err("usb_control_msg error: %d\n", ret);
> @@ -429,9 +425,10 @@ static int gdm_mux_send_control(void *priv_dev, int request, int value,
>  
>  static void release_usb(struct mux_dev *mux_dev)
>  {
> -	struct rx_cxt		*rx = &mux_dev->rx;
> -	struct mux_rx		*r, *r_next;
> -	unsigned long		flags;
> +	struct rx_cxt *rx = &mux_dev->rx;
> +	struct mux_rx *r;
> +	struct mux_rx *r_next;
> +	unsigned long flags;

No need to change this at all.

>  
>  	cancel_delayed_work(&mux_dev->work_rx);
>  
> diff --git a/drivers/staging/gdm724x/gdm_mux.h b/drivers/staging/gdm724x/gdm_mux.h
> index 51c22e3d8aeb..5bfb95be3ed3 100644
> --- a/drivers/staging/gdm724x/gdm_mux.h
> +++ b/drivers/staging/gdm724x/gdm_mux.h
> @@ -13,7 +13,7 @@
>  #define PM_NORMAL 0
>  #define PM_SUSPEND 1
>  
> -#define USB_RT_ACM          (USB_TYPE_CLASS | USB_RECIP_INTERFACE)
> +#define USB_RT_ACM (USB_TYPE_CLASS | USB_RECIP_INTERFACE)

No tab?

thanks,

greg k-h
