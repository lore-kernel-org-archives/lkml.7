Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5213C31E4D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A783520850
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfFNNLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:11:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57972 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbfFNNLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 09:11:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9053F308425B;
        Fri, 14 Jun 2019 13:11:17 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-63.rdu2.redhat.com [10.10.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 69115783A5;
        Fri, 14 Jun 2019 13:11:16 +0000 (UTC)
Message-ID: <fc2067b31f70e1cf329343660783684c816597cb.camel@redhat.com>
Subject: Re: linux-next: manual merge of the rdma tree with Linus' tree
From:   Doug Ledford <dledford@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>,
        Gal Pressman <galpress@amazon.com>
Date:   Fri, 14 Jun 2019 09:11:13 -0400
In-Reply-To: <20190614130033.2d50bc2e@canb.auug.org.au>
References: <20190614130033.2d50bc2e@canb.auug.org.au>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-CgkdA8UnalBHFZBn30/c"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 14 Jun 2019 13:11:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CgkdA8UnalBHFZBn30/c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-06-14 at 13:00 +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> Today's linux-next merge of the rdma tree got conflicts in:
>=20
>   drivers/infiniband/core/uverbs_cmd.c
>   drivers/infiniband/core/uverbs_std_types_cq.c
>=20
> between commit:
>=20
>   6876aaedc8a1 ("RDMA/uverbs: Pass udata on uverbs error unwind")
>=20
> from Linus' tree and commit:
>=20
>   e39afe3d6dbd ("RDMA: Convert CQ allocations to be under core
> responsibility")
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

Thanks Stephen.  There will be at least one more coming too.  We've had
a number of -rc patches and -next patches that touch the same area of
code this cycle.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57
2FDD

--=-CgkdA8UnalBHFZBn30/c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0DnPEACgkQuCajMw5X
L90nWQ/9HggFOB67AhdyNW1HxKEG/telgYudzJLlSx+uJzfTgjpQmE8bSy0YMxbf
ImMonVYi9pjLz/xOt0vyrnmOpkI9r4eIa1s1pUJOopRQUIJ1yARD5YXR9xCV3rCw
/ytoenGHcx//K4P6dWBed7aszEqwtMQwh20Eli9sgKa/MsBV+HZKyLqnQQViCLdo
mT4kwE5/32wZlMzW5ED+LyQ8eFHMCK6yrQU1BxLih0Mld2ROqc44TCs7AY7stK3T
tuvU7xkAm2sJUBj/4/iOAadgghHSAFVxkWl3JqMJ9czK0ogguRD9vLnsxLO4QJ6o
0fjU65UQJVa9b0lTxL236DR1nRcWliAtN10jwXsPxgLdImjybiwLvsYqm4Hg97Nm
Nnz3Qh1e9mddkw1vnBKcxI44gtkgMR3eJqde0ztNCPVwachEYvDsyJE5kuSx3iib
wdp+ryom3lpdHDBsW6eAxYHIiu14lH4nQbzpIgwBLjMv57PARYv5LYIN/lSLVlY1
FCPH9CT3u/mfwDvgssDwF7JhwvZZQ4Iypd9rIrjfWoR+LB2hopjRzgdBE1SbbuT9
+wkq1W2SCZuMMfhcA3zFK9SfTVhk+OJ9DDpku01dzGe4i53MFFn3M8TeQVdUPq4O
UgKR7kBGv6OpvkqyEhqnUVS93KC0fnPfvELwOrOdk+TvWwlMFGU=
=xJiO
-----END PGP SIGNATURE-----

--=-CgkdA8UnalBHFZBn30/c--

