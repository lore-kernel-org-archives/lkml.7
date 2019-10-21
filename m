Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06928CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 11:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB390206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 11:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571655989;
	bh=6aIiiW6Oy2Tp3jMHez2uZxsG1cbGxMZp3/IBu+pOkT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=riVH41YzYp5qQLJ6t8pdtgwF99qdvXv/LYx4G30KbsDwre83BLMH8CvYWxDZO+Bpg
	 I5dflmbAZnrbIKVEoWIghnBeqkrLL/zkWP+YVdxjGkcOcBmI+dtAgkDsKssPPxY+mz
	 PTVMcplXgWOGzx9yUVuonWTt6Q7pFUQ4LB0Vnbec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfJULGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 07:06:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:45946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727058AbfJULGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 07:06:16 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8679C2084C;
        Mon, 21 Oct 2019 11:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571655975;
        bh=6aIiiW6Oy2Tp3jMHez2uZxsG1cbGxMZp3/IBu+pOkT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SmsbcM7ob9APIInCUIWU9pFZGqvQIzlGXwhVv9ndL0rOALynmG1mW1Lk39mqHaJ+Q
         TQBh/zNq2g+4biDbSzud0mQktKJ4SKk26i2jhm9Z/4ZJi/BOWEEtnOTVilP/UQOxXA
         fAORWnAKW7DLCV5+MqTkkoIA0Rta9wHUGhHGt0Sg=
Date:   Mon, 21 Oct 2019 13:06:12 +0200
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
Subject: Re: [PATCH 1/4] dt-bindings: Add bindings for USB3 phy on Allwinner
 H6
Message-ID: <20191021110612.55ym4y3m3xko3kpc@gilmour>
References: <20191020134229.1216351-1-megous@megous.com>
 <20191020134229.1216351-2-megous@megous.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ewuc6ubrfgaw6qrn"
Content-Disposition: inline
In-Reply-To: <20191020134229.1216351-2-megous@megous.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ewuc6ubrfgaw6qrn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Oct 20, 2019 at 03:42:26PM +0200, megous@megous.com wrote:
> From: Ondrej Jirman <megous@megous.com>
>
> The new Allwinner H6 SoC contains a USB3 PHY that is wired to the
> external USB3 pins of the SoC.
>
> Add a device tree binding for the PHY.
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>  .../phy/allwinner,sun50i-h6-usb3-phy.yaml     | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/allwinner,sun50i-h6-usb3-phy.yaml
>
> diff --git a/Documentation/devicetree/bindings/phy/allwinner,sun50i-h6-usb3-phy.yaml b/Documentation/devicetree/bindings/phy/allwinner,sun50i-h6-usb3-phy.yaml
> new file mode 100644
> index 000000000000..2fdc890748db
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/allwinner,sun50i-h6-usb3-phy.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2019 Ondrej Jirman <megous@megous.com>
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/phy/allwinner,sun50i-h6-usb3-phy.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Allwinner sun50i USB3 PHY

H6 would be more appropriate here instead of sun50i. There's a bunch
of sun50i SoCs already, and only one uses it.

With that fixed,
Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--ewuc6ubrfgaw6qrn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXa2RJAAKCRDj7w1vZxhR
xR48AQDAv8g0iblut9ytzfU6bZMgT1D68v8XPkVM2Tm82RTKoAEAn/tXqAEV2OQF
ePOXBUp1QBOrzVFUJQx03BYGUacvdwI=
=O92R
-----END PGP SIGNATURE-----

--ewuc6ubrfgaw6qrn--
