Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFB8C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 13:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17E5E20706
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 13:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574429555;
	bh=oTuWrUy7fpMEAfE4QBT9wkrjwjJJaY7iBKrVHeJAAso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LpSuTsQZXvg24qS6/1r12UuTDN/wMtL5oATpRtnM0ZmbPQvkYer3xlnagA2WSBuQy
	 Th33tjfhx3kO9Q4K9LvtBa2CHBVueJOgntu+W/8A1Q+NjNVc6N0FTpGLwR5Co6i12b
	 axhh6CF71v1VbSN5GFcxIF1zJ9XEOFzdQjnOyzzA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfKVNce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 08:32:34 -0500
Received: from foss.arm.com ([217.140.110.172]:47614 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726633AbfKVNcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 08:32:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA49731B;
        Fri, 22 Nov 2019 05:32:32 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 617BF3F703;
        Fri, 22 Nov 2019 05:32:32 -0800 (PST)
Date:   Fri, 22 Nov 2019 13:32:30 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        Axel Lin <axel.lin@ingics.com>, Dan Murphy <dmurphy@ti.com>,
        devicetree@vger.kernel.org, Grigoryev Denis <grigoryev@fastwel.ru>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>
Subject: Re: Applied "tps6105x: add optional devicetree support" to the
 regulator tree
Message-ID: <20191122133230.GD6849@sirena.org.uk>
References: <20191119154611.29625-2-TheSven73@gmail.com>
 <applied-20191119154611.29625-2-TheSven73@gmail.com>
 <20191122073124.GA3296@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Qrgsu6vtpU/OV/zm"
Content-Disposition: inline
In-Reply-To: <20191122073124.GA3296@dell>
X-Cookie: sillema sillema nika su
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qrgsu6vtpU/OV/zm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2019 at 07:31:24AM +0000, Lee Jones wrote:
> On Wed, 20 Nov 2019, Mark Brown wrote:

> > Example: put chip in regulator mode:

> > i2c0 {
> > 	tps61052@33 {
> > 		compatible =3D "ti,tps61052";
> > 		reg =3D <0x33>;
> >=20
> > 		regulator {
> >                             regulator-min-microvolt =3D <5000000>;
> >                             regulator-max-microvolt =3D <5000000>;
> >                             regulator-always-on;
> > 		};
> > 	};
> > };

> ?

Sorry, I completely missed that this was adding a MFD file - the binding
only mentioned regulator stuff and I clearly didn't look at the
filename.  Do you want me to drop it?

--Qrgsu6vtpU/OV/zm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3X420ACgkQJNaLcl1U
h9A+dwf9F8AlkRemvtREyMZpewdCJ0ovvR/f76eStncNGq9odeCRfkw7R9l7SDZx
gCd0WiEkEMecVYjARC8uYv6pJ/CyVDD0UvVp5ZmLc7cJRFgyKWzOfyIQoM+1BDwI
nzPzQim+DdOmmjB+3/gxHQ4JAjBx9R9S+D/NwQGpLQdEQHhzrKDvLz3BY1mvLJCh
1wBvAX2x/xnHwVkQ4wH4mmyQnvE2uWXeuv9kyv9b8iW/jREtFBrK9w/m8SyyVUjO
8kInYGaOgmwHKX3PSzy+6tKNT8KpGPIdzLgUOji8JUxy0yK2cRfXPrQwzKGA3N1x
ypeqE8aNQ6TS3kcHieEFIb3OVrD1Ag==
=YBx2
-----END PGP SIGNATURE-----

--Qrgsu6vtpU/OV/zm--
