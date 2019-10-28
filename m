Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0D5CA9EC2
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 20:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45FEB20830
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 20:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rPu8xMyY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388297AbfJ1Us4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 16:48:56 -0400
Received: from ozlabs.org ([203.11.71.1]:43959 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbfJ1Us4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 16:48:56 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4726JP4V1Vz9sPK;
        Tue, 29 Oct 2019 07:48:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1572295733;
        bh=/93MLdafeQeivcemDGE3gagKGbyuQ4PaosU63LPUVHU=;
        h=Date:From:To:Cc:Subject:From;
        b=rPu8xMyYqACUYFADD/8EJFgFJQHPa7f3G2XA1RK7HJmVIDccJLKD0RYJOTRSrJWBv
         v8h1aEvj0e5gZVL2MeM2vGfNsALPeouklaeeiv/VrKc50ccs4iqVopNQUmD6LzhKY6
         NCrDbJMiJSuMU8Hdayht29xhe+4MZYMzMRIzwNfDU+nPo7d+YqlGrlqwtOoFnjuI2v
         FSFnJflx6RbRy8dj3JXH7tTTyqD+uMbOcEH3awrMJ+NGzpAdPeRLlbVG1QemcsHDjD
         g0lhmPSZxKkBzME9jqiy2k+/GblqbdNV7sPaAdV+kzKRHm+37bVS2lQjTP7kJKyfSA
         joVKe3l/3oeyA==
Date:   Tue, 29 Oct 2019 07:48:48 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the rcu tree
Message-ID: <20191029074848.12af3e7d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/EX5s2RWSi14QDHog1WqOo6p";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EX5s2RWSi14QDHog1WqOo6p
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

n commit

  292d1bb21aba ("rcu: Several rcu_segcblist functions can be static")

Fixes tag

  Fixes: ab2ef5c7b4d1 ("rcu/nocb: Atomic ->len field in rcu_segcblist struc=
ture")

has these problem(s):

  - Target SHA1 does not exist

Did you mean

Fixes: eda669a6a2c5 ("rcu/nocb: Atomic ->len field in rcu_segcblist structu=
re")

--=20
Cheers,
Stephen Rothwell

--Sig_/EX5s2RWSi14QDHog1WqOo6p
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl23VDAACgkQAVBC80lX
0Gz7hgf9F4Eue/ca/49d6nGFr8Xzl6l91xlk/qTR2u0Y4c4VQbeApYftfRyRgv3i
P2Sf4hb1N7Rn085w+bU3JQHNTFmK4Xh0fj8cfTYmlZ92/EaZGa3Qrq7SBYfNBnUc
899YtFf4YNbh+OFWOP66HDIfJoRzl+lyQTak9bhjmKfKNawCUASDh7+IASJMukQh
6NHKcWHB4g5+rPhMF1EufJg2r5GzqASFI+/u38uA45gOFrsuLP9wPbw0Tmr/et1d
uMdlkt6NzxmZPFc9P+vqpaH02IGTAkZQ8PXXmI1p/x95HiLsngVUqgszVwo9F5XA
YYGPEFbJRpIT7UkAv3vO19YLxyRaSg==
=qWqB
-----END PGP SIGNATURE-----

--Sig_/EX5s2RWSi14QDHog1WqOo6p--
