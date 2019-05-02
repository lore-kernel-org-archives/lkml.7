Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EF6C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 18:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAE2A208CB
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 18:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfEBSKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 14:10:33 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:47711 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfEBSKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 14:10:33 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 0A753200006;
        Thu,  2 May 2019 18:10:29 +0000 (UTC)
Date:   Thu, 2 May 2019 20:10:29 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: h6: add PIO VCC bank supplies for
 Pine H64
Message-ID: <20190502181029.dy4bu2v3qdqljejs@flea>
References: <20190424062543.61852-1-icenowy@aosc.io>
 <20190502074303.g3px63n4v4o7xade@flea>
 <8CB1EDA4-E4B7-486D-8BCD-884E0025C6EA@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ogx5tjikbf2c3v7p"
Content-Disposition: inline
In-Reply-To: <8CB1EDA4-E4B7-486D-8BCD-884E0025C6EA@aosc.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ogx5tjikbf2c3v7p
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2019 at 03:46:17PM +0800, Icenowy Zheng wrote:
>
>
> =E4=BA=8E 2019=E5=B9=B45=E6=9C=882=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=883=
:43:03, Maxime Ripard <maxime.ripard@bootlin.com> =E5=86=99=E5=88=B0:
> >Hi,
> >
> >On Wed, Apr 24, 2019 at 02:25:43PM +0800, Icenowy Zheng wrote:
> >> The Allwinner H6 SoC features tweakable VCC for PC, PD, PG, PL and PM
> >> banks.
> >>
> >> This patch adds supplies for PC and PD banks on Pine H64 board. PG
> >and
> >> PM banks are used for Wi-Fi and should be added when Wi-Fi is added
> >
> >Not really. The regulator is still there, whether we use it or not. If
> >it's not used, then it will be left disabled so it doesn't really
> >change anything.
>
> Okay, I will include them in the next revision.
>
> >
> >> PL bank is where PMIC is attached, and currently if a PMIC regulator
> >> is added for it a dependency loop will happen.
> >
> >I guess we should fix that somehow
>
> But this patch is needed for eMMC to be functional again in HS200 mode, s=
o I hope
> it can get applied before this get fixed.

Yep, sure

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ogx5tjikbf2c3v7p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXMsylQAKCRDj7w1vZxhR
xeoiAP44NHYBSHTIGLN3XJxbGfAnItMHslGpuTmzgJu/MEen1AD/UKdw+42VNQ70
d3em7IPxIATxVLFG4eOlrhX6/oqsBQM=
=G4jo
-----END PGP SIGNATURE-----

--ogx5tjikbf2c3v7p--
