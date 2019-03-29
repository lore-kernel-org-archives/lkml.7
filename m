Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D186C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 565F0218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbfC2QqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:46:10 -0400
Received: from mga06.intel.com ([134.134.136.31]:15426 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728853AbfC2QqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 12:46:09 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Mar 2019 09:46:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,285,1549958400"; 
   d="asc'?scan'208";a="126992194"
Received: from mvaitla-mobl.amr.corp.intel.com ([10.252.138.221])
  by orsmga007.jf.intel.com with ESMTP; 29 Mar 2019 09:46:08 -0700
Message-ID: <406ed115ce8c3bd690c0d434f8d5a5062ab4f793.camel@intel.com>
Subject: Re: linux-next: Fixes tag needs some work in the net tree
From:   Jeff Kirsher <jeffrey.t.kirsher@intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arvind Sankar <niveditas98@gmail.com>
Date:   Fri, 29 Mar 2019 09:46:06 -0700
In-Reply-To: <20190329142605.5e3263d1@canb.auug.org.au>
References: <20190329142605.5e3263d1@canb.auug.org.au>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-B1aM37n2wI2XBDiwefHM"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-B1aM37n2wI2XBDiwefHM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-03-29 at 14:26 +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> In commit
>=20
>   dabb8338be53 ("igb: Fix WARN_ONCE on runtime suspend")
>=20
> Fixes tag
>=20
>   Fixes: fb29f76cc566 ("igb: Fix an issue that PME is not enabled during
> runtime suspend")
>=20
> has these problem(s):
>=20
>   - Target SHA1 does not exist
>=20
> Did you mean:
>=20
> Fixes: 1fb3a7a75e2e ("igb: Fix an issue that PME is not enabled during
> runtime suspend")
>=20

Yes

--=-B1aM37n2wI2XBDiwefHM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiTyZWz+nnTrOJ1LZ5W/vlVpL7c4FAlyeS84ACgkQ5W/vlVpL
7c7U3hAAjDrnd5mqw58ZPFtepxXH+dM4967nXKVYwZjxpc/bHcLYblMLw3haHifK
EcRUneeqG7zg4Ps/CiNiVg+BXMtOtFkt7465GPVL5F4/pbcTahP7jYqO9cWX6pEt
zG6dseCaK+up5WuQ5RW50+tVS6MOKwANDvB+oZ4qzfEUymhX2/QRV6GJhPl42e0m
viAIa+leMtCWp294igX0ltZ22gAUQhpW6C9zlrhpwFFdJmy3i71uZN/HaARBFnDi
OJVGeO25yBpDrCYWl9cYBw1D+6SDEJYPAEPQSolZ9l4iBjYM/SqJlKvkAG7U9IiW
EOVYEb505LpYB2vexX29wzMhaz9WUG8x2CrDuj5cecSPIOKNasWEEYnblWLFNSvU
45dC24IevWFc3ZbySh66fI+orBxeuV6IhK8iDTL7/kY0dE6zq8Ra5e3AJBMKn1Iw
/Q2mQL4gJujdyIIZd9Z+SmyGlD6GmGQu7TyDtY8cpSB9VZimCv1lHML/aXePBT2Q
Iwe9rrW8jGTDB2UqJYs+qn91hDDRX8b5bE+bcu37zZoOcQizsgtbUZ4xNMcnqqz5
ChDR7C7++YQ4kRVUs31EJKxbrJm5eKV+US1n4jYXdyM62VaSZutt/V4X9X+blIM0
sNwSTLH0DH/kHgGFS1WKI18HPzLuOmUUQhDp7fiGPjx3M7+XXIk=
=jE88
-----END PGP SIGNATURE-----

--=-B1aM37n2wI2XBDiwefHM--

