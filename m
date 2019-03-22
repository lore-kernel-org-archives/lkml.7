Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87381C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D712183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730947AbfCVNJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:09:15 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:43828 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730189AbfCVLfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:35:12 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 9069880519; Fri, 22 Mar 2019 12:35:02 +0100 (CET)
Date:   Fri, 22 Mar 2019 12:35:09 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Nick Crews <ncrews@chromium.org>
Cc:     enric.balletbo@collabora.com, bleung@chromium.org,
        linux-leds@vger.kernel.org, jacek.anaszewski@gmail.com,
        linux-kernel@vger.kernel.org, dlaurie@chromium.org, sjg@google.com,
        groeck@google.com, dtor@google.com
Subject: Re: [PATCH 3/3] platform/chrome: Add Wilco EC keyboard backlight
 LEDs support
Message-ID: <20190322113509.GE8681@amd>
References: <20190321221334.240059-3-ncrews@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5oH/S/bF6lOfqCQb"
Content-Disposition: inline
In-Reply-To: <20190321221334.240059-3-ncrews@chromium.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5oH/S/bF6lOfqCQb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The EC is in charge of controlling the keyboard backlight on
> the Wilco platform. We expose a standard LED class device at
> /sys/class/leds/wilco::kbd_backlight. This driver is modeled
> after the standard Chrome OS keyboard backlight driver at
> drivers/platform/chrome/cros_kbd_led_backlight.c

Please make it platform::kbd_backlight . Userland should not need to
know what wilco is...

What is wilco, anyway?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--5oH/S/bF6lOfqCQb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyUyG0ACgkQMOfwapXb+vI3PQCeNMpXRM3HzrbVPlrFbv5HDU1p
QCYAnAr7iz4pAf8qslk9HOAkNNTzvVxZ
=jRXk
-----END PGP SIGNATURE-----

--5oH/S/bF6lOfqCQb--
