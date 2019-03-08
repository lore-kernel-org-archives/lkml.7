Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F099C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FAB120449
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfCHRq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 12:46:29 -0500
Received: from anholt.net ([50.246.234.109]:53318 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbfCHRq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 12:46:29 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 5DFD810A2E2B;
        Fri,  8 Mar 2019 09:46:28 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id nUhpFZ7WvNjT; Fri,  8 Mar 2019 09:46:27 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id EE72410A2BEE;
        Fri,  8 Mar 2019 09:46:26 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 8FACC2FE4653; Fri,  8 Mar 2019 09:46:26 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Rob Herring <robh@kernel.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        david.emett@broadcom.com, thomas.spurden@broadcom.com
Subject: Re: [PATCH 1/4] drm: Add helpers for locking an array of BO reservations.
In-Reply-To: <CAL_JsqL-16kyPiWSC=pEC+JLeeJaDBJahnXqOW3Wni5CJcACsQ@mail.gmail.com>
References: <20190308161716.2466-1-eric@anholt.net> <20190308161716.2466-2-eric@anholt.net> <CAL_JsqL-16kyPiWSC=pEC+JLeeJaDBJahnXqOW3Wni5CJcACsQ@mail.gmail.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Fri, 08 Mar 2019 09:46:24 -0800
Message-ID: <87a7i59s3z.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Rob Herring <robh@kernel.org> writes:

> On Fri, Mar 8, 2019 at 10:17 AM Eric Anholt <eric@anholt.net> wrote:
>>
>> Now that we have the reservation object in the GEM object, it's easy
>> to provide a helper for this common case.  Noticed while reviewing
>> panfrost and lima drivers.  This particular version came out of v3d,
>> which in turn was a copy from vc4.
>>
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> ---
>>  drivers/gpu/drm/drm_gem.c | 76 +++++++++++++++++++++++++++++++++++++++
>>  include/drm/drm_gem.h     |  4 +++
>>  2 files changed, 80 insertions(+)
>
> Sweet! I was about to go write this same patch. You are changing the
> license from GPL to MIT copying the v3d version, but I guess you have
> rights to do that.

The original vc4 copy I had was MIT, anyway.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlyCqnEACgkQtdYpNtH8
nuh8RQ/9FM2usVyLXi1z96eXeRIaYiVrT73/M81oaqVNN8h9o6lxQsVH4BHT1OIA
knvWiW80vK8iespeRfAqBV16Gt1+mdmY0MCpCf683XAfwmAD8h6Q14G2RHMVNZmh
S3YApe66AUPzKt22IG2c8gZ86soZ74IJA/VJ367XT4JyHni3PCWrV3+qg4W/pAA9
/GrmlRnpo6xop9ESPtp4vhAFmtK8vCr7hx4nnHt9tRoG6xckVMnnziZHINU+Em56
y1XBt1kfarI5icUuwDfyW993vc3BMKhWoarl8qhoixyJDsh6cIimVw7wnxZ0fRcM
LR4vl1Gcbx95cPXP7/l6zBrrcAH4/tmGqIytZ975jkq93JmmyQgVriyeCoHDEspv
Hr96IV0vMDtYf84dpkEsVt1fQOVv8zGRYUTQVdS81NEncyaFi6kKTWy1dJqIc8R2
MOsHeN6aAUnfEIkZCnvbkk6eQPBd9vT09kUruNxjIgHmroSUwP++rYjugr5J6IWL
lQw8LQ0bTk6rBPa4IY+4kfFihLap0h7KhA1XWFABVVv6LJgREA8yskBKY0T/NX9U
nPLCZKVJRpy2Jj74FG990YauadNUvssuVuUrwvQkfDUpO6788T1ZCEYhS71WnWIQ
VTyraSurf20j+QtI6Jz6tPpJ/SNLF5tPMnzwKOa/69wdbhGFWh0=
=h25V
-----END PGP SIGNATURE-----
--=-=-=--
