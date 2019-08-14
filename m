Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90054C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 676E220665
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565803270;
	bh=YR72w7Msh0x7uY3cbj05UlGIa3087BPrnDe2KXS8u+M=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=CPhdHGRdD9z6oybsld+Go9wMyFdZ/K8lhRsknBEwAiNcF1aa1dEUkaHYJCCvDIT1B
	 Y6YQgaXlyxW/SnY1zA7bOaLv0piyHpqygEtJVpDZWfdJesG9OjzPc2uZIrttEs3C9h
	 xpRYhZR/p7mtB+4zEO7E51zFVjBgvL9FlnvNzfsE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbfHNRVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:21:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:32896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730099AbfHNRKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:10:15 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA226208C2;
        Wed, 14 Aug 2019 17:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802615;
        bh=YR72w7Msh0x7uY3cbj05UlGIa3087BPrnDe2KXS8u+M=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=y2V2HS9ulR+8xGHy7TYxrLWt9a9SonJznOIXj/qcJNbtOcKiaCcFSlEScGf2LZADe
         YP7AGXd3ZxWfanLnDkfqdCg3mCPnxsGkXssUCtjOS8VXdEUtIk0USvnjF7FWWLoHPf
         iFYgAMsCAiVezUaJYXtAyXj7GS+m3fUfcSmnKC08=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190814125012.8700-13-vkoul@kernel.org>
References: <20190814125012.8700-1-vkoul@kernel.org> <20190814125012.8700-13-vkoul@kernel.org>
Subject: Re: [PATCH 12/22] arm64: dts: qcom: pm8150l: Add Base DTS file
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        sibis@codeaurora.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Andy Gross <agross@kernel.org>, Vinod Koul <vkoul@kernel.org>
User-Agent: alot/0.8.1
Date:   Wed, 14 Aug 2019 10:10:14 -0700
Message-Id: <20190814171014.DA226208C2@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Koul (2019-08-14 05:50:02)
> PMIC pm8150l is a slave pmic and this adds base DTS file for pm8150l
>=20
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/pm8150l.dtsi | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/pm8150l.dtsi
>=20
> diff --git a/arch/arm64/boot/dts/qcom/pm8150l.dtsi b/arch/arm64/boot/dts/=
qcom/pm8150l.dtsi
> new file mode 100644
> index 000000000000..e61ae6c6dab5
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +// Copyright (c) 2017-2019, The Linux Foundation. All rights reserved.
> +// Copyright (c) 2019, Linaro Limited
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/spmi/spmi.h>
> +
> +&spmi_bus {
> +       qcom,pm8150@4 {

pmic

> +               compatible =3D "qcom,spmi-pmic";

Update compatible string too.

> +               reg =3D <0x4 SPMI_USID>;
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +       };
> +
> +       qcom,pm8150@5 {
> +               compatible =3D"qcom,spmi-pmic";
> +               reg =3D <0x5 SPMI_USID>;
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +       };
> +};
