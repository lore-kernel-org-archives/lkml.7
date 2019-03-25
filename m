Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC283C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C8BE20863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="fMnEnW1B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730075AbfCYUJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 16:09:27 -0400
Received: from ozlabs.org ([203.11.71.1]:60783 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729283AbfCYUJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 16:09:27 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44Slj06VtYz9sSY;
        Tue, 26 Mar 2019 07:09:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1553544565;
        bh=3a3lRI1lHiUkeS9diDhbrLcMwp3CKMuwxGEkyFHkFu8=;
        h=Date:From:To:Cc:Subject:From;
        b=fMnEnW1BYSmzyXCUk4tfMQ/+7QOe3gpezQaaV7PdnQ73u9pTkYQTGvHPcLypHsLmB
         lijhQIjstM/qaQxto8HtCm8imskseXZ0Z5b6II/rubCkTKb0iK49Cpwyk9qQh6bu2s
         IsX/XhoZimmFqMsKDx0xKMMeCqqHDqWuAZe/6hRcz9hVZarHiYCgQjczta6uoaslDg
         FpIYLMZJXE03+drVUHb3N6BR5JjwrL2q+A2giXM+NjS06qHaK5/TrZHm/IHGqN0q6p
         1ZGGCTuOXeF49Pm1h5xSaQIuW0BM3X17t2l57V0qwKSu26LZwR8MV6MPjIbHNYiThy
         eqwehQFALWxrA==
Date:   Tue, 26 Mar 2019 07:09:24 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Qu Wenruo <wqu@suse.com>
Subject: linux-next: Fixes tag needs some work in the btrfs-kdave tree
Message-ID: <20190326070924.1857a3fd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/5up7MfN.NOQ/szYoxHKbsXk"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5up7MfN.NOQ/szYoxHKbsXk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  167ab7e5ebbf ("btrfs: reloc: Fix NULL pointer dereference due to expanded=
 reloc_root lifespan")

Fixes tag

  Fixes: d2311e698578 ("btrfs: relocation: Delay reloc tree deletion after =
merge_reloc_roots()")

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h (%s)'

--=20
Cheers,
Stephen Rothwell

--Sig_/5up7MfN.NOQ/szYoxHKbsXk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyZNXQACgkQAVBC80lX
0GwUtwgAnqMT9YluZIAXae3fjaTGSoP4BSu4YAJf3gmsY1ddUCuaojxQL4LT24yi
EZMcQwp9F0taJgTG6I3418vLi3LiMqJSRJp+WI7Nd3kbn2WOJR+198LAiIry1BIr
jTZk5oV/JEcfBBcurBTkqYodRDekEWe+h6ndHcryVPouLBBfqTAi+82El9chr7mi
Oco9rsoGlXEvxX05xCFY4li+VkQrSZ5ZTJX2v4WQu5Xt0wM8Ws1KTos3V4iYg8y4
TtQwq3OAwf7GEnYc7FsyDVl2n7gueGLELebEf0pD9I1swUxZSgDQLxJv2Bz5kzgb
pgNeBqRoWDc7NISbh0n7g2ET9oVV/w==
=2zbs
-----END PGP SIGNATURE-----

--Sig_/5up7MfN.NOQ/szYoxHKbsXk--
