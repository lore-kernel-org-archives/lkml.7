Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C11C48BE3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26CDB2084E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ZnhVfspA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfFULY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 07:24:28 -0400
Received: from ozlabs.org ([203.11.71.1]:35271 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726311AbfFULY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 07:24:27 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Vbtc4QFXz9s4V;
        Fri, 21 Jun 2019 21:24:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561116265;
        bh=w9QqvJ0HjQ+a4vkaOugPMvDP3ZNXDtM3YxoGeN1r9wk=;
        h=Date:From:To:Cc:Subject:From;
        b=ZnhVfspAFndgY7TT1s+MnpETU1yntpVIjiSPTeJiju9Qkv3UNe6FOhWYChPt1sJdY
         iNdcvMLjuRZQMgtSe5KB/uGVbMpgbJ09QpHVXvFvWo1NKjfgbgC8I0jqOxhGCKnsze
         yrXfYalJfVum5CJRx6is70ZpxL97CEAYOrOJCYbB+tzrmz3nIG4KN6Tg8A4XMm4oOu
         FHp0aQjSE0RlSEUY+rbsVp4E4fzvVLru2hSry92dNzsIEvzwmuUUN60pypXurSWL+p
         JH0C4jZ7BDBwyeLmeFxD6hao9iNPPnKwaQx5JwjLFRj/NIaa8pT+kklWPaxlMLWZb2
         kRyNd/IiPzWoQ==
Date:   Fri, 21 Jun 2019 21:24:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: linux-next: unexpected file in the usb tree
Message-ID: <20190621212423.2b264411@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/XJOShJY0Ij/5q/Xu_UDrkXw"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XJOShJY0Ij/5q/Xu_UDrkXw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Commit

  ecefae6db042 ("docs: usb: rename files to .rst and add them to drivers-ap=
i")

added this unexpected file:

  Documentation/index.rst.rej

--=20
Cheers,
Stephen Rothwell

--Sig_/XJOShJY0Ij/5q/Xu_UDrkXw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0MvmcACgkQAVBC80lX
0Gz43wgAl00qKYCW7nw2PVf9Fkqw56z65Mw8ZCrBhUodoTEqCxSYG7w5lZ0VwsJj
mvnPvsJbBgLLf/7tZX8fdtKTr32JqESWyjOo9z7XTOO/FuNRA+E4GHglq4GGOXGt
dMUMaBxMJBCVMCAqA8er6WtP6kgIgNJmI/JovOnBHfUZ/dD0U+8x7EtWW+pY7QCK
9ZVZq9zSgzWsjmSlHMYkvy8qrWtWu0Wl50gKD9Z9Lx28oSknz7hmVsBUDBwRd8Mt
XLcfUDFJGZ6v6b4mUwjtH/MYsIgHdS/ulqn40jK1EJuYP2L+K1qKHUTnyRYkfHFL
G8UQXZfpOlc9MxMb20D4RuQbXr7OqA==
=e0zi
-----END PGP SIGNATURE-----

--Sig_/XJOShJY0Ij/5q/Xu_UDrkXw--
