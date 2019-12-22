Return-Path: <SRS0=7h0X=2M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD064C3F68F
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 13:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76BAE21655
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 13:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577020377;
	bh=7fo1Bsez53qvaIMcnnp2p8h4Fw2pDtHMMLmgtCx+WjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GMwaI1UunER0Rskc7ceYxwUfD+4vLFAHmaVYWT/tCxmpIFcKDUfD1iVhDtQVGItNR
	 Vm/mXEJxXx1ppAd1+wXpAyV1UXBJwnqwxt8lyhgpstbJW4fRYhXzTRSV/Tq4pBM8Az
	 GL256R3U2JHIQvTJa9171oAlrmMKoRk2ccxt9CX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfLVNM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 08:12:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:47986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbfLVNM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 08:12:56 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC48C2067C;
        Sun, 22 Dec 2019 13:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577020375;
        bh=7fo1Bsez53qvaIMcnnp2p8h4Fw2pDtHMMLmgtCx+WjE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O6NmTRWamrm8T248gsebwRoVAUQ4JGuFBFiY2kHQlWxmaJl5qGcz5/BicZryms7QH
         2DmFNJc20vV/EBi2z5ekGq5N9NnmAJr1jHC5iBNvWcPoFuJA1zNqsiuQZ38tI2bF84
         rW1dEo6GWyIMR/+uu1+SFDuH5YxfxV8tHq86AD8w=
Date:   Sun, 22 Dec 2019 14:12:52 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, heiko@sntech.de,
        sam@ravnborg.org, icenowy@aosc.io,
        laurent.pinchart@ideasonboard.com, gregkh@linuxfoundation.org,
        Jonathan.Cameron@huawei.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: regulator: add document bindings for
 mpq7920
Message-ID: <20191222131252.ajrat2kxcyvozzia@gilmour.lan>
References: <20191221234029.7796-1-sravanhome@gmail.com>
 <20191221234029.7796-3-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="q43gh6v3wj5ad5fi"
Content-Disposition: inline
In-Reply-To: <20191221234029.7796-3-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--q43gh6v3wj5ad5fi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 22, 2019 at 12:40:27AM +0100, Saravanan Sekar wrote:
> Add device tree binding information for mpq7920 regulator driver.
> Example bindings for mpq7920 are added.
>
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  .../bindings/regulator/mpq7920.yaml           | 135 ++++++++++++++++++
>  1 file changed, 135 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mpq7920.yaml
>
> diff --git a/Documentation/devicetree/bindings/regulator/mpq7920.yaml b/Documentation/devicetree/bindings/regulator/mpq7920.yaml
> new file mode 100644
> index 000000000000..a60d3ef04c05
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/mpq7920.yaml
> @@ -0,0 +1,135 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/mpq7920.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Monolithic Power System MPQ7920 PMIC
> +
> +maintainers:
> +  - Saravanan Sekar <sravanhome@gmail.com>
> +
> +properties:
> +  $nodename:
> +    pattern: "mpq@[0-9a-f]{1,2}"

This is still not a valid node name

> +  compatible:
> +    enum:
> +	- mps,mpq7920
> +
> +  reg:
> +    maxItems: 1
> +
> +  regulators:
> +    type: object
> +    description: |
> +      list of regulators provided by this controller, must be named
> +      after their hardware counterparts BUCK[1-4], one LDORTC, and LDO[2-5]
> +      The valid names for regulators are
> +      buck1, buck2, buck3, buck4, ldortc, ldo2, ldo3, ldo4, ldo5

These should be validated.

> +  properties:

If it's properties under the regulators node, it should be at one more
indentation level.

> +       mps,time-slot:

This should have an allOf here

> +         - $ref: "/schemas/types.yaml#/definitions/uint8"
> +         - enum: [ 0, 1, 2, 3 ]
> +         - default: 0
> +       description: |
> +         each regulator output shall be delayed during power on/off sequence which
> +         based on configurable time slot value, must be one of following corresponding
> +         value 0.5ms, 2ms, 8ms, 16ms

And this should be under the property, not at the same level.

Did you run dt_bindings_check?

Maxime

--q43gh6v3wj5ad5fi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXf9r1AAKCRDj7w1vZxhR
xdfAAP9LE45bHHScx2Iw015hPBYVCLIwpqkV7lG2MenTX2mDWAEArKgGeyv9CeSj
BlqZDlA5FtX5YfPaFGRnSu0wTnoNYAs=
=y9bw
-----END PGP SIGNATURE-----

--q43gh6v3wj5ad5fi--
