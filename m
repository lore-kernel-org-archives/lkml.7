Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15576C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 01:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D259221841
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 01:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="H04Lwc19"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfGBBO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 21:14:59 -0400
Received: from ozlabs.org ([203.11.71.1]:54639 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726966AbfGBBO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 21:14:58 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45d5rH5wHPz9s00;
        Tue,  2 Jul 2019 11:14:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562030096;
        bh=6DINRxab0oepeYG4X9g8db4n+wH/d8FRBfdW4MiWGDw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H04Lwc19GDwA5Sps+VblYB//0TrpIn2EOae0P3HIQMZVaV05ZnoSg99ZmL5K18xlq
         h9X5eJauKGbeKFJOBI3x/QtmAxcoCkfOVVUfYpajL1ykvfCG1itTom8xQf7YRdHm+w
         MHcFqJ0TtgM6m3WJ1XbCn5aHYIWzPQrU+KE6hqoSYTVHXCON2Y8tEDku03ZigM7ZsK
         pRWia+bd92d+0Q66qiIkvS0uUIvSBUhg8eo1KBtxagKbdEW7IYsibPOP5XsfQ/5Ans
         oZFdZ0TZi3xd2dCmBxXEtfeAYxotr3ccRQbWBECziQDHueDD0RPDRn3Iw+OBCPmDZL
         GcXtWGU+wcBGw==
Date:   Tue, 2 Jul 2019 11:14:55 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the clk tree
Message-ID: <20190702111455.4ef3494f@canb.auug.org.au>
In-Reply-To: <20190702100103.12c132da@canb.auug.org.au>
References: <20190702100103.12c132da@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/dC.eE9hnONbxkU8d1qv2LhA"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/dC.eE9hnONbxkU8d1qv2LhA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 2 Jul 2019 10:01:03 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>=20
> We need something like this (untested):

simple testing shows build errors ... we need something better.

--=20
Cheers,
Stephen Rothwell

--Sig_/dC.eE9hnONbxkU8d1qv2LhA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0asA8ACgkQAVBC80lX
0Gzz6QgAn58oRLE1K7cpckXuctX0SQq2ZLchwZZ8oyIu6bio96qRGNXbiOkSSvyS
87YtYBV5uwz6i2sZ4W69GmZeGg1J14k8mdUfNhfZMrEhaIEaw5PNlKYZJxVylpP6
IzAfmttnu9J2ehEDNa9kC8j/TozGRLE6ygZt+bOSfY9oG/u9DoUSczVVKw7+Hwsk
32kPscyRYyBMkMjrmdpCrbVcazoKoqMvEBCvEGR5ANC2z2IQ5E7SwIGUHl1PF/OE
hyP1net2+j9/tmssTOrz8H5tR97mL8isBHyKqOJhXx8Mya/Q32G6rkZdLU9LNEaY
XY5X6ktZS0zvLHZK6fl91LFTRFCOwg==
=a9Op
-----END PGP SIGNATURE-----

--Sig_/dC.eE9hnONbxkU8d1qv2LhA--
