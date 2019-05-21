Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF83BC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 05:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B53E821743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 05:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ExmJpkxF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfEUFgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 01:36:53 -0400
Received: from ozlabs.org ([203.11.71.1]:36039 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbfEUFgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 01:36:53 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 457Pdt4sSTz9s55;
        Tue, 21 May 2019 15:36:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1558417011;
        bh=rBU5D62blCLj/Fiq/B6fGBj5k3UWnAQ5l4vb3sjsMEI=;
        h=Date:From:To:Cc:Subject:From;
        b=ExmJpkxFMa1F19+q1jjebqFJtIwCgSM5OdZDg8i355KN4vIwLCy19+zeB3/rvkEf4
         PSFKDQgvdcESOkxduGHWtZbsisa+iyfMIrAa8OqyajMv/0krBtdi3331udGAekktJA
         APQ363TEoZ4u8l8L8lltQLJoVIqXEQhrrlwXsk4bO29IisTWLvAivK+0iI0QcaCcyN
         yagQJOMtBY8JYs+4vYkx6YUf3W+JsWZCnjc5byRWXJSBLX4ISSgxLvkySKyaAeYqTp
         Zz7mD2Jw0vXicnybcxqX2JL72NtVjezpjwE/HFOs8z+QcyzlbDHZdFjmUY9/MxSc5J
         5m5rqo89+mchA==
Date:   Tue, 21 May 2019 15:36:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the amlogic tree
Message-ID: <20190521153649.0f44f3c8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/pvHOUmZAjcS7WnHy7=FWu5R"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pvHOUmZAjcS7WnHy7=FWu5R
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  5d32a77c6e2e ("arm64: dts: meson-g12a: Add PWM nodes")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/pvHOUmZAjcS7WnHy7=FWu5R
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzjjnEACgkQAVBC80lX
0GwT9Af/avLEl+T3sdiLDURsN7zi55ubXrf7NuzdGrbHYrzqnaPCFAsYy/nhd1s5
+5oYj50vt8Ku+KRUSusfE3aSghZGym5eh79WTW2klrcFKr30uRBWOa2FpRTLsYKP
X2amzZgZertOyYXsc1iXu1X4o+z9otuPg4c/JXNmujTpAVqAPJSUe9zV4B0m8APB
Cx3t4t97Cxi+OyKsAte2S5K7kJiJLmJ97/NIg8iumeUA9lAv38of/Sy27TwAy1el
9Y2s286gicRgQt+6cgmZB8ot5w+C1h2JXCh3vqXQDKDAUVnqBv30ZwwVOXLKgsbL
O7OuVgoL7CIoXhrjqqjvZ6EZTl/WbQ==
=qxv+
-----END PGP SIGNATURE-----

--Sig_/pvHOUmZAjcS7WnHy7=FWu5R--
