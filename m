Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF0AC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 575F5222C4
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570103257;
	bh=4nbskvtMte6G8Dn16qGwpWvD7usNNHZVowY6nzQ2Cx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AT3iWCZuwmjl15UFUAmxCAkrr3dkE7SiF5zpw9nkIhum+NWv4NdNP5ofDrtYyuLCg
	 6CdVUeqcPyc4LRHPLuaVWoIiAHwIQq2BUMfnVPLV80O5yya9z+rM81LtVIXqjCeTQ+
	 T9SuSbH0yA4l04+g1q0QUK7XG48CUgAjbMTIQ1wI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbfJCLrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 07:47:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:34892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbfJCLrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 07:47:36 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15A932070B;
        Thu,  3 Oct 2019 11:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570103255;
        bh=4nbskvtMte6G8Dn16qGwpWvD7usNNHZVowY6nzQ2Cx8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O20g3VXN3/cg4aktrTVEe1GoW8i3ThoeeCN1k/JWU6mjTRj16XPoBKKQyzKDaXwN2
         4lZpEHI+x/6TtmfN5YS8Gy5rtabyI3lmUdMvHUjqCRr2kyrMwRtkphLHWmIzPJAv5u
         qo1v5dHZgQ3uBbnCCPnNR81iVgTFACMX8U0wxo0I=
Date:   Thu, 3 Oct 2019 13:47:33 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, michael@amarulasolutions.com,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v11 4/7] dt-bindings: sun6i-dsi: Add VCC-DSI supply
 property
Message-ID: <20191003114733.56mlar666l76uoyb@gilmour>
References: <20191003064527.15128-1-jagan@amarulasolutions.com>
 <20191003064527.15128-5-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="abhaj7rlytqkllsn"
Content-Disposition: inline
In-Reply-To: <20191003064527.15128-5-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--abhaj7rlytqkllsn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 03, 2019 at 12:15:24PM +0530, Jagan Teki wrote:
> Allwinner MIPI DSI controllers are supplied with SoC DSI
> power rails via VCC-DSI pin.
>
> Some board still work without supplying this but give more
> faith on datasheet and hardware schematics and document this
> supply property in required property list.
>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Tested-by: Merlijn Wajer <merlijn@wizzup.org>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  .../bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml         | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
> index 47950fced28d..9d4c25b104f6 100644
> --- a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
> +++ b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
> @@ -36,6 +36,9 @@ properties:
>    resets:
>      maxItems: 1
>
> +  vcc-dsi-supply:
> +    description: VCC-DSI power supply of the DSI encoder
> +

The driver treats it as mandatory, so I've added it to the binding, as
suggested by the commit log.

Maxime

--abhaj7rlytqkllsn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXZXf1QAKCRDj7w1vZxhR
xQpxAP98mYp2+COHS85N0R4A/9rdJqX3YHaZ0XyYCj2Ihb0iVQD/QWC0ZaUcuku4
nKva2ZQhgqqxhRK3v8jH9MrfregJmAE=
=CYoo
-----END PGP SIGNATURE-----

--abhaj7rlytqkllsn--
