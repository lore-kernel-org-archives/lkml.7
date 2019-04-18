Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF67EC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99037217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388969AbfDRMVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 08:21:38 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48147 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbfDRMVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 08:21:38 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 5ABEB805DC; Thu, 18 Apr 2019 14:21:27 +0200 (CEST)
Date:   Thu, 18 Apr 2019 14:21:35 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        dtor@google.com, robh@kernel.org, Jaroslav Kysela <perex@perex.cz>,
        linux@roeck-us.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/26] ALSA: line6: Avoid polluting led_* namespace
Message-ID: <20190418122135.GA6925@amd>
References: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
 <20190417205439.17685-2-jacek.anaszewski@gmail.com>
 <s5h8sw7riwt.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <s5h8sw7riwt.wl-tiwai@suse.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2019-04-18 07:17:54, Takashi Iwai wrote:
> On Wed, 17 Apr 2019 22:54:14 +0200,
> Jacek Anaszewski wrote:
> >=20
> > led_colors clashes with the array of the same name being added
> > to the LED class. Do the following amendments to fix this issue
> > and the other prospective one.
> >=20
> > led_colors -> toneport_led_colors
> > led_init_vals -> toneport_led_init_vals
> >=20
> > Fixes: f44edd7b2bbed ("ALSA: line6/toneport: Implement LED controls via=
 LED class")
> > Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> > Cc: Jaroslav Kysela <perex@perex.cz>
> > Cc: Takashi Iwai <tiwai@suse.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
>=20
> Looks good.
>=20
> Feel free to take my ack:
>   Reviewed-by: Takashi Iwai <tiwai@suse.de>

I guess this is independend of pretty much everything, and should be
taken through the sound tree?
									Pavel
								=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAly4a88ACgkQMOfwapXb+vLheQCeKn0Mp1aviCrf59LaaIwYOfbu
31sAnju8z8NM2XCi6i9PXH2Mokx/j32v
=3eLM
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
