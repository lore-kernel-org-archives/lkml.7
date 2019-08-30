Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679A2C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 00:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A006208C2
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 00:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="VWX1ckyK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfH3AZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 20:25:59 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:48675 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726825AbfH3AZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 20:25:59 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46KKyW3GnNz9sNC;
        Fri, 30 Aug 2019 10:25:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1567124756;
        bh=vTWsfu1z/Zldg29nCHdodXHx5wD3TBHhT6EeGtP28ng=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VWX1ckyKQXcHmNP4JteBl6TE/gmuxrP5sqQPj0Vjx0kHFlpd6bjBrIREQoWvZyQDK
         8lYSkDpUpFkz/UKdFCQk9jTOS7FT4qMpIPyMpWXVA26IATpca1q2/boOcZ6yEcPqca
         3Pr4j7IWzat7tEiQ26Jr1TJMwCNVBJONka0Mvt+9K2dQ6VlSaIx2d78BtKoug/C7we
         GzXtMHQRUBNNTd2a40E7O/2D360R8y5Q8ppaQjbKxI9dXl03BUDBQwP8Z/sEIqT+Wi
         /sbRYdc5rAbtjf8tB0GZMeS6C0xrmQe9CZbIToU2aVs6wWyWdHGn2a3RJ/2C4/0ipQ
         9fk6g+xlv3U+w==
Date:   Fri, 30 Aug 2019 10:25:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning from Linus' tree
Message-ID: <20190830102553.38fd43f2@canb.auug.org.au>
In-Reply-To: <alpine.DEB.2.21.1908300028360.1938@nanos.tec.linutronix.de>
References: <20190830082357.4650d243@canb.auug.org.au>
        <alpine.DEB.2.21.1908300028360.1938@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/53o8or2.LpQF327peWRQAaa";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/53o8or2.LpQF327peWRQAaa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Fri, 30 Aug 2019 00:29:21 +0200 (CEST) Thomas Gleixner <tglx@linutronix.=
de> wrote:
>
> On Fri, 30 Aug 2019, Stephen Rothwell wrote:
>=20
> Yes. We have a fix queued which should hit next tomorrow.

Excellent, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/53o8or2.LpQF327peWRQAaa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1obREACgkQAVBC80lX
0GxVBgf9Eszs4ByVn6CUMr+KfbGwM9GZSjXLty5Y9Y089gZ+CJbxFbt5FY3QxZo4
IIYPuhhj3OOecNnhF+zE0/IHO/GDE0zmo8bXe+dl+R5X68yeJYyQzaH1ObUJ79qV
LqudJNie1ESyM7N3tuwPgY/q1q+QnPsZ8L6DrD62MB485bJbQvndN/O5Fxr6SREz
ToQ+GA0soVx5HOZB2691GFiYnx2YJgUy94nasyV7cqjAd1kJJ/c/eHKJJSYVAHrb
G+rM9MIJX1fctzZgiNcyObyQridE3U5cwKjCs4/BqwfM/BPesMBq332SPdSv5DTj
J44mIWADk3VxC++e2/W479YNMPXEjw==
=OPga
-----END PGP SIGNATURE-----

--Sig_/53o8or2.LpQF327peWRQAaa--
