Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF31C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 09:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D3821881
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 09:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfGCJ5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 05:57:11 -0400
Received: from mx1.emlix.com ([188.40.240.192]:33842 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbfGCJ5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 05:57:10 -0400
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 4A1A260ACA;
        Wed,  3 Jul 2019 11:57:08 +0200 (CEST)
From:   Rolf Eike Beer <eb@emlix.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org
Subject: Re: [PATCH v3] scripts: use pkg-config to locate libcrypto
Date:   Wed, 03 Jul 2019 11:57:07 +0200
Message-ID: <1811702.YVQuMqyDZo@devpool35>
Organization: emlix GmbH
In-Reply-To: <20538915.Wj2CyUsUYa@devpool35>
References: <20538915.Wj2CyUsUYa@devpool35>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1729975.KOner38kvF"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1729975.KOner38kvF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

> From 71e19be4247fbaa2540dfb321e2b148234680a13 Mon Sep 17 00:00:00 2001
> From: Rolf Eike Beer <eb@emlix.com>
> Date: Thu, 22 Nov 2018 16:40:49 +0100
> Subject: [PATCH] scripts: use pkg-config to locate libcrypto
>=20
> Otherwise build fails if the headers are not in the default location. Whi=
le
> at it also ask pkg-config for the libs, with fallback to the existing
> value.

Ping?
=2D-=20
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
=46on +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 G=C3=B6ttingen, Germany
Sitz der Gesellschaft: G=C3=B6ttingen, Amtsgericht G=C3=B6ttingen HR B 3160
Gesch=C3=A4ftsf=C3=BChrung: Heike Jordan, Dr. Uwe Kracke =E2=80=93 Ust-IdNr=
=2E: DE 205 198 055

emlix - smart embedded open source
--nextPart1729975.KOner38kvF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCXRx78wAKCRCr5FH7Xu2t
/Ji/BACRSuxQHEqsw0qcdlknyNcG9PldpGMWh1OAgJeYQtOUH0cecj2XfUQuOXhL
chxN4YJsu6GCZG6sLYdoCPdYDO8WNN33vqXXD5JMYBzWIStR8ZyyzfJj1qFlgTRL
JqjrwrHLHAuGhJVyxHKr1IFjdLFfVgefpKkdaHFnK9CoEST2gg==
=yMur
-----END PGP SIGNATURE-----

--nextPart1729975.KOner38kvF--



