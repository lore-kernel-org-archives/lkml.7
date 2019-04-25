Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C81C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C238F20717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556229227;
	bh=Plwfy3oB+OykF8/1IlF7++4WyiIFYA0MI70M18z1WSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rk5GERdSE9rHno2zAntXQJiu9wt8HdO+QRqQP0TwLkf3EVs7pdpMsyrD5ppOmUoEP
	 yAOkhDs+NQZ09hclnGm0iJmXhDebvUGhOILQGS6q5/Zes6xbzAX5wkcs0hE36l7LE1
	 2cm4PTmlBtfnRCrGceUZr2DFIbFgB2wRngWAto0E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730877AbfDYVxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:53:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:53328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfDYVxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 17:53:46 -0400
Received: from earth.universe (unknown [185.62.205.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67A24206C1;
        Thu, 25 Apr 2019 21:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556229224;
        bh=Plwfy3oB+OykF8/1IlF7++4WyiIFYA0MI70M18z1WSI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jqQL/dbcwqs2D51cN4rE1l6EI93UALyGTXHF8GdW/erXVaGHeb+oSgw6ECTy0Q8Ou
         whkQPwJF+dfOPOqiUrGQbXLMKHCX1ErBvIBGnh3koruCpj91M7nhiLVWHUlynOf1L1
         DYQ0C/P50aeIJOcRJWdsI5+pnq5rwwqQ5JbkrcSw=
Received: by earth.universe (Postfix, from userid 1000)
        id 00E5D3C0D1D; Thu, 25 Apr 2019 23:46:09 +0200 (CEST)
Date:   Thu, 25 Apr 2019 23:46:09 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Pavel Machek <pavel@denx.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v10 00/11] mfd: add support for max77650 PMIC
Message-ID: <20190425214609.rav7ooxovzhvgn7e@earth.universe>
References: <20190423090451.23711-1-brgl@bgdev.pl>
 <20190424083127.GB6699@amd>
 <CAMRc=McN78_gJw_T4EPucM8veTC9XRUu7TGJ0J+zPsU=0Hu2GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hkqjlur2zgw6jemw"
Content-Disposition: inline
In-Reply-To: <CAMRc=McN78_gJw_T4EPucM8veTC9XRUu7TGJ0J+zPsU=0Hu2GQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hkqjlur2zgw6jemw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 24, 2019 at 10:45:00AM +0200, Bartosz Golaszewski wrote:
> =C5=9Br., 24 kwi 2019 o 10:31 Pavel Machek <pavel@denx.de> napisa=C5=82(a=
):
> >
> > On Tue 2019-04-23 11:04:40, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > This series adds support for max77650 ultra low-power PMIC. It provid=
es
> > > the core mfd driver and a set of five sub-drivers for the regulator,
> > > power supply, gpio, leds and input subsystems.
> > >
> > > Patches 1-4 add the DT binding documents. Patch 5 documents mfd_add_d=
evices().
> > > Patches 6-10 add all drivers. Last patch adds a MAINTAINERS entry for=
 this
> > > device.
> > >
> > > The regulator part is already upstream.
> >
> > I see v10 in my inbox... and acks from all over the place, but patches
> > not going in. Who takes these? I don't think I need another 10
> > versions in my inbox...
> >                                                                 Pavel
>=20
> I think Lee Jones should take them through the MFD tree. With the ack
> from Sebastian Reichel on the driver part and the example in the
> charger binding fixed I think they are ready to be picked up.

Fine with me.

-- Sebastian

--hkqjlur2zgw6jemw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlzCKpoACgkQ2O7X88g7
+pr2mBAAkSSqMITsZQW+RCxTbutrVPO+dqNO9WPo6/0+bjuOfMLt5V9ty3vimvhi
K/dCIpbQRO417ZwlyCM+mt5wuhPBGbgOy/65EBAcdFKweDFv4q/tug45qh6V3fZ8
6iaSwd9wXMf2UttkJZ5UeOX+O+ud19RjBVmoJ8HqUG5LA+ud0ZbUcVDhlUEiMcEJ
+zNMo0HQpUuKMmHRp2iKlWkoekPFDhEWnQZbuBxwhVhKbvZCX4LavbHeiR3GCkO8
Q1onr1MjkpFJfrQTjbQLOKFB5i2/I4EMmZ63LECwv5PhaYkb3Rf7dtGj7koS+4ni
rVKYEvSuiCXDPliimXmV6zorkK4FQd2ykZc+pHamTdEMsqanOr+K/BpSh4qOZvqH
Mo2t4FiEqKZ2ATKnfimQsqnPG37cr5yq4cKwukL+hND36maWjws0jF9o2HkXJI8Y
CTcIs+ZGjuDRDgW5bxkpao9P+M16FlKzrkO1EP6LLCBtIQde4nWf5jn26xHj8j56
QHGToQk12PykVLrXrzpWFYxHilzCtV7ZNdSj02rMFJFiCwcxkqPv2jJqQhILJnuR
CcdSpEILZZgcTan0H4p7plyOJWoPpminEHFZLHTNkQyywFYXXQRGHVRvNXjc/P/I
vpvXVsB8WQCEXVhUtJz1fzyEhBSKN0XGOPEWEe6OYtI4rgtm+io=
=X5TB
-----END PGP SIGNATURE-----

--hkqjlur2zgw6jemw--
