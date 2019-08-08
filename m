Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15146C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 06:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE385217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 06:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="MTtE1i2w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731465AbfHHGdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 02:33:10 -0400
Received: from ozlabs.org ([203.11.71.1]:35653 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbfHHGdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 02:33:10 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 463z8M47sqz9sMr;
        Thu,  8 Aug 2019 16:33:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1565245987;
        bh=Apx5eCJWWpnCX9eZCPmjBd+hU8WQjYshhIE53owQm7c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MTtE1i2w0IQyzrrMXS//6q73d5fcQtk+IntnIzN9JtCO+gt050s9VA90X8753g0ws
         jtzBripsXwYG3PtOncrTGdGyHfC1ZUtmfoDiUjZJhdjyhDtoSEn3shOB9SRh3KE+FO
         Hy7ct0t6xlGrY4y3RG892towchQo6+o8kMy7r4nMQt67K2g1jtrzgPjIWr/Q4JeXbr
         IJv3gdqyVIfBYJWGlI85MjoCKlNMjszQxjQkMWBJZI0VXTTwVGNLeesVl1rySMo7c0
         PIPpOpZeJfD5ZtTsMBKvYt8iDwFYFhVBXD7mfAnNBDyI/cWuGFXl2EIlTkbdyDEAYs
         S8QWNdUwd73tw==
Date:   Thu, 8 Aug 2019 16:33:06 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Please revert c4b230ac34ce for today's linux-next
Message-ID: <20190808163306.092be501@canb.auug.org.au>
In-Reply-To: <CAK7LNARd_RVY9K6ZG0rvamuPizj8E2hfN35UROv++KYekDUcyw@mail.gmail.com>
References: <CAK7LNARd_RVY9K6ZG0rvamuPizj8E2hfN35UROv++KYekDUcyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//SA7_h0x+DqX.IYYG8rb82g";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//SA7_h0x+DqX.IYYG8rb82g
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Masahiro,

On Thu, 8 Aug 2019 15:20:11 +0900 Masahiro Yamada <yamada.masahiro@socionex=
t.com> wrote:
>
> I queued the following commit in linux-kbuild/fixes,
> but it turned out to produce false-positive warnings for single-targets.
>=20
> commit c4b230ac34ce64bdd4006f5e0e9be880b8a4d0a5 (origin/fixes)
> Author: Masahiro Yamada <yamada.masahiro@socionext.com>
> Date:   Tue Aug 6 19:03:23 2019 +0900
>=20
>     kbuild: show hint if subdir-y/m is used to visit module Makefile
>=20
>=20
> If it is not too late, could you revert it for today's linux-next ?

Just caught me in time :-)  I have reverted it.
--=20
Cheers,
Stephen Rothwell

--Sig_//SA7_h0x+DqX.IYYG8rb82g
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1LwiIACgkQAVBC80lX
0Gw2oggAmHMB1ZGOc+iVe0wZVTwn5RBfQwHk6c8n/wYU5Pz5LK8/MKqTva3oIZP5
SKznZhKzed4izocTFEzJZzpo6imb08oGMj4fP4ErCr+rlDWox+Z2Pzy6E13F+pzQ
0ql1L+7AUVoDF2cWsu+7iciISISq5eELHV8Q2G12RPyNdtHVvZloDzzwKAg2iSAU
td4bwyy3YCm+HOE9w47RR9BTMHp27hyWLpWNfEBwi+I+Na9+rNbhZOvpNTA9tx6C
kTP9zd4tCfRhxv/JSPdgONYHIEux/9Ms82XnyGOM8/WrpFL3DMqiB/K1HhiW2Jw8
F+DLhLXfDu9obYa+VOKJyJnWDg6q7w==
=OfTz
-----END PGP SIGNATURE-----

--Sig_//SA7_h0x+DqX.IYYG8rb82g--
