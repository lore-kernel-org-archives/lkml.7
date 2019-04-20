Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D2AC282E2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 19:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 083BB217F9
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 19:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555789868;
	bh=IWyxSI3pim/NYOfv+ZVrKFJhmS8+s9EwNEOMIt55IjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k21vqafCkB2boWoh15jLs2KROn7BwJRBCAZSRuiBpJUo+g30UeQWe+H+Tt+GZ/9kd
	 gCN3aWmsWmyk8WNVsu7hPX3FUJWDklxrMwEit+qdVG+5TGMgOXigAvbvBwSo3TUYfd
	 lB8l+QQPwdkfbXGEzxJlu+nm3YlshBwPIMCcBJKk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfDTTvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 15:51:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbfDTTvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 15:51:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED67520833;
        Sat, 20 Apr 2019 19:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555789865;
        bh=IWyxSI3pim/NYOfv+ZVrKFJhmS8+s9EwNEOMIt55IjE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Au4yafySDZxTkow5xWlbMBUWp+QNkxTgzp2WdPoLOrxR6v5KPYTl8lkQp54eYXn1o
         HPTNkV0GGeOp3tMuqtssXMPzubStFJhkWY8nnmzjdgrIDujhVhcJ5cUMbAOZWJe3uG
         On3YuxIjVK4lpQzWUBE1UHfmZaewTOx64nVyP7dU=
Date:   Sat, 20 Apr 2019 21:51:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Madhumitha Prabakaran <madhumithabiw@gmail.com>
Cc:     eric@anholt.net, stefan.wahren@i2se.com, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Staging: vc04_services: Cleanup in ctrl_set_bitrate()
Message-ID: <20190420195103.GA18489@kroah.com>
References: <20190420165644.11892-1-madhumithabiw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190420165644.11892-1-madhumithabiw@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2019 at 11:56:44AM -0500, Madhumitha Prabakaran wrote:
> Remove unnecessary variable and replace return type.
> In addition to that align the function parameters with parentheses to
> maintain Linux coding style.
> 
> Issue suggested by Coccinelle.
> 
> Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>
> 
> ---
> Changes in v2
> 
> 1) Fix my own error of removing function call from the variable.
> 2) Align the function parameters with parentheses.
> 
> ---
> ---
>  .../staging/vc04_services/bcm2835-camera/controls.c    | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/bcm2835-camera/controls.c b/drivers/staging/vc04_services/bcm2835-camera/controls.c
> index e39ab5fae724..71eb349c3138 100644
> --- a/drivers/staging/vc04_services/bcm2835-camera/controls.c
> +++ b/drivers/staging/vc04_services/bcm2835-camera/controls.c
> @@ -607,18 +607,16 @@ static int ctrl_set_bitrate(struct bm2835_mmal_dev *dev,
>  			    struct v4l2_ctrl *ctrl,
>  			    const struct bm2835_mmal_v4l2_ctrl *mmal_ctrl)
>  {
> -	int ret;
>  	struct vchiq_mmal_port *encoder_out;
>  
>  	dev->capture.encode_bitrate = ctrl->val;
>  
>  	encoder_out = &dev->component[MMAL_COMPONENT_VIDEO_ENCODE]->output[0];
>  
> -	ret = vchiq_mmal_port_parameter_set(dev->instance, encoder_out,
> -					    mmal_ctrl->mmal_id,
> -					    &ctrl->val, sizeof(ctrl->val));
> -	ret = 0;
> -	return ret;
> +	vchiq_mmal_port_parameter_set(dev->instance, encoder_out,
> +				      mmal_ctrl->mmal_id, &ctrl->val,
> +				      sizeof(ctrl->val));
> +	return 0;
>  }

Why does this function even return anything at all if it can not fail?

Why not return the value that vchiq_mmal_port_parameter_set() returned?

thanks,

greg k-h
