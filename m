Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9EDC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 00:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92CD12186A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 00:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DXRtw80A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389509AbfHHAnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 20:43:01 -0400
Received: from ozlabs.org ([203.11.71.1]:57487 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729624AbfHHAnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 20:43:01 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 463qNK34RGz9sDB;
        Thu,  8 Aug 2019 10:42:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1565224977;
        bh=IbcFGct0WdrCjGA1O2Oy65DuO5Pm1d0UQw80h84ztRQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DXRtw80AQRUOzjvvGK+GGzVuJJ5QB2f+8c8A0E48I6c3nQn9G9YKbVnFmL8tRqSBA
         cWBGJzOjYhFPAcLL1hRFN5qszS1v8uGxIf8L4KeMI5nDUJ6oztbGfdc2BTA3a8ti4+
         vdle1vcAcJAWA1pxI76XOO2hIUmmVm0rE8Up7T1qeHjcQGCFdWBvalthh/qQr0aNbJ
         SnwUBdbPPpxgY+y/9yL6pulLCarCazb2ECWAA/RI41le2DQsB8q/rrXgjx2//dlByb
         PmHftP5yEN2xg+nHl6RG44bRHpU73i9IYaamhGTkWYSujFh5lGn/eVnXLHHTG+BpDq
         d0k+ODxpu4JfA==
Date:   Thu, 8 Aug 2019 10:42:55 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the dma-mapping-fixes
 tree
Message-ID: <20190808104255.70592401@canb.auug.org.au>
In-Reply-To: <20190807223722.GA22875@lst.de>
References: <20190808082948.781f0033@canb.auug.org.au>
        <20190807223722.GA22875@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hdl3D5rNO3wtQ=PVzuxMV7p";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hdl3D5rNO3wtQ=PVzuxMV7p
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Thu, 8 Aug 2019 00:37:22 +0200 Christoph Hellwig <hch@lst.de> wrote:
>
> That commit should not have been in that tree at all, let me check what
> went wrong.

I was wondering about that.  Now it has caused build problems further
along, so I have reverted the merge of the branch (along with my fix
up).

--=20
Cheers,
Stephen Rothwell

--Sig_/hdl3D5rNO3wtQ=PVzuxMV7p
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1LcA8ACgkQAVBC80lX
0Gy67wf/dvZOd+KM43G6HGV9VNU29YlQVgDj1xPV0E441lzLnzucqD/DDAQEr5r3
oG6GjnEbnilZKMIry8vF0WguJ0k67K7pk01aR/iIKanyd0fP5l6yaFcNB3H3pUob
fMO4aSJHuXHHD0rAIAbdbCaYJjmFzg+DcZtJDT9Tdj0lAoetnr0A4BjVeH+nKUoW
Oy3lD0dmM+3veykcwzye7XiC9/exA0xMJGlwi6LbhrEoUSQgfGyW32AejYmQb/NW
hfEvflIzSqMBGj6O38A44Kja4ciKffcZr/kQYD0Nxt9FoWLQufL81lJlVsiPRTlq
ohdxHd7VnFMoJK/dQkMxiuKLhtEJZQ==
=siFp
-----END PGP SIGNATURE-----

--Sig_/hdl3D5rNO3wtQ=PVzuxMV7p--
