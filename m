Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B24C2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 12:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04782227BF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 12:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbfLLMG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 07:06:27 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:39370 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728996AbfLLMG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 07:06:26 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id C77F31C2461; Thu, 12 Dec 2019 13:06:24 +0100 (CET)
Date:   Thu, 12 Dec 2019 13:06:24 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 134/243] bpf: btf: check name validity for various
 types
Message-ID: <20191212120624.GA15567@duo.ucw.cz>
References: <20191211150339.185439726@linuxfoundation.org>
 <20191211150348.188128369@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
In-Reply-To: <20191211150348.188128369@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-12-11 16:04:56, Greg Kroah-Hartman wrote:
> From: Yonghong Song <yhs@fb.com>
>=20
> [ Upstream commit eb04bbb608e683f8fd3ef7f716e2fa32dd90861f ]
>=20
> This patch added name checking for the following types:
>  . BTF_KIND_PTR, BTF_KIND_ARRAY, BTF_KIND_VOLATILE,
>    BTF_KIND_CONST, BTF_KIND_RESTRICT:
>      the name must be null
>  . BTF_KIND_STRUCT, BTF_KIND_UNION: the struct/member name
>      is either null or a valid identifier
>  . BTF_KIND_ENUM: the enum type name is either null or a valid
>      identifier; the enumerator name must be a valid identifier.
>  . BTF_KIND_FWD: the name must be a valid identifier
>  . BTF_KIND_TYPEDEF: the name must be a valid identifier
>=20
> For those places a valid name is required, the name must be
> a valid C identifier. This can be relaxed later if we found
> use cases for a different (non-C) frontend.

Does this fix any serious bug? I don't think this is suitable for
stable.

								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXfItQAAKCRAw5/Bqldv6
8sZNAKCpPlKj4aNOz24kULtOT5OPHge6zgCdFh7w/ah2JlnWD5WRRljYPZLpo48=
=1DLt
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
