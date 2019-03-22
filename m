Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E32C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 01:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0138421900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 01:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553219198;
	bh=Q3JfeTGDvGLcXeouNN+Uo90D5B+O05F/i81Q3IxTn2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Bg0zsy65CL8X1/9H97RRKPtTus2m0gD+1NNkWF+YZE9XFgciyssBG3Oz8Ske+/vEK
	 EaGqRYGEHuTb2mHwCgtTD/iRH0h9aEWSjArW8edFOM9/mEZyjkmTQZxks1M9aOh0kP
	 oxuqwYNMvT7Woncc+bFhYS5mgcZ7tTSIqYmmnaNQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfCVBqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 21:46:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:57058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727552AbfCVBqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 21:46:36 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DFF8218E2;
        Fri, 22 Mar 2019 01:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553219195;
        bh=Q3JfeTGDvGLcXeouNN+Uo90D5B+O05F/i81Q3IxTn2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YxJgY4iVNFZQX19I3Gymmz4xbcSVky6w6zysn7w5sgZ3sb2A5JpJOTKvjv1ynuyXl
         YHqBJmLTXOwcbMKiKGjnJXTsGHb0XgwhrDWXHAtgXF1q+JBQygA5WnBHvy/A5Q9qG6
         tg3dcwQ6QxX7dsueTG0q6UqJzSXnScoeHqJkbZk8=
Date:   Fri, 22 Mar 2019 09:46:06 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Alexander Kurz <akurz@blala.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <treding@nvidia.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] ARM: dts: imx50: Fix the numbering of the I2C
 controllers
Message-ID: <20190322014605.GT12513@dragon>
References: <20190319152421.16179-1-j.neuschaefer@gmx.net>
 <20190319152421.16179-6-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190319152421.16179-6-j.neuschaefer@gmx.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 04:24:20PM +0100, Jonathan Neuschäfer wrote:
> Ensure that the i2c buses are reported to userspace (for example to
> i2cdetect) in the same order as they are numbered in the SoC's
> documentation by adding aliases to the devicetree.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Alexander already sent a patch [1] covering i2c.  But I'm not sure why
i2c3 is missing there.

Shawn

[1] https://www.spinics.net/lists/devicetree/msg278684.html

> ---
>  arch/arm/boot/dts/imx50.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/imx50.dtsi
> index e5632ce24ba0..8cab0ab3bd4e 100644
> --- a/arch/arm/boot/dts/imx50.dtsi
> +++ b/arch/arm/boot/dts/imx50.dtsi
> @@ -26,6 +26,9 @@
>  		gpio3 = &gpio4;
>  		gpio4 = &gpio5;
>  		gpio5 = &gpio6;
> +		i2c0 = &i2c1;
> +		i2c1 = &i2c2;
> +		i2c2 = &i2c3;
>  		serial0 = &uart1;
>  		serial1 = &uart2;
>  		serial2 = &uart3;
> --
> 2.20.1
> 
