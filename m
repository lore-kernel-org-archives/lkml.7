Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400D4C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BFD22784B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="sznVNVN0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbfFCOUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 10:20:33 -0400
Received: from ozlabs.org ([203.11.71.1]:53485 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728883AbfFCOUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 10:20:33 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Hcf52SY6z9s1c;
        Tue,  4 Jun 2019 00:20:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559571630;
        bh=Q4B8FpfsK6DpZ7z9YCUHwiC5RVI5aIkPJwaUh8DL63w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sznVNVN0JD/wPHa8k7oqf6G/YwvOXs4ukGTnK5khxI8ufSGFC9A/3nPKGq/x8XZ5x
         EgtoXse9P1DCAIpa/AKIZNYS4BvpVt2Mg6dAlhGT3aZ27XD+6atMQ2hw4L2FGxMMpf
         I+1N/C0Cm8mAl+v3WWal/s6XyZ/DlqMrE1gD3l70f5cmAL96rNaf+pYkHpvsPGJhkz
         9+Ai2Tjukd47or6FgeZ3DPCKuPEeAFpiSSc88eSYE99jdk5pIypU2j6NMc9pPghBHr
         PYxjqlwR1YL1kukEN3IHLyyYNqVtBbwr551uKwt41bm5zrcfZDHD216bktTX9efVJU
         6/B6K6h+q8fMw==
Date:   Tue, 4 Jun 2019 00:20:28 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: unable to fetch the mvebu tree
Message-ID: <20190604002028.57b0431c@canb.auug.org.au>
In-Reply-To: <87y32ikbbs.fsf@FE-laptop>
References: <20190603082346.7bd1d7a4@canb.auug.org.au>
        <87y32ikbbs.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/IjKKVR6x0E8Lm5amJ.5B/P="; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/IjKKVR6x0E8Lm5amJ.5B/P=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Gregory,

On Mon, 03 Jun 2019 16:11:51 +0200 Gregory CLEMENT <gregory.clement@bootlin=
.com> wrote:
>
> But now it should be available.

Looks good now, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/IjKKVR6x0E8Lm5amJ.5B/P=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz1LKwACgkQAVBC80lX
0GyKxwgAg/pkt9W9v4z32zFUGoB0nFf+57pHKDyXkBltI7xReRxDv9e6FLU8pBlH
KwelCWSDEagINzPjCQQ23FhJb7YfPNMlewG5epuKE35nFV47/5PJmJNNwkewg9gY
LhL5tUGRdWD52YLGdsFO4f1ikNx/9Yau1wN4sIRPXSqJvNFSCriUjPt57qZ/bhpi
pt2ssbUyHD1ABC3WWEj5OxgpSSBtK/TAhTM14ZAx164m+GlnaLr2Xwz7NqSsjcB4
djIBVVRkmn6skLZiSEut3I9zezAZbVLqYxvIaz03RfZQybff0xBQ5bkybHu3r1Q9
qBPRuGugzYBEyB12RZBvL3FAt6vdFg==
=t3c6
-----END PGP SIGNATURE-----

--Sig_/IjKKVR6x0E8Lm5amJ.5B/P=--
