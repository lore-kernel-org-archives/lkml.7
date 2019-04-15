Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD18C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D9ED2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555358997;
	bh=vB1Iq7EjrvPMhbU1T4FpnaMcPknA5Udp5zu0AqFeKPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hGpi1ddbdcLBxl52DKDBPl41hM0g+WxFIAX/pyfYVDGKq6eJ0M+tlUZwPHb8iyanL
	 /aADP7B5NtCM8ru0UWKFPnmhMA02wZeE9b7XcDNRj/StpMFiqRkYiS+lmL/CNpkI5L
	 qPKU6w1OFaiTGUO/0NWeYYdtGpxz2mytkx0QgtXE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbfDOUJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 16:09:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:60374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728148AbfDOUJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 16:09:55 -0400
Received: from earth.universe (unknown [185.62.205.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F758206BA;
        Mon, 15 Apr 2019 20:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555358994;
        bh=vB1Iq7EjrvPMhbU1T4FpnaMcPknA5Udp5zu0AqFeKPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rWW8y+GkLe9QshLVt+k9L8UbKApfm2jWrKkFZ3Hj49WCDD9Y5t5Dj/p3zImFFwHrj
         Z4qHIa13IVJolK3/OZ9Vd8dcGgblBVi+S2naLKh2WW0HzGLr1dINtgtMsE3NmZOQ1b
         WBwO/7eD0LtYRZVWE3NpiMT18fSuV5tyow71foo8=
Received: by earth.universe (Postfix, from userid 1000)
        id 0485C3C08D5; Mon, 15 Apr 2019 22:09:52 +0200 (CEST)
Date:   Mon, 15 Apr 2019 22:09:51 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: power: supply: Add
 charge-status-gpios property
Message-ID: <20190415200951.jcp2ksfn7osucyxh@earth.universe>
References: <20190414124039.10040-1-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gcnw5pz23wsfch2f"
Content-Disposition: inline
In-Reply-To: <20190414124039.10040-1-contact@artur-rojek.eu>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gcnw5pz23wsfch2f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Apr 14, 2019 at 02:40:38PM +0200, Artur Rojek wrote:
> Add documentation for the "charge-status-gpios" property.
> Update the "gpios" property with a valid example.
>=20
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Thanks, both queued.

-- Sebastian

>=20
> Changes:
>=20
> v2: - add a better description for the "status-gpios" property,
>     - add valid examples for the "gpios" and "status-gpios" properties
>=20
> v3: rename the "status-gpios" property to "charge-status-gpios"
>=20
>  .../devicetree/bindings/power/supply/gpio-charger.txt       | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/gpio-charger.=
txt b/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
> index adbb5dc5b6e9..30349332f051 100644
> --- a/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
> +++ b/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
> @@ -14,12 +14,16 @@ Required properties :
>       usb-cdp (USB charging downstream port)
>       usb-aca (USB accessory charger adapter)
> =20
> +Optional properties:
> + - charge-status-gpios: GPIO indicating whether a battery is charging.
> +
>  Example:
> =20
>  	usb_charger: charger {
>  		compatible =3D "gpio-charger";
>  		charger-type =3D "usb-sdp";
> -		gpios =3D <&gpf0 2 0 0 0>;
> +		gpios =3D <&gpd 28 GPIO_ACTIVE_LOW>;
> +		charge-status-gpios =3D <&gpc 27 GPIO_ACTIVE_LOW>;
>  	}
> =20
>  	battery {
> --=20
> 2.21.0
>=20

--gcnw5pz23wsfch2f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAly05QsACgkQ2O7X88g7
+pqdGA/+KsYQL0q2WUeGM35ujw9cogRo7OFQO4V0JOEYvGAB/ZoTEUqoVYOTi+aq
V/I4c+WDh2I5o74/QY+zCuyQJtxkO5/DWWQoiOteXX91UW6siSHu4oosm0GRYRKJ
H9fjYcNcpBN8UCtOMezNdKbhPdA2oPc4OZWQp0qsu5Jab7QNPEHgHuz5E8FQ4pLU
ZiihiBLkWAR5RnwB3LB6w9v+xk8+NAQc5Wve0uGo3cu0MreP+hQbnp5wGD1RjOj6
dTrtZYgfV4U0gofRrrZfS+Scg2QGNTKtzSmEVd5Qtbx6DxUCGSPGilglJX4hu2Qr
Ww7GHW0Nd3nHvhxr3y6ugY9tYOw+dPQhmLbV+DaIqTa97F8D2YJBDQ4bxGuYTaZu
K9w87Kcl8XmEyeXMj/T43dylLGA3NiCAxK4PUAN69SRpbJqjpUkaw6l5kxRSYYtg
Mio17MIwwz01Q0+By6AHwmEbuVJ0OJYh47ezF4zDWDAMvf9WiuVfsUPmpujUleLY
R1elh5wEHTH4rgVlRIXwkH8Zy+oYL3v/LpJ/1q4CJsFlC46nCdq0sJbnfPlTA+bE
xHqsKc4knclLHaSqlVrGORnlPZch0TD66VSHcXHnrHdq2x5/9tHgTL+sT2gj1Ekl
48vRc0rCLWGAa0KCzFCG2LhLzZmVELZZ19T7+bXZcdqigHlZZ6A=
=1Nfv
-----END PGP SIGNATURE-----

--gcnw5pz23wsfch2f--
