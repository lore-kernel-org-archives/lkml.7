Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710A2C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 22:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AF2121773
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 22:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388439AbfEWWGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 18:06:14 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46442 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387616AbfEWWGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 18:06:13 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 02EB0803D1; Fri, 24 May 2019 00:06:00 +0200 (CEST)
Date:   Fri, 24 May 2019 00:06:10 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Angus Ainslie <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v13 2/4] arm64: dts: fsl: librem5: Add a device tree for
  the Librem5 devkit
Message-ID: <20190523220610.GB15523@amd>
References: <20190520142330.3556-1-angus@akkea.ca>
 <20190520142330.3556-3-angus@akkea.ca>
 <20190523191922.GA3803@xo-6d-61-c0.localdomain>
 <9626cd324eaaab2b49c37cf3c824aa5e@www.akkea.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Content-Disposition: inline
In-Reply-To: <9626cd324eaaab2b49c37cf3c824aa5e@www.akkea.ca>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >>This is for the development kit board for the Librem 5. The current
> >>level
> >>of support yields a working console and is able to boot userspace from
> >>the network or eMMC.
> >>
> >>Additional subsystems that are active :
> >
> >>- haptic motor
> >
> >Haptic motor is not a LED. It should be controlled by input subsystem.
> >
> >>+	pwmleds {
> >>+		compatible =3D "pwm-leds";
> >>+
> >>+		haptic {
> >>+			label =3D "librem5::haptic";
> >>+			pwms =3D <&pwm2 0 200000>;
> >>+			active-low;
> >>+			max-brightness =3D <255>;
> >>+			power-supply =3D <&reg_3v3_p>;
> >>+		};
> >>+	};
> >
> >You can take a look at N900, that has reasonable interface.
>=20
> I wanted to control the haptic with the pwm-vibra driver but "fsl,imx27-p=
wm"
> doesn't seem to respect the PWM_POLARITY_INVERTED flag so when I start the
> system the vibrator is full on.

Ok, lets fix that :-).

> I could use gpio-vibrator but that seemed like a waste when the device is
> connected to pwm.
>=20
> I figured the using the pwm-leds interface was a reasonable compromise un=
til
> I had an opportunity to make changes the the imx27-pwm driver.

I guess in such case it would be best to leave out this section for
now... or keep it disabled / something. We don't want incorrect device
trees to stick around.

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlznGVIACgkQMOfwapXb+vKN/gCfWaysTUeuBj2xcwWEq2OylDMS
zFsAnRLEFwUNhwGErAbVlCaxo8N8aM47
=iExp
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--
