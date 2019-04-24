Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75C5C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 11:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 703C32084B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 11:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556190724;
	bh=xxr/gsoL6alH3mlWXMoUgEpWk4JCmpJ/sRaTzuCpCro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jp3JtdjM04Zrij8O16kJ0fY73TuiRETKwO3PNjCZf6ZMbiPxKsO6qHIbYxM5mA5yW
	 1n9dFRQTKgZGDscUQYAEeBylD2K2sI4Aj1ozuPOzQ0p6z+QZWpuRmKWMRFfoqllEa4
	 fRnH3Kp+FCt7NS5V1ZOL6QP/ZUFLiz2bR5I4jpXY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730706AbfDYLMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 07:12:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:45654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbfDYLMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 07:12:02 -0400
Received: from earth.universe (dyndsl-037-138-081-021.ewe-ip-backbone.de [37.138.81.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A750217FA;
        Thu, 25 Apr 2019 11:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556190721;
        bh=xxr/gsoL6alH3mlWXMoUgEpWk4JCmpJ/sRaTzuCpCro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vxtB7tbdB5wSP+fdketexgu5Xt1pCgVd+Vn9HTV4JVBZSnwQZvd2MV5FiDCsIPWg2
         qFCMtPXhu6TBH0YyACSq8IYmqw6cW9WIYvXM2e1RGrP8TNwblri5FDH2Z0d0CtEg7M
         aekwYNV56oan4PJQH9LbXYTCA1pnDxrLzdcVwwFw=
Received: by earth.universe (Postfix, from userid 1000)
        id 4DBDA3C0C74; Wed, 24 Apr 2019 13:31:02 +0200 (CEST)
Date:   Wed, 24 Apr 2019 13:31:02 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v10 02/11] dt-bindings: power: supply: add DT bindings
 for max77650
Message-ID: <20190424113102.pej37jnlidwfzjhk@earth.universe>
References: <20190423090451.23711-1-brgl@bgdev.pl>
 <20190423090451.23711-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tzyyotohclek3npg"
Content-Disposition: inline
In-Reply-To: <20190423090451.23711-3-brgl@bgdev.pl>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tzyyotohclek3npg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 23, 2019 at 11:04:42AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>=20
> Add the DT binding document for the battery charger module of max77650.
>=20
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  .../power/supply/max77650-charger.txt         | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/max776=
50-charger.txt
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/max77650-char=
ger.txt b/Documentation/devicetree/bindings/power/supply/max77650-charger.t=
xt
> new file mode 100644
> index 000000000000..e6d0fb6ff94e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/max77650-charger.txt
> @@ -0,0 +1,28 @@
> +Battery charger driver for MAX77650 PMIC from Maxim Integrated.
> +
> +This module is part of the MAX77650 MFD device. For more details
> +see Documentation/devicetree/bindings/mfd/max77650.txt.
> +
> +The charger is represented as a sub-node of the PMIC node on the device =
tree.
> +
> +Required properties:
> +--------------------
> +- compatible:		Must be "maxim,max77650-charger"
> +
> +Optional properties:
> +--------------------
> +- input-voltage-min-microvolt:	Minimum CHGIN regulation voltage. Must be=
 one
> +				of: 4000000, 4100000, 4200000, 4300000,
> +				4400000, 4500000, 4600000, 4700000.
> +- input-current-limit-microamp:	CHGIN input current limit (in microamps)=
=2E Must
> +				be one of: 95000, 190000, 285000, 380000,
> +				475000.
> +
> +Example:
> +--------
> +
> +	charger {
> +		compatible =3D "maxim,max77650-charger";
> +		input-voltage-min-microvolt =3D <4200000>;
> +		input-current-limit-microamp =3D <285000>;
> +	};
> --=20
> 2.21.0
>=20

--tzyyotohclek3npg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlzASPEACgkQ2O7X88g7
+pr0JRAApxsn5uxXytg/SEvhNBb/SxefIg95+EkMbpo96sFxk5ZP5xwaRdheUUzC
0sBN3TDPfn0IQsksQtLaZBqQ+RmQEA/K+PS7reoMNx0he1Xgetd33E6R1dBUR1XX
zi0thWOgS08u0TIX4tnogtitjVtXrY5tXJGDAqu0lQAhVjMuX8n81XQZ2zgZo4nG
42I+WP00S6JNI6kWBjHt8enj0ZzXUQc8bfcBm9uGkPpeO0u4DPHAysNeVQQBR0Ef
x4GoTX26tKiJoNrcV+V7wWDDpnpLV9c8QP0jyJCjCZPGpPtJNNieF79zhfLpgrVN
lkCamB9WLfigpnZBYgkm8dR7f1ZTFle1haYdGBfj/G/CL+rOPnrBcnQV4mv4VeNZ
vx5pM+H7EKRNDQASERSDXFejrtMi/VOj+pKxpUZqhyT63SgfVA0kHkTDt7xm+Ovc
ecvpRgx4FMWCj+FFpMVqIqcLrcdYmlnrOgJQvrkXMADuLW7xkPptQkuPnCUmugDq
uqZI4uIs7PVD/guIVM6UZhFP+4gsLFkRg8VW4T+I73NIJkN9AbKAp6L7vu2xMeYl
V3NVfGSp4f8lJNvlNV5auM2b+8vTGX+W7Ef+xUrxHj2Nh6zOR27wmVeDRcsofbmF
bH6mOSfxHrgnc9LG0LIahlxhIbfcmMr4XCu31xYozmL1GgwuWPM=
=usHc
-----END PGP SIGNATURE-----

--tzyyotohclek3npg--
