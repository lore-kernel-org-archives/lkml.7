Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A61C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238F520825
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfDOHwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 03:52:05 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:56471 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfDOHwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 03:52:05 -0400
Received: from localhost (aaubervilliers-681-1-63-121.w90-88.abo.wanadoo.fr [90.88.18.121])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 70CFB100016;
        Mon, 15 Apr 2019 07:52:02 +0000 (UTC)
Date:   Mon, 15 Apr 2019 09:52:02 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Pablo Greco <pgreco@centosproject.org>
Cc:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] ARM: dts: sun8i: v40: bananapi-m2-berry: Sort
 device node dereferences.
Message-ID: <20190415075202.33bfyrvtfkmwv6xt@flea>
References: <1555065186-8154-1-git-send-email-pgreco@centosproject.org>
 <1555065186-8154-2-git-send-email-pgreco@centosproject.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fsgyyzmxo4azs4z2"
Content-Disposition: inline
In-Reply-To: <1555065186-8154-2-git-send-email-pgreco@centosproject.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fsgyyzmxo4azs4z2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 12, 2019 at 07:33:00AM -0300, Pablo Greco wrote:
> The device node dereferences are out of order, sort them.
>
> Signed-off-by: Pablo Greco <pgreco@centosproject.org>

Applied, thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--fsgyyzmxo4azs4z2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXLQ4IQAKCRDj7w1vZxhR
xZ+kAP9Ax2kxGsQoW02gbWsXHXOVKOBT146LmgtcuBB/siusRAD+NdVaV1Wm4W/Z
5msr5E7GKFR+H+71PzGfjkTyaOLlGgs=
=Gh5G
-----END PGP SIGNATURE-----

--fsgyyzmxo4azs4z2--
