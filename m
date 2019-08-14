Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795D4C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 517DF2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfHNIVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 04:21:04 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47831 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbfHNIVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 04:21:04 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 1CD148097D; Wed, 14 Aug 2019 10:20:49 +0200 (CEST)
Date:   Wed, 14 Aug 2019 10:21:01 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     kishon@ti.com, pavel@denx.de, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] phy: renesas: rcar-gen3-usb2: Fix sysfs interface of
 "role"
Message-ID: <20190814082101.GA22422@amd>
References: <1564563689-25863-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <1564563689-25863-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-07-31 18:01:29, Yoshihiro Shimoda wrote:
> Since the role_store() uses strncmp(), it's possible to refer
> out-of-memory if the sysfs data size is smaller than strlen("host").
> This patch fixes it by using sysfs_streq() instead of strncmp().
>=20
> Reported-by: Pavel Machek <pavel@denx.de>
> Fixes: 9bb86777fb71 ("phy: rcar-gen3-usb2: add sysfs for usb role swap")
> Cc: <stable@vger.kernel.org> # v4.10+
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Acked-by: Pavel Machek <pavel@denx.de>

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1TxGwACgkQMOfwapXb+vLE1gCgqglIGMRA+M9T0O8eyasQGzbO
FRYAnijM5OY3RrH7HXlpsEtSTWj8gSs5
=FEge
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
