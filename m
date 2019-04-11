Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165F6C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E372146F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="huN8u1VH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfDKVcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 17:32:06 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:43281 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726872AbfDKVcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 17:32:06 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44gDkW2Q2xz9s4V;
        Fri, 12 Apr 2019 07:32:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555018323;
        bh=2hXveXP0LCdpEnHzaAZDz0FruPrmRmNJNU84FVaxkHA=;
        h=Date:From:To:Cc:Subject:From;
        b=huN8u1VHZrmkM7KfIimOnql3wxqH4dJjYZA35+egDaZKC9sjKgpGf0v8CAEb1Ws8a
         ivTG9tV77PTj3AlQvGo2sHuYY2YZDNj+x7li9/3Iei/PIXFrEXXRtaqIjp7sxslVNZ
         ERLet3N8zkkGWK7t0BkEM4ZFOOpfzC+TnBt1q0A5EqduuQsN57oEv+C+YeVl7Nrni8
         MdHXC5KoeLR0oFYbwtGHj9Re749EoTSZA4qfZEcU3s/7umYdhbFYs9xDNqfDhn4C9f
         sLggQBcIK3PMcpO99afsxSmgPAFtxzfgDaCB1kLlW5Y663QozLuQgDii0Xn1ur5otl
         MKl59eRrw5+Lg==
Date:   Fri, 12 Apr 2019 07:32:01 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     John Johansen <john.johansen@canonical.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the apparmor tree
Message-ID: <20190412073201.5b8ad548@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/KV+JkmtVQqczK+HXrh_=yhh"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KV+JkmtVQqczK+HXrh_=yhh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  270ad142eb0f ("apparmor: fix missing ZLIB defines")

Fixes tag

  Fixes: 876dd866c084 ("apparmor: Initial implementation of raw policy blob=
 co

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please do not split Fixes tags over more than one line.

--=20
Cheers,
Stephen Rothwell

--Sig_/KV+JkmtVQqczK+HXrh_=yhh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyvslEACgkQAVBC80lX
0GzWUQf+NBDLkS4TEXng1cnPegsE3iXTNOpfgSBojRCBZLJycNaULxilKtBqVoDP
6/s1tiwIP4Zcz60ZUE/0MggoifQ/Z097eMfxCbgZW/bMph4kzErjLz6F2VZcCHXa
3x0/FFqeZWMqU7uvpQ4zrA+PcAr/nsUH7oeTe1WOO2dJAhB29qg3JN375WN3gS89
4VCW4IqfB9FveROTR1tOJzPIaQT/QZGglaPkaqyk4d1pLFF/5RlhxWEEns1ZnKWH
6xULiRw6Wj3PlpEpVXhvpqJSlyQLwHrY2AVBvwVs4OQa+InCF701bOs5EzEufoRK
m96z0sg7ZYoHJa3ZHPHNOoqahhBFAw==
=Ag3f
-----END PGP SIGNATURE-----

--Sig_/KV+JkmtVQqczK+HXrh_=yhh--
