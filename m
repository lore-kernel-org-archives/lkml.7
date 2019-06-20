Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCAFC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 03:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1DF520861
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 03:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731358AbfFTDZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 23:25:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43907 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726389AbfFTDZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 23:25:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DDE8975727;
        Thu, 20 Jun 2019 03:25:33 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C6459608A7;
        Thu, 20 Jun 2019 03:25:31 +0000 (UTC)
Message-ID: <f9cea65ef547c35d6fa8e0d005804308d014bc32.camel@redhat.com>
Subject: Re: linux-next: manual merge of the rdma tree with Linus' tree
From:   Doug Ledford <dledford@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Wed, 19 Jun 2019 23:25:29 -0400
In-Reply-To: <20190620121005.6c01e6ee@canb.auug.org.au>
References: <20190620121005.6c01e6ee@canb.auug.org.au>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Ef3oX6n1UIeoCsBydY2R"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 20 Jun 2019 03:25:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Ef3oX6n1UIeoCsBydY2R
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-06-20 at 12:10 +1000, Stephen Rothwell wrote:
>   2d3c72ed5041 ("rdma: Remove nes")

Yeah, not much you can do about tree wide patchsets conflicting with a
removal ;-)

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-Ef3oX6n1UIeoCsBydY2R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0K/KkACgkQuCajMw5X
L921cA//QayeKBVGqpUDsqXLmDtY4XqCpmv9iHLgQYBRxCZ/+Okv907+AUwCZW4z
gTXgpySiToPeH0JpGCgq63gcHaYa6Gfk7X6g/3W0H6GdQDdWzMSo5on0QgTbRNKW
VY1l8FSybjBQG14zKHXgV/7EQ5OmbTI5+dxOBeHLjMEW/TqkcoLwZIAqwOfbwqBU
nMKWmVH+OkwrFhCjtmGIIJRZyKjKRdt6j/w3h4cg11U0S2GSl+WMDZJAtNP0YwhX
KifiCJdatrGLuqccJccSfPbiqxEhaG/bnTyWl/WFoTCMXaz/+h/daR7hQQjJ9JT1
7F/cHr3C2zs2uxpWsRibLy+YcgC/8m/spxGbtcy4HcWzHsV128BvbaajF2a7eNpT
3G7odE/UxDgL5Dxbsff45kuPk/wSV6yNch6aJDFRzNKa6si4VOtwjUP9alEam267
4qgO5WO5h3ATxyV1n5Vt8BxfdCyT6kGQ8plmJfIvHFmaeqUw6I86I5eMXzynpNPs
mZu8HoAuKEJIQgYfcHOevS+NCggJ/9xZk6O9pcgJV2O+lRkElG7x5mxweADovNSJ
f64R5qxqyu6mJo5qyjG1L+olnhVRd2x27ZV8B2kI/egrodopnOptW/vcs0SnijIA
32vphY76yhzO4WNg1w7Hr6TMaqr2c2bk8tU9cq2l/7W9DRapP5w=
=9Usi
-----END PGP SIGNATURE-----

--=-Ef3oX6n1UIeoCsBydY2R--

