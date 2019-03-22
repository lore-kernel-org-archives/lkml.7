Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F58C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30386218FC
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553264257;
	bh=AbtLVFb6zi/ZbXQmLC6sAb73bOX5H7jsZ57Pufk0Lnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CfRoz9RkT0Afru02A6rDn79i0oJHtFQ5S4o9b9rLFORIcGDrhc4g90Dy6uSrreIfD
	 N/8UsZn2WQ6IZN7kxcSgKv7c0TeNccWMU0065pLGl8DhAUPNm49Qvw+AfycJOztLDN
	 4T4byx5Ihva4RYFNnCfpL7ziHsahkF1qUbGds48c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbfCVORf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:17:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:44278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727719AbfCVORf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:17:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F10EE218E2;
        Fri, 22 Mar 2019 14:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553264254;
        bh=AbtLVFb6zi/ZbXQmLC6sAb73bOX5H7jsZ57Pufk0Lnw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AGDIXOXSM7FLaiwrHO37vQXbL8GXuyPD954u+HH4PmbY0Tk06NSN7SemHlxEBzyXM
         REPXxn8tgZgaHuHxkYMdw/2GoJsw7GuzI1WRheOxU23UPbO9g4D0MVsVS6mQ2VXMtI
         vpEY7W6tpTDAcKs/46etT5Ry3UHCQ3+wJp8KAhOY=
Date:   Fri, 22 Mar 2019 15:17:32 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Emanuel Bennici <benniciemanuel78@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Jens Frederich <jfrederich@gmail.com>,
        Daniel Drake <dsd@laptop.org>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH] staging: olpc_dcon: Add Tabs to define-Macros
Message-ID: <20190322141732.GA12018@kroah.com>
References: <20190322095244.22348-1-benniciemanuel78@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322095244.22348-1-benniciemanuel78@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 10:52:43AM +0100, Emanuel Bennici wrote:
> Improve Code Readability by adding Tabs after #define-Macro
> definition.
> 
> Signed-off-by: Emanuel Bennici <benniciemanuel78@gmail.com>
> ---
>  drivers/staging/olpc_dcon/olpc_dcon.h        | 24 ++++++++++----------
>  drivers/staging/olpc_dcon/olpc_dcon_xo_1_5.c |  8 +++----
>  2 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/staging/olpc_dcon/olpc_dcon.h b/drivers/staging/olpc_dcon/olpc_dcon.h
> index c987aaf894e7..277b19967315 100644
> --- a/drivers/staging/olpc_dcon/olpc_dcon.h
> +++ b/drivers/staging/olpc_dcon/olpc_dcon.h
> @@ -10,18 +10,18 @@
>  #define DCON_REG_ID		 0
>  #define DCON_REG_MODE		 1
>  
> -#define MODE_PASSTHRU	BIT(0)
> -#define MODE_SLEEP	BIT(1)
> -#define MODE_SLEEP_AUTO	BIT(2)
> -#define MODE_BL_ENABLE	BIT(3)
> -#define MODE_BLANK	BIT(4)
> -#define MODE_CSWIZZLE	BIT(5)
> -#define MODE_COL_AA	BIT(6)
> -#define MODE_MONO_LUMA	BIT(7)
> -#define MODE_SCAN_INT	BIT(8)
> -#define MODE_CLOCKDIV	BIT(9)
> -#define MODE_DEBUG	BIT(14)
> -#define MODE_SELFTEST	BIT(15)
> +#define MODE_PASSTHRU		BIT(0)
> +#define MODE_SLEEP		BIT(1)
> +#define MODE_SLEEP_AUTO		BIT(2)
> +#define MODE_BL_ENABLE		BIT(3)
> +#define MODE_BLANK		BIT(4)
> +#define MODE_CSWIZZLE		BIT(5)
> +#define MODE_COL_AA		BIT(6)
> +#define MODE_MONO_LUMA		BIT(7)
> +#define MODE_SCAN_INT		BIT(8)
> +#define MODE_CLOCKDIV		BIT(9)
> +#define MODE_DEBUG		BIT(14)
> +#define MODE_SELFTEST		BIT(15)

These really did not have to be changed, did they?

>  
>  #define DCON_REG_HRES		0x2
>  #define DCON_REG_HTOTAL		0x3
> diff --git a/drivers/staging/olpc_dcon/olpc_dcon_xo_1_5.c b/drivers/staging/olpc_dcon/olpc_dcon_xo_1_5.c
> index 838daa2be3ef..7972b591d1b8 100644
> --- a/drivers/staging/olpc_dcon/olpc_dcon_xo_1_5.c
> +++ b/drivers/staging/olpc_dcon/olpc_dcon_xo_1_5.c
> @@ -31,10 +31,10 @@
>   *	DCONSMBCLK connects to VX855 graphics CRTSPCLK
>   */
>  
> -#define VX855_GENL_PURPOSE_OUTPUT 0x44c /* PMIO_Rx4c-4f */
> -#define VX855_GPI_STATUS_CHG 0x450  /* PMIO_Rx50 */
> -#define VX855_GPI_SCI_SMI 0x452  /* PMIO_Rx52 */
> -#define BIT_GPIO12 0x40
> +#define VX855_GENL_PURPOSE_OUTPUT	0x44c /* PMIO_Rx4c-4f */
> +#define VX855_GPI_STATUS_CHG		0x450  /* PMIO_Rx50 */
> +#define VX855_GPI_SCI_SMI		0x452  /* PMIO_Rx52 */
> +#define BIT_GPIO12			0x40

Also use a tab before the comment on these lines.

thanks,

greg k-h
