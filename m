Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5F9C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 18:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B4C121D82
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 18:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbfJBSDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 14:03:32 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45141 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbfJBSDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 14:03:32 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id B49EE802D9; Wed,  2 Oct 2019 20:03:14 +0200 (CEST)
Date:   Wed, 2 Oct 2019 20:03:28 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH -next 0/2] leds: add substitutes for
 /sys/class/leds/<led>/trigger
Message-ID: <20191002180327.GA13492@amd>
References: <1570029181-11102-1-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <1570029181-11102-1-git-send-email-akinobu.mita@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Reading /sys/class/leds/<led>/trigger returns all available LED triggers.
> However, this violates the "one value per file" rule of sysfs.
>=20
> This series provides a new /sys/devices/virtual/led-trigger/ directory and
> /sys/class/leds/<led>/current-trigger. The new api follows the "one value
> per file" rule of sysfs.

Lets not do this. We'll have to maintain the old interface, anyway, so
it does not really help.

Thanks,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl2U5m8ACgkQMOfwapXb+vJLOQCfaC+bQibVCrwNnM1twZAhfV6K
/vgAn0/ANRXMC6faiGgSOvA8tZyh1z8Y
=1/Zv
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
