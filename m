Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018B4C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF0820883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbfDAOb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 10:31:58 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:53595 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbfDAOb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 10:31:58 -0400
X-Originating-IP: 90.88.32.136
Received: from localhost (aaubervilliers-681-1-91-136.w90-88.abo.wanadoo.fr [90.88.32.136])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 9734AFF821;
        Mon,  1 Apr 2019 14:31:55 +0000 (UTC)
Date:   Mon, 1 Apr 2019 16:31:55 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     megous@megous.com
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] ARM: dts: sun8i: a83t: Add missing CPU clock
 references
Message-ID: <20190401143155.ve2v5anx3q356wtj@flea>
References: <20190401133610.17916-1-megous@megous.com>
 <20190401133610.17916-2-megous@megous.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jnchzzrdnhnzjjug"
Content-Disposition: inline
In-Reply-To: <20190401133610.17916-2-megous@megous.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jnchzzrdnhnzjjug
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 01, 2019 at 03:36:10PM +0200, megous@megous.com wrote:
> From: Ondrej Jirman <megous@megous.com>
>
> A83T DTSI has cpu clocks defined only on the first CPU in each cluster.
> We can bring down any CPU in the cluster, so we need to define clock
> for each CPU, so that the system knows what clock to use if the first
> CPU is down.
>
> Also move the clocks property below the compatible on cpus where it is
> already defined. Property "clock-names" is not needed.
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>

Applied, thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--jnchzzrdnhnzjjug
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXKIg2gAKCRDj7w1vZxhR
xVvvAP466zK/os4fPZy/9uxLxF2Xk8YAczLyrzMIDnSKOMdCKAEA9NXfyydnSyKt
jbud02qfGuepMZh6Iepg4OiEc6mhxwU=
=IrqA
-----END PGP SIGNATURE-----

--jnchzzrdnhnzjjug--
