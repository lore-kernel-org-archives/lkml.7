Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D20C74A44
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 22:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D4520C01
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 22:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rezVNhNL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbfGNWCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 18:02:07 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:46435 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728731AbfGNWCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 18:02:07 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45n0xm1kG1z9sBt;
        Mon, 15 Jul 2019 08:02:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1563141724;
        bh=2wEPadkFUuVKl5geGn5FRdIiAE7+he0oCXHPcoMfXtY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rezVNhNLFsgeHlUdswBLxn+tjsTlmufwkaeeaE6DTQt3cdzOaZFOcFNtatW0M0Myy
         KtNO2D3AasJD/P9YMtSkLIZBItj/3Po3KUcj1J1Xlve6mit0UzW7f5RJv9f1BbnEkO
         1sbSWirqhS+24qwAyb/SFyJ3zeSLS20J9CDEEtSfG/02PdL5lf+K1KdpeDLi6BIFWZ
         fmrNuUF76nRDm/UrPKtgjThSwwnh1Nfm3htGyZFWw5PTe8feHy1reLCzPIKBybPqA0
         pwE5NQWV53vs3CgZxui5Jh3ibJeI5XafEzwLlGNx6pKLpA3iY4Z8WOrZNQvykdb1a7
         JQmVZz0rnYfeQ==
Date:   Mon, 15 Jul 2019 08:01:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the hyperv-fixes tree
Message-ID: <20190715080159.318b4edf@canb.auug.org.au>
In-Reply-To: <44b7e61d-438d-e906-57fd-b1182bf6f6c6@infradead.org>
References: <20190714225534.1dc093ad@canb.auug.org.au>
        <44b7e61d-438d-e906-57fd-b1182bf6f6c6@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/O6yCx_qZFaW42BLIUBNXb2J"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/O6yCx_qZFaW42BLIUBNXb2J
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Randy,

On Sun, 14 Jul 2019 08:02:11 -0700 Randy Dunlap <rdunlap@infradead.org> wro=
te:
>
> > Please do not split Fixes tags over more than one line.  Also do not
> > include blank lines among the tag lines. =20
>=20
> Hm, so you are saying that the Fixes: line should not be separated from t=
he
> other tag lines?  That's news to me...

see "git interpret-trailers".

> Should Fixes: be before the other tag lines or does it matter?

I don't think that matters, but first seems most used.

--=20
Cheers,
Stephen Rothwell

--Sig_/O6yCx_qZFaW42BLIUBNXb2J
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0rplcACgkQAVBC80lX
0Gx1lggAhr6vtC1VPmBV6PVDvOPjTZPK4CrxH5/vZ7y34nMlg+ChLrw0x9AGKC+S
CjaxClI3/jNTRVs9T1PJmOYQKgLxTpxjmyxMXOZulClQjhWTZXZPHypLCJ3Dsmc4
N4rjUw4WMynpC/ufPL4QoGCPUppV2V6pVimZhuUTPx3kuRyVBRiJ3+qkiqxUZFni
cIKvFJGIIqWNmuOzUeV4At3LPWXhuPshBPC+6fAo/AuaG1aXI0+4WpyzKC8MAfKw
7Yo1P8kXxtPKRSf+Jg3ighGALc905HJymVNdDiF7rjb9QVypaVgtlqbXGkrICDtq
Egtg4Fboes8bntitHwV/wNatSGtWUA==
=Le/S
-----END PGP SIGNATURE-----

--Sig_/O6yCx_qZFaW42BLIUBNXb2J--
