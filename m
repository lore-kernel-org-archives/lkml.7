Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE0BC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA99F2189F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbfGXQkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 12:40:11 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34202 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbfGXQkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 12:40:11 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: alyssa)
        with ESMTPSA id 09C9B284CF8
Date:   Wed, 24 Jul 2019 09:40:04 -0700
From:   Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Steven Price <steven.price@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: Re: [PATCH] drm/panfrost: Export all GPU feature registers
Message-ID: <20190724164004.GA8255@kevin>
References: <20190724105626.53552-1-steven.price@arm.com>
 <CAL_JsqLkxKe=feVQDb3VXqOnA7fvDBEKWgLf2suOHhNLnR704Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <CAL_JsqLkxKe=feVQDb3VXqOnA7fvDBEKWgLf2suOHhNLnR704Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This is definitely helpful!

My one concern is, supposing userspace really does need all of this
information, is it wasteful to have to do 30+ ioctls just to get this?
kbase had a single ioctl to grab all of the properties, whether
userspace wanted them or not. I'm not sure if that's better -- the two
approaches are rather polar opposites.

Granted this would be on driver init so not a critical path.

On Wed, Jul 24, 2019 at 10:27:03AM -0600, Rob Herring wrote:
> Adding Alyssa's Collabora email.
>=20
> On Wed, Jul 24, 2019 at 4:56 AM Steven Price <steven.price@arm.com> wrote:
> >
> > Midgard/Bifrost GPUs have a bunch of feature registers providing details
> > of what the hardware supports. Panfrost already reads these, this patch
> > exports them all to user space so that the jobs created by the user spa=
ce
> > driver can be tuned for the particular hardware implementation.
> >
> > Signed-off-by: Steven Price <steven.price@arm.com>
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_device.h |  1 +
> >  drivers/gpu/drm/panfrost/panfrost_drv.c    | 38 +++++++++++++++++++--
> >  drivers/gpu/drm/panfrost/panfrost_gpu.c    |  2 ++
> >  include/uapi/drm/panfrost_drm.h            | 39 ++++++++++++++++++++++
> >  4 files changed, 77 insertions(+), 3 deletions(-)
>=20
> LGTM. I'll give it a bit more time to see if there are any comments
> before I apply it.
>=20
> Rob

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ17gm7CvANAdqvY4/v5QWgr1WA0FAl04id4ACgkQ/v5QWgr1
WA0lzRAAi1aJutAUzh1Pr9kmsSkjB1v5aMpdDQPOT7W/hfgODztRyqINqZNWuItB
Mmt45PyXLcFV+S+ZT7rzYtwRlm9HOL+N5iXakC8UgfqlF3lCYmosrAJHNjb3Czmk
aJ0WAyXZOHpmDQI6p0ATa5H8sNJGy31UbtHVYfT7WO55XW2VH/F+f9nIoOJMA/SF
L3ktWjzTg7PNBqSIPde/2xy2czZTXHyMwQV4aP8U7U/V0OViYxhXyO6Nyuy9XBsW
OpO1Q6Ka+DO6o/rEAwWREFOfI/NI4ISeyJhW60gBT2uq6oaLh3ohseET4oM0/EkM
BI4QcwuB1cwjfUFK7uuCdFR8KNhKRdJeE9iuw6+spU8/BUmBwsJtd6y+k2QVTfOq
oiD8ebpNoFXdLncQcVYRz85q2idD0BvhNLoslFPRs/pX/kYPax6uppmXRZ98XOEt
wN0Fg29ph8TmDS+fsyljPUd12pgEtb4EDMouJAwROGqSNqw7IjISYHaGH3oojGSt
K5+Zx8halrk78aYFh9Wv+0REtrK2bzxPv4vd4pEMnS3oHtc37qNei5WXeL1wvjMa
/L/cFSAw2cl3NN8Ex2+CKFstI1I702BOQMI0yoGCgbnFTjiWC5QpO1O4VZuFBhJg
1I6nA8xn4bOUxcrCYKiMmhylTL9BasZ9RDFQKk2ggWvayAR3/l4=
=+QFJ
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
