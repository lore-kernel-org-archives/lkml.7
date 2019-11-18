Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DC6C43215
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6568C21479
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574096475;
	bh=ma3hU9rG4HI8z8lWpvKDqtt2mW3ZBOM5oyvya7/4vis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ocTdpgT2qMHjSRwr4ofT5gOEreDKJiT1Sbq9+ZqGqrri1UhJq/Db3Y3UmY+R3jNC7
	 8xcVQVLYQPFCRLZYlnP9Frw9ZT9lV27ri0jidAWByX5/1zv1wiSII8++yuQArCOjGW
	 pMZD396Aqtl9FAScbA1SoZXCuLoVgdy61V6apuD0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfKRRBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 12:01:14 -0500
Received: from foss.arm.com ([217.140.110.172]:37214 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbfKRRBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 12:01:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 947BD1FB;
        Mon, 18 Nov 2019 09:01:13 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 026763F703;
        Mon, 18 Nov 2019 09:01:12 -0800 (PST)
Date:   Mon, 18 Nov 2019 17:01:11 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Grigoryev Denis <grigoryev@fastwel.ru>,
        Axel Lin <axel.lin@ingics.com>, Dan Murphy <dmurphy@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v1 1/4] tps6105x: add optional devicetree support
Message-ID: <20191118170111.GL9761@sirena.org.uk>
References: <20191118165400.21985-1-TheSven73@gmail.com>
 <20191118165400.21985-2-TheSven73@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4oF+6Ged69J0+4/e"
Content-Disposition: inline
In-Reply-To: <20191118165400.21985-2-TheSven73@gmail.com>
X-Cookie: no maintenance:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4oF+6Ged69J0+4/e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2019 at 11:53:57AM -0500, Sven Van Asbroeck wrote:

> 	tps61052@33 {
> 		compatible =3D "ti,tps61052";
> 		reg =3D <0x33>;
>=20
> 		regulator {
> 			compatible =3D "ti,tps6105x-regulator";
> 		};

We shouldn't need a compatible here, the MFD should just instantiate any
children it has.  This also doesn't document any actual regulators on
the device.

--4oF+6Ged69J0+4/e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3SzlYACgkQJNaLcl1U
h9C0AQf+PilXEdM8POFA/pohdo6vlL+sDny5SKG71tCYQ69MJZnHrrxX3mFryP06
D3AbTr4JQzd2PY6nBev/3LXrAzQOGg9KlFrp6Y6n7NIFpGwSOYceewD6abtPC6fL
7ss/L9ksyULzAI3Fo3aawOnTO/9E7nA5omSnJjz2/myTcvT6LRK/gajlmZEoBB4a
SDDUyphWfe7B1DNuZmaCWpcW8N0WYazByoV4NCH0haqueYtcgcYap1vO6JyVh9e9
/TAFSENMFes5NeAOYwagvCvJNs5sTdS6rF1cGCwwj8FeDe+VAydYL9QCPLd/F+j2
ZHrVgIc2XeJAn/8FO3Vk4mmgGioyqA==
=SUqe
-----END PGP SIGNATURE-----

--4oF+6Ged69J0+4/e--
