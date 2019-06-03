Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE1AC04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 07:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1986E27CD8
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 07:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfFCHkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 03:40:06 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54503 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfFCHkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 03:40:06 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 0B8918028B; Mon,  3 Jun 2019 09:39:53 +0200 (CEST)
Date:   Mon, 3 Jun 2019 09:40:05 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, intel-gfx@lists.freedesktop.org,
        kernel list <linux-kernel@vger.kernel.org>
Subject: 5.2: display corruption on X60, X220
Message-ID: <20190603074004.GA15821@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

In recent kernels (5.2.0-rc1-next-20190522, 5.2-rc2) I'm getting
display corruption in X. Usually in terminals, but also in title bars
etc. Black areas with white lines in them, usually...

Same configuration worked properly in ... probably 4.19? Then I got
some graphics-crashes on X220 that prevented me from testing :-(.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlz0ztQACgkQMOfwapXb+vL3XgCfdrfE5/QIhmIwNFjA9gbc+rDp
hBUAoKIsXX5K+hFq8BY4AdpAgJ/o6xgj
=k0n+
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
