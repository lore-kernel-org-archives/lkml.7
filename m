Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BCEC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 606A821473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfDCIuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:50:55 -0400
Received: from sauhun.de ([88.99.104.3]:46706 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfDCIuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:50:54 -0400
Received: from localhost (p54B3311F.dip0.t-ipconnect.de [84.179.49.31])
        by pokefinder.org (Postfix) with ESMTPSA id B5CE02C282F;
        Wed,  3 Apr 2019 10:50:52 +0200 (CEST)
Date:   Wed, 3 Apr 2019 10:50:49 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [PATCH 5/6] mfd: da9063: remove leftover platform_data
 definitions
Message-ID: <20190403085049.4clchelp4tgslikg@ninjato>
References: <20190318154759.21978-1-wsa+renesas@sang-engineering.com>
 <20190318154759.21978-6-wsa+renesas@sang-engineering.com>
 <20190403080758.GF11301@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="e7f37usrgqshnalg"
Content-Disposition: inline
In-Reply-To: <20190403080758.GF11301@dell>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e7f37usrgqshnalg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2019 at 09:07:58AM +0100, Lee Jones wrote:
> On Mon, 18 Mar 2019, Wolfram Sang wrote:
>=20
> > Not used, not needed, remove them.
> >=20
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > ---
> >  include/linux/mfd/da9063/pdata.h | 65 --------------------------------=
--------
> >  1 file changed, 65 deletions(-)
> >  delete mode 100644 include/linux/mfd/da9063/pdata.h
>=20
> Can't take this until the last user has been removed.
>=20
> But for now:
>=20
> For my own reference:
>   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

As I wrote in the cover-letter, I'd vote for all patches going in via
MFD. Is that fine with you? Then I'll ping other maintainers for acks.


--e7f37usrgqshnalg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlykc+UACgkQFA3kzBSg
KbbSCg/+MMeSoOkTVYVUQZ/GYTc/J/yEmpkmKv5SsQRFoQ3RdPU278fh0o5AOe5d
kUwojAz0VXrKfIldAyTw2js5bx05HEd3iKJWMtx/Shss1VhM8JyIPxypbYXLf5wO
sKuJ8h1dSDdR5NPmSG3JnkVL0due64aNBBClaAsBcnzZKSZkniwqyEGoYTLbo6iH
oROq50RNPAN66ZjrITgSKsB7wq4dTDD+4tKWW7HDU0nsvZEN+3G4Y+eIUylFKpnQ
qMKlR9M35wLleHBXdKFUQZ6pqaz+UVjowc17r/wFTmfszgf/jA6pXvp5wX5MDBZK
l4R1pqmAtXbQP6ypbH/h0gHOeYAElF4XbtjdEEgCUoNhCAr2K9zfmiujx5Gtmaeq
jiisc3Td7SCwPecuPX1QaF+V6xd3KNp7uRSYtcP9SmJmnDnDjKOhfCpqrEljjMMq
zGfpqJjB24Oxc+QrLzUGSPMYcXn5LWp6HyxBN/Pn0VbwT6WBiE52s4AJdap2jM1U
61oFGOvQhT/pEIzsu6f6S+aflPSKWxk/1WNnNZx9r6bru7fZaeAG8ygs9A0KWfe+
6oFdsRRxR5Y27uESmEZ+brp3D3sKB727WfLoeD2k18OG6dwXiil6pcRaa4bqBhEY
8uPgGU2/CBdcq3KHEReZ+FVhgiTkGBMQ+1ArxpFS4gxv/AfYSGQ=
=VbCW
-----END PGP SIGNATURE-----

--e7f37usrgqshnalg--
