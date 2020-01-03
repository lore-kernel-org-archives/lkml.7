Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E77C32767
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 17:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E1020866
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 17:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgACRSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 12:18:38 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:53480 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbgACRSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 12:18:38 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 63DDC1C25FE; Fri,  3 Jan 2020 18:18:36 +0100 (CET)
Date:   Fri, 3 Jan 2020 18:18:35 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 067/114] libfdt: define INT32_MAX and UINT32_MAX in
 libfdt_env.h
Message-ID: <20200103171835.GD14328@amd>
References: <20200102220029.183913184@linuxfoundation.org>
 <20200102220035.827015006@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SFyWQ0h3ruR435lw"
Content-Disposition: inline
In-Reply-To: <20200102220035.827015006@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SFyWQ0h3ruR435lw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2020-01-02 23:07:19, Greg Kroah-Hartman wrote:
> From: Masahiro Yamada <yamada.masahiro@socionext.com>
>=20
> [ Upstream commit a8de1304b7df30e3a14f2a8b9709bb4ff31a0385 ]
>=20
> The DTC v1.5.1 added references to (U)INT32_MAX.

Is this good idea for stable? We are not planning update of the dtc in 4.19=
=2EX?

Best regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--SFyWQ0h3ruR435lw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl4Pd2sACgkQMOfwapXb+vKXNQCeIEueIO98niVVQCz9CyoM26PX
NxoAoLHoKwNqfiNlRGoEfiSMukxFimPp
=ikAO
-----END PGP SIGNATURE-----

--SFyWQ0h3ruR435lw--
