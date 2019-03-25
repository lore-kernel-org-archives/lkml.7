Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BCEC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AAB020854
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbfCYUWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 16:22:06 -0400
Received: from sauhun.de ([88.99.104.3]:48778 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729283AbfCYUWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 16:22:05 -0400
Received: from localhost (p54B33284.dip0.t-ipconnect.de [84.179.50.132])
        by pokefinder.org (Postfix) with ESMTPSA id 2CD872C0963;
        Mon, 25 Mar 2019 21:22:04 +0100 (CET)
Date:   Mon, 25 Mar 2019 21:22:03 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Simon Horman <horms@verge.net.au>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [PATCH 3/6] mfd: da9063: remove platform_data support
Message-ID: <20190325202203.GA7749@kunai>
References: <20190318154759.21978-1-wsa+renesas@sang-engineering.com>
 <20190318154759.21978-4-wsa+renesas@sang-engineering.com>
 <20190319122556.7wpabcnwklv3fg3v@verge.net.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <20190319122556.7wpabcnwklv3fg3v@verge.net.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > -	if (pdata) {
> > -		da9063->flags =3D pdata->flags;
> > -		da9063->irq_base =3D pdata->irq_base;
> > -	} else {
> > -		da9063->flags =3D 0;
> > -		da9063->irq_base =3D -1;
> > -	}
> > +	da9063->flags =3D 0;
> > +	da9063->irq_base =3D -1;
>=20
> If the flag and irq_base fields have fixed values can
> they be removed? As a follow-up?

There is likely more simplification possible. But yes, it should be a
follow up patch, I think.


--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyZOGcACgkQFA3kzBSg
KbZt7Q/+ORnpb67l6sGMv5O5vgPK9uXv9lSOu7wR9M4URAhOtZRWO9L8/z966SaI
KYH041CJZij6odFXtHf2xOK65ZjM7TOBFTtNeg1VQf+q4U9GQK0UERGWw+DSjOwJ
g0myfiJKhTBAXNl4tO3cU6noF2rosJuxEMX4CXqgFG9PhhVuYZ3IU/ftoQ7+eAMw
uavKsQR3jEdAWY8IrKlSanWg+21Ky0LipVmX3Y9SrPoUYV89zhwQJtaT0p7zN15d
tJKwc/LuR9IBPRPU56qHIgppmcQ1exi4gy1z0Wf0nvbo74KIV9MVAOYohIVbV4bo
4ciDwbJWeXlCMynZ8N3WNcfYaMng5wWfCSz/lE+ckt1aLna6OFugOQsUuVLXB5Jp
f8pPpZl47aSxv1XWBIL2QW7BEqlBD4SUCYk2Aj7Hg0h7kl+A2PMZYPMOQacyOSpn
sN4mFKrVCv4zTryi1crPhgaWhWz2bgXPMrrusv6FfU1I3PBvMNVA2esoJQsDD6pv
JK0wwg4oBQeLrUNeyzt/P+B+47xEIprbhIHabBxE16QVRm9lt3gRHbOIKkwct6+c
tSN6pX9wUHN96XbDu1kG9CKmtW9hcouJJ7ayc9Vckru6W+s8vk/7a5Xz8s81pzLi
8IO0EibivOP3rC1yIBi99ke+7a6zSwEIwERWXQGG2KotKRq1CoE=
=fdoN
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
