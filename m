Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB79C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A0F4207E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfFFIpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 04:45:36 -0400
Received: from mx1.emlix.com ([188.40.240.192]:35888 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbfFFIpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 04:45:36 -0400
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id B161D600A1;
        Thu,  6 Jun 2019 10:45:34 +0200 (CEST)
From:   Rolf Eike Beer <eb@emlix.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] scripts: use pkg-config to locate libcrypto
Date:   Thu, 06 Jun 2019 10:45:34 +0200
Message-ID: <9643543.8bRR4aT8lR@devpool35>
Organization: emlix GmbH
In-Reply-To: <6fbc10d7addf5aaab7b4b52537e0f0af6e0f2d71.camel@infradead.org>
References: <3861016.XCek94Sdvs@devpool21> <4904761.bSUFNkusSJ@devpool35> <6fbc10d7addf5aaab7b4b52537e0f0af6e0f2d71.camel@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1801806.k86Mj31LU8"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1801806.k86Mj31LU8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

David Woodhouse wrote:
> On Thu, 2019-06-06 at 09:55 +0200, Rolf Eike Beer wrote:
> > +CRYPTO_LIBS =3D $(shell $(PKG_CONFIG) --libs libcrypto 2> /dev/null ||
> > -lcrypto)
> That's going to run:
>=20
> $ pkg-config --libs libcrypto || -lcrypto
>=20
>=20
> If libcrypto.pc isn't there, it's going to get this:
>=20
>=20
> -lcrypto: command not found
>=20
> I think you meant:
>=20
> +CRYPTO_LIBS =3D $(shell $(PKG_CONFIG) --libs libcrypto 2> /dev/null || e=
cho
> -lcrypto)

Doh! Thanks, v3 in a minute.

Eike
=2D-=20
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
=46on +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 G=C3=B6ttingen, Germany
Sitz der Gesellschaft: G=C3=B6ttingen, Amtsgericht G=C3=B6ttingen HR B 3160
Gesch=C3=A4ftsf=C3=BChrung: Heike Jordan, Dr. Uwe Kracke =E2=80=93 Ust-IdNr=
=2E: DE 205 198 055

emlix - smart embedded open source
--nextPart1801806.k86Mj31LU8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCXPjSrgAKCRCr5FH7Xu2t
/FGVBACDaZeAF1gv/N+Xaryn024glR1o0HYMeA4okZuBXinlGu7dz1NgjI3mVVPq
c6p0rOOZ7MyQAuQkeMFuYKNN4bPzCm2psxl9/HsFK9+GaYIj/T8n6FtFwIY+PX7o
PalkzHoHq/dSoWkNwA94MIRCDCYDeKrdEYoxQxxiNUy5CozvoA==
=h8oM
-----END PGP SIGNATURE-----

--nextPart1801806.k86Mj31LU8--



