Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30A7C4CEC8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 18:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819F321479
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 18:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389321AbfIMSRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 14:17:38 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58856 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389005AbfIMSRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 14:17:37 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: alyssa)
        with ESMTPSA id ED22D289F25
Date:   Fri, 13 Sep 2019 14:17:29 -0400
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
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [PATCH] arm64: dts: mt8183: Add node for the Mali GPU
Message-ID: <20190913181729.GB3115@kevin>
References: <20190905081546.42716-1-drinkcat@chromium.org>
 <CAL_JsqJCO2G90TTT9Mpy4kjVKQyXWw4aXEEnbRp_SE8X=EGc5g@mail.gmail.com>
 <CANMq1KCTPdFhJG1SLf-i+-557Yx-1WLzWCHu3tT_5Q2BF+JgdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
In-Reply-To: <CANMq1KCTPdFhJG1SLf-i+-557Yx-1WLzWCHu3tT_5Q2BF+JgdQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > > The binding we use with out-of-tree Mali drivers includes more
> > > clocks, I assume this would be required eventually if we have an
> > > in-tree driver:
> >
> > We have an in-tree driver...
>=20
> Right but AFAICT it does not support Bifrost GPU (yet?).

By the time MT8183 shows up in more concrete devices, it will, certainly
in kernel-space and likely in userspace as well. At present, the DDK can
be modified to run on top of the in-tree Mali drivers, i.e. "Bifrost on
mainline linux-next (+ page table/compatible patches), with blob
userspace".

While the open userspace isn't ready here quite yet, I would definitely
encourage upstream kernel for ChromeOS, since then there's no need to
maintain the out-of-tree GPU driver.

---

More immediately, per Rob's review, it's important that the bindings
accepted upstream work with the in-tree Bifrost driver. Conceptually,
once Mesa supports Bifrost, if I install Debian on a MT8183 board,
everything should just work. I shouldn't need MT-specific changes / need
to change names for the DT. Regardless of which kernel driver you end up
using, minimally sharing the DT is good for everyone :-)

-Alyssa

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ17gm7CvANAdqvY4/v5QWgr1WA0FAl173TQACgkQ/v5QWgr1
WA2KFBAAnQIHm2aIeWt2mYq9onM7XNfSCCxZzYCsLXaE1LiylCZdcDanV4VaF+B3
f+jIbfoeoHcnqlhNYRNiI93L0dl3YdmKHBJsPkxNg+ziQu/alZQbsYFNB07LBsuk
2dxKissYufkSfdcc4UFEBDYq6LQlLF0XmXr5G7oNazC29e73h6Jpn8lrIlKrKo+v
5SE/KJs7ua1sfKkj6As8LOh2VFqCv+NZ7XPjI+qUQDoSfXgoO2DTsLu79lhInxRr
pdC8YKeypMlEGRuDgXt9Ee1zi0lk0OroJ+9uELf1G67V/JlpSOOI1go00HhC4Tll
I8LeczfwD2ujVnJ1kpENyQAmqEY/b6lNPIQJm0MvLFh59Hk9hjl8j1WlH9+yKMNH
rcZK1/SYeo97URXmKbfYFiwnRLXsX3p7wXjC6vtiw0xa7AcgdsfU+su4uUp8uq3V
6xCVdnowzNVjYBt8OZbOV5QWXTp0peb9VRIdCjHnrtgb55eYoQDV7Mh69Q5oG8MB
GZoD72p8ks3LI9BrTJ2QFjEsbWYj9XpvXI7AGL7YcR99QyF9hmgQF0h8Xnwz4nwD
8oYGMbECAYUT7gVNHCU9lbFkmvsgMCSTvLfMNO5nwarwgF5y8LsQITo9Bf2tLyQ/
nu3S6fy0qmIcLnwbiMG7urG8a81EtGUNJb8JBd4SLmKQAkA4NWo=
=H0a9
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
