Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB04C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3851A2084F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="P7wUKglE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfCRLSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 07:18:13 -0400
Received: from ozlabs.org ([203.11.71.1]:35969 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726493AbfCRLSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 07:18:12 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44NDFG0n1nz9s6w;
        Mon, 18 Mar 2019 22:18:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1552907890;
        bh=kUB0MA6cN+BXwuDXj8WYH0O5o08h58DUUwh7K73uSoM=;
        h=Date:From:To:Cc:Subject:From;
        b=P7wUKglEn1yu2tXb0GsAP8pySoJcet7mOnfIpsQjF1ilaaFbxKN3Arq5BoyoP+0WY
         rjApc++40el3yowRZGDbUzGLMdimHrPYUD1iDMH9ERpm/stYtpP4SnVcQUzMI2eNjp
         LAGAZZJ59Ia9ZMDU1VLldghqBFv5Ev3vfWwNTKV1SQCLaI5BqKZsfru8rYHonGy5oN
         HvKjTkoWTeUCBP3iD+5nvW/DS7V8UFhenpkil6KBcF/gq4eqTVuMpjSHOMXmXXduQZ
         MFYPNLWZ9pSTENezsbgztYVjUIZsGN4OoeB/02H8kL2oYLVF2EdjQQc2zfRupcChvy
         yKGC/UrCWeHpw==
Date:   Mon, 18 Mar 2019 22:18:07 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiada Wang <jiada_wang@mentor.com>
Subject: linux-next: Fixes tag needs some work in the sound-asoc tree
Message-ID: <20190318221807.6a8eadd3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/iVv7u9KJP0m58jvp2G66wdY"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iVv7u9KJP0m58jvp2G66wdY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  825b22e5961a ("ASoC: rsnd: src: fix compiler warnings")

Fixes tag

  Fixes: linux-next commit 7674bec4fc09 ("ASoC: rsnd: update BSDSR/BSDISR h=
andling")

has these problem(s):

  - 'linux-next commit' was unexpected.

--=20
Cheers,
Stephen Rothwell

--Sig_/iVv7u9KJP0m58jvp2G66wdY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyPfm8ACgkQAVBC80lX
0GxwEgf+JTq7XTw0AXdw8AEBFuPKYo3R2WU82AQECWnE9W3Wl2EkAP6rZlRM43op
QrC+OoVGQQzt7XaLuvpT2pWkdO0zsx4kpxnZve33M/Cq0l3IPSF6KZyJ/gXA7U+v
H0zFhwPkujxiCTtp8jp5MM8F8gx2Av7vV6O+IVRAzTh84MjoaMT1qQ47RYaFROrM
Dmzn2W+YLNAQOwArc9hXyCRruO9di7j0SalugnUoVew5KH5joDNNZtAvXUwp4+wp
0dCsBcFU/FaWZbmkH2YCDWmfisR/M344AjCt5PssgfH0BASEsd7EdLf4Sv/FfBEb
IJeXA4e/+P5yCHPHjZ107dZ0A89rgg==
=6oUb
-----END PGP SIGNATURE-----

--Sig_/iVv7u9KJP0m58jvp2G66wdY--
