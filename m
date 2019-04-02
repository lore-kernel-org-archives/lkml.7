Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56075C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EBE1206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730873AbfDBQpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:45:33 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45867 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729134AbfDBQpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:45:32 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 48C1E803A1; Tue,  2 Apr 2019 18:45:22 +0200 (CEST)
Date:   Tue, 2 Apr 2019 18:45:33 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Brian Masney <masneyb@onstation.org>, lee.jones@linaro.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com,
        robh+dt@kernel.org, jacek.anaszewski@gmail.com,
        mark.rutland@arm.com, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org, jonathan@marek.ca
Subject: Re: [PATCH v2 3/3] backlight: lm3630a: add device tree supprt
Message-ID: <20190402164533.GA21197@amd>
References: <20190401103034.21062-1-masneyb@onstation.org>
 <20190401103034.21062-4-masneyb@onstation.org>
 <7bcd94ee-a4f8-c91b-697d-cc4c6337ec88@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <7bcd94ee-a4f8-c91b-697d-cc4c6337ec88@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2019-04-02 08:45:40, Dan Murphy wrote:
> Hello
>=20
> On 4/1/19 5:30 AM, Brian Masney wrote:
> > Add device tree support to the lm3630a driver and allow configuring
> > independently on both banks the mapping mode (linear or exponential),
> > initial and maximum LED brightness.
> >=20
> > Driver was tested on a LG Nexus 5 (hammerhead) phone.
> >=20
>=20
> Don't need this in the commit message.

Actually yes, we want that in commit message.

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyjka0ACgkQMOfwapXb+vJlLQCfb+QClcjkBs0Gz/ZOrNVc67Ym
Q5AAn2zrd/Y8a0Olh+hEaIMAtfAIiIRx
=/PdP
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
