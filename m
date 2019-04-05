Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C853EC10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F7CE21902
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554477490;
	bh=oqQfrHf2pZO2yORsvkdFBH1q8/RZUyJKabxuePfQB3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g95O8PdJ1bgeXZpRHbcjcRyQh5qMHPGa3EIhbCHgOsjL6dT1eZL7/GsH+dBBOd8zW
	 XhsVwU3w6qsor/Pdp43Dp8EJkEAeYb93MCvOgCmec5VLTfxSnAW2OmREOhqMmZszv5
	 FPjUG5lKrdHuv3p4LuaQcHGsk/u22Wy6um/0qcDI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731487AbfDEPSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:18:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbfDEPSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 11:18:09 -0400
Received: from earth.universe (host-091-097-083-087.ewe-ip-backbone.de [91.97.83.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83B11218D4;
        Fri,  5 Apr 2019 15:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554477487;
        bh=oqQfrHf2pZO2yORsvkdFBH1q8/RZUyJKabxuePfQB3g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FmpZoHDiR1vOC4pMe0A6KMxn3jviex7Vt0xcC7efDawDZAKAaGyFyK0LLdxOyYK0s
         Lr4yAnpDdAo5Aw6lDiXHVZnmWDu5c0LdAMdLo4g97sRbBQkQBi8NNLR6jaBkSouCAT
         xK3/Fs2k41otY66Dcmev7rE5Nx8q4BZgaHetfEfk=
Received: by earth.universe (Postfix, from userid 1000)
        id 7EF0A3C08D5; Fri,  5 Apr 2019 17:18:05 +0200 (CEST)
Date:   Fri, 5 Apr 2019 17:18:05 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Martin Schiller <ms@dev.tdt.de>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, fkan@apm.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: reset: syscon-reboot: add a mask property
Message-ID: <20190405151805.fr3ie3q2vspljhr7@earth.universe>
References: <20190308074930.15270-1-ms@dev.tdt.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4iycinlwha4fbtrm"
Content-Disposition: inline
In-Reply-To: <20190308074930.15270-1-ms@dev.tdt.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4iycinlwha4fbtrm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 08, 2019 at 08:49:30AM +0100, Martin Schiller wrote:
> Make the syscon-reboot driver accept value and mask instead of
> just value.
>=20
> Prior to this patch, the property name for the value was 'mask'. If
> only the mask property is defined on a node, maintain compatibility
> by using it as the value.
>=20
> This patch is based on commit
> f2c199db477e ("power: reset: syscon-poweroff: add a mask property")
> and does the same change for the syscon-reboot driver.
>=20
> Signed-off-by: Martin Schiller <ms@dev.tdt.de>
> ---

thanks, queued.

-- Sebastian

>  .../devicetree/bindings/power/reset/syscon-reboot.txt | 11 +++++++++--
>  drivers/power/reset/syscon-reboot.c                   | 19 +++++++++++++=
++++--
>  2 files changed, 26 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot.=
txt b/Documentation/devicetree/bindings/power/reset/syscon-reboot.txt
> index 11906316b43d..e23dea8344f8 100644
> --- a/Documentation/devicetree/bindings/power/reset/syscon-reboot.txt
> +++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot.txt
> @@ -3,13 +3,20 @@ Generic SYSCON mapped register reset driver
>  This is a generic reset driver using syscon to map the reset register.
>  The reset is generally performed with a write to the reset register
>  defined by the register map pointed by syscon reference plus the offset
> -with the mask defined in the reboot node.
> +with the value and mask defined in the reboot node.
> =20
>  Required properties:
>  - compatible: should contain "syscon-reboot"
>  - regmap: this is phandle to the register map node
>  - offset: offset in the register map for the reboot register (in bytes)
> -- mask: the reset value written to the reboot register (32 bit access)
> +- value: the reset value written to the reboot register (32 bit access)
> +
> +Optional properties:
> +- mask: update only the register bits defined by the mask (32 bit)
> +
> +Legacy usage:
> +If a node doesn't contain a value property but contains a mask property,=
 the
> +mask property is used as the value.
> =20
>  Default will be little endian mode, 32 bit access only.
> =20
> diff --git a/drivers/power/reset/syscon-reboot.c b/drivers/power/reset/sy=
scon-reboot.c
> index 7d0d269a0837..5a6bb638c331 100644
> --- a/drivers/power/reset/syscon-reboot.c
> +++ b/drivers/power/reset/syscon-reboot.c
> @@ -27,6 +27,7 @@
>  struct syscon_reboot_context {
>  	struct regmap *map;
>  	u32 offset;
> +	u32 value;
>  	u32 mask;
>  	struct notifier_block restart_handler;
>  };
> @@ -39,7 +40,7 @@ static int syscon_restart_handle(struct notifier_block =
*this,
>  					restart_handler);
> =20
>  	/* Issue the reboot */
> -	regmap_write(ctx->map, ctx->offset, ctx->mask);
> +	regmap_update_bits(ctx->map, ctx->offset, ctx->mask, ctx->value);
> =20
>  	mdelay(1000);
> =20
> @@ -51,6 +52,7 @@ static int syscon_reboot_probe(struct platform_device *=
pdev)
>  {
>  	struct syscon_reboot_context *ctx;
>  	struct device *dev =3D &pdev->dev;
> +	int mask_err, value_err;
>  	int err;
> =20
>  	ctx =3D devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
> @@ -64,8 +66,21 @@ static int syscon_reboot_probe(struct platform_device =
*pdev)
>  	if (of_property_read_u32(pdev->dev.of_node, "offset", &ctx->offset))
>  		return -EINVAL;
> =20
> -	if (of_property_read_u32(pdev->dev.of_node, "mask", &ctx->mask))
> +	value_err =3D of_property_read_u32(pdev->dev.of_node, "value", &ctx->va=
lue);
> +	mask_err =3D of_property_read_u32(pdev->dev.of_node, "mask", &ctx->mask=
);
> +	if (value_err && mask_err) {
> +		dev_err(dev, "unable to read 'value' and 'mask'");
>  		return -EINVAL;
> +	}
> +
> +	if (value_err) {
> +		/* support old binding */
> +		ctx->value =3D ctx->mask;
> +		ctx->mask =3D 0xFFFFFFFF;
> +	} else if (mask_err) {
> +		/* support value without mask*/
> +		ctx->mask =3D 0xFFFFFFFF;
> +	}
> =20
>  	ctx->restart_handler.notifier_call =3D syscon_restart_handle;
>  	ctx->restart_handler.priority =3D 192;
> --=20
> 2.11.0
>=20

--4iycinlwha4fbtrm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlynca0ACgkQ2O7X88g7
+popCA//dK7Dexr7cJnG6mdmK2NQzYdDB/9PyWQmOBWxP0WgBqKNUyqj0E9TCkNi
EbrvppE4s4QTKAZ4pc9pUJEqNDqFPhRi82Xaj1NUp2cPAeyPUJr4O/kjM6VmLpbj
lgTFkjn/d2IvHT5s/HAs+AMDzqVaSrVxRemgFk+7Ccux5dfnZAKGaDLJANYi/dxW
w/kaiYiw0rQMq3b7sEEaEI7D3OR11qo/BV3SC3154PeqSKohroRE5o6YUsC7zUSJ
4hA+i+NjNekqfKkQKY6FsgRLoSuKXpWBIf4EhYuLVPxAXEsEWtd/Hs8jjVxoYgpq
biiPoi3EdgMs364O3kTFrJbfe946F4AiH04rVX4m4wHZ83WIERO3y2DnvQ3Y67td
Hu7J01uKjMuulrjGF9si3EoUui6ppxW6Lmbof6/GUCt3LdVon+gC517uJjtW7a8t
EjM+gbSttmOblGWYcVb3RvM/FQrIoslE9V2BXLXbIALXF1bOHi1GTJXWxeHI1FNN
YrARbBM0Cp1/ESBlF6PtrKLfI4fn8U6XYu5JEN+lTYPuDuSBTs7KhsRbkLAIuYbe
oYHYh6XCEGQGaRkwNYilda5Uz6iClzdZPOwTlAOixfDDBu1Ne33h7c3CBt1V8nOb
2tLA9q96c9qGAGt4xP1lFmroHdvFCaq4zr7fzIm2PtqzsmKQ1gY=
=VyQN
-----END PGP SIGNATURE-----

--4iycinlwha4fbtrm--
