Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0988BC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9BDA2199C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563832298;
	bh=sJhnAkadNzZPHZKBNq0Nth2LENsL/9MwlV66EhJeax4=;
	h=In-Reply-To:References:Subject:To:Cc:From:Date:List-ID:From;
	b=VKrmOpfIGqXquh43Gi8SQwiQITig2BV1jIz7alMLKO0IM7fvpTJeegx3TDgm9BAkx
	 ZQfwzXOiUtmTdoCAFgKASvoa0zV35dvTJLs5+qtl4ZEdgTjnCmJERIblaYuuO9s+Oc
	 CNSC+eLO0IMPn4M82a3fhuKdC011ntlk/K7UGeWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732940AbfGVVvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 17:51:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:42102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732855AbfGVVvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:51:37 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FC9121951;
        Mon, 22 Jul 2019 21:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563832296;
        bh=sJhnAkadNzZPHZKBNq0Nth2LENsL/9MwlV66EhJeax4=;
        h=In-Reply-To:References:Subject:To:Cc:From:Date:From;
        b=TZjRSGF1zvC/ZiV2R1+IyRjkYyVgKiy8vjM8qITMYo2tw8iESWFGq/kARKNKC/QkT
         n8D6HH0qXKGK+zKkyLDPAuPxOKlKf4kFuapJSEfKQ7o0NOoVUYOeXWgl4I+tQGhr1p
         uCOVtsPHAthaALMHPgkTTrveFCpduGBxc7xY1kqk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190709182018.23193-4-gch981213@gmail.com>
References: <20190709182018.23193-1-gch981213@gmail.com> <20190709182018.23193-4-gch981213@gmail.com>
Subject: Re: [PATCH 3/5] dt: bindings: add mt7621-pll dt binding documentation
To:     "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        John Crispin <john@phrozen.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Weijie Gao <hackpascal@gmail.com>, NeilBrown <neil@brown.name>,
        Chuanhong Guo <gch981213@gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Mon, 22 Jul 2019 14:51:35 -0700
Message-Id: <20190722215136.1FC9121951@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chuanhong Guo (2019-07-09 11:20:16)
> This commit adds device tree binding documentation for MT7621
> PLL controller.
>=20
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> ---
>  .../bindings/clock/mediatek,mt7621-pll.txt    | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt76=
21-pll.txt
>=20
> diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt7621-pll.=
txt b/Documentation/devicetree/bindings/clock/mediatek,mt7621-pll.txt
> new file mode 100644
> index 000000000000..05c15062cd20
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/mediatek,mt7621-pll.txt
> @@ -0,0 +1,19 @@
> +Binding for Mediatek MT7621 PLL controller
> +
> +The PLL controller provides the 2 main clocks of the SoC: CPU and BUS.
> +
> +Required Properties:
> +- compatible: has to be "mediatek,mt7621-pll"
> +- #clock-cells: has to be one
> +
> +Optional properties:
> +- clock-output-names: should be "cpu", "bus"
> +
> +Example:
> +       pll {
> +               compatible =3D "mediatek,mt7621-pll", "syscon";

Why is this a syscon and not just part of some larger mt7621 clk
provider node?

> +
> +               #clock-cells =3D <1>;
> +               clock-output-names =3D "cpu", "bus";
> +       };
> +
