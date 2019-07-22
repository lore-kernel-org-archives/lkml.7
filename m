Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95D8C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 10:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDBE8214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 10:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbfGVKB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 06:01:29 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:47789 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfGVKB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 06:01:28 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 68EB86000A;
        Mon, 22 Jul 2019 10:01:26 +0000 (UTC)
Date:   Mon, 22 Jul 2019 12:01:25 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jan Kotas <jank@cadence.com>
Cc:     mchehab@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        rafalc@cadence.com, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] media: Add support for Cadence CSI2TX version 2.1
Message-ID: <20190722100125.y4ojf3quqopktncf@flea>
References: <20190722082223.18693-1-jank@cadence.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dgdhrvv3ycjgpmmt"
Content-Disposition: inline
In-Reply-To: <20190722082223.18693-1-jank@cadence.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dgdhrvv3ycjgpmmt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 22, 2019 at 09:22:19AM +0100, Jan Kotas wrote:
> This patchset adds support for Cadence CSI2TX controller version 2.1.
> Existing compatibility with v1.3 is updated and maintained.
>

For the whole series

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--dgdhrvv3ycjgpmmt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXTWJdQAKCRDj7w1vZxhR
xStlAQCn41vU+G6UpwEkOdIzsntf4crx4vpr3XFje6b3E/gn+AEAyOChzbyIRden
akf239VnjvsQn3AU1/GEpWsF9jCc2wE=
=YpCh
-----END PGP SIGNATURE-----

--dgdhrvv3ycjgpmmt--
