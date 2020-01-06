Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97021C33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 17:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7787B207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 17:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgAFRJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 12:09:49 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:45473 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgAFRJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 12:09:49 -0500
X-Originating-IP: 93.34.114.233
Received: from uno.localdomain (93-34-114-233.ip49.fastwebnet.it [93.34.114.233])
        (Authenticated sender: jacopo@jmondi.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 93514C000D;
        Mon,  6 Jan 2020 17:09:44 +0000 (UTC)
Date:   Mon, 6 Jan 2020 18:12:09 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v2 2/3] ARM: dts: imx6qdl-icore-1.5: Remove duplicate phy
 reset methods
Message-ID: <20200106171209.bkberpu4it5qo6qj@uno.localdomain>
References: <20191230120021.32630-1-jagan@amarulasolutions.com>
 <20191230120021.32630-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="u75eg3etc6nba3gs"
Content-Disposition: inline
In-Reply-To: <20191230120021.32630-2-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u75eg3etc6nba3gs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Jagan,
   small detail, this should come -after= 3/3 in the series, am I
   wrong ?

On Mon, Dec 30, 2019 at 05:30:20PM +0530, Jagan Teki wrote:
> From: Michael Trimarchi <michael@amarulasolutions.com>
>
> Engicam i.CoreM6 1.5 Quad/Dual MIPI dtsi is reusing fec node
> from Engicam i.CoreM6 dtsi but have sampe copy of phy-reset-gpio
> and phy-mode properties.
>
> So, drop this phy reset methods from imx6qdl-icore-1.5 dsti file.
>
> Cc: Jacopo Mondi <jacopo@jmondi.org>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Anyway, I've tested on my iCore 1.5 Quad starter kit and things are
still working.

Pending acceptance of 3/3, which seem correct to me but I cannot
really judge knowing very few things about net:

Tested-by: Jacopo Mondi <jacopo@jmondi.org>

Thanks
   j

> ---
> Changes for v2:
> - new patch.
>
>  arch/arm/boot/dts/imx6qdl-icore-1.5.dtsi | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/imx6qdl-icore-1.5.dtsi b/arch/arm/boot/dts/imx6qdl-icore-1.5.dtsi
> index d91d46b5898f..0fd7f2e24d9c 100644
> --- a/arch/arm/boot/dts/imx6qdl-icore-1.5.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-icore-1.5.dtsi
> @@ -25,10 +25,8 @@
>  &fec {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_enet>;
> -	phy-reset-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
>  	clocks = <&clks IMX6QDL_CLK_ENET>,
>  		 <&clks IMX6QDL_CLK_ENET>,
>  		 <&clks IMX6QDL_CLK_ENET_REF>;
> -	phy-mode = "rmii";
>  	status = "okay";
>  };
> --
> 2.18.0.321.gffc6fa0e3
>

--u75eg3etc6nba3gs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtcQ9SICaIIqPWDjAcjQGjxahVjwFAl4TamkACgkQcjQGjxah
VjydUhAAhZ1rpFfpJEhocX9PC/9nhJAgmt1D+IOAudsNBlc41dVfVL/QWHzL0Fkl
x2SAuFR0UuYRlXWddg0XlbF3WzYgiiNS4eHcoSlK9v9d2KIXo5NrFLJ18xRoont9
fyD6bwDc7R4ZITur+r8OXfd/mIs8Gj5NTQv/AcKsS94siZGzrhGxxIdSWdkaliZq
XwIsVRf1q9jNifFvUIDFDUGuEYLm9NYY8uOWSvA0Pj0ZOTkCgrOvMmcAUy69+uUq
Sqznbj28XP2daw4n9PZ+1rj2Nluiou/SbGpeAq5qoEe+O+ZAPO+++eVroRKQt2q7
kDEM3FZ8sUiyfKchp+iqZK9qAdFbCldvzhy4xeZFdCBQnNKHOn8obq0DlfUoXMYl
pf/h4cusUeF8Ip4EL1G9yJDCmqrUsZ0bBma4fI17TjHfNQBed1KpjM+F66lL00m1
gFOSKICn4CUQUSVqK0nPJ96ZEHObKVQbL+SQdJoPRcwjaTCGjXWZIaLJ5iWsgO05
NOA//juKke2Lv8IslxD0fA3dhMj8ws3MI0N1q2rI06XX9+lwmUrlU00awWazPLgd
Fz2Av+sxAi+aWIt+4X4tYH9IjFE0qn1d7yZFqBjQGQHQg4S9xn6sRs4rD/Dcf2BN
rXDGW5/tIo+z4lcR0cpRusLAlHwYHvxKYzB+u795bdIKwS44gdI=
=Qc8J
-----END PGP SIGNATURE-----

--u75eg3etc6nba3gs--
