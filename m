Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90CBC282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 17:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC5727988
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 17:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559495610;
	bh=7c7MGnOBuOAWpj0ShGwHMFsBnl9Xhe+SYRNE9LavnQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=auTIJw0J4NP6fQ0jzwmDX3rPXEyVVj+tGz8iz1NgeN2r8mbF+WvuYAjMrQXIKipTc
	 Mz/flKkQ52w2C8R8erBv7h4xcKCeqmKKN5v+njLse5wGMXXmCtLzjKcYAIOQ5ldm8h
	 le/+ZSo2UzXDXsRI4e2A/1mZF5P0/m+PUDRpT3Jo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfFBRNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 13:13:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:53714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbfFBRND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 13:13:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B419C27987;
        Sun,  2 Jun 2019 17:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559495583;
        bh=7c7MGnOBuOAWpj0ShGwHMFsBnl9Xhe+SYRNE9LavnQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MS9vWORlzmAfBSYkViINZDaty0QeOr/zoodM7qk926WaPugjEBugUI/L+cE3BSq5V
         LlsrpS9qK2OcNFSZtuaNRt+hgNzshCShj3X2d51zwiDvsUPgds9jEtmsek0mO87wnu
         Q7f5M3xOpCV+80nKRZ4b0nJPpQEXu4hKX2UbH3Ys=
Date:   Sun, 2 Jun 2019 19:13:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Deepak Mishra <linux.dkm@gmail.com>
Cc:     linux-kernel@vger.kernel.org, joe@perches.com, wlanfae@realtek.com,
        Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        himadri18.07@gmail.com, straube.linux@gmail.com
Subject: Re: [PATCH v2 5/9] staging: rtl8712: Fixed CamelCase renames
 IsrContent to isr_content
Message-ID: <20190602171300.GC19671@kroah.com>
References: <cover.1559470737.git.linux.dkm@gmail.com>
 <c56907d81f9452eec28f7b26eac54df185fb5735.1559470738.git.linux.dkm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c56907d81f9452eec28f7b26eac54df185fb5735.1559470738.git.linux.dkm@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 02, 2019 at 03:55:34PM +0530, Deepak Mishra wrote:
> This patch fixes CamelCase IsrContent to isr_content as suggested by
> checkpatch.pl
> 
> Signed-off-by: Deepak Mishra <linux.dkm@gmail.com>
> ---
>  drivers/staging/rtl8712/drv_types.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8712/drv_types.h b/drivers/staging/rtl8712/drv_types.h
> index 5360f049088a..a5060a020b2b 100644
> --- a/drivers/staging/rtl8712/drv_types.h
> +++ b/drivers/staging/rtl8712/drv_types.h
> @@ -148,7 +148,7 @@ struct _adapter {
>  	bool	driver_stopped;
>  	bool	surprise_removed;
>  	bool	suspended;
> -	u32	IsrContent;
> +	u32	isr_content;
>  	u32	imr_content;
>  	u8	eeprom_address_size;
>  	u8	hw_init_completed;

Same comment here, just remove unused variables.  Is this structure even
ever used anywhere?

thanks,

greg k-h
