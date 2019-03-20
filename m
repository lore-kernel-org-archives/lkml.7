Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1F7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 342372146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbfCTPuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 11:50:25 -0400
Received: from mx1.emlix.com ([188.40.240.192]:39242 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbfCTPuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 11:50:25 -0400
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id AA01760972;
        Wed, 20 Mar 2019 16:50:22 +0100 (CET)
From:   Rolf Eike Beer <eb@emlix.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: query pkg-config for libelf location
Date:   Wed, 20 Mar 2019 16:50:18 +0100
Message-ID: <13279932.E8cnC9vheV@devpool35>
Organization: emlix GmbH
In-Reply-To: <20190320153701.7wym7btpjshdujpz@treble>
References: <3381642.TeJ1gWjbju@devpool35> <20190320153701.7wym7btpjshdujpz@treble>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2341083.vYKama657H"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2341083.vYKama657H
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Josh Poimboeuf wrote:
> On Tue, Mar 19, 2019 at 08:20:12AM +0100, Rolf Eike Beer wrote:

> > diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
> > index c9d038f91af6..0c8dd1609348 100644
> > --- a/tools/objtool/Makefile
> > +++ b/tools/objtool/Makefile
> > @@ -25,14 +25,17 @@ LIBSUBCMD		=3D $(LIBSUBCMD_OUTPUT)libsubcmd.a
> >=20
> >  OBJTOOL    :=3D $(OUTPUT)objtool
> >  OBJTOOL_IN :=3D $(OBJTOOL)-in.o
> >=20
> > +LIBELF_FLAGS =3D $(shell pkg-config libelf --cflags)
> > +LIBELF_LIBS =3D $(shell pkg-config libelf --libs 2>/dev/null || echo -=
lelf)
>=20
> Should LIBELF_FLAGS also pipe stderr to /dev/null?

Probably. New version in a minute.

Thanks,

Eike
=2D-=20
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
=46on +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 G=C3=B6ttingen, Germany
Sitz der Gesellschaft: G=C3=B6ttingen, Amtsgericht G=C3=B6ttingen HR B 3160
Gesch=C3=A4ftsf=C3=BChrung: Heike Jordan, Dr. Uwe Kracke =E2=80=93 Ust-IdNr=
=2E: DE 205 198 055

emlix - smart embedded open source
--nextPart2341083.vYKama657H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCXJJhOgAKCRCr5FH7Xu2t
/ESXA/9AO8tjkho+vP9MZppxojdHOFaDFK+666seGq4wWSyz6HM153myO4ZWJBD7
8pYynpB3kEStj966bFb5RacDfWVUOr+zVf8kTBCrlVEhHAxmOaj9PrDQwyetXO/x
5T40PgctbJlQ9I/I6hZmEXKqvZRvxPcQvq17780tE42AHWpQsA==
=PRY/
-----END PGP SIGNATURE-----

--nextPart2341083.vYKama657H--



