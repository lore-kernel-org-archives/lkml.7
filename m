Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB60CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B83B20863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="B9Yui+5R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732440AbfCZQ14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:27:56 -0400
Received: from mout.gmx.net ([212.227.15.18]:50391 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732359AbfCZQ1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 12:27:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553617614;
        bh=nSVFcrPQYo+Yi46hXmioVjq43OqM2eOGHE7px4XpTV8=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=B9Yui+5R1JDqa35co7ep0REjnkUWwevChfhqDh6y2zKJm4kaG1I8xuqser52LPN6c
         r2o+L9lXvTBgi4cTJ70BQcvwyK+L6gaw9jzXBjFVvRq9HQ6+WAPIOtx6RzrddaQxKX
         Z0WXtP/gD5xAxlOfJDkkLnwl9irZDVsy9DcBk7lg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lg0wl-1gbi1l2CAl-00pbtG; Tue, 26
 Mar 2019 17:26:54 +0100
Date:   Tue, 26 Mar 2019 17:26:53 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-arm-kernel@lists.infradead.org,
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
Subject: Re: [PATCH 2/5] ARM: dts: imx50: Add Kobo Aura DTS
Message-ID: <20190326162653.GD2095@latitude>
References: <20190319152421.16179-1-j.neuschaefer@gmx.net>
 <20190319152421.16179-3-j.neuschaefer@gmx.net>
 <20190322013151.GR12513@dragon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TiqCXmo5T1hvSQQg"
Content-Disposition: inline
In-Reply-To: <20190322013151.GR12513@dragon>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:5Q8cM7b4ZIfQLtdy+33b9FqRfRr0NhNNXWc9wva1X+jmX+iYVmS
 Ic3aGITljrWJPWDT4IIDr7SzZ1/Cme6oTDI58xPlIwPpwmM+fwTzTwowBOxU1uJwtZzpsHe
 eXi7GyOyCjbgidCgLwcL/9vNw5uIEWCJHmi8k12HCQKrzsfB6EzlNqUlexRnpirC6fU0ZZ7
 MOtyAd0aTytISNEryJTMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uRvbXfsGktk=:+zDcrvakFf406EvAD+H6js
 AzcEqnH3GH7/LWNOqLSxjWmrVEASz8YSF88xm6/btEYSY6L8oHxVa9KVKyGUpx7kQxxnkHcPI
 nJF5sIxH0zdLay0/P8n3365Z5+TayNuOLWhwsHpS60qX3lEL4vlAhg0sijMT1Up4Jh5THgZwL
 95XOWHw8vUVmsoC8cX8dIzvSBCRzni0Ev/q7OzBR2crRnEEyIKrvkaRs3KR9ek8memzisYwK6
 vwsonoCbxOblMChiDEOZXeDzmobmupYEwi6xEsh/ielXpuZy5rbD8jdgOTuFsitkTCGsYH/MB
 Vck/36JQOxZYnU4EXEHvFxNRCohbWKGt1ZnA5hGCwCDS7HcPc/TpwO994IgApNJqYMdpfaAMt
 lfwbbPbQ9F//qnQicv6Tr/+YjVpWtQrOKpW50Y2XO6VwwctV2q2B94xus9DYYVE4x5AEREa6G
 tv2LUkUU7roauc5mB+t6tQsNGRutCqx3a4AmctgRTjOLbq1S5+lSjwyoAOzCM+Y2JvmQXCiVQ
 L+ZgHjLRzx2vpK52w3ArZoAu+hRnclT8/l9P95YJ/BRSAuexG3NyjpegRHi28htBahX+p56hb
 JHXxMcq3/OXPTW/IoAczSK3kL9kq7HYSohLfaet8LBI03abViW2MXoaoVKNZUqCkJF1UqXaBx
 LYWm7tdThz7NF8ViBUZ9kH2Qjjnl4VRJGV0llel5vb9NtN4hN0Gb9RFKW07YLe3qUQS84GgOj
 V+nK0nOVng9U0n0gPiRKKKk0iHhHe8WFYfT5/YQqFPsehZ6mbwOLA+nw/SLerp5+9tZlUfxIK
 ep82gfZBZGVg/zu4gQNXdrg42PdGUXSPqtAGctQ2bztUshAAu7UrCS1rvkXTJuBHbhLGthcYZ
 ynXo/l+gYUctk144KMD+TiuxB58gPp0pMOIZk9KTNWNMrai5oJgHNZCQ3pGCPp
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi, thanks for your comments. I'll address them in v2.

On Fri, Mar 22, 2019 at 09:31:53AM +0800, Shawn Guo wrote:
> On Tue, Mar 19, 2019 at 04:24:17PM +0100, Jonathan Neusch=C3=A4fer wrote:
> > The Kobo Aura is an e-book reader released in 2013.
[...]
> > +	sd2_pwrseq: pwrseq {
> > +		compatible =3D "mmc-pwrseq-simple";
> > +		pinctrl-names =3D "default";
> > +		pinctrl-0 =3D <&pinctrl_sd2_reset>;
> > +
>=20
> Please do not have random newlines.

Does that apply to all empty lines between properties?

>=20
> > +		reset-gpios =3D <&gpio4 17 GPIO_ACTIVE_LOW>;
> > +	};
> > +
[...]
> > +&iomuxc {
> > +	pinctrl_uart2: uart2 {
> > +		fsl,pins =3D <
> > +			MX50_PAD_UART2_TXD__UART2_TXD_MUX	0x1e4
> > +			MX50_PAD_UART2_RXD__UART2_RXD_MUX	0x1e4
> > +		>;
> > +	};
> > +
> > +	pinctrl_i2c1: i2c1 {
>=20
> Please sort these pinctrl nodes alphabetically.

It doesn't make a difference here, but should I generally sort by name
or by label in cases like this one?


Jonathan Neusch=C3=A4fer

--TiqCXmo5T1hvSQQg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAlyaUsUACgkQCDBEmo7z
X9sy1RAAniEdi+8w5/NPyQRbEYP4cdEcBxUhgP9VZXT1QxAxFoRDcYYOF0HUmu2g
qz5ppATEQ7+/rJZH9KTsOtNKEBW/+QjKs1gNa8ZYE9wWkF/LEz8twQHDv7VsmUbm
KJSUIOvXDvJ2U8PXLZowPjsOP+I6N7BQkxOGr0pDBcpsrm3INNHZYOXKfRzc5ogU
OuV6i9UDzS7/A/L2CORuOit/27R9iP0w8noLWgJdwW49Nx2lcnT9QXlFQYqAKvlY
GV25ht7eNJuPrh1RVm40zh59WT3vYQHS3vyVYoI8heSWx5pP7YuHLRZvUJgahXQ6
vn781Fz4zqp+7VqDscUk3xsy7K4oG0hsbBqBCUiyIsyz1ndAOEjbDoViCjfJRTeA
e0cnEX2ZXkm8EknLOSkahcqp1lCthVHdjgd7Q98OAYRCX30uGLlvSgqChZ09kzRF
RbUL/3EiLeJp58hXSMV0p9JH6ESVleiXmI5VGJT4LLI2SaQ6xtQM+dtta6w/CCsm
gS16xfRL/znFp4+ZtDFwbInDH/RRj+WWGETruMnX4pLgx+TiEJ57kL0psqDwjGDF
E8ha2On0qwh6x7VrjdGYvM/PeqkPxYYNJlsXZOUdpk0AQS0WDe/+jQvVIEXxQ9t/
bi8rxYU3QZFZTT4rkl/wXGhL5bRn35FTqFtmX5SuSfYysJ8rMhg=
=2tJW
-----END PGP SIGNATURE-----

--TiqCXmo5T1hvSQQg--
