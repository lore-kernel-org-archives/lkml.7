Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2071BC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E42FC21726
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554476060;
	bh=izOXLK7Rr9BxTRV8ObwIzw5DcKONC1vfAXbz0JoTQMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QoFomR23Uu3vl4Ln02Y6Ff+EVud1w6De/0/KLH36huaHIewSh0qNIfzOtXx0eTOhA
	 n+bRw2MB9Z7SpzGJIcSUVXJRFgxSZnuVHTzflotiDjcTkBNxpYq32MHpAZiUN+h3pk
	 9+ZWPn3nHhKNOdHT0PLm4+WS4ILzLYoCoAlv7/EQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731220AbfDEOyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:54:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:53934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbfDEOyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 10:54:18 -0400
Received: from earth.universe (host-091-097-083-087.ewe-ip-backbone.de [91.97.83.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FC6D206B6;
        Fri,  5 Apr 2019 14:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554476057;
        bh=izOXLK7Rr9BxTRV8ObwIzw5DcKONC1vfAXbz0JoTQMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fr3Ultc8BUg3nLGq2VRCs8OZFCTqSbUkj0wgROxT4Z7iePKRRfepULzzoXqv92uqP
         8oQCNmwkBCShIA6nMN/ZFHLZTFYnKnJF7aA+1k1n4/6UW+ltuBbp4nwrWKHwBaC/Mt
         Bqw9ubMRMd05Q23/cFvPgnIG4R1hyu90+NbA8Lis=
Received: by earth.universe (Postfix, from userid 1000)
        id ABCD73C08D5; Fri,  5 Apr 2019 16:54:15 +0200 (CEST)
Date:   Fri, 5 Apr 2019 16:54:15 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org
Subject: Re: [PATCH 1/1] dt-bindings: power: supply: add missing semi-colon
 in example
Message-ID: <20190405145415.4dthzpqgvww7gv3a@earth.universe>
References: <20190328203518.12100-1-sebastien.bourdelin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wepqn5kyeknu4t3h"
Content-Disposition: inline
In-Reply-To: <20190328203518.12100-1-sebastien.bourdelin@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wepqn5kyeknu4t3h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 28, 2019 at 04:35:18PM -0400, Sebastien Bourdelin wrote:
> Fix the example documentation which is missing a semi-colon.
>=20
> Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
> ---
>  Documentation/devicetree/bindings/power/supply/gpio-charger.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/gpio-charger.=
txt b/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
> index adbb5dc5b6e9..ddf7b7b971e1 100644
> --- a/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
> +++ b/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
> @@ -20,7 +20,7 @@ Example:
>  		compatible =3D "gpio-charger";
>  		charger-type =3D "usb-sdp";
>  		gpios =3D <&gpf0 2 0 0 0>;
> -	}
> +	};
> =20
>  	battery {
>  		power-supplies =3D <&usb_charger>;
> --=20
> 2.20.1
>=20

Thanks, queued.

-- Sebastian

--wepqn5kyeknu4t3h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlynbBMACgkQ2O7X88g7
+pqViRAAo72q+SntauFv4VqYQR6nq1rukGbCNCYWqdn1DW8iSGQQNWJbtq+jJ7lC
eWcrAMYx64tGioMfW0WRhJLPjXC393h7XRG4LvCUJDXBxzl6Yx7gDA0DkyEZpJMH
OLxgTK7NNmS3fSdtPkwi90C+QOKV013Ci/HBpoEX35b1Jrx/Z58q3mHrxCstFW5j
qgHvnUslid4LTpHnbLF3UfdG2a9cmXLrpdooUxaJ3khIbo1KKcU56UR1raXuwQvZ
bJUZx3SkDUowr/FhaoyWNEFWYwWG0fHgXtoi5aUu4TMGu7xgZz23gsXOh+y3UD48
UIq1qwhMBe6X+f3JenzGwdZcL0qw/jlwtFZGST/qhb2aLTxbsyfw86JNm8ogUgBN
b3FrH81iMPTzHEVJP5oLSSYHqHoq+iOXB6vuu8FtpwUxR1Mw6ULESV2qyBKv5lDC
43cT+UAwAYGrMg7tMA5RqXMQH4CjTA4zWUNvY8jL7oADFrZkFtGNHWsCQwwm/RnU
dHuc6Frn5JL9DJxXxsVXtLlKfVgrUr6wjoNWkG19p8i9GhRimFN67IH/nYViJLpU
LMskOjETonKzy6+ubpEclSpJGtW1LyS+dAiNaCWlbwaRGa0+FDkW62Uwiyz0+Bgn
Px/ZR6dYskChIQAJEGx47BwJ2/OVGrdSx3N7bbnWWtF+z9igHsU=
=uV8j
-----END PGP SIGNATURE-----

--wepqn5kyeknu4t3h--
