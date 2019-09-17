Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11081C4CECE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 12:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB405214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 12:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbfIQMSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 08:18:37 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40114 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbfIQMSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 08:18:36 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: alyssa)
        with ESMTPSA id E035E27FF58
Date:   Tue, 17 Sep 2019 08:18:27 -0400
From:   Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Steven Price <steven.price@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] drm/panfrost: Simplify devfreq utilisation tracking
Message-ID: <20190917121827.GA2974@kevin>
References: <20190912112804.10104-1-steven.price@arm.com>
 <20190912112804.10104-3-steven.price@arm.com>
 <20190913174343.GB5387@kevin>
 <CAL_JsqJHqvwJrO2jocoMx38z8rMtVrK+PcMRHO13Y7EQaQK+DQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <CAL_JsqJHqvwJrO2jocoMx38z8rMtVrK+PcMRHO13Y7EQaQK+DQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Alright; I'm not familiar with patchwork but sounds good.

On Mon, Sep 16, 2019 at 05:36:24PM -0500, Rob Herring wrote:
> On Fri, Sep 13, 2019 at 12:43 PM Alyssa Rosenzweig
> <alyssa.rosenzweig@collabora.com> wrote:
> >
> > Patch 1 is:
> >
> >         Acked-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
> >
> > Patch 2 is:
> >
> >         Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
>=20
> In the future, please reply to each patch with your tag. The reason
> being is patchwork will automatically add them instead of me doing it
> manually. For a tag on a whole series, replying to patch #0 is fine.
> Patchwork doesn't handle that, but I view that as a patchwork
> limitation.
>=20
> Rob

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ17gm7CvANAdqvY4/v5QWgr1WA0FAl2Azw0ACgkQ/v5QWgr1
WA2KMA/+KVj7jhNMdRi2MPjUXgPHmAfKnSSyNcaAZd+ZBQyR/xgJeOPVFfPUAspT
i9DVkssAxdbeZ+3TSMYPQxDCjUkwiOPVrmm1lRWTYTNsgS1X/X16vbp1IhSWKtw2
TQ+aJtS2aKKw+8XPJxg8vblCSVXm45UsDC4T7Zgq5CUeTmopxRvMxZ5kOgCJlsD3
s5lRYZwZa1KKVlus98ClsQ19GbvdFkLzQiPkXPXBRoiBDsWngB+9uVZeX1n+9F1B
H8N9OEJ7NLfuRa6mC6NHBw+bMeM1ugiFz6vpQIcqHVoyBpXLioXk2hrD3PuoFzh/
wIl0SLe5BfHBFRH1KgmIUmjqhRZs8eNO5opKHJmFxPvPf/0nvJMAcRJWVXgXu0q2
sAvjlUBRdFCvND9ULR8k0ocxIYmmfbVZWON9JHyCjR9gBbiujAVhgP7SEUotkFDJ
cz9AUSwzjkl0LIBaEUX7heC70YjST/T+wNoDuVcy2VnQYaOcXN/wkKiwxolKrA7H
peSTpqNVIfi08eOs0uuHyueoY0uuoXOPzOs9LO89LbAkBUW9p/GQMnGyhStRlnFD
gbo5qEu+bkIzVJ2Ybx/hXDqz40MATbqRq0ddBb+sCra6PUyNe1Ub5T/75Ypbq2Uu
5RgWj5R9e9OI6RQpwKGi+jOEd7OYNZwqi7wN8uiDLW5o+wAHL54=
=qsDL
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
