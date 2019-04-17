Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860D7C282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 02:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55F5C21871
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 02:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555554924;
	bh=yL//ZT2RAkjNGEi5D1GWC+bb1OILXN4jA4Dl91sbwE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BkoW9brG1TOTUmj2ZJARGQQxnOWfkmiRZIYkzCsh6vZ/9UZGYR/lfcQwAp4p812Er
	 eCEwliEa+tgcT37JSYpZ4E00oH8qlc8ddyczcMhhYVjsH9NRvmItrYhk+5VtkMmS6A
	 wF9hnpFfn2HL8poDdt9B/ajuIZHJnO5plQg4O7hg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387973AbfDRCfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 22:35:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387943AbfDRCfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 22:35:19 -0400
Received: from earth.universe (dyndsl-037-138-087-229.ewe-ip-backbone.de [37.138.87.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 340F021871;
        Thu, 18 Apr 2019 02:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555554917;
        bh=yL//ZT2RAkjNGEi5D1GWC+bb1OILXN4jA4Dl91sbwE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lXz5vQ1kAN4XSaefLePn7gHTfawbzLtq6LSBeBvdB/zJE6ekSBZcj45W1oM5JBY0t
         6Pr2RnnB6L4kF2ML/RndE+3sAyyjtmObuvOOT1AvfiGrriBy8VS7THAv0bPUle36TR
         yqj9GeHnCzvPfuofJmCOb7bWwfZn/H6b0md51CiI=
Received: by earth.universe (Postfix, from userid 1000)
        id 2BF063C08D5; Wed, 17 Apr 2019 22:30:09 +0200 (CEST)
Date:   Wed, 17 Apr 2019 22:30:09 +0200
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
Subject: Re: [PATCH v9 02/11] dt-bindings: power: supply: add DT bindings for
 max77650
Message-ID: <20190417203009.saoa63glegq4eb3v@earth.universe>
References: <20190411124212.7612-1-brgl@bgdev.pl>
 <20190411124212.7612-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7fhkjxtdavvca5ie"
Content-Disposition: inline
In-Reply-To: <20190411124212.7612-3-brgl@bgdev.pl>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7fhkjxtdavvca5ie
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 11, 2019 at 02:42:03PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>=20
> Add the DT binding document for the battery charger module of max77650.
>=20
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  .../power/supply/max77650-charger.txt         | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/max776=
50-charger.txt
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/max77650-char=
ger.txt b/Documentation/devicetree/bindings/power/supply/max77650-charger.t=
xt
> new file mode 100644
> index 000000000000..821a2240e70f
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

The binding looks good to me.

> +Example:
> +--------
> +
> +	charger {
> +		compatible =3D "maxim,max77650-charger";
> +		min-microvolt =3D <4200000>;
> +		curr-lim-microamp =3D <285000>;
> +	};

The example does not match the binding.

-- Sebastian

--7fhkjxtdavvca5ie
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAly3jMUACgkQ2O7X88g7
+poRyxAAlC312T7qc3WLeS8sgNYvcN2jm8slesimGubCyfHSTmE5uHQkIWF9tTnr
piMNbali+wQmePuzKQgrdPMRljrVIS0K+3OUatTEitWnMrJsLbNLeAnCkmiN/6v4
KJEf8MvJGJmmTv6VzENcZPzUR8W25piJdB9qQO9snTh+c250VHwqiL9WAJnC3rhy
Lz+PQishmNyw5/B2VOICjFKmsFfK1FzO41kmfTjXwJYY6PIsl/IHrT98ph/dz0Ng
X7mfv4bq1aem6uicG+qMIhZUtcBwsLW79TF16HLYbrpPXtBMdXuHFRLvgt4TSNVH
QB9cGl9az/3mqGcQOjAYPgbEYgdNHkiWY4hCu7ZTha7aL50SU8idcNnnmpi0vCHB
iOKrTUuvb9dNM2NTkC6nENi2+Q0xg6LkqeaM4xAee2u2/sFVAL9utF+56T2A+050
8b4p8ItAR6zR7JFQYviVyEYhR7L/phnJjYYzL/KgV6qtKYeBG4Je2xwOsZnfqd4q
t/d1KaJzmHAOFGVkbycroQaMk0SNM6CwBLi4uDTCRSv2B9V2UYTouGCXyyyoxSfy
NjQKWh4Dl8KdVO48ILGHH4idCtA8qi0dhAexL7AEpG9rgxqK2Zo6fjk98vd+UbGL
YZVUF6mQlLuEPWrqBmqiHTvrXMR2Qy62napScFntBc6C2b85IXE=
=8/J+
-----END PGP SIGNATURE-----

--7fhkjxtdavvca5ie--
