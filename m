Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9552CA9EC2
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 21:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F64D21835
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 21:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="uFlM1uXL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388753AbfJ1VBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 17:01:20 -0400
Received: from ozlabs.org ([203.11.71.1]:59531 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729449AbfJ1VBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 17:01:20 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4726Zj4rCHz9sPd;
        Tue, 29 Oct 2019 08:01:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1572296477;
        bh=vI7mZ+DC2IUrUk3rLTrQd/wmba5TysXkf2AZ6nWrBpA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uFlM1uXLeWuuiwlydsS7YidEYoMA4PQEf9qkBxUfNzltxHmgeUsBnJdtoj2Q2xpF0
         6Z2450x+JLkNEvQgOgOqhkOfIB2zSY5+zclyrl2EnM4hEskIBL+8KvuDs1nW6K8vjf
         TgD3HQbNzagqqHcOIvSRNykYCKGVoZVL+eDEYtVguQL1yo7E0yszvfGpNARin7tK72
         MUxTMqiycabIILD6R8k7yhI2KVK7QyqoVkhHrU32Suz8GPApl71tcwgVRIHePO3vZg
         PkpMkZuqqiZMyx0PJeuFr0Q57aif+45lZc6QU2LYAHkP3zfnoJz0UmZSWMey/pfRhV
         Pqnk1C62ZxDUg==
Date:   Tue, 29 Oct 2019 08:01:16 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the rcu tree
Message-ID: <20191029080116.1ba4849f@canb.auug.org.au>
In-Reply-To: <20191029075041.7bf3f723@canb.auug.org.au>
References: <20191029075041.7bf3f723@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2_3MiMKp.=Q08gpA/RR.sl5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2_3MiMKp.=Q08gpA/RR.sl5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

[Resending with correct address syntax]

On Tue, 29 Oct 2019 07:50:41 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> [Resent with Paul's new (working) address]
>=20
> In commit
>=20
>   292d1bb21aba ("rcu: Several rcu_segcblist functions can be static")
>=20
> Fixes tag
>=20
>   Fixes: ab2ef5c7b4d1 ("rcu/nocb: Atomic ->len field in rcu_segcblist str=
ucture")
>=20
> has these problem(s):
>=20
>   - Target SHA1 does not exist
>=20
> Did you mean
>=20
> Fixes: eda669a6a2c5 ("rcu/nocb: Atomic ->len field in rcu_segcblist struc=
ture")

--=20
Cheers,
Stephen Rothwell

--Sig_/2_3MiMKp.=Q08gpA/RR.sl5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl23VxwACgkQAVBC80lX
0GykzQf/ef0FNsoIOZzbbVQqUrFGJsZmkHA2XdN56h6R0Nd02f/8jYrPVRN6Id26
rIQtKlky62q3jrT9kuEJ9rNz2x0ue+sEQgMLXrYtn7Xr6sR0JEvY4VeDdRo0XWAh
71LXl2P43vz0Cyrk5hPKRK3gKfyGnUWsZxLkeFQII5G43vRE4r18+AlnPLACxQ0q
2Omndy+O9yVzTyPfTQY0sjdShH99E5MCSokMYFQEN5UmoVpKBf1xLVEB+R1hGrUz
9Pdapb20c6XYbWG+7b1/R3x1HAzSG5vk8uikVyU8LhEx1wid60wVvjUSTSARrzuk
052a1S1yNZFQkFG6bTBNWxskQqpKjg==
=H+im
-----END PGP SIGNATURE-----

--Sig_/2_3MiMKp.=Q08gpA/RR.sl5--
