Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41EEC10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E5221473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554281034;
	bh=sNDtqsQEANsZW0US1SoDin5P4RdBQeE6mWB5C5qDp78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s6vo+Os7O18WtC6iIsoN+Vro9WWQUCTj8RAtYhNCGydaYDnTc7KXMu2WKIB11Uu+S
	 eelrNo9a4q/mjC370T1wD2AdTTW/gz1s2dzIFHmwbFFbOIFU0EZre/Rc6idrSRMLiF
	 ML88Lu8S4xwZI+bMk2u1WhJU4o8UcjL+Un7XrQDs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbfDCInx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:43:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729037AbfDCInw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:43:52 -0400
Received: from X250 (unknown [147.50.13.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF8CE20830;
        Wed,  3 Apr 2019 08:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554281031;
        bh=sNDtqsQEANsZW0US1SoDin5P4RdBQeE6mWB5C5qDp78=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r1TjIGdnr8eYkvsnqi5TFy75xfB3hMevWhxGuCF56P4e2rUpoFs3fuTAxwd8v/EG0
         pgfru7Rq16C4xe1H0qa6UpnhBWazEc4lLfSAc1E75tywxTtk2x83gnEg5eaUOgS8TH
         ZUXtY1M+vo6YPiXAM7b5pag6+AuNTcLyqBe4ju80=
Date:   Wed, 3 Apr 2019 15:43:43 +0700
From:   Shawn Guo <shawnguo@kernel.org>
To:     linus.walleij@linaro.org,
        VI1PR04MB42227AA158BA1FCBF314AA27807B0@VI1PR04MB4222.eurprd04.prod.outlook.com
Cc:     aisheng.dong@nxp.com, festevam@gmail.com, stefan@agner.ch,
        kernel@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christina Quast <cquast@hanoverdisplays.com>
Subject: Re: [PATCH v2] dt-bindings: pinctrl: imx7d: Fix PAD_CTL_DSE_X*
Message-ID: <20190403084341.GA4636@X250>
References: <20190313142040.26694-1-cquast@hanoverdisplays.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313142040.26694-1-cquast@hanoverdisplays.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I assume this will go via your tree.  Let me know if you think
differently.

Shawn

On Wed, Mar 13, 2019 at 03:20:40PM +0100, Christina Quast wrote:
> In the iMX7d datasheet, the PAD_CTL_DSE_X* values are different from
> the documentation.
> 
> Changes since v2:
> * Changed patch title to 'dt-bindings: pinctrl: imx7d:'
> 
> Signed-off-by: Christina Quast <cquast@hanoverdisplays.com>
> ---
>  .../devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt       | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt
> index 6666277c3acb..8ac1d0851a0f 100644
> --- a/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt
> @@ -48,9 +48,9 @@ PAD_CTL_HYS                     (1 << 3)
>  PAD_CTL_SRE_SLOW                (1 << 2)
>  PAD_CTL_SRE_FAST                (0 << 2)
>  PAD_CTL_DSE_X1                  (0 << 0)
> -PAD_CTL_DSE_X2                  (1 << 0)
> -PAD_CTL_DSE_X3                  (2 << 0)
> -PAD_CTL_DSE_X4                  (3 << 0)
> +PAD_CTL_DSE_X4                  (1 << 0)
> +PAD_CTL_DSE_X2                  (2 << 0)
> +PAD_CTL_DSE_X6                  (3 << 0)
>  
>  Examples:
>  While iomuxc-lpsr is intended to be used by dedicated peripherals to take
> -- 
> 2.20.1
> 
