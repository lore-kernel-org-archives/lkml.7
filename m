Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56BBC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F201206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfDKM3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:29:11 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:45501 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfDKM3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 08:29:11 -0400
X-Originating-IP: 90.88.18.121
Received: from localhost (aaubervilliers-681-1-63-121.w90-88.abo.wanadoo.fr [90.88.18.121])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id DBB7020006;
        Thu, 11 Apr 2019 12:29:07 +0000 (UTC)
Date:   Thu, 11 Apr 2019 14:29:06 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     pgreco@centosproject.org
Cc:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: sun8i: v40: bananapi-m2-berry: Sort device
 node dereferences.
Message-ID: <20190411122906.v6j2467grxgkyobu@flea>
References: <1554983689-47305-1-git-send-email-pgreco@centosproject.org>
 <1554983689-47305-2-git-send-email-pgreco@centosproject.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ia2tdbg2qdy6eiuq"
Content-Disposition: inline
In-Reply-To: <1554983689-47305-2-git-send-email-pgreco@centosproject.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ia2tdbg2qdy6eiuq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 11, 2019 at 08:54:48AM -0300, pgreco@centosproject.org wrote:
> From: Pablo Greco <pgreco@centosproject.org>
>
> This is the equivalent of Commit 02b301f5d18c5015a33b25d0283306ebe96fa794
> ("ARM: dts: sun8i: r40: bananapi-m2-ultra: Sort device node dereferences")

Please describe what you are doing and why instead of pointing to
another commit.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ia2tdbg2qdy6eiuq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXK8zEgAKCRDj7w1vZxhR
xZQYAQCY2Kg1BLXggBEmCZ89Z4t9eUKHKtLA9fZySbWgvvQS2AD9EiP3TIzwKAZ+
2TFE1rvJpZoP8/ZBHq0ySIi+6hyfDwo=
=hGOr
-----END PGP SIGNATURE-----

--ia2tdbg2qdy6eiuq--
