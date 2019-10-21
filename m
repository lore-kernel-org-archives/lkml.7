Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6587ACA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 11:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C47820B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 11:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571656115;
	bh=tBYGme/3FWzm/ih6xspHcVw+dNmojtv6QL8gPcuU85U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aaToM2g6LZfLQv/VJIo9A7RdiQf84ts7TG8zUyKiArAhEmi+7HAHDgwMoNmQccnAB
	 bTnDknH8tKggD4Z6OVt6OoW2wp4V0WpUowB2zbUCsBg+GA+0mlW+sLYWH00p3OnmPV
	 HVMO9MCjAOM91B4xXnmO9tfJIkY3XwZVIblA0gyI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbfJULIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 07:08:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727433AbfJULId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 07:08:33 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7BEF206C2;
        Mon, 21 Oct 2019 11:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571656113;
        bh=tBYGme/3FWzm/ih6xspHcVw+dNmojtv6QL8gPcuU85U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=noXYuhgt63hGzvfq+0yDhuJIIJuOJGuJCtc1uk6QM3wFsLHmp6Hzb7cuu47Mlkx1S
         R1Ki2UTzEUlaHXqCO9R+VpFc/ZT0DR1QVqRh1KZLTLguIqySKkkF3PbOvW/OfglIep
         1qtIvZNMbkvvBNOZxxdXbzJDWuJtcJshi9w/oXB8=
Date:   Mon, 21 Oct 2019 13:08:30 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     megous@megous.com
Cc:     linux-sunxi@googlegroups.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/4] phy: allwinner: add phy driver for USB3 PHY on
 Allwinner H6 SoC
Message-ID: <20191021110830.74m4ys7mvztb4nqs@gilmour>
References: <20191020134229.1216351-1-megous@megous.com>
 <20191020134229.1216351-3-megous@megous.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wkap5bf7ph4ddhpj"
Content-Disposition: inline
In-Reply-To: <20191020134229.1216351-3-megous@megous.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wkap5bf7ph4ddhpj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Oct 20, 2019 at 03:42:27PM +0200, megous@megous.com wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
>
> Allwinner H6 SoC contains a USB3 PHY (with USB2 DP/DM lines also
> controlled).
>
> Add a driver for it.
>
> The register operations in this driver is mainly extracted from the BSP
> USB3 driver.
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--wkap5bf7ph4ddhpj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXa2RrgAKCRDj7w1vZxhR
xUVEAP0UwD5i2m60iQ3FP1B5X7mKnqw6PlzwMDnX4NC+gEbFrQD9Fbgi5TtiREt4
HRfbtIC6fTm7SkAMo6JU0iYU/DEpTQw=
=SIZy
-----END PGP SIGNATURE-----

--wkap5bf7ph4ddhpj--
