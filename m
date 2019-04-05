Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E280DC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF6F21872
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731035AbfDEMWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 08:22:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:53826 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726663AbfDEMWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 08:22:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C51E2AF76;
        Fri,  5 Apr 2019 12:22:10 +0000 (UTC)
Message-ID: <0e7d2e00050cca6ffd05b8d85af33be99aaad10c.camel@suse.de>
Subject: Re: [PATCH 1/3] Revert "staging: vchiq_2835_arm: quit using custom
 down_interruptible()"
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-kernel@vger.kernel.org, stefan.wahren@i2se.com,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        phil@raspberrypi.org, eric@anholt.net,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Date:   Fri, 05 Apr 2019 14:22:09 +0200
In-Reply-To: <20190405120217.GP32590@kadam>
References: <20190405113423.14495-1-nsaenzjulienne@suse.de>
         <20190405113423.14495-2-nsaenzjulienne@suse.de>
         <20190405120217.GP32590@kadam>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-/V7XpRpqdhfiJ+NA+tX1"
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/V7XpRpqdhfiJ+NA+tX1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-04-05 at 15:02 +0300, Dan Carpenter wrote:
> On Fri, Apr 05, 2019 at 01:34:20PM +0200, Nicolas Saenz Julienne wrote:
> > This reverts commit ff5979ad86368425b7da3a25f4e84650b51ff5fd.
> > ---
>=20
> Git kind of sets you up for failure with reverts...
>=20
> Fix the subject, add a commit message and a Signed off by etc.  We need
> all the regular stuff.  See commit 75ae193626de ("dm: revert
> 8f50e358153d ("dm: limit the max bio size as BIO_MAX_PAGES *
> PAGE_SIZE")") for an example of how to do it nicely.
>=20

Will do, Thanks!

> regards,
> dan carpenter
>=20


--=-/V7XpRpqdhfiJ+NA+tX1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlynSHEACgkQlfZmHno8
x/5sxQf/cztkEfGjBScMKbToZz6ppcakZMlsMQn3H9S0hX5Yc3Li3Bzp2GWOBML1
71aaHvGdinYWh77smNen3jpNj1opRVubOHH0+reeMO0tR6Wx2ZcBa7J7KUBiHfMV
binf0PD1qO/KP0umz1Lw+wp7Xg2nsfpBlmDZEPyQcbR2HPD5DNnXJ0gefXUlv9gc
apMXKQ36RAQnkVNC+/OTK2rT5wa2VXKPIEmCHIaF2g7MHnXsQS6+jJR81bRiTNO3
Bh96wkZNfSpIMP+71dlEQBdfkPhnTkDqUcTHyo/nSNw5bEaK3EE2OMOcp9obdTBi
4jVqsSEbZEOygOIuvm0lIcrxr8CZzA==
=goUN
-----END PGP SIGNATURE-----

--=-/V7XpRpqdhfiJ+NA+tX1--

