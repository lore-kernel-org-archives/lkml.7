Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23585C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 03:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C222186A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 03:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555644893;
	bh=esYqxcyWBII7VicI57GYCPW0UZenWkjmNmm7xcQXqLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LqNtuogrc43oit77ZjIzCS8MRNmVHmkWNrmyQabXDQWxCgLimQBZoCUCI4zjFxnYH
	 uNpTI6dg4HsYq0XML48UUsDq8GUzJdeMjXKlyJsYnkuHciaOOGsPRS7PncGr4AV+DR
	 0VMsAv1Koh8qk+q0KilGXpaP3yf481wuXJdGANWI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfDSDev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 23:34:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:51384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727192AbfDSDet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 23:34:49 -0400
Received: from earth.universe (dyndsl-091-248-050-217.ewe-ip-backbone.de [91.248.50.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 645FA2171F;
        Fri, 19 Apr 2019 03:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555644888;
        bh=esYqxcyWBII7VicI57GYCPW0UZenWkjmNmm7xcQXqLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ebwaTntv9OHOFruI1Ejb2MyL6OEgeHvL+hC0us6Asa3dYV8tETd3eFS80BxiFByV1
         1eYAW68K6GizlKZ5kw7dgx9Pm6deX5MzEu/lhpxVkRolb57xlJnHXZ7TVL9K1rwoL6
         L1MEacrI2RfpWY5F7+hfwej/7hKABmrDNnFs+sZQ=
Received: by earth.universe (Postfix, from userid 1000)
        id E255C3C08D8; Thu, 18 Apr 2019 21:47:03 +0200 (CEST)
Date:   Thu, 18 Apr 2019 21:47:03 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Artur Rojek <contact@artur-rojek.eu>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 3/4] dt-bindings: power: supply: Add docs for Ingenic
 JZ47xx SoCs battery.
Message-ID: <20190418194703.ft5rycsrzz3fyxxb@earth.universe>
References: <20190323172809.14407-1-contact@artur-rojek.eu>
 <20190323172809.14407-3-contact@artur-rojek.eu>
 <20190324153018.2e4011c9@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jlupxtszm5xqgv3k"
Content-Disposition: inline
In-Reply-To: <20190324153018.2e4011c9@archlinux>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jlupxtszm5xqgv3k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Mar 24, 2019 at 03:30:18PM +0000, Jonathan Cameron wrote:
> On Sat, 23 Mar 2019 18:28:08 +0100
> Artur Rojek <contact@artur-rojek.eu> wrote:
>=20
> > Add documentation for the ingenic-battery driver, used on JZ47xx SoCs.
> >=20
> > Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> Looks fine to me.
>=20
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks, queued.

-- Sebastian

>=20
> > ---
> >=20
> > Changes:
> >=20
> > v2: no change
> >=20
> >  .../bindings/power/supply/ingenic,battery.txt | 31 +++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/supply/inge=
nic,battery.txt
> >=20
> > diff --git a/Documentation/devicetree/bindings/power/supply/ingenic,bat=
tery.txt b/Documentation/devicetree/bindings/power/supply/ingenic,battery.t=
xt
> > new file mode 100644
> > index 000000000000..66430bf73815
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/supply/ingenic,battery.txt
> > @@ -0,0 +1,31 @@
> > +* Ingenic JZ47xx battery bindings
> > +
> > +Required properties:
> > +
> > +- compatible: Must be "ingenic,jz4740-battery".
> > +- io-channels: phandle and IIO specifier pair to the IIO device.
> > +  Format described in iio-bindings.txt.
> > +- monitored-battery: phandle to a "simple-battery" compatible node.
> > +
> > +The "monitored-battery" property must be a phandle to a node using the=
 format
> > +described in battery.txt, with the following properties being required:
> > +
> > +- voltage-min-design-microvolt: Drained battery voltage.
> > +- voltage-max-design-microvolt: Fully charged battery voltage.
> > +
> > +Example:
> > +
> > +#include <dt-bindings/iio/adc/ingenic,adc.h>
> > +
> > +simple_battery: battery {
> > +	compatible =3D "simple-battery";
> > +	voltage-min-design-microvolt =3D <3600000>;
> > +	voltage-max-design-microvolt =3D <4200000>;
> > +};
> > +
> > +ingenic_battery {
> > +	compatible =3D "ingenic,jz4740-battery";
> > +	io-channels =3D <&adc INGENIC_ADC_BATTERY>;
> > +	io-channel-names =3D "battery";
> > +	monitored-battery =3D <&simple_battery>;
> > +};
>=20

--jlupxtszm5xqgv3k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAly41DcACgkQ2O7X88g7
+prxuQ//dogDbAB6g0ZRjyPjplt7z1BFvF8WcW561216oY8bwMlXn8kw/tzWFD7O
4g1iuFFbdVbySVuEccFdzzdGbjx71+nWvVVy5ucC5mr/W5NGMdnFGzWf74uEUbga
p6UYg+lizs4SAVfJEiCreZQAS0qdbF2IPgs39Wnov6PXra87L/H+0USKIDwZZqUb
cnmQl7TF19w7JDgNNp5j8nPELRtqrRhq00liIS155LBiUGUYjufiot0oCDe58Z/K
MYtxl1suUcKRLLj8f3CjMFJKSkL9XbE0gGnVtwJBIiDAwqahYtmmbzHDjxroiHm2
jzbm05EtTXWBKxze4D9o9RTaTbyjY1wTzyvaM0x9S+PxocOaXGqiLaFGcHTONBDz
SnuczqxylpVLmOYHWLb7ByB8muY++kuFFkOZvcp60aEl9+9nQyaNF48sOOh9+aPB
MyjcjVBOxES5JYIYhFglW4WFRuy8XR3KuUaKLz/DWy+F8/tpQOvR60BSSiMuZ5tM
CW/RqV9J9d6Lc6Ect4EnFtZuEOwdHzuUiDGj7hS3Q6YWwIjzma5RMQjDZdH5SGKW
D6eJIgXJBC+9FXtl9EdCxxDI+yKf7Igsp0rOSxfXkD5w12zCYNEnGhLqnXCCf+x3
QKUOHIFWTwVkH8gKZ75Jg8nDy/jdIDrStMopvWTgHFB6suO1peA=
=iubX
-----END PGP SIGNATURE-----

--jlupxtszm5xqgv3k--
