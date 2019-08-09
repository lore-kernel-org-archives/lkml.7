Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773BAC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 12:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54834208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 12:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406770AbfHIMOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 08:14:30 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:20868 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfHIMO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 08:14:29 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 679A0A1879;
        Fri,  9 Aug 2019 14:14:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id GAVsWbOOM3vL; Fri,  9 Aug 2019 14:14:23 +0200 (CEST)
Message-ID: <0d59b0745db9dae17af0122cbb08f82540da652b.camel@carmenbianca.eu>
Subject: Re: REUSE/SPDX: Invalid LicenseRef in Linux sources
From:   Carmen Bianca Bakker <carmen@carmenbianca.eu>
To:     Charlemagne Lasse <charlemagnelasse@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Basil Peace <grv87@yandex.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keith Maxwell <keith.maxwell@gmail.com>,
        Matija =?UTF-8?Q?=C5=A0uklje?= <matija.suklje@liferay.com>
Date:   Fri, 09 Aug 2019 14:14:20 +0200
In-Reply-To: <CAFGhKbwJVv23Mwd7ruo8JCC-0U3BdNRwnxih9zgFSCyPe=jnoA@mail.gmail.com>
References: <CAFGhKbwJVv23Mwd7ruo8JCC-0U3BdNRwnxih9zgFSCyPe=jnoA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-CVrLfDxRx7v5iRG0hf5e"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CVrLfDxRx7v5iRG0hf5e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Je ven, 2019-08-09 je 11:30 +0200, Charlemagne Lasse skribis:
> When I run the reuse lint tool on the current linux sources, I get
> following error
>=20
> reuse.project - WARNING - Could not resolve SPDX identifier of
> LICENSES/deprecated/GPL-1.0, resolving to LicenseRef-Unknown0
> reuse.project - WARNING - Could not resolve SPDX identifier of
> LICENSES/exceptions/GCC-exception-2.0, resolving to
> LicenseRef-Unknown1
> reuse.project - WARNING - Could not resolve SPDX identifier of
> LICENSES/preferred/LGPL-2.0, resolving to LicenseRef-Unknown2
> reuse.project - WARNING - Could not resolve SPDX identifier of
> LICENSES/preferred/LGPL-2.1, resolving to LicenseRef-Unknown3
> reuse.project - WARNING - Could not resolve SPDX identifier of
> LICENSES/preferred/GPL-2.0, resolving to LicenseRef-Unknown4
> reuse.project - WARNING - Could not resolve SPDX identifier of
> LICENSES/dual/Apache-2.0, resolving to LicenseRef-Unknown5
> reuse.project - WARNING - Could not resolve SPDX identifier of
> LICENSES/dual/MPL-1.1, resolving to LicenseRef-Unknown6
> reuse.project - WARNING - Could not resolve SPDX identifier of
> LICENSES/dual/CDDL-1.0, resolving to LicenseRef-Unknown7
>=20
> Can you please help to fix the problem

The REUSE Spec mandates a file extension. The kernel isn't perfectly
compliant, and doesn't aim to be compliant.

Kindly,
Carmen


--=-CVrLfDxRx7v5iRG0hf5e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEaOz9p2Grh2PLV5z6duum9rbqLskFAl1NY5wACgkQduum9rbq
Lskctg/+OAW8+sXFXIv6PQGs1b6IVgtI5nGKyGg5v89clHTACdSnaABN24Du5nnh
qssyVVRWXQa/15gpmK4TzmZtBpPvEyCM+RBV6soAFGoPQ4vGXw2ctV9Y45jf0atq
sLPBQR1AihnAxGhpCa865M0ILbgDB1TvloXb2AgUSnkWT0+VkjURPY2mDargF/jT
G2DzWwrwllujCM0BMkrzb2t+IYTr8MROdw6ailOfo/F83bvokCVUN0ufTL9ezFsA
022lGaLoXvUl8cV4DAjdlImyAb1R32unTJggcIYuWOnOxqQiU5MvIBBoLbZ3i/7A
V50nqTAF96U1REU7n1BjNVtBz+G15D9XJJFxs7LGHbeFve6v/Zh7Yo8xe5R0bzv6
thiXDmtbvFA0/TaIOlONG/MahQxzw7TBqHdCrgYVArV2EVsdvyyrPKvylem+UL/8
JNmxJnaB5ELMBhkyLoXG5hUeWMELQJydT8kaAJ/HQaikZt58aJpmMhFGvrS7iYIC
smY/CVTF85/LN56TtS33vLVH6pU+38Xpq3IB0dmxK7fd6GrIgdjqNWfEO/4VksBM
JzJwQYNau9UypfWGO7ye9kDOVAJYCKt+ijGRUKL8ozvYOv7kpjHf9fMMn2aSWY5p
32E5zgvhdDPh2O7ZVq2m4I8cQcZSD3wpejMQEbFiVNEIKw6SQRA=
=cfbi
-----END PGP SIGNATURE-----

--=-CVrLfDxRx7v5iRG0hf5e--

