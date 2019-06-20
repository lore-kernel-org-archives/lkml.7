Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EB3C48BE1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 03:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 520F720861
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 03:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731272AbfFTDYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 23:24:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60724 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbfFTDYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 23:24:37 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5C38830872F5;
        Thu, 20 Jun 2019 03:24:37 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 621E71001E67;
        Thu, 20 Jun 2019 03:24:36 +0000 (UTC)
Message-ID: <2443017de714630058322853d4fff5213f039e56.camel@redhat.com>
Subject: Re: linux-next: manual merge of the rdma tree with Linus' tree
From:   Doug Ledford <dledford@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Date:   Wed, 19 Jun 2019 23:24:33 -0400
In-Reply-To: <20190620120640.5dbcc599@canb.auug.org.au>
References: <20190620120640.5dbcc599@canb.auug.org.au>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-bpAVpBoi9B+tzNPPGyT1"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 20 Jun 2019 03:24:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-bpAVpBoi9B+tzNPPGyT1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-06-20 at 12:06 +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> Today's linux-next merge of the rdma tree got a conflict in:
>=20
>   include/rdma/ib_verbs.h
>=20
> between commit:
>=20
>   dc1435c00fcd ("RDMA/srp: Rename SRP sysfs name after IB device
> rename trigger")
>=20
> from Linus' tree and commit:
>=20
>   0e2d00eb6fd4 ("RDMA: Add NLDEV_GET_CHARDEV to allow char dev
> discovery and autoload")
>=20
> from the rdma tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your
> tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any
> particularly
> complex conflicts.
>=20

Yep, this one was expected.  Thanks.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-bpAVpBoi9B+tzNPPGyT1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0K/HEACgkQuCajMw5X
L90mdxAAubZeH+lhdxVlGNgymiPHJ5yD2LVDDeNbhL7KZbJRUtoYmQdQ7MRnjCy5
ZZasrxR7/MSp8y3H0srbzIuMGlCFjg1/HugZR99he/eXfVuZBRldBkaHRcFWkM77
PuAAoPgRL2uKOucZUs8/SQAFfzEkN+//b/ONrWnRCY6FGgbOKiaLbrx27uvF02ML
bU+waW585AWr+vLhMDajLHbPQI1hbsVlZ/KepSfosCTBA8CTa+V/37h0FT7t152h
EWmPW/IX5Cosk90ATKKq2s2LmqJH37CBqKo9Yise+wJLXDn3W1RazEiYaU8CTgx8
DQXcM8mqhxa08dJiekhzYFlhEY0RkUvrsyiDUegQxZx1PDfMNaBZqGdraEbrhFgL
sXO5BWVd68RsOWVF6tJtLou/K1GB+m0KMMhillbilIiYzM+vubXAf+qtSxH6qaV2
N3JxP6RDlWQQYzuUxUGu72rmUyJqE7qCHDjdT9k6VEyhhb59SBG+bUsa5lH6hODc
uMWsn1d+X3kIz6qM6T7SFOKOleNrfKoXW77FP7hqTdpkZnUKvfjrmIWYVp4lToGv
JdCBiHJD/yRyujjT9qucaQh0nVAsi92WpvMh1EE8E9oeCBBX6eTZPSMrbBOOh4GN
O6Hd3V/6S/pjk7Q7UqdVSj/Ke3rizurALJx4z8UeaOqUbk+Jc1c=
=wPue
-----END PGP SIGNATURE-----

--=-bpAVpBoi9B+tzNPPGyT1--

