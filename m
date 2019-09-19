Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4873DC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 12:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2458621848
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 12:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732099AbfISMc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 08:32:56 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39878 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727980AbfISMc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 08:32:56 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: alyssa)
        with ESMTPSA id B8C1C28E946
Date:   Thu, 19 Sep 2019 08:32:43 -0400
From:   Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nick Fan <nick.fan@mediatek.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Dominik Behr <dbehr@chromium.org>,
        Steven Price <steven.price@arm.com>
Subject: Re: [PATCH] arm64: dts: mt8183: Add node for the Mali GPU
Message-ID: <20190919123243.GA3457@kevin>
References: <20190905081546.42716-1-drinkcat@chromium.org>
 <CAL_JsqJCO2G90TTT9Mpy4kjVKQyXWw4aXEEnbRp_SE8X=EGc5g@mail.gmail.com>
 <CANMq1KCTPdFhJG1SLf-i+-557Yx-1WLzWCHu3tT_5Q2BF+JgdQ@mail.gmail.com>
 <20190913181729.GB3115@kevin>
 <CANMq1KD++==d0Mb6T2gKU1T7c_MaedswOYdxqEqEKKUL1bxgiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <CANMq1KD++==d0Mb6T2gKU1T7c_MaedswOYdxqEqEKKUL1bxgiw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > By the time MT8183 shows up in more concrete devices, it will, certainly
> > in kernel-space and likely in userspace as well. At present, the DDK can
> > be modified to run on top of the in-tree Mali drivers, i.e. "Bifrost on
> > mainline linux-next (+ page table/compatible patches), with blob
> > userspace".
> >
> > While the open userspace isn't ready here quite yet, I would definitely
> > encourage upstream kernel for ChromeOS, since then there's no need to
> > maintain the out-of-tree GPU driver.
>=20
> That's an interesting idea, I had no idea, thanks for the info!
>=20
> Would that work with midgard as well? We have released hardware with
> RK3288/3399, so it might be nice to experiment with these first.

Yes, the above would work with Midgard as well with no changes needed.
Ping Steven about thtat (CC'd).

> > More immediately, per Rob's review, it's important that the bindings
> > accepted upstream work with the in-tree Bifrost driver. Conceptually,
> > once Mesa supports Bifrost, if I install Debian on a MT8183 board,
> > everything should just work. I shouldn't need MT-specific changes / need
> > to change names for the DT. Regardless of which kernel driver you end up
> > using, minimally sharing the DT is good for everyone :-)
>=20
> Yes. I'll try to dig further with MTK, but this may take some time.

Thank you!

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ17gm7CvANAdqvY4/v5QWgr1WA0FAl2DdWcACgkQ/v5QWgr1
WA1hxw//TRYFfG359ycsk4qVwveSnK9GFoKgfPx0UD6KVttjcVebh10JgmvhdS6P
MIUe3X2Z55xOliZtP/J8aRTI+GcqodYOm+2NXit9Qrs9ME3wH1PribyPOanVdDeY
LyVOiz2hKFiXgIQ+Tc3IwbKF8fG/9J1SCuBCPF7WhxWPPCq/M8l9nfis2BptnMri
e/qXnFjFULKgZqr2PT/iAE4FwqqRwazg3zZrknP+pVyluXKYm2yjVN9wpjG9PD+/
rxjgLJF8q+YmhTnVsN17bs5/lM0I1DPAMPaQqcDgYXt2BDpqqX1iImmxvLhWo2Gd
cJ9uLExJvgwlpwGAv/q5S6UDJb6Svm2Hj9vqhE4gc0nRldJ+z61CnoSZZxohSOLP
c37VB3DCoy2Nq3AYL2RWWESL1e7fmrFvhfXAn+vUguvufzv6khm/ymkV/Fv3sCIf
pScO4+/WtjsjPVCUJhqE/sJmQAZSGJl3JntNPjW/Wcx/RytrfduL7/xDm36jtC5u
zMTPdW9gZlS6ljNBVpErL1sq40MLM3aH8uUaeiOZmq+/P8zDYYBPgxAPPQ+oa0Ai
y3uXXGb80thBw3uCZQlYmfeo5pfGb8opGmvEGejJWy05CC/jZIdDvq7vm0Cw9r0Y
FniCzNzidydYsTv2Hg6rPNSGHAfh2ZzJq9nSRKhUa4HpZEOK0SY=
=V95/
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
