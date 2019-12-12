Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655B7C2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 11:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3283D214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 11:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dVS8H5UB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbfLLLwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 06:52:13 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:41755 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbfLLLwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 06:52:11 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47YXGJ2qdGz9sPK;
        Thu, 12 Dec 2019 22:52:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1576151529;
        bh=pQx0Hn9VwNLWs+av3Y7yIbP9UhlN3gaBjg53IUB7FOY=;
        h=Date:From:To:Cc:Subject:From;
        b=dVS8H5UBT3DT1URweU/fcAirs7m9wmDanPXZGLx3ZDie2r4yawSyVX/F24SI6VouN
         GkDywmopFogv11mxprxZ7SwWURh+WIhX2GccEf2Rtkellz3xoNTy/deoDuwcF4/JH7
         XRs3KPPTJH0HZpTfTbcC9FrV/gdlk+fBLYgxz/ABaSJHCwDKQUA6cvdSExBFwag0xA
         N6L2n32CzxmvpCPUikkk7qTMhw962qIlWE4Ily9oGCt7qteQcC49L+HfcRSQExseJo
         K4GomS2ji1C56tD/QaoV43+I94K31Phr/UH1KHlq4uey0uMrnihJw/tTlllrJCtgxd
         cm5ey8N/EXlIQ==
Date:   Thu, 12 Dec 2019 22:52:02 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: linux-next: Fixes tag needs some work in the drm-fixes tree
Message-ID: <20191212225202.04d0d0e7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/oCbuhG6LIC_mZCajeFNESo1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/oCbuhG6LIC_mZCajeFNESo1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

n commit

  64d17f25dcad ("drm/nouveau: Fix drm-core using atomic code-paths on pre-n=
v50 hardware")

Fixes tag

  Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1706557

has these problem(s):

  - No SHA1 recognised

I haven't seen a Fixes tag with a bug URL before, they usually reference
the buggy commit.

--=20
Cheers,
Stephen Rothwell

--Sig_/oCbuhG6LIC_mZCajeFNESo1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl3yKeIACgkQAVBC80lX
0Gx7OwgAi97JtVQ8Ok7s9cphYws5Mo8MnUQVlRIG5zkbVjeOK7UcVYjWvAFU/YdW
Kvz1yC12va5kcSZycsE24KvVPOY8+sxJYb/asbqg+xZzcG/hpdUlv0aUCb/4Ch2I
lxBkcAz7pnb/r6Mccfgxgv6hbUCxuaNmySNJuDEXNWRURFKIvKsPQDBdfX+ZAeoK
1pij0d0SFR0zM3G1IEJ9+C7UwDoQWFqjVmqwluEu9C/zTR9pGQN2L5Lq5MUdHY7B
YhJoXlOf/3U9FZxHnKVOSrFIQePYPAgZhs4a4xtDD0IlqUfY72v9Ryi5G1h2VVv1
R5ZcakJSEzTsSjR+TWOohEOKIbiwIw==
=NdW3
-----END PGP SIGNATURE-----

--Sig_/oCbuhG6LIC_mZCajeFNESo1--
