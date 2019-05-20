Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F199C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 16:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EACC20815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 16:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392569AbfETQPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 12:15:52 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60416 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732368AbfETQPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 12:15:51 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 8463B8030C; Mon, 20 May 2019 18:15:40 +0200 (CEST)
Date:   Mon, 20 May 2019 18:15:49 +0200
From:   Pavel Machek <pavel@denx.de>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Pavel Machek <pavel@denx.de>, stable@kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        davem@davemloft.net, gregkh@linuxfoundation.org
Subject: Re: net: atm: Spectre v1 fix introduced bug in bcb964012d1b in
 -stable
Message-ID: <20190520161549.GB25789@amd>
References: <20190520124014.GA5205@amd>
 <02622e60-8ce9-8db3-8d16-fa1a32e063bf@embeddedor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="K8nIJk4ghYZn606h"
Content-Disposition: inline
In-Reply-To: <02622e60-8ce9-8db3-8d16-fa1a32e063bf@embeddedor.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-05-20 09:15:50, Gustavo A. R. Silva wrote:
>=20
>=20
> On 5/20/19 7:40 AM, Pavel Machek wrote:
> >=20
> > In lecd_attach, if arg is < 0, it was treated as 0. Spectre v1 fix
> > changed that. Bug does not exist in mainline AFAICT.
> >=20
>=20
> NACK
>=20
> array_index_nospec() macro returns zero if *arg* is out of bounds.

No, it does not. Take a look:

#define array_index_nospec(index, size)
=2E..
        (typeof(_i)) (_i & _mask);
})
=09
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzi0rUACgkQMOfwapXb+vIPJwCfdBSR8BgAwXcVkyk5pkbpdugb
nG8AoIwI8CnkhXjJuvcqEIRLx9IWhenE
=22HN
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--
