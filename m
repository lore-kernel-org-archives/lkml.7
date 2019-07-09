Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64246C73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 15:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC3F2166E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 15:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562685236;
	bh=WYes44d1XbX9RL1aWGMXhJciepw8Ge41YgS9/MqBDmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UTbNfSfHAoJcbiTgtf3jCBn7g7GxYkCKizMgVWWn8QpgGZXm2HJqXbbmX5A2VZydm
	 j1/G2Tg8SD0jnRTmO9U48bhmPKYB6uNyjWfG/rny91JkzESUWCHFFK6BbC4JWB77Sg
	 Z2XY8qWATxxS2BhkXtkxCYC7NtZVQwpg2a6gZ3mw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfGIPNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 11:13:55 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52766 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfGIPNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 11:13:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QA3KMjVRm27Z/yBIcHSySV/7M7db3yiAsja5A/gEvl4=; b=j8fzb9CuPBPbVvm/uYU37XSDy
        leO0YTTLD6yKzuYre7oQPNZrl6Mj5qDaHsHhlcJYM/7Hi4CIwnkKn4lkTLEZ5bLNXguTTAhj0et2G
        x0e56AmMuSXjblhwq9X7kzL9zSsq4zE9YM5Q92kPOkZ16bW7NYNECrxUPyaYVNCIpUc1E=;
Received: from [217.140.106.51] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hkroE-0005fD-RQ; Tue, 09 Jul 2019 15:13:34 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 9133ED02D72; Tue,  9 Jul 2019 16:13:33 +0100 (BST)
Date:   Tue, 9 Jul 2019 16:13:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Mark-PK Tsai <Mark-PK.Tsai@mediatek.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Cc:     kernel-build-reports@lists.linaro.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Re: next/master build: 230 builds: 3 failed, 227 passed, 391
 warnings (next-20190709)
Message-ID: <20190709151333.GD14859@sirena.co.uk>
References: <5d24a6be.1c69fb81.c03b6.0fc7@mx.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lc9FT7cWel8HagAv"
Content-Disposition: inline
In-Reply-To: <5d24a6be.1c69fb81.c03b6.0fc7@mx.google.com>
X-Cookie: Visit beautiful Vergas, Minnesota.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lc9FT7cWel8HagAv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 09, 2019 at 07:37:50AM -0700, kernelci.org bot wrote:

Today's -next fails to build tinyconfig on arm64 and x86_64:

> arm64:
>     tinyconfig: (clang-8) FAIL
>     tinyconfig: (gcc-8) FAIL
>=20
> x86_64:
>     tinyconfig: (gcc-8) FAIL

due to:

> tinyconfig (arm64, gcc-8) =E2=80=94 FAIL, 0 errors, 0 warnings, 0 section=
 mismatches
>=20
> Section mismatches:
>     WARNING: vmlinux.o(.meminit.text+0x430): Section mismatch in referenc=
e from the function sparse_buffer_alloc() to the function .init.text:sparse=
_buffer_free()
>     FATAL: modpost: Section mismatches detected.

(same error for all of them, the warning appears non-fatally in
other configs).  This is caused by f13d13caa6ef2 (mm/sparse.c:
fix memory leak of sparsemap_buf in aliged memory) which adds a
reference from the __meminit annotated sparse_buffer_alloc() to
the newly added __init annotated sparse_buffer_free().

--lc9FT7cWel8HagAv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0krxwACgkQJNaLcl1U
h9Az4wf+NjXEh83svNGV2ZzFvXQyIX1F5+MZY7+Qec/kz30LoJZXoVpSQ/XOSPZw
4w0AlO9ogCAByTihA7SYdDeWVIbjYtpnBJkPPH9q4cr4pq73gM5VtvPMOwsLnC02
BkikiievlHtZzDDtVZMwN/lBEsMzLPhVzth/od3+b64fG3miWorWXsCZvQP1Ru31
JcqASJSggqba3JnUZsMTDe/eGCOiVezjwqOK33t+Wa+EVMmdqFUYsezamhzJbbQQ
ig7iz36rj8ktEfNZ7FQF/LL+0oWG/SQr2CLB2gRmspC9eGybuMPFjsDvOsDnX3GZ
9Yp3O3IMuXos/PMucVWAU7m76qnCGQ==
=G6YQ
-----END PGP SIGNATURE-----

--lc9FT7cWel8HagAv--
