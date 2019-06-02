Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A052CC282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 17:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE5527987
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 17:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559495501;
	bh=vznpSpGdaGOFqIuCE8ixvq0iIHCjinb385fHoG02ERs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nAMMNQEiNq+YxxPw7XQHqxDd/oQLN/EOPdJ6/gM36UkkD9ssXE2xzVpNm/F0F0Eoi
	 8AXpA5CFHtq0W2W9vLBF6aRwV5b+XtquZBEBTtl1hCTOIoUq+zOwru51u0u616alt7
	 mJ4MgFtljJGLzvNQ3TZhSgp15sjAKfttx7kkVLu4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfFBRLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 13:11:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:51102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbfFBRLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 13:11:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDDD827980;
        Sun,  2 Jun 2019 17:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559495499;
        bh=vznpSpGdaGOFqIuCE8ixvq0iIHCjinb385fHoG02ERs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fcCFq3XsyNm/3Fz3rYRzgXLtZB+/oTAqqFjrFYPfiHhpbBf0e2y+lIR26dUrZNVtB
         66yiJ3EjVe/a7IMxJz+dj3wzp4MHnDOVFKob41fHT8cIDFplyCIMwOHvYZDfNfDJxU
         jtkRQ02Sfnai2csEZ82Vj5W4aLqPy4SZvQlhrcZ0=
Date:   Sun, 2 Jun 2019 19:11:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Deepak Mishra <linux.dkm@gmail.com>
Cc:     linux-kernel@vger.kernel.org, joe@perches.com, wlanfae@realtek.com,
        Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        himadri18.07@gmail.com, straube.linux@gmail.com
Subject: Re: [PATCH v2 1/9] staging: rtl8712: Fixed CamelCase rename
 ImrContent to imr_content
Message-ID: <20190602171136.GA19671@kroah.com>
References: <cover.1559470737.git.linux.dkm@gmail.com>
 <b23b7ef3b339923fee07045b6cc053a05bd9b717.1559470738.git.linux.dkm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b23b7ef3b339923fee07045b6cc053a05bd9b717.1559470738.git.linux.dkm@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 02, 2019 at 03:55:30PM +0530, Deepak Mishra wrote:
> This patch renames CamelCase ImrContent to imr_content in struct _adapter and related
> files drv_types.h, rtl871x_mp_ioctl.c, rtl871x_pwrctrl.h
> 
> CHECK: Avoid CamelCase: <ImrContent>
> 
> Signed-off-by: Deepak Mishra <linux.dkm@gmail.com>
> ---
>  drivers/staging/rtl8712/drv_types.h        | 2 +-
>  drivers/staging/rtl8712/rtl871x_mp_ioctl.c | 2 +-
>  drivers/staging/rtl8712/rtl871x_pwrctrl.h  | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/drv_types.h b/drivers/staging/rtl8712/drv_types.h
> index 9ae86631fa8b..89ebb5a49d25 100644
> --- a/drivers/staging/rtl8712/drv_types.h
> +++ b/drivers/staging/rtl8712/drv_types.h
> @@ -149,7 +149,7 @@ struct _adapter {
>  	bool	surprise_removed;
>  	bool	suspended;
>  	u32	IsrContent;
> -	u32	ImrContent;
> +	u32	imr_content;
>  	u8	EepromAddressSize;
>  	u8	hw_init_completed;
>  	struct task_struct *cmdThread;

This field is never used?  Why not just delete it?

> diff --git a/drivers/staging/rtl8712/rtl871x_mp_ioctl.c b/drivers/staging/rtl8712/rtl871x_mp_ioctl.c
> index 588346da1412..4cf9d3afd2c5 100644
> --- a/drivers/staging/rtl8712/rtl871x_mp_ioctl.c
> +++ b/drivers/staging/rtl8712/rtl871x_mp_ioctl.c
> @@ -665,7 +665,7 @@ uint oid_rt_pro_write_register_hdl(struct oid_par_priv *poid_par_priv)
>  		if ((status == RNDIS_STATUS_SUCCESS) &&
>  		    (RegRWStruct->offset == HIMR) &&
>  		    (RegRWStruct->width == 4))
> -			Adapter->ImrContent = RegRWStruct->value;
> +			Adapter->imr_content = RegRWStruct->value;

It is set and never read?  Please remove.

thanks,

greg k-h
