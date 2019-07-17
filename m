Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A40C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 11:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B35EE20880
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 11:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731419AbfGQLcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 07:32:52 -0400
Received: from orion.archlinux.org ([88.198.91.70]:57952 "EHLO
        orion.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbfGQLcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 07:32:52 -0400
Received: from orion.archlinux.org (localhost [127.0.0.1])
        by orion.archlinux.org (Postfix) with ESMTP id 6730C13DDAD811;
        Wed, 17 Jul 2019 11:32:43 +0000 (UTC)
Received: from saetre (unknown [154.53.1.40])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ffy00)
        by orion.archlinux.org (Postfix) with ESMTPSA;
        Wed, 17 Jul 2019 11:32:42 +0000 (UTC)
Message-ID: <d09b2d4cb888f215266404e7d012bcc75fd29c4f.camel@archlinux.org>
Subject: Re: [PATCH] hid-logitech-hidpp: add USB PID for some mice
From:   Filipe =?ISO-8859-1?Q?La=EDns?= <lains@archlinux.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     nlopezcasad@logitech.com,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <nycvar.YFH.7.76.1907171330320.5899@cbobk.fhfr.pm>
References: <20190716073726.6726-1-lains@archlinux.org>
         <nycvar.YFH.7.76.1907171330320.5899@cbobk.fhfr.pm>
Organization: Archlinux
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-xf/RDRtvN8ZxSMWqnlWM"
Date:   Wed, 17 Jul 2019 12:32:42 +0100
MIME-Version: 1.0
User-Agent: Evolution 3.32.3 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xf/RDRtvN8ZxSMWqnlWM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-07-17 at 13:31 +0200, Jiri Kosina wrote:
> On Tue, 16 Jul 2019, Filipe La=C3=ADns wrote:
>=20
> > Signed-off-by: Filipe La=C3=ADns <lains@archlinux.org>
>=20
> We generally don't accept empty changelogs for the kernel. I've added at=
=20
> least a few words, and comitted.
>=20
> This applies also to your second patch to logitech-dj. Thanks,

Will keep in mind. Thanks!

Filipe La=C3=ADns
3DCE 51D6 0930 EBA4 7858 BA41 46F6 33CB B0EB 4BF2

--=-xf/RDRtvN8ZxSMWqnlWM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0jW0leqs33gyftiw+JPGdIFqqV0FAl0vB00ACgkQ+JPGdIFq
qV3xPw/9HMHwZPNPOPR7oTCuU8x3ixR5N821RwAY+bsonCj8gznTiOgXyxcQbOp6
MG8tI5VGgZJOYV3XjqjQcbE4ht68Ers+Lq/hLElLRLxxJTPGwBZSw5GK/gEPfu+j
Ix1I1exNa343q8gYW/usP5gmRKq9ga3B/7pLIQYDnBC4ozoI9q6fTvF4cDs7RuPq
OnW4CDgLG+Is9UOsZPY4AGY8A4nKNpciMAHkcig3JVLe9VkecwKiTmCnVdeevKJd
1wlgxLBMGhbkHu6ShqgVPF5qzcv/K8McueWKLHHfuuoWIqC7BwzkgVM7ojh3O9pX
HDwHXnA2xWlaYRgfcL5R5EVpTIBkCiQcD3k2ZV8y4tJ2B0GVWfrluwVGcn+E3SWC
FSGSh7SB6YBml3UBCQ1z+VVGCkuZXjk8ObS8oO6DR8dyslHvypMvSy0FEz0pr8FK
VHji5gHEVxDsi1qJdtOWEG6HDFkYJfm8Jn0nYGfjHiXht5PT9YBASt+drvrPOh6Y
cHgpSsE3ms4+DPQsavCn5SxP0GfNtrTCb8biUKR1zCdtcpr0ShpZrvziwSdc1AXn
gVhgqu2bh2Z/M9hK/KR3llSEgU+7cDDZr1MJYEK7luRc1JsqNTQmxtmfmNY3ylOv
Pnz6XNc2c9rEEtaXvDbWKF5r9KaEWyEAii556h1ht7erbIsuxDk=
=r+TE
-----END PGP SIGNATURE-----

--=-xf/RDRtvN8ZxSMWqnlWM--
