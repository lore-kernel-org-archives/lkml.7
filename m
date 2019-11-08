Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D99FC6195
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13FE92087E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="Tmmx0Hjf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbfKHSeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 13:34:44 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.80]:29494 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbfKHSen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 13:34:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573238079;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=vJ+74fn3Vf4Saca/F02gUt/u2deD5EnYg79w7uayWuk=;
        b=Tmmx0HjfM9rDZXEw3LNe8dEKmY0Rkwm+K0YXxCNhiUm5pI2Um3GVR7Rk33k5UNTgw/
        w9uN/5kmfX8+tVtBwFGYw58eAzGyDMuq46Yh4BCoWFTUdn49EE8XGmoZgSQK9z1Kvw6m
        BzAVXX6A6oJTozdb1p+AMo2q4956crUmcB1dgWtuRs4SpcWpZe8BIcIIz1BQfE0CXmow
        bzkvPyW5HaMhqOHH8+ic3i0xwH9VZAWpRTPQdrsAImUGGXKzSN4MrGJOeQeYMCgsGcbB
        xqeg63PcC25aXpRl74K4M5aa4NYbniW9sjxehV/3VJdQKbyLQev4Zy4HHEFqcdKmMaVx
        +JsQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Qpw97WFDleUXAoPgQ=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 44.29.0 DYNA|AUTH)
        with ESMTPSA id L09db3vA8IYFmD0
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 8 Nov 2019 19:34:15 +0100 (CET)
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: add compatible string for Tolino Shine 3
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20191108111834.18610-2-andreas@kemnade.info>
Date:   Fri, 8 Nov 2019 19:34:14 +0100
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, andrew.smirnov@gmail.com,
        manivannan.sadhasivam@linaro.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        j.neuschaefer@gmx.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <015ED275-1F30-4ECB-B248-AD91D8874B13@goldelico.com>
References: <20191108111834.18610-1-andreas@kemnade.info> <20191108111834.18610-2-andreas@kemnade.info>
To:     Andreas Kemnade <andreas@kemnade.info>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 08.11.2019 um 12:18 schrieb Andreas Kemnade <andreas@kemnade.info>:
>=20
> This adds a compatible string for the Tolino Shine 3 eBook reader.
>=20
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml =
b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 4a8ce4a56e0b..663964134604 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -142,6 +142,7 @@ properties:
>         items:
>           - enum:
>               - fsl,imx6sl-evk            # i.MX6 SoloLite EVK Board
> +              - kobo,tolino-shine3
>           - const: fsl,imx6sl
>=20
>       - description: i.MX6SLL based Boards
> --=20
> 2.11.0

Tested-by: H. Nikolaus Schaller <hns@goldelico.com> # Tolino Shine3

