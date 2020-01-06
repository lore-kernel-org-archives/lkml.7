Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3595FC33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 16:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1233124685
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 16:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgAFQrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 11:47:02 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:37949 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgAFQrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 11:47:02 -0500
X-Originating-IP: 93.34.114.233
Received: from uno.localdomain (93-34-114-233.ip49.fastwebnet.it [93.34.114.233])
        (Authenticated sender: jacopo@jmondi.org)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 7288760014;
        Mon,  6 Jan 2020 16:46:57 +0000 (UTC)
Date:   Mon, 6 Jan 2020 17:49:22 +0100
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
Subject: Re: [PATCH v2 1/3] ARM: dts: imx6q-icore-mipi: Use 1.5 version of
 i.Core MX6DL
Message-ID: <20200106164922.2miekwayssugdnfi@uno.localdomain>
References: <20191230120021.32630-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ba6vza4vxzejqwcg"
Content-Disposition: inline
In-Reply-To: <20191230120021.32630-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ba6vza4vxzejqwcg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Jagan,

On Mon, Dec 30, 2019 at 05:30:19PM +0530, Jagan Teki wrote:
> The EDIMM STARTER KIT i.Core 1.5 MIPI Evaluation is based on
> the 1.5 version of the i.Core MX6 cpu module. The 1.5 version
> differs from the original one for a few details, including the
> ethernet PHY interface clock provider.
>
> With this commit, the ethernet interface works properly:
> SMSC LAN8710/LAN8720 2188000.ethernet-1:00: attached PHY driver
>
> While before using the 1.5 version, ethernet failed to startup
> do to un-clocked PHY interface:
> fec 2188000.ethernet eth0: could not attach to PHY
>
> Similar fix has merged for i.Core MX6Q but missed to update for DL.
>
> Fixes: a8039f2dd089 ("ARM: dts: imx6dl: Add Engicam i.CoreM6 1.5 Quad/Dual MIPI starter kit support")
> Cc: Jacopo Mondi <jacopo@jmondi.org>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> - Add Michael s-o-b
>
>  arch/arm/boot/dts/imx6dl-icore-mipi.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/imx6dl-icore-mipi.dts b/arch/arm/boot/dts/imx6dl-icore-mipi.dts
> index e43bccb78ab2..d8f3821a0ffd 100644
> --- a/arch/arm/boot/dts/imx6dl-icore-mipi.dts
> +++ b/arch/arm/boot/dts/imx6dl-icore-mipi.dts
> @@ -8,7 +8,7 @@
>  /dts-v1/;
>
>  #include "imx6dl.dtsi"
> -#include "imx6qdl-icore.dtsi"
> +#include "imx6qdl-icore-1.5.dtsi"
>
>  / {
>  	model = "Engicam i.CoreM6 DualLite/Solo MIPI Starter Kit";

In
09ad741b7ece ("ARM: dts: imx6q-icore-mipi: Use 1.5 version of i.Core MX6")>

I also changed this line to
-       model = "Engicam i.CoreM6 Quad/Dual MIPI Starter Kit";
+       model = "Engicam i.CoreM6 1.5 Quad/Dual MIPI Starter Kit";

Maybe you want the same here.

With or without this change:
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>

Thanks
   j

> --
> 2.18.0.321.gffc6fa0e3


--ba6vza4vxzejqwcg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtcQ9SICaIIqPWDjAcjQGjxahVjwFAl4TZRIACgkQcjQGjxah
VjzcqQ//WS7o8+zUGA2LnNefMrQhNBeylfzlQRf98NJRQCltspxDVGDIPvS2TYYT
JoCsLFQNM/tyZZgYcGhr6tKYErBkzxeh/jMDiPoXKaQopFUAZ6i3sy7S8WWszfT2
su2jz5QUogz5Gx5ZJs8BoYA5YS0shQx3uWW19dEhLCmm9a7DCAEy5sdDj29RQbrN
W0CImduDGrWC7opEtjnNrkAbFgv5dBVhwZJ/t3EoixNAZBNzUnXsEmXPaDQRRqUh
/XlUMrfHRTuUGT6d3dPxGvtF9zrLuqtwXKLhXllNfWeS+cjFErmEjX2Q7hI+LLMU
sJzpYODFSbIc4OzaRqFlLO8gMfE1TLK8faual2G+JHOgi8qDRbmVY3uwIMhBVlTF
YPrnZxz6txG6VDqmb/eVrgas7RwCD+nUpS16sqxxirpHhmkdVqkMD2bP2JdGh6b5
I1XFGnugROQ7+OZZ6oe1HeM2aEGSk7rY6PyYRNEdm/eEa7adlH+D+dhSLvvIYi5N
MzrgrpdPtuonuoAsiA7GZUEGccLMezvaxw+mQIAR58GA4AWkicfjWBfjyrL867zf
F1DJ2+fbALQopjvDua4JxqCSYM/vBP1oyhpoUxjdyjd3kE/qniG7v7Cd3eitt38U
rfCGMveoqNqZoSujybP7qydqR2P5tn/NNpNYbZanEsOiSC1YnXQ=
=nkp8
-----END PGP SIGNATURE-----

--ba6vza4vxzejqwcg--
