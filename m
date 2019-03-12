Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA96C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56CB5206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfCLRhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:37:20 -0400
Received: from anholt.net ([50.246.234.109]:43892 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728719AbfCLRhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:37:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 44E4810A0640;
        Tue, 12 Mar 2019 10:37:17 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id qK_m3o_Jtye2; Tue, 12 Mar 2019 10:37:15 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 807C310A2E69;
        Tue, 12 Mar 2019 10:37:10 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id BD2822FE4653; Tue, 12 Mar 2019 10:37:09 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Rob Herring <robh@kernel.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        david.emett@broadcom.com, thomas.spurden@broadcom.com
Subject: Re: [PATCH 1/4] drm: Add helpers for locking an array of BO reservations.
In-Reply-To: <CAL_JsqL-16kyPiWSC=pEC+JLeeJaDBJahnXqOW3Wni5CJcACsQ@mail.gmail.com>
References: <20190308161716.2466-1-eric@anholt.net> <20190308161716.2466-2-eric@anholt.net> <CAL_JsqL-16kyPiWSC=pEC+JLeeJaDBJahnXqOW3Wni5CJcACsQ@mail.gmail.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Tue, 12 Mar 2019 10:37:09 -0700
Message-ID: <8736nsm1tm.fsf@anholt.net>
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
>
> FWIW,
>
> Acked-by: Rob Herring <robh@kernel.org>

Was this just for this one patch, or the series?  I don't think I can
merge without a consumer.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlyH7kUACgkQtdYpNtH8
nugR9w/9E/LA+up/0FHhnmGLF2eXnjtwvUTcbSZ9OW331vUIWs9DBMsKTBiywBxd
ffsX8Hcguyg/NZDJieCVJ+Nizww/WEz5J0dsr2/eW8oz7G6xBOWW+gYdwvwmcRtb
c/62mPkzeQQV0rXkFvDZrr0yElU+D97QEv3IqLNUAnLwitzh8FXiJkSigiiawUGA
UYnjjMs77JSou2xLI2h/mei+XCoQcTm9FaRiR1x8RsGCieIR8d4VAVA+nAvqFWUN
qd2i68DHzi83aoTqcU5N1MooxJn8JcaJrQN3kRnXiHitzSnNxtZibn9xU0BVPtjB
OwqY1T4KjMMtkuiO6iE9atFGSgRCkeptqL9II3BYbsaOBY+curdTgBtubCjgkxrd
OzFI4APbhfX4ZHj7k1P0rslmuW9bJmRgK2ir9VAYVFI/hKgLod8GL6GbMCwe80SD
CagHjn/FlRPYs5bxriuoU+wOcE6AbliI1j8g3bBMdLKaL6qc9rNPKsPYhNYuJ+3b
Xcnb+wW1Paj7aRc4IAnf6mPy9GWl7aAyXpSIG3Ucvq+vEkvUpwpzpTjDHgkOmAah
9po07mZ7zA306qoaeJU0iEXhHyLtVqgR2GnFKUfGkZwIIXNm/LzojmXA/JrVqIaF
Xp813Ne4+QenRWumt6lVzlQkiPpW29XxygWMFGWPMxLkixJ2UYY=
=njRu
-----END PGP SIGNATURE-----
--=-=-=--
