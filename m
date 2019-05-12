Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496F7C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 13:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 202A62173B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 13:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfELNpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 09:45:15 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:59395 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfELNpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 09:45:14 -0400
X-Originating-IP: 109.190.253.16
Received: from localhost (unknown [109.190.253.16])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 88435FF805;
        Sun, 12 May 2019 13:45:11 +0000 (UTC)
Date:   Sun, 12 May 2019 15:45:09 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH v3 0/8] Allwinner H6 Mali GPU support
Message-ID: <20190512134509.vcduqbkmnvpkbmkb@flea>
References: <20190417173031.9920-1-peron.clem@gmail.com>
 <CAJiuCccu_wfgio9wUcOCP0o4XPRgQOvTOZS8St7mV88TAdwaRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rdm3gipkowzevz6z"
Content-Disposition: inline
In-Reply-To: <CAJiuCccu_wfgio9wUcOCP0o4XPRgQOvTOZS8St7mV88TAdwaRg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rdm3gipkowzevz6z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 11, 2019 at 06:39:39PM +0200, Cl=E9ment P=E9ron wrote:
> Hi Maxime,
>
> Is this series ok for you ?

I'm not the maintainer of that binding, so I'd need a ack from whoever
that is.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--rdm3gipkowzevz6z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXNgjZQAKCRDj7w1vZxhR
xYZsAQD5+ls2Dl1d2OZDihJtXIvSzrlA2EwW9o3twORAyHJbmgD/bGqu28VMWFpf
Dp9xKj1AiGUCNUe2O3d0X2/FGXNE3wQ=
=Uxq2
-----END PGP SIGNATURE-----

--rdm3gipkowzevz6z--
