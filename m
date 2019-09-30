Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A77C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 21:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF37215EA
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 21:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732235AbfI3VNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 17:13:47 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59463 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732098AbfI3VNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 17:13:45 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 7837F80450; Mon, 30 Sep 2019 20:46:53 +0200 (CEST)
Date:   Mon, 30 Sep 2019 20:47:07 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>,
        intel-gfx@lists.freedesktop.org, rodrigo.vivi@intel.com,
        joonas.lahtinen@linux.intel.com, jani.nikula@linux.intel.com
Subject: DDC on Thinkpad x220
Message-ID: <20190930184707.GA5703@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Thinkpad X220 should be new enough machine to talk DDC to the
monitors, right? And my monitor has DDC enable/disable in the menu, so
it should support it, too...

But I don't have /dev/i2c* and did not figure out how to talk to the
monitor. Is the support there in the kernel? What do I need to enable
it?

lspci says:

00:02.0 VGA compatible controller: Intel Corporation 2nd Generation
Core Processor Family Integrated Graphics Controller (rev 09)

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl2STasACgkQMOfwapXb+vL16ACfSoUa6tozp+6EaRI5SZTafFKL
SyYAmQE2L8RE1QlhotneMsJwyFUl0K8g
=8vfn
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
