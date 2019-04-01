Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A48AC4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80EF214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732288AbfDAIUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:20:21 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:33637 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732244AbfDAIUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:20:07 -0400
X-Originating-IP: 90.88.32.136
Received: from localhost (aaubervilliers-681-1-91-136.w90-88.abo.wanadoo.fr [90.88.32.136])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id E56EDFF814;
        Mon,  1 Apr 2019 08:20:04 +0000 (UTC)
Date:   Mon, 1 Apr 2019 10:20:04 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     megous@megous.com
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ARM: dts: sun8i: a83t: Add missing cooling device
 properties for CPUs
Message-ID: <20190401082004.kulhr3r6nskidycg@flea>
References: <20190328113159.9668-1-megous@megous.com>
 <20190328113159.9668-2-megous@megous.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="epc7aefphqiuf7xg"
Content-Disposition: inline
In-Reply-To: <20190328113159.9668-2-megous@megous.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--epc7aefphqiuf7xg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 28, 2019 at 12:31:58PM +0100, megous@megous.com wrote:
> From: Ondrej Jirman <megous@megous.com>
>
> Enable to use CPUs as cooling device in the future, by adding
> "#cooling-cells" to each CPU node. This property should be present for
> all the CPUs of a cluster. If these are present only for a subset of
> CPUs of a cluster then things will start falling apart as soon as the
> CPUs are brought online in a different order. For example, this will
> happen because the operating system looks for such properties in the CPU
> node it is trying to bring up, so that it can register a cooling device.
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>

Applied, thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--epc7aefphqiuf7xg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXKHJtAAKCRDj7w1vZxhR
xWuZAP9Hp2GuWULF0JM1kpGZOm1umGq2Zyoz/j/0KxYpgbdjzgD8CCqqkeLyMces
Hcil/gwx5eUE2Wsp/Tf/5HYJzWxX5Qc=
=f6ck
-----END PGP SIGNATURE-----

--epc7aefphqiuf7xg--
