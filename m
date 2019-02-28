Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A70C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 04:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B8F21850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 04:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Pfd83lEg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730782AbfB1EwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 23:52:05 -0500
Received: from ozlabs.org ([203.11.71.1]:57625 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727672AbfB1EwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 23:52:04 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4490X22ZMtz9s5R;
        Thu, 28 Feb 2019 15:52:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1551329522;
        bh=c6ljqEpuw+rnANiMNxGSNOaCn1TOphAHyZlBKJBcY/o=;
        h=Date:From:To:Cc:Subject:From;
        b=Pfd83lEg/6UE4U7CqiQNvFY4TA5wU7CIrnVDdBW60S/26+bdi65f0QBUp+K2t4qR8
         w4Nw+ESo+CiL8b/V9PoJ3hAoGPcL34ixBZjxyuqjqKbz1RNk4MluzcbTxqWrf9SyoW
         vwB+hxQq+vAhZzNyZ+lTr+W1YfqvxfE3p7FeG+XCBwmFmiHJ73Y7QvOuKRp8Lp2ltr
         /x0TnKVo/tuuofoGP9iZCj3Y3mjdqARJlNIEpiyplpq/hnbx3EIJqbycq6DtTBpQ9Y
         vaBPIA5l3EK461qQxX+GlDYZWUfh4swMno2AoTDK3o6s2Ktf2YdHYfNKZGnuszt9pX
         cxRjct4Xp0Tlw==
Date:   Thu, 28 Feb 2019 15:52:01 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: linux-next: manual merge of the staging tree with the net-next tree
Message-ID: <20190228155201.329a1fad@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/JyAC1TUGYkg3xe9svj/HL1K"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JyAC1TUGYkg3xe9svj/HL1K
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the staging tree got a conflict in:

  drivers/staging/fsl-dpaa2/ethsw/ethsw.c

between commit:

  570b68c8ddde ("staging: fsl-dpaa2: ethsw: Handle SWITCHDEV_PORT_ATTR_SET")

from the net-next tree and commit:

  11f27765f611 ("staging: fsl-dpaa2: ethsw: Add missing netdevice check")

from the staging tree.

I fixed it up (the former is a superset of the latter) and can carry the
fix as necessary. This is now fixed as far as linux-next is concerned,
but any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/JyAC1TUGYkg3xe9svj/HL1K
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlx3aPEACgkQAVBC80lX
0Gx+1Af/XY5BPPNxunXMZml6YaUuyP+N/0nOxUeF9h28hRtJBXvyWvE+RCPfWB0p
9mrH+wa3XCkmyMAjxrtcDI96btwioE9GRFSDRO4ZXXwZp8eepfUXglDzBfuS4qS/
fHlDFvm4rRQ2NLsASmLzfqfMHDXPbaaMp7sCDV7OpeZbUD0Ps2/RVwodWqzT7Y4y
TyHb4uaNEgwaqng1BhwQev/LSWbUI2ZpUupEz4gk8O752RObvI9iPseXogQ6NF/p
n+LPTKSRMFapArvqFj9rN0Q8CsrlU+ant929VPLjH8VPNxBQE2h4xLQeSq45NcJ+
I26Xxhqd2YqwpaMqu2hpEteB47fstA==
=ScKE
-----END PGP SIGNATURE-----

--Sig_/JyAC1TUGYkg3xe9svj/HL1K--
