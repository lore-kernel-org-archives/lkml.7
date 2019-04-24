Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A3EC10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 01:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0811218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 01:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="pbnN8AwG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbfDXB7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 21:59:36 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:45345 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbfDXB7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 21:59:36 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44pk5d2H5vz9s3q;
        Wed, 24 Apr 2019 11:59:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556071173;
        bh=Kggwjgb3lS4lSBQTEiUvpPTrVb/g0WqRx7iivBYuVxE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pbnN8AwG/KKmQVeIbqtV26FvMVafJAcu17i/NPY8HmP4lv7QKbJDHZhBBIuN6KGZV
         i+oDnJcUa+a6Jl9da4pzAbiPpr4o1RB66buJqluR77th4oST9jhjm2/yRUvCJE8Gfl
         KiXn6LeUTlW5QOLHnXyUFFmPgjiH3ceK5uLWT8ZagEgNYUI35aqCww88zdn8SpYV6f
         2xaTxIp0OyZNbCC9hi3oTaQsjWd0j2FbDrUKoMQH3hhXTLWAna4SF913kybej5jEgK
         E2huyXScgFgix5JkcadcKWyIj33mD8kOkr36XqCVxYnPmh1zh2Y3kdNq8m7D6eg6U3
         DVASTEI5Gl2ug==
Date:   Wed, 24 Apr 2019 11:59:32 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Deepak Singh Rawat <drawat@vmware.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "airlied@linux.ie" <airlied@linux.ie>
Subject: Re: linux-next: Signed-off-by missing for commit in the drm tree
Message-ID: <20190424115932.330a2174@canb.auug.org.au>
In-Reply-To: <45f1305e2ea62ca76a86c6cca1693c20d3a0c891.camel@vmware.com>
References: <20190424102219.48cfdfe2@canb.auug.org.au>
        <44707352378dcd414b476ec5420db23093fb9351.camel@vmware.com>
        <20190424111259.6a1aacce@canb.auug.org.au>
        <45f1305e2ea62ca76a86c6cca1693c20d3a0c891.camel@vmware.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/jxLVVcFoz.UJKb2.QJ5VfFb"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jxLVVcFoz.UJKb2.QJ5VfFb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Deepak,

On Wed, 24 Apr 2019 01:31:59 +0000 Deepak Singh Rawat <drawat@vmware.com> w=
rote:
>
> Sorry missed that part and missed your email context about commiter and
> not the author. I think at this point nothing can be done?

Probably, I am pretty sure that Dave does not rebase the drm tree.
--=20
Cheers,
Stephen Rothwell

--Sig_/jxLVVcFoz.UJKb2.QJ5VfFb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly/wwQACgkQAVBC80lX
0GyoEAf/caswu7ukXMn0c1mGWx4LgZ6otAOP9JVTCGAIrXlshnkEF/wR2CQmAXsD
uAIiZRLgFw8zl8nZvgn9BR3dzmRdSikiCslKzN9ClNjXAhj4TQHuTSlx2ZYTyA7+
2JqwcYUK7OBC0l250p89QteRvTEiaOTvsbFN68EVpCxRM11Nx5oSoCH0nS8RA7X9
AJ+Ab0Txy7uqqCBTdWB99ZEySumqX1y15xVxiq0eaRkolYv+3dLreiFQDi62+XMQ
omPZZvfGNWz4R2DUIIE6WEowA8lgUIhjAdZVwbC7vtzjBLymMEhaSroH0IKoMDlf
LM4fwyiSzx7vSf9xAMt3l5DOqXOS/w==
=nle/
-----END PGP SIGNATURE-----

--Sig_/jxLVVcFoz.UJKb2.QJ5VfFb--
