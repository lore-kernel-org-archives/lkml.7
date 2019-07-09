Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8444DC606D3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 00:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C40C216C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 00:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="K5rwjxmU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfGIAmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 20:42:33 -0400
Received: from ozlabs.org ([203.11.71.1]:52983 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbfGIAmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 20:42:33 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45jNnf5P0Sz9sMQ;
        Tue,  9 Jul 2019 10:42:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562632951;
        bh=wWC6fAyjgQTj/KoZ0dwwBsIL7iZlRWuzNQgC/MzxXGI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K5rwjxmUcYgzLZhAsMglRLx0Oi0SF5ighgmJYKvtTJsjZoFNXinE7ShSZDBnSRsmv
         js9N8r3KmNYYjeGAPqQBKoqTwsVd5piL9F0AGLNg1vTSaHdPuE1LxpHWfhZ9N7Geb7
         O7JWQO+xdNKKSqpJgFzSWfhodqschhmHAKfzOqPdB0lrDsqtcR0tbK+3VVlSwa7rah
         ghO/SDrf6RbBfRtreX6jcgKW3l2mW3cDzjFsEQfOLmoF+ODYOIihH5brQAFxkprOKk
         47kE8JGtGIyw2kNwSscHT5z7SaupymFo8qlxOwelvJIuB9tzpQE95R6ZKeM5ek0R8W
         4fHSoKpjhGDTg==
Date:   Tue, 9 Jul 2019 10:42:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the keys tree with the integrity
 tree
Message-ID: <20190709104230.439f61c5@canb.auug.org.au>
In-Reply-To: <1562632295.11461.73.camel@linux.ibm.com>
References: <20190626143333.7ee527ca@canb.auug.org.au>
        <20190709101107.0754b26c@canb.auug.org.au>
        <1562632295.11461.73.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/g5eMwaLkW.oi6kozM+r+asR"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/g5eMwaLkW.oi6kozM+r+asR
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Mimi,

On Mon, 08 Jul 2019 20:31:35 -0400 Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> Thank you for carrying the patch! =C2=A0I did remember to mention it in t=
he
> pull request.  :)

Excellent!

--=20
Cheers,
Stephen Rothwell

--Sig_/g5eMwaLkW.oi6kozM+r+asR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0j4vYACgkQAVBC80lX
0GyLlAf8CwTh73yqJWYdUnbJCvVqNxo1Qvhmpw/Jz+FvOYUQSbTjUUnoz7DqE8e4
HYX8zuVsTHedX35fFG9kSi2v5dcgPQzmCJKoGcDLCLgpbr7A5qKFq+PT2ajuaGU8
eKfXhV+ekmr97lRtzLfKckdnBTL9cRGaA3dWmzYGk2xwYi4N5NeCSkLBXL9puwwP
miq1fmYfH9/RMteZtrONqiT7oqGthK/ggXVlapzYhemMPUDlwDW4lq2NLotUDhC8
OSp2Q/RZ9q4ko9kUKx4Almhmso0da3QrhFhI+GCa4D0PTjIzbtv4R9PGa4vDDJix
eBOc66cYGCYYftxpIg3Jm8G000BKAg==
=hEG5
-----END PGP SIGNATURE-----

--Sig_/g5eMwaLkW.oi6kozM+r+asR--
