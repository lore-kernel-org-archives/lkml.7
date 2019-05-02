Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3AAC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 18:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 383B4205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 18:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfEBSJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 14:09:57 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:60715 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfEBSJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 14:09:56 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id ACD61240005;
        Thu,  2 May 2019 18:09:53 +0000 (UTC)
Date:   Thu, 2 May 2019 20:09:52 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Pablo Greco <pgreco@centosproject.org>
Cc:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/5] ARM: dts: sun8i: v40 Rewrite BPi M2 Berry DTS
 based on BPi M2 Ultra
Message-ID: <20190502180952.vsnccuoefnbzddu7@flea>
References: <1556804030-25291-1-git-send-email-pgreco@centosproject.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="slwwbo4od3ptjqjp"
Content-Disposition: inline
In-Reply-To: <1556804030-25291-1-git-send-email-pgreco@centosproject.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--slwwbo4od3ptjqjp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 02, 2019 at 10:33:44AM -0300, Pablo Greco wrote:
> BPi M2 Berry is a trimmed down version of the BPi M2 Ultra, completely
> software compatible.

Queued all for 5.3, thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--slwwbo4od3ptjqjp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXMsyaAAKCRDj7w1vZxhR
xX09AP0WVJEEWFiWEqNzh0Os9U6AfuUj64vmMokvrL7gb92eggD6AxtREGX3bitW
fe0PKVusH6CQI0mnJijOubZyWQpYjAA=
=nFqn
-----END PGP SIGNATURE-----

--slwwbo4od3ptjqjp--
