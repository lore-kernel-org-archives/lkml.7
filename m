Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D63ECDE20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 13:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB9F3206CD
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 13:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbfIKNnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 09:43:41 -0400
Received: from mx1.emlix.com ([188.40.240.192]:36884 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728100AbfIKNnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 09:43:41 -0400
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 82AC55FC57;
        Wed, 11 Sep 2019 15:43:39 +0200 (CEST)
From:   Rolf Eike Beer <eb@emlix.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Linux Kernel Developers List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3][RESEND] scripts: use pkg-config to locate libcrypto
Date:   Wed, 11 Sep 2019 15:43:35 +0200
Message-ID: <8434324.HpHetu710e@devpool35>
Organization: emlix GmbH
In-Reply-To: <20190910104830.C1B0E2067B@mail.kernel.org>
References: <2010898.sAvVGPNi7W@devpool35> <20190910104830.C1B0E2067B@mail.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1843712.YdZ8EksWrV"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1843712.YdZ8EksWrV
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Am Dienstag, 10. September 2019, 12:48:30 CEST schrieb Sasha Levin:
> Hi,
>=20
> [This is an automated email]
>=20
> This commit has been processed because it contains a -stable tag.
> The stable tag indicates that it's relevant for the following trees: all
>=20
> The bot has tested the following trees: v5.2.13, v4.19.71, v4.14.142,
> v4.9.191, v4.4.191.
>=20
> v5.2.13: Build OK!
> v4.19.71: Build OK!
> v4.14.142: Failed to apply! Possible dependencies:
>     8377bd2b9ee1 ("kbuild: Rename HOST_LOADLIBES to KBUILD_HOSTLDLIBS")

This one causes the collision, the simple fix would probably be to manually=
=20
use the old variable names when cherry-picking.

> How should we proceed with this patch?

I can send a backport or you manually fix it up when applying, as you wish.

Greetings,

Eike
=2D-=20
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
=46on +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 G=C3=B6ttingen, Germany
Sitz der Gesellschaft: G=C3=B6ttingen, Amtsgericht G=C3=B6ttingen HR B 3160
Gesch=C3=A4ftsf=C3=BChrung: Heike Jordan, Dr. Uwe Kracke =E2=80=93 Ust-IdNr=
=2E: DE 205 198 055

emlix - smart embedded open source
--nextPart1843712.YdZ8EksWrV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCXXj6BwAKCRCr5FH7Xu2t
/CJvA/98TzIia9tLM92HI7zOFV60dSizs/V5UolpD0n4AmSHgHxz//mYvfZGnE7P
JY9rxyQvFePMSmxR7snjRlpH89HfPGl0sbZsQrnD/fiIbDmtujDlC5LGXBMJ+umD
7mHWc0dTZ/ZZ4v4hcSRK15mj0phyMBsjo+H8FgyjGIoYXVoCyg==
=gcVr
-----END PGP SIGNATURE-----

--nextPart1843712.YdZ8EksWrV--



