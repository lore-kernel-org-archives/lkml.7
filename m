Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1E8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF3F5217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730581AbfC2Whf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 18:37:35 -0400
Received: from mga01.intel.com ([192.55.52.88]:53478 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730137AbfC2Whf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 18:37:35 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Mar 2019 15:37:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,286,1549958400"; 
   d="asc'?scan'208";a="136023203"
Received: from schintha-mobl1.amr.corp.intel.com ([10.251.143.114])
  by fmsmga008.fm.intel.com with ESMTP; 29 Mar 2019 15:37:34 -0700
Message-ID: <59cd9dd2381c029fe0ca81510f016e28ff906f18.camel@intel.com>
Subject: Re: [PATCH][next] iavf: iavf_client: use struct_size() helper
From:   Jeff Kirsher <jeffrey.t.kirsher@intel.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 29 Mar 2019 15:37:33 -0700
In-Reply-To: <20190328203613.GA23692@embeddedor>
References: <20190328203613.GA23692@embeddedor>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-7wgFgYgg/nYQWXCZS0Xv"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7wgFgYgg/nYQWXCZS0Xv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-03-28 at 15:36 -0500, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
>=20
> struct foo {
>     int stuff;
>     struct boo entry[];
> };
>=20
> size =3D sizeof(struct foo) + count * sizeof(struct boo);
>=20
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
>=20
> size =3D struct_size(instance, entry, count);
>=20
> This code was detected with the help of Coccinelle.
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_client.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Thanks Gustavo, I will queue this up.

--=-7wgFgYgg/nYQWXCZS0Xv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiTyZWz+nnTrOJ1LZ5W/vlVpL7c4FAlyeni0ACgkQ5W/vlVpL
7c7EGA//RGnOT5JHhRV4Srf3B6I09QLbkWJyaq5EVELHodEAsCgpkzuCRf2RFdA2
xNGsurdeOobCwfzLi2Th6s4hp9PhUVfjZrrMISGIgvNMcMHkejEtRSuuNV8y2Ell
xC8no004A2HqfOOH3MKXKxm6W+gAleRfKppsOMKfXHFxJlKUMevW3cLo+U53jKTe
evBufmhbbERakWQJtU/Xf4b/Tggt+wSMLFkjlUMcsl16MGzITP/NTtXhdpr9hPtN
vnnAnEmtRe19hDRzyx00Nr2GpwMG5cHPEsgUI3fIAQ8x7WT6J7UPATAsU17gPaGi
2u+v4C1ucLnu5cFgZxks2QeaKW9vUP2FAomY8Iv59x2COTypyozy7Umts7eao7fM
jnMlBbie0X7dJj/cBCnMqyaxIH4uG5PVZOpe4kaMgl2vlEqcITVRDYmM8vemot4c
xQ8WV0iMmPDBab6A/mBppGaRIgtQBbkv2X3dtKZsSYoQCBkKdma3g5lFvtSm3kxd
oX1eOuxieANEqcxfoYWYD9tI0d0kDBec4WFM9kGZokUKLoe/Sakt6YUNpy27AnO2
CRd1NXAWndPioLY96RnyODR+sO9ctFeBHeVxTOd8pgk3kNeh5APfmrjbnknM7S1M
YhQ9g8i2JSp13ECROwcN+XKhFAR5Gllb0jwvgc/8UDvNI/o5DX8=
=w+Fd
-----END PGP SIGNATURE-----

--=-7wgFgYgg/nYQWXCZS0Xv--

