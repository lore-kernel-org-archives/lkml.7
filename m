Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795B5C73C65
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 23:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4543D2082A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 23:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="s9WEygv3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfGIXar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 19:30:47 -0400
Received: from ozlabs.org ([203.11.71.1]:50083 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbfGIXar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 19:30:47 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45jz8M0dPZz9sBt;
        Wed, 10 Jul 2019 09:30:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562715044;
        bh=B85qe5sVAs6gET2P/YWRTXMs4fjDTUH5FZWZR59bAow=;
        h=Date:From:To:Cc:Subject:From;
        b=s9WEygv3l9mId4NqL9V4v/s1fxnBwUxJy/tJy3fqrxuxRIAB4FZs3caN8vEdMv3iP
         7tMFPnnxeFjTzanMB6p5z8qIqBhX7fHoW6DvX+JqI6CNOjrZA6UN5SKEpk98NZPCvn
         yhHN1wVTw9TMPZXeyhkI8RKz0jUMiDVEbRDjDkcOQyjiKRB03dWHBxKd4H86CPBbcA
         KJNrmgNOpJ8XIESp86VHXaVXdDhdDzDc5ik9NLyH4pSzr1h+TgFcyHx5Y/2JIc9Lvz
         BZ6g3eLEWONkTBznWTSUsNjDkZnhXtwLi5f6Krxi0EEcPxiFn/CcyrBZeZlHks5nN0
         yFk6F+JHUCvZA==
Date:   Wed, 10 Jul 2019 09:30:35 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg Ungerer <gerg@snapgear.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: linux-next: manual merge of the m68knommu tree with the
 m68k-current tree
Message-ID: <20190710093035.48cc876d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/tVRVxORUodfEB/.8uiS1NPT"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tVRVxORUodfEB/.8uiS1NPT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the m68knommu tree got a conflict in:

  arch/m68k/Kconfig

between commit:

  f28a1f16135c ("m68k: Don't select ARCH_HAS_DMA_PREP_COHERENT for nommu or=
 coldfire")

from the m68k-current tree and commit:

  aef0f78e7460 ("binfmt_flat: add a ARCH_HAS_BINFMT_FLAT option")

from the m68knommu tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/tVRVxORUodfEB/.8uiS1NPT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0lI5wACgkQAVBC80lX
0Gygsgf+LX6svK04n4v1wEAt+dRj62g9jHZtsf95gD7DTPiHoQifMT3kEsgvw4Bv
YFgCjWY/QrUpO/ZsSo22+bnOmAYTSlTRmLZRLLaoZaSgB6qpLy3ELSBfHUkoER4W
QdCM8WbgaEYsA6uW1gg8lP+D5HshDkH3NuO2QL2a5rtYJUoLmmg6D91an8vu1bwY
wtfvhnww4/7zrHzbVvVBduWEhsU+WWboBPP2xTdHPzqAPqA7gru8gRaP/7ZGYG40
okPMPTFkujeRqcupOlVI0FiQx9fYrvd9S8AxQopFrlZN6jf68Iv7sX2Hc+fZ/TJ3
cWElbW4xlUrdS9kSzr2rWu7k6Rp4sw==
=GMBw
-----END PGP SIGNATURE-----

--Sig_/tVRVxORUodfEB/.8uiS1NPT--
