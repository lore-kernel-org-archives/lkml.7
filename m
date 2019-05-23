Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7CFC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1671F21019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730049AbfEWJJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 05:09:30 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53784 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfEWJJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 05:09:29 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 74E3E80311; Thu, 23 May 2019 11:09:17 +0200 (CEST)
Date:   Thu, 23 May 2019 11:09:26 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
Subject: 5.2-rc1 on droid4: spi crash
Message-ID: <20190523090926.GA9106@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

This was greeting me overnight... I don't yet know how reproducible it
is, it happened once so far.

Best regards,
								Pavel

root@devuan:/sys/class/leds#
Message from syslogd@devuan at May 23 00:11:31 ...
 kernel:[14889.641143] Internal error: Oops: 5 [#1] SMP ARM

Message from syslogd@devuan at May 23 00:11:51 ...
 kernel:[14909.638275] Process spi0 (pid: 100, stack limit =3D
 0x97305d31)

Message from syslogd@devuan at May 23 00:11:51 ...
 kernel:[14909.650238] Stack: (0xedee7ed0 to 0xedee8000)

Message from syslogd@devuan at May 23 00:11:51 ...
 kernel:[14909.652069] 7ec0:
 00000000 00000000 eba35c14 eba35c50

Message from syslogd@devuan at May 23 00:11:51 ...
 kernel:[14909.662841] 7ee0: edd93000 edd93360 ede3da50 c052683c
 ffffffff edadcc10 edadcc9c 00000004

Message from syslogd@devuan at May 23 00:11:51 ...
 kernel:[14909.671051] 7f00: 00000000 ede3d800 600f0013 edd93000
 eba35c14 eba35c50 edadcc10 edadcc10

Message from syslogd@devuan at May 23 00:11:51 ...
 kernel:[14909.679260] 7f20: 00000002 00000001 edd9322c c0526cb4
 edd932a4 edb34600 edd932a0 edd932a4

Message from syslogd@devuan at May 23 00:11:51 ...
 kernel:[14909.687499] 7f40: 00000000 edd932d0 edd932a0 edd932a4
 00000000 00000001 c0e82d14 edd932b4

Message from syslogd@devuan at May 23 00:11:51 ...
 kernel:[14909.695709] 7f60: c0e82d14 c0148f40 00000000 edca5580
 00000000 ede39400 edca55a8 edd932a0

Message from syslogd@devuan at May 23 00:11:51 ...
 kernel:[14909.703918] 7f80: ed88dd48 c0148e74 00000000 c01491ec
 ede39400 c01490dc 00000000 00000000

Message from syslogd@devuan at May 23 00:11:51 ...
 kernel:[14909.708251] 7fa0: 00000000 00000000 00000000 c01010e8
 00000000 00000000 00000000 00000000

Message from syslogd@devuan at May 23 00:11:51 ...
 kernel:[14909.720367] 7fc0: 00000000 00000000 00000000 00000000
 00000000 00000000 00000000 00000000

Message from syslogd@devuan at May 23 00:11:51 ...
 kernel:[14909.724334] 7fe0: 00000000 00000000 00000000 00000000
 00000013 00000000 00000000 00000000

Message from syslogd@devuan at May 23 00:11:51 ...
 kernel:[14909.807312] Code: e3a08c02 e5954034 e1a01005 e1a00007
 (e5943008)
 Write failed: Broken pipe
 pavel@duo:/data/l/k$
=20
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzmY0YACgkQMOfwapXb+vImbACglBJwmJksJUdy7p/yaXHVJm2I
OzEAoLOmo07dE0Zan5Wn0qs3XGq3xV55
=vTr7
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
