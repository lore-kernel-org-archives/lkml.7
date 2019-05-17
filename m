Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC1BC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 11:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB4C620879
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 11:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="SbeI+uH3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbfEQLJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 07:09:28 -0400
Received: from ozlabs.org ([203.11.71.1]:50553 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727689AbfEQLJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 07:09:27 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4555CS3gmQz9s55;
        Fri, 17 May 2019 21:09:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1558091365;
        bh=wv3hnsOuPhwdRJsjknemqN8vMnKHjA1P8fi3B4VtVhg=;
        h=Date:From:To:Cc:Subject:From;
        b=SbeI+uH354EhsJ/HSTr2dVQaome3jUMzcgTCA6zhZ/L66BWx97EL37ARaX6boRf07
         wzLFH+jIn0sf9Gx/ibsIBGg7MlOr/M/Aiz8O/YW2qgnNjqW5ab5+hAuZSvfg2cLrU3
         U4+6VpXgYmChvwa6DfnNpqe6nyPWaRq+muqsIV4jVqBcD0TZ4jpcH19GPY44ihlOoA
         aG29ClLB1b+XqoacA3q2Bm3Zke44uTIhM2OzOu9P9lsxUOoecnbEqMBTo89ZUnwpU1
         JYKrPNYG33XHyGuK18B9X6pQw+msdWLl0m7PgUBJolUA6wgQ/QD5cf1X/VgeD3xtrQ
         A/OFUxTBfrR0g==
Date:   Fri, 17 May 2019 21:09:22 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Iuliana Prodan <iuliana.prodan@nxp.com>
Subject: linux-next: Fixes tag needs some work in the crypto-current tree
Message-ID: <20190517210922.70a51b83@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/fhNqN8siC+gvfEhd1u78a5."; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fhNqN8siC+gvfEhd1u78a5.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  4fa0b1f971fc ("crypto: caam - fix typo in i.MX6 devices list for errata")

Fixes tag

  Fixes: 33d69455e402 ("crypto: caam - limit AXI pipeline to a depth of

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please don't split Fixes tags over more than one line.

--=20
Cheers,
Stephen Rothwell

--Sig_/fhNqN8siC+gvfEhd1u78a5.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzelmIACgkQAVBC80lX
0GxatAgAm+FtYL5tBLB+70elBaeisaAg66l8kbgzrk1MvfUTH0kregdykejfqlem
ioXbvn2bSLYCKgP4+yC9PGET9Od91qnzbFkTKW3fw/eRhVjQbDAsbPlqS+9w5m48
dUdtTwOt+55kxZZjsStnYFe/BADQZbio/tZTP+lZ9xP7TrF6QX0Hx6S+3ApvyQ8h
AQ0XUtgjEz2//EfE3y/Nw5xJloZFNJB9I4BLzzYvvth7Tn1QSveUf4mwoK/bZd7g
YN4lE5zcIBqjMLwBqzFqoNEPUMmpsXyBfC7e6ywhjNV9CHXZxQtwFcXjgx+u8tI0
DRnruLjuwiEcRgmjG/Uo0aD3zzkJXw==
=14pw
-----END PGP SIGNATURE-----

--Sig_/fhNqN8siC+gvfEhd1u78a5.--
