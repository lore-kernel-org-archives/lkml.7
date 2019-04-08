Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF92EC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 22:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EBCA20880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 22:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="NcUitqfj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbfDHWA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 18:00:56 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:33799 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726615AbfDHWAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 18:00:55 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44dPW82wwPz9sNG;
        Tue,  9 Apr 2019 08:00:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554760852;
        bh=B/UYTqHWbY7WRlEakFDoXaGWrazjErnV7X/SGPqMP00=;
        h=Date:From:To:Cc:Subject:From;
        b=NcUitqfjQZTAk86CBJ9gg8eaZvVSq9JcHIB4srD2got0yFvVeKx4WLcpJ8Js9qlb6
         Fl6jZWD4SAdmCuFNd9Xg94pnDOOcFEuLFwRWsgvMMALYvabdidxuZOy0krTvKYewFg
         z37KQLeG9iIORo4wqzm/kw8hAj0EZH746q0YfrhUB65Nv0GSc5tWZSkjXCWmpILK8q
         6DohQq7zGMJFqE7jB5YBL2rO/zlBdEZHwZcv+ysL7LZYoEt4KusMLL+DDJdckn+TFb
         Lo1t31j67joV/LqYwEMOfXDjzfQqRHTcSeep0rjLE8bNokbJ8ndHnyiXED5lNcOcem
         XxMpDMxKXazkg==
Date:   Tue, 9 Apr 2019 08:00:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eli Britstein <elibr@mellanox.com>
Subject: linux-next: Fixes tags need some work in the net-next tree
Message-ID: <20190409080051.3cc54e1e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/1nioSGE/ngx_G5KfUGe8bw3"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1nioSGE/ngx_G5KfUGe8bw3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  6fca9d1e603a ("net/mlx5e: Allow VLAN rewrite of prio field with the same =
match")

Fixes tag

  Fixes: 37410902874c ("net/mlx5e: Support VLAN modify action")

has these problem(s):

  - Target SHA1 does not exist

In commit

  bf2f3bca1c5d ("net/mlx5e: Deny VLAN rewrite if there is no VLAN header ma=
tch")

Fixes tag

  Fixes: 37410902874c ("net/mlx5e: Support VLAN modify action")

has these problem(s):

  - Target SHA1 does not exist

Did you mean

Fixes: bdc837eecf73 ("net/mlx5e: Support VLAN modify action")

--=20
Cheers,
Stephen Rothwell

--Sig_/1nioSGE/ngx_G5KfUGe8bw3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyrxJMACgkQAVBC80lX
0Gz7fggAkoBgU9zhYPP4JYUuabGM8rj0MGmi0PdToMvoYuB2OPsMlULWOdgWOaiX
nwsFovdVSMMQf0+31/t3h2l+9NuiOQaCV+eQ/e5p2iVxxTMIO10aRRHCKoUB1p8q
0Y8UMi0VgrH/iD81YOVmW1YVRSnXjugXCGZ8RzEU6PfEXho78z/kqHBpC3twejEw
G5Oq4LLam5k5yApyEVMOfjDqkI74RgB+bCrvH0zVFx7OE/Vd9f+oRHV+FMG2Zder
vGoKWPOAgZ7eL6gqF4KRcjbd9Z5QuHAEz0rUFg14KWi93qe8g9D0a8be8xlpEhO/
4ejPo3bFN1J5cmk8py1fVvhj1+PUHg==
=8nP6
-----END PGP SIGNATURE-----

--Sig_/1nioSGE/ngx_G5KfUGe8bw3--
