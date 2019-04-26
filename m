Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C8FC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03BBA2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfDZM31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 08:29:27 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:38954 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfDZM31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 08:29:27 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 44rCzS381Wz1rKY3;
        Fri, 26 Apr 2019 14:29:24 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 44rCzS25h7z1rgsF;
        Fri, 26 Apr 2019 14:29:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id BXQTjIr906P9; Fri, 26 Apr 2019 14:29:22 +0200 (CEST)
X-Auth-Info: apaWWv1zufYYSTRzq1Jxz4zStL4Kl2Kh/UizkK4XUpw=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 26 Apr 2019 14:29:22 +0200 (CEST)
Date:   Fri, 26 Apr 2019 14:29:14 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: display/panel: Add KOE
 tx14d24vm1bpa display description
Message-ID: <20190426142914.45adfdae@jawa>
In-Reply-To: <20190404112243.9473-1-lukma@denx.de>
References: <20180412143715.6828-1-lukma@denx.de>
        <20190404112243.9473-1-lukma@denx.de>
Organization: denx.de
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/QOX5Xd8fL4u/irJU0gONYsV"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QOX5Xd8fL4u/irJU0gONYsV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Dear All,

> This commit adds documentation entry description for KOE's 5.7"
> display.
>=20
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
>=20
> ---
> Previous discussion (and Rob's Reviewed-by) about this patch
> https://patchwork.kernel.org/patch/10339595/
>=20
> Changes for v3 :
> - New patch

Gentle ping on this patch...

> ---
>  .../bindings/display/panel/koe,tx14d24vm1bpa.txt   | 42
> ++++++++++++++++++++++ 1 file changed, 42 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/display/panel/koe,tx14d24vm1bpa.txt
>=20
> diff --git
> a/Documentation/devicetree/bindings/display/panel/koe,tx14d24vm1bpa.txt
> b/Documentation/devicetree/bindings/display/panel/koe,tx14d24vm1bpa.txt
> new file mode 100644 index 000000000000..be7ac666807b --- /dev/null
> +++
> b/Documentation/devicetree/bindings/display/panel/koe,tx14d24vm1bpa.txt
> @@ -0,0 +1,42 @@ +Kaohsiung Opto-Electronics Inc. 5.7" QVGA (320 x
> 240) TFT LCD panel +
> +Required properties:
> +- compatible: should be "koe,tx14d24vm1bpa"
> +- backlight: phandle of the backlight device attached to the panel
> +- power-supply: single regulator to provide the supply voltage
> +
> +Required nodes:
> +- port: Parallel port mapping to connect this display
> +
> +This panel needs single power supply voltage. Its backlight is
> conntrolled +via PWM signal.
> +
> +Example:
> +--------
> +
> +Example device-tree definition when connected to iMX53 based board
> +
> +	lcd_panel: lcd-panel {
> +		compatible =3D "koe,tx14d24vm1bpa";
> +		backlight =3D <&backlight_lcd>;
> +		power-supply =3D <&reg_3v3>;
> +
> +		port {
> +			lcd_panel_in: endpoint {
> +				remote-endpoint =3D <&lcd_display_out>;
> +			};
> +		};
> +	};
> +
> +Then one needs to extend the dispX node:
> +
> +	lcd_display: disp1 {
> +
> +		port@1 {
> +			reg =3D <1>;
> +
> +			lcd_display_out: endpoint {
> +				remote-endpoint =3D <&lcd_panel_in>;
> +			};
> +		};
> +	};




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/QOX5Xd8fL4u/irJU0gONYsV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlzC+ZoACgkQAR8vZIA0
zr0lYAf+IJnNCKzyRLvnjXawDB53bWGwWygFn8+i87scG/6xNTrawduWFhndYwoA
D8L0QtjGUwBt3H/VRzjdciKlUlUT8DjMrpnbA6X2MSW2bvlH0xwyUQfr/MsmWNIq
j6Y92E1kDnYfWWY1OzaOqfjtxqJ92dxM7CnHBRy2HdGl6fa9nYlnD6/I8T9BvkxJ
M20W6KCVIRqrg7mioponoRm34A7WyEqWNV3sUYScPTJlyS+rOemLl7Lm1B4dbdhc
myut2GPixVxzeJ9nlQJY7yTIzynteDePCL4pWYd49I62nke2qQ0QbrCh0OwuHjgb
3/boIMTzYLUAcdSSDdl+iGBIY+d3ew==
=7oyd
-----END PGP SIGNATURE-----

--Sig_/QOX5Xd8fL4u/irJU0gONYsV--
