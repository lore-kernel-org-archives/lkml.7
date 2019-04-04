Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71616C10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5024B20820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbfDDLRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 07:17:32 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48333 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbfDDLRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 07:17:32 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 8EDF480323; Thu,  4 Apr 2019 13:17:20 +0200 (CEST)
Date:   Thu, 4 Apr 2019 13:17:31 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Nick Crews <ncrews@chromium.org>
Cc:     enric.balletbo@collabora.com, bleung@chromium.org,
        linux-leds@vger.kernel.org, jacek.anaszewski@gmail.com,
        alexandre.belloni@bootlin.com, a.zummo@towertech.it,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dlaurie@chromium.org, sjg@google.com, groeck@google.com,
        dtor@google.com
Subject: Re: [PATCH v4 2/2] platform/chrome: Add Wilco EC keyboard backlight
 LEDs support
Message-ID: <20190404111731.GA18653@amd>
References: <20190403212757.132684-1-ncrews@chromium.org>
 <20190403212757.132684-2-ncrews@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <20190403212757.132684-2-ncrews@chromium.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-04-03 15:27:58, Nick Crews wrote:
> The EC is in charge of controlling the keyboard backlight on
> the Wilco platform. We expose a standard LED class device at
> /sys/class/leds/chromeos::kbd_backlight. This driver is modeled

Please use platform::kbd_backlight.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyl58sACgkQMOfwapXb+vJt3QCghaHErLDMJqTNyiuOdDItOitT
GksAn3e8UW+bDBwdh66UJ0k4HR+I51RZ
=yv61
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
