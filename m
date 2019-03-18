Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BB0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA6A52070D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfCRImS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 04:42:18 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:33267 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbfCRImS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 04:42:18 -0400
Received: from localhost (aaubervilliers-681-1-80-102.w90-88.abo.wanadoo.fr [90.88.22.102])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id E851624000F;
        Mon, 18 Mar 2019 08:42:12 +0000 (UTC)
Date:   Mon, 18 Mar 2019 09:42:12 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] nvmem: sunxi_sid: Read out data in native format
Message-ID: <20190318084212.lv2lorskizl65uzg@flea>
References: <20190318073354.12151-1-wens@kernel.org>
 <20190318073354.12151-5-wens@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pby5l7iw3zraifpt"
Content-Disposition: inline
In-Reply-To: <20190318073354.12151-5-wens@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pby5l7iw3zraifpt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Mon, Mar 18, 2019 at 03:33:52PM +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
>
> Originally the SID e-fuses were thought to be in big-endian format.
> Later sources show that they are in fact native or little-endian.
> The most compelling evidence is the thermal sensor calibration data,
> which is a set of one to three 16-bit values. In native-endian they
> are in 16-bit cells with increasing offsets, whereas with big-endian
> they are in the wrong order, and a gap with no data will show if there
> are one or three cells.
>
> Switch to a native endian representation for the nvmem device. For the
> H3, the register read-out method was already returning data in native
> endian. This only affects the other SoCs.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

I thought only the newer SoCs were impacted by this issue?

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--pby5l7iw3zraifpt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXI9Z5AAKCRDj7w1vZxhR
xag8AP47BMEXFaDn8FTHN67Db5PvozKd5J1OIkr4/NQzV5lLIQEA+3LzHeutDmpg
VTbAfwne4GqFJ4QLhJRD4BSuWRtyOgU=
=sOTk
-----END PGP SIGNATURE-----

--pby5l7iw3zraifpt--
