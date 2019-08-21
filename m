Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B9FC3A5A0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 08:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A78992339F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 08:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfHUIWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 04:22:41 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:56395 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfHUIWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 04:22:41 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 628481BF206;
        Wed, 21 Aug 2019 08:22:39 +0000 (UTC)
Date:   Wed, 21 Aug 2019 09:31:54 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Heiko Stuebner <heiko@sntech.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] dt-bindings: Convert Arm Mali GPUs to DT schema
Message-ID: <20190821073154.jnqv4sysoyorv7vo@flea>
References: <20190820195959.6126-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ye7watdg3ithuyxt"
Content-Disposition: inline
In-Reply-To: <20190820195959.6126-1-robh@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ye7watdg3ithuyxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Rob,

On Tue, Aug 20, 2019 at 02:59:56PM -0500, Rob Herring wrote:
> This series converts the various Arm Mali GPU bindings to use the DT
> schema format.
>
> The Midgard and Bifrost bindings generate warnings on 'interrupt-names'
> because there's all different ordering. The Utgard binding generates
> warnings on Rockchip platforms because 'clock-names' order is reversed.

Thank for taking care of that one, it was on my radar but I didn't
really want to actually do it :)

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ye7watdg3ithuyxt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXVzzagAKCRDj7w1vZxhR
xeOoAP0fDHwGDG+Pp7I7jUWueHcugddYVgoBEitC7+EXWXCGywD/cyBgtgtPE19N
g0eZSCfigQtpIBBde4Gqm9+94pYLnwI=
=UmRS
-----END PGP SIGNATURE-----

--ye7watdg3ithuyxt--
