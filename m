Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4F7C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D52B321872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfDKM2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:28:38 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:33773 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfDKM2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 08:28:37 -0400
X-Originating-IP: 90.88.18.121
Received: from localhost (aaubervilliers-681-1-63-121.w90-88.abo.wanadoo.fr [90.88.18.121])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 76E641C0009;
        Thu, 11 Apr 2019 12:28:34 +0000 (UTC)
Date:   Thu, 11 Apr 2019 14:28:33 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     pgreco@centosproject.org
Cc:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: sun8i: v40: Update BPi M2 Berry DTS to the
 level of M2 Ultra
Message-ID: <20190411122833.c2q5shetb5yxzxaq@flea>
References: <1554983689-47305-1-git-send-email-pgreco@centosproject.org>
 <1554983689-47305-3-git-send-email-pgreco@centosproject.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eipbfyuowstngaw2"
Content-Disposition: inline
In-Reply-To: <1554983689-47305-3-git-send-email-pgreco@centosproject.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eipbfyuowstngaw2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, Apr 11, 2019 at 08:54:49AM -0300, pgreco@centosproject.org wrote:
> From: Pablo Greco <pgreco@centosproject.org>
>
> BPi M2 Berry is a trimmed down version of the BPi M2 Ultra, completely
> software compatible.
>
> Changes include:
> - 2GiB -> 1GiB
> - no eMMC
> - no onboard microphone
> - no IR
> - no blue LED
> - no charging (and power jack to USB)
> - dropped USB2 and connect USB1 to a 4-port HUB.
>
> This patch brings the BPi M2 Berry to the same level as the BPi M2 Ultra
> Includes the changes from:
> commit c36fd5a48bd2 ("ARM: dts: sun8i: r40: bananapi-m2-ultra: Enable GMAC
> ethernet controller")
> commit db49c6825901 ("ARM: dts: sun8i: r40: Enable HDMI output on BananaPi
> M2 Ultra")
> commit ccefd95f648a ("ARM: dts: sun8i: r40: Add missing TCON-TOP - TCON
> connections")
> commit 6a7556f604f9 ("ARM: dts: sun8i: r40: Disable TCONs by default.")
> commit 666907a3f9bd ("ARM: dts: sun8i: sun8i-r40-bananapi-m2-ultra: enable
> AHCI")
> commit e5c6e693be83 ("ARM: dts: sun8i: r40: bananapi-m2-ultra: Fix WiFi
> regulator definitions")
> commit 1e5f1db4ccd8 ("ARM: dts: sun8i: r40: bananapi-m2-ultra: Add
> Bluetooth device node")
>
> Signed-off-by: Pablo Greco <pgreco@centosproject.org>

Please make separate commits for each logical changes you're doing.

And there's no need to reference commits as you were doing, it's for a
separate board.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--eipbfyuowstngaw2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXK8y8QAKCRDj7w1vZxhR
xdLjAQDVBwdJqeib4kkhNEE5HYX72t8/B8K6w7WH54yj96RCDAD/T6TttygZt1rT
nkT6IsH3KGZF0GxQPXMhA1NmcYTarQM=
=oMJh
-----END PGP SIGNATURE-----

--eipbfyuowstngaw2--
