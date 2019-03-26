Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAC5C10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F6320830
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731422AbfCZKda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:33:30 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:26823 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726266AbfCZKd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 06:33:29 -0400
X-UUID: 79f4725e715a4ff086b75836e5093e7e-20190326
X-UUID: 79f4725e715a4ff086b75836e5093e7e-20190326
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <seiya.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1488152924; Tue, 26 Mar 2019 18:33:22 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 26 Mar 2019 18:33:21 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by mtkcas07.mediatek.inc
 (172.21.101.84) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 26 Mar
 2019 18:33:21 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 26 Mar 2019 18:33:20 +0800
Message-ID: <1553596401.24277.4.camel@mtksdaap41>
Subject: Re: [PATCH v2 1/2] arm64: dts: mt8173: correct cpu type of cpu2 and
 cpu3 to cortex-a72
From:   Seiya Wang <seiya.wang@mediatek.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rob Herring" <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Date:   Tue, 26 Mar 2019 18:33:21 +0800
In-Reply-To: <20190225065112.3400-1-seiya.wang@mediatek.com>
References: <20190225065112.3400-1-seiya.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-02-25 at 14:51 +0800, Seiya Wang wrote:
> The cpu type of cpu2 and cpu3 should be cortex-a72, not cortex-a57.
> 
> Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index 44374c506a1c..99675c51577a 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -178,12 +178,12 @@
>  
>  		cpu2: cpu@100 {
>  			device_type = "cpu";
> -			compatible = "arm,cortex-a57";
> +			compatible = "arm,cortex-a72";
>  			reg = <0x100>;
>  			enable-method = "psci";
>  			cpu-idle-states = <&CPU_SLEEP_0>;
>  			#cooling-cells = <2>;
> -			clocks = <&infracfg CLK_INFRA_CA57SEL>,
> +			clocks = <&infracfg CLK_INFRA_CA72SEL>,
>  				 <&apmixedsys CLK_APMIXED_MAINPLL>;
>  			clock-names = "cpu", "intermediate";
>  			operating-points-v2 = <&cluster1_opp>;
> @@ -191,12 +191,12 @@
>  
>  		cpu3: cpu@101 {
>  			device_type = "cpu";
> -			compatible = "arm,cortex-a57";
> +			compatible = "arm,cortex-a72";
>  			reg = <0x101>;
>  			enable-method = "psci";
>  			cpu-idle-states = <&CPU_SLEEP_0>;
>  			#cooling-cells = <2>;
> -			clocks = <&infracfg CLK_INFRA_CA57SEL>,
> +			clocks = <&infracfg CLK_INFRA_CA72SEL>,
>  				 <&apmixedsys CLK_APMIXED_MAINPLL>;
>  			clock-names = "cpu", "intermediate";
>  			operating-points-v2 = <&cluster1_opp>;

Since CLK_INFRA_CA72SEL has been added in mt8173-clk.h , please review
this patch. Thanks.


