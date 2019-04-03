Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB00C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 00:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B6920882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 00:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="MHzoDWlx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfDCALO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 20:11:14 -0400
Received: from ozlabs.org ([203.11.71.1]:43475 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfDCALN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 20:11:13 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44YmhD6FL3z9s9y;
        Wed,  3 Apr 2019 11:11:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554250270;
        bh=GPzXue+buKSOIE35c/YyueAIkyfL268BtFgifQLZH8A=;
        h=Date:From:To:Cc:Subject:From;
        b=MHzoDWlxwxFZJmXdDJ6yw+InfqD32Wnu695DCFla9Xuih2toE+K1IvaYQaRFIzPlA
         9psQY3i6Q//x+aubHDAyAMOAXsQlVOn6FDQwkuYX6xn20+r+NwNuhQ0fid/S7lVVjL
         cmtsZFtd+908EwdItOc6YEB1gfol/89h7SticIvWKolTzF3CIV0gvx/uMyHVQrE2jZ
         7NjpGFgo3XdQ9L5QKWiXOuSOA/3HJy/6EE08HZSjqSdDLiCwnr1sUDeKTWiPXHfPm4
         RRrzIJWteTNPxgMRK0tIRToLuLpr6iKDe3AsYb8R7+zqNWBWppaOsdKiF5kfRUycBt
         A1zvcvc1bZL4A==
Date:   Wed, 3 Apr 2019 11:11:08 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Yintang Ren <yintang.ren@unisoc.com>
Subject: linux-next: build failure after merge of the sound-asoc tree
Message-ID: <20190403111108.2ff4a309@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/6t9BxO+vh_Iinn.Ler=0s8I"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6t9BxO+vh_Iinn.Ler=0s8I
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the sound-asoc tree, today's linux-next build (x86_64
allmodconfig) failed like this:

ERROR: "sprd_platform_compr_ops" [sound/soc/sprd/sprd-pcm-dma.ko] undefined!

Caused by commit

  cce1396936ef ("ASoC: sprd: Add Spreadtrum audio compress offload support")

I have used the sound-asoc tree from next-20190402 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/6t9BxO+vh_Iinn.Ler=0s8I
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyj+hwACgkQAVBC80lX
0GyCYQf7BZL46LGn/rTF50AUMMp64FHZ0xYx9y/OxC7qQWWiyQp2eB9HfNpL2C1t
awMnUzhyOznGLoejS5mahDyAPCJTfX3EXVgzShLQk30bnS57euTA4Z5wFpPIliq/
CXcJ7kbhBBw+1ZmwJIJeG8cJHxtdElei43M8+PIIhqZLgBADIEzakEn9ZsKDyRt7
WacWAlgjq9kfVzMaIeEVv7y/Mbq+c0gu/GW9xLgRli1kbpPr+hP+qnihfl5HLxdG
NkCQSnVg1eDZVioDGH+xafoypgV0mC7UpElCdf26puSK5PRDs/NGmGqcFbFN5E66
m7PVVuQD3UZv46Kls40vH9XZu1zh5w==
=LM/B
-----END PGP SIGNATURE-----

--Sig_/6t9BxO+vh_Iinn.Ler=0s8I--
