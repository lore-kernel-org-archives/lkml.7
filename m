Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F98DC2D0D0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 10:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 262DE20709
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 10:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577098155;
	bh=sqPHwr8qHyWWpux7PPLNzplN9pbdpukFtHqCYP7unLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yM5HSDTU91lk2e9MfPTRni+C0SICT/r0Um5zuOeWGGzUiicZ0yqt48GAqbLSFyp6w
	 +ikGp4N0MztHNDqmON39NghxtsJecdoXVJkkPodrC8Siy4u3ydBXsbKij6NhJJgMhn
	 LYDZk+DYIFDAkOb7ziAK/XbS0nIGBFYL7TX1OEVQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfLWKtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 05:49:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:52676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfLWKtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 05:49:14 -0500
Received: from localhost (lfbn-lyo-1-633-204.w90-119.abo.wanadoo.fr [90.119.206.204])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 968222053B;
        Mon, 23 Dec 2019 10:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577098153;
        bh=sqPHwr8qHyWWpux7PPLNzplN9pbdpukFtHqCYP7unLQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uo2/kq0uxknzr7A45/OvbAICiFOJeU9L8991PDNNLyid2FPaa4kI7xxKzifR43MLg
         PwA6E00P+6MD/lb0jgW1TyZbuvy8LOoUWeP0JDqOBlqvgFdIQ5FehnhEg4o1IGGe8+
         4vfIQGN6X77onp41cqmq6OSMqy1FIqF1159Yo7y4=
Date:   Mon, 23 Dec 2019 11:50:28 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, heiko@sntech.de,
        sam@ravnborg.org, icenowy@aosc.io,
        laurent.pinchart@ideasonboard.com, gregkh@linuxfoundation.org,
        Jonathan.Cameron@huawei.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] dt-bindings: regulator: add document bindings for
 mpq7920
Message-ID: <20191223105028.amtzf62yjdpdsfrt@hendrix.home>
References: <20191222204507.32413-1-sravanhome@gmail.com>
 <20191222204507.32413-3-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tshqfk7yxrnfce4d"
Content-Disposition: inline
In-Reply-To: <20191222204507.32413-3-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tshqfk7yxrnfce4d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 22, 2019 at 09:45:05PM +0100, Saravanan Sekar wrote:
> Add device tree binding information for mpq7920 regulator driver.
> Example bindings for mpq7920 are added.
>
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  .../bindings/regulator/mpq7920.yaml           | 143 ++++++++++++++++++
>  1 file changed, 143 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mpq7920.yaml
>
> diff --git a/Documentation/devicetree/bindings/regulator/mpq7920.yaml b/Documentation/devicetree/bindings/regulator/mpq7920.yaml
> new file mode 100644
> index 000000000000..d173ba1fb28d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/mpq7920.yaml
> @@ -0,0 +1,143 @@
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
> +    pattern: "pmic@[0-9a-f]{1,2}"
> +  compatible:
> +    enum:
> +      - mps,mpq7920
> +
> +  reg:
> +    maxItems: 1
> +
> +  mps,time-slot:
> +    description:
> +      each regulator output shall be delayed during power on/off sequence which
> +      based on configurable time slot value, must be one of following corresponding
> +      value 0.5ms, 2ms, 8ms, 16ms
> +    allOf:
> +      - $ref: "/schemas/types.yaml#/definitions/uint8"
> +      - enum: [ 0, 1, 2, 3 ]
> +      - default: 0
> +
> +  mps,fixed-on-time:
> +     description:
> +       select power on sequence with fixed time output delay mentioned in
> +       time-slot reg for all the regulators.
> +     type: boolean
> +
> +  mps,fixed-off-time:
> +     description:
> +        select power off sequence with fixed time output delay mentioned in
> +        time-slot reg for all the regulators.
> +     type: boolean

I'm not sure what this fixed-on-time and fixed-off-time property is
supposed to be doing. Why not just get rid of the time slot property,
and set the power on / power off time in fixed-on-time /
fixed-off-time property?

> +  mps,inc-off-time:
> +     description: |
> +        mutually exclusive to mps,fixed-off-time an array of 8, linearly increase
> +        output delay during power off sequence based on factor of time slot/interval
> +        for each regulator.
> +     allOf:
> +       - $ref: "/schemas/types.yaml#/definitions/uint8-array"
> +       - minimum: 0
> +       - maximum: 15
> +       - default: [ 0, 6, 0, 6, 7, 7, 7, 9 ]

You should check the size of the array too, but if it's a property of
the regulators, why not have it in the regulators node?

> +  mps,inc-on-time:
> +     description: |
> +        mutually exclusive to mps,fixed-on-time an array of 8, linearly increase
> +        output delay during power on sequence based on factor of time slot/interval
> +        for each regulator.
> +     allOf:
> +       - $ref: "/schemas/types.yaml#/definitions/uint8-array"
> +       - minimum: 0
> +       - maximum: 15
> +       - default: [ 0, 6, 0, 6, 7, 7, 7, 9 ]
> +
> +  mps,switch-freq:
> +     description: |
> +        switching frequency must be one of following corresponding value
> +        1.1MHz, 1.65MHz, 2.2MHz, 2.75MHz
> +     allOf:
> +       - $ref: "/schemas/types.yaml#/definitions/uint8"
> +       - enum: [ 0, 1, 2, 3 ]
> +       - default: 2
> +
> +  mps,buck-softstart:
> +     description: |
> +        An array of 4 contains soft start time of each buck, must be one of
> +        following corresponding values 150us, 300us, 610us, 920us
> +     allOf:
> +       - $ref: "/schemas/types.yaml#/definitions/uint8-array"
> +       - enum: [ 0, 1, 2, 3 ]
> +       - default: [ 1, 1, 1, 1 ]
> +
> +  mps,buck-ovp:
> +     description: |
> +        An array of 4 contains over voltage protection of each buck, must be
> +        one of above values
> +     allOf:
> +       - $ref: "/schemas/types.yaml#/definitions/uint8-array"
> +       - enum: [ 0, 1 ]
> +       - default: [ 1, 1, 1, 1 ]
> +
> +  mps,buck-phase-delay:
> +     description: |
> +        An array of 4 contains phase delay of each buck must be one of above values
> +        corresponding to 0deg, 90deg, 180deg, 270deg
> +     allOf:
> +       - $ref: "/schemas/types.yaml#/definitions/uint8-array"
> +       - enum: [ 0, 1, 2, 3 ]
> +       - default: [ 0, 0, 1, 1 ]
> +
> +  regulators:
> +    type: object
> +    description:
> +      list of regulators provided by this controller, must be named
> +      after their hardware counterparts BUCK[1-4], one LDORTC, and LDO[2-5]
> +      The valid names for regulators are
> +      buck1, buck2, buck3, buck4, ldortc, ldo2, ldo3, ldo4, ldo5

For the third times now, the names should be validated using
propertyNames.

Maxime
>

--tshqfk7yxrnfce4d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXgCb9AAKCRDj7w1vZxhR
xSxbAP4szHyZdRo10yVZx0kq85Ph4xNUDMaRG2CXjwDtKbQw2AEAiSouGi0i2eOE
hnHmBeq55p8mM921ov/w8SwQweKPSwI=
=X/1Z
-----END PGP SIGNATURE-----

--tshqfk7yxrnfce4d--
