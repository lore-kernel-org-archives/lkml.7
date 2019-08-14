Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488D2C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 178AD20665
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565803508;
	bh=SUSCWt4xADsQMaH8+atQZsd7pBSYIKD5PVgyeC0Sc7E=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=G6ujBxg6AgG9HD0W/2hyUt1qE9v3S2rATbIDKFv4Oxe65JxX5Wm+7JL24l5JrDSHG
	 Lfmhl99T9dccwL7KA68go+1ETb7qSsCMmawZw15k5T0DhNOt6VbTSGtpZXQfrOGPRB
	 4p0H/hILYKwBvCTbeGR5KsMRNzkpIxxtc82yyFaQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbfHNRZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:25:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:54992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729547AbfHNRF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:05:59 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB1F52084D;
        Wed, 14 Aug 2019 17:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802358;
        bh=SUSCWt4xADsQMaH8+atQZsd7pBSYIKD5PVgyeC0Sc7E=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=F3QEhYWRy8PZBbWJ9+3RRUXDylL5Jpml3gB5zrbcuc36EuLCXGqosdX3Z1f2CPIYR
         BJtvqinnV/8D6Rd6T8nxleFg1Euqa98S5FYLIDYqsKpy9TmmSRQajcJKb81TEhtRYK
         PXLmc4KeIkeKESHHjQbzl+95are40ZUT9I/CscLo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190814125012.8700-10-vkoul@kernel.org>
References: <20190814125012.8700-1-vkoul@kernel.org> <20190814125012.8700-10-vkoul@kernel.org>
Subject: Re: [PATCH 09/22] arm64: dts: qcom: pm8150b: Add Base DTS file
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        sibis@codeaurora.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Andy Gross <agross@kernel.org>, Vinod Koul <vkoul@kernel.org>
User-Agent: alot/0.8.1
Date:   Wed, 14 Aug 2019 10:05:57 -0700
Message-Id: <20190814170557.DB1F52084D@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Koul (2019-08-14 05:49:59)
> diff --git a/arch/arm64/boot/dts/qcom/pm8150b.dtsi b/arch/arm64/boot/dts/=
qcom/pm8150b.dtsi
> new file mode 100644
> index 000000000000..c0a678b0f159
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +// Copyright (c) 2017-2019, The Linux Foundation. All rights reserved.
> +// Copyright (c) 2019, Linaro Limited
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/spmi/spmi.h>
> +
> +&spmi_bus {
> +       pm8150@2 {

pmic.

> +               compatible =3D "qcom,spmi-pmic";
> +               reg =3D <0x2 SPMI_USID>;
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +       };
> +
> +       qcom,pm8150@3 {

pmic. Funny this one has qcom, prefix!

> +               compatible =3D"qcom,spmi-pmic";
> +               reg =3D <0x3 SPMI_USID>;
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +       };
> +};
> --=20
> 2.20.1
>=20
