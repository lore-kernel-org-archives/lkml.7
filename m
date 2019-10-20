Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21081CA9EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 12:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7FF42067B
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 12:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571574648;
	bh=LG3hIT3vIYsy7sPs1hGybqcgmHmIm04Fv7pjm9ecXvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Oetn8hENjdCln81Y8gZHLKqbKeiN+NXZ6lI9O9EcdXUBO350BJkepKLZ1CCBVPZ7K
	 Admatlb4QRv/X+kprToFbqdHZXVsPovg+NWywcqM1CPbuCwQcpZFzkGr3d0lX0RIPT
	 1ZCL5GwTptWkWiJ/zOM8CYloIrxbqGykpLmPDk6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfJTMa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 08:30:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:51886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbfJTMa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 08:30:28 -0400
Received: from earth.universe (tmo-104-243.customers.d1-online.com [80.187.104.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77A8F21927;
        Sun, 20 Oct 2019 12:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571574627;
        bh=LG3hIT3vIYsy7sPs1hGybqcgmHmIm04Fv7pjm9ecXvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BWf9naJQt/VNuenutvPgOZ6HDOBa+t5mw7harMq8X9V8ZwrBFIX+GbXgVra1k9NPP
         BTbUcPHbSmlM6i6emPMxVZRRpY2iXK4+YpG32pU7TlXcUiz8HrnNX8TXuljq2u7oIa
         uYUdU+My+WWBZ8KXHry9gDdWIeoAUwjqg1LlNR1o=
Received: by earth.universe (Postfix, from userid 1000)
        id 6E8AE3C09B1; Sun, 20 Oct 2019 14:30:14 +0200 (CEST)
Date:   Sun, 20 Oct 2019 14:30:14 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt: power: Add the bq2515x family dt bindings
Message-ID: <20191020123014.trvn5auxbv6ftngj@earth.universe>
References: <20190930143137.21624-1-dmurphy@ti.com>
 <20190930143137.21624-2-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rtitbtohtnvbnysq"
Content-Disposition: inline
In-Reply-To: <20190930143137.21624-2-dmurphy@ti.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rtitbtohtnvbnysq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dan,

On Mon, Sep 30, 2019 at 09:31:36AM -0500, Dan Murphy wrote:
> Add the bindings for the bq25150 and bq25155 500mA
>  charging IC from Texas Instruments.
>=20
> Datasheet:
> http://www.ti.com/lit/ds/symlink/bq25150.pdf
> http://www.ti.com/lit/ds/symlink/bq25155.pdf
>=20
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  .../bindings/power/supply/bq2515x.txt         | 48 +++++++++++++++++++

This should use the new YAML binding style.

>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/bq2515=
x.txt
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/bq2515x.txt b=
/Documentation/devicetree/bindings/power/supply/bq2515x.txt
> new file mode 100644
> index 000000000000..98203ab53d44
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/bq2515x.txt
> @@ -0,0 +1,48 @@
> +Binding for TI bq25150 500-mA Linear charger
> +
> +The BQ25150 is a highly integrated battery charge management IC that int=
egrates
> +the most common functions for wearable devices, namely a charger, an
> +output voltage rail, ADC for battery and system monitoring, and
> +push-button controller.
> +
> +Required Properties:
> +	- compatible: Should contain one of the following:
> +		"ti,bq25150"
> +		"ti,bq25155"
> +	- reg: int I2c address 0x6b
> +	- #address-cells: 1;
> +	- #size-cells: =3D 0;
> +
> +Optional Properties:
> +	- ti,battery-regulation-voltage: integer, maximum charging voltage in m=
V.
> +		Values range from 3600->4600mV
> +	- ti,charge-current: integer, maximum charging current in mA.
> +		Values range from 50->600mA

Those values should be in uV and uA. Also the values basically
describe the dumb battery, so please use this binding:

Documentation/devicetree/bindings/power/supply/battery.txt

> +	- reset-gpios: GPIO used for Master reset
> +	- low-power-gpios: GPIO used for low power mode of IC.
> +	- charge-enable-gpios: GPIO used to turn on and off charging.
> +	- pg-gpios: GPIO used for connecting the bq2515x device PG (Power Good)
> +		pin.  This pin should be used if possible as this is the
> +		recommended way to obtain the charger's input PG state.
> +		If this pin is not specified a software-based approach for PG
> +		detection is used.
> +
> +Example
> +bq25150@6b {

charger@6b

> +	compatible =3D "ti,bq25150";
> +	reg =3D <0x6b>;
> +	#address-cells =3D <1>;
> +	#size-cells =3D <0>;
> +
> +	pg-gpios =3D <&gpio1 28 GPIO_ACTIVE_HIGH>;
> +	reset-gpios =3D <&gpio0 14 GPIO_ACTIVE_HIGH>;
> +	low-power-gpios =3D <&gpio0 15 GPIO_ACTIVE_HIGH>;
> +	charge-enable-gpios =3D <&gpio0 13 GPIO_ACTIVE_LOW>;
> +
> +	ti,charge-current =3D <300>;
> +	ti,battery-regulation-voltage =3D <4200>;
> +};
> +
> +Reference Datasheet:
> +http://www.ti.com/lit/ds/symlink/bq25150.pdf
> +http://www.ti.com/lit/ds/symlink/bq25155.pdf
> --=20
> 2.22.0.214.g8dca754b1e
>=20

-- Sebastian

--rtitbtohtnvbnysq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl2sU1YACgkQ2O7X88g7
+pqvZA//fM8eIVmOvdIvzuodwv79zMkuzA/5HrJENqTYa/T773WMaP40yDvuX9Yl
kO9WCni/qc2GWPcDPhILF+0XmHdhguWNA23Rr4/g5cFvHDSvEYdmEYmJr7jXSA7u
JsH5u2lcc3ou4dHizRlX73PJJH42mhuhydkcmmqUHVZI0RIOboEmjpRi+4zczF0h
qg7ED6/0PAUbc/QrAj89tTUuVqDma05YZUTAK0ZHITGGnuGNbgIzZBVm+/gf1j8Q
KaGyGbq1AWKypDY8BSRvndC1Jpsv/A9i0mbqEtFN/U4+CVMG8j1yDT16M0pq5fB0
iNgJQkCPSxJKLE56BpDoESBAb25AdZ5fEjTPCy7A4lB0aVpTVxXzwkc8rpPPkCXv
6uaOgmucLH9oDpNQizDjP6DCUKEUXx/eXIXySJYYDYeATcZK2txU2VHYSjYi7uSE
HjdsBmRUVhTukqQBOQeIwcRAYL66hjDap/AJXvdcKZ3tLpmXv2uO5/YiRmAQH6hB
RPAvm7maH0hp66+9C/NJ8UAnvuSILPgzzkrbYjFtu55mBFDv4SIM1GflnwR8wGeJ
qiUmgsnZmUuNbbO77vvMR1owYsa2a/ao4bHeNemJG8ptjIrHTlVhG9T/Y6G9SIh3
UMcxDvl6sPbr0DMZFDNxHyyl4bVfgG3/TzQiGtUlQdc0zrtc0uU=
=2E8i
-----END PGP SIGNATURE-----

--rtitbtohtnvbnysq--
