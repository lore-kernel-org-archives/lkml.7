Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D0DC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 01:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D213C222C4
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 01:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391209AbfIZBea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 21:34:30 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:45848 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388759AbfIZBe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 21:34:29 -0400
X-UUID: 02390ec3819943f59fad01eaed510d65-20190926
X-UUID: 02390ec3819943f59fad01eaed510d65-20190926
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1057313941; Thu, 26 Sep 2019 09:34:20 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 26 Sep
 2019 09:34:19 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 26 Sep 2019 09:34:17 +0800
Message-ID: <1569461658.32135.12.camel@mhfsdcap03>
Subject: Re: [PATCH 4/5] dt-bindings: usb: dwc3: of-simple: add compatible
 for HiSi
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     John Stultz <john.stultz@linaro.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        "Andy Shevchenko" <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yu Chen <chenyu56@huawei.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>
Date:   Thu, 26 Sep 2019 09:34:18 +0800
In-Reply-To: <20190925234224.95216-5-john.stultz@linaro.org>
References: <20190925234224.95216-1-john.stultz@linaro.org>
         <20190925234224.95216-5-john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: F93ADA76283739A391119E64EF2F43EF159D1815EA94474BA56A6CF3A64D18CB2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-09-25 at 23:42 +0000, John Stultz wrote:
> Add necessary compatible flag for HiSi's DWC3 so
> dwc3-of-simple will probe.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Yu Chen <chenyu56@huawei.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Cc: linux-usb@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>  .../devicetree/bindings/usb/hisi,dwc3.txt     | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/hisi,dwc3.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/hisi,dwc3.txt b/Documentation/devicetree/bindings/usb/hisi,dwc3.txt
> new file mode 100644
> index 000000000000..dc31b8a3c006
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/hisi,dwc3.txt
> @@ -0,0 +1,52 @@
> +HiSi SuperSpeed DWC3 USB SoC controller
> +
> +Required properties:
> +- compatible:		should contain "hisilicon,hi3660-dwc3" for HiSi SoC
> +- clocks:		A list of phandle + clock-specifier pairs for the
> +			clocks listed in clock-names
> +- clock-names:		Should contain the following:
> +  "clk_usb3phy_ref"	Phy reference clk
It's not good idea to apply phy's clock in dwc3's node

> +  "aclk_usb3otg"	USB3 OTG aclk
> +
> +- assigned-clocks:	Should be:
> +				HI3660_ACLK_GATE_USB3OTG
> +- assigned-clock-rates: Should be:
> +				229Mhz (229000000) for HI3660_ACLK_GATE_USB3OTG
> +
> +Optional properties:
> +- resets:		Phandle to reset control that resets core and wrapper.
> +
> +Required child node:
> +A child node must exist to represent the core DWC3 IP block. The name of
> +the node is not important. The content of the node is defined in dwc3.txt.
> +
> +Example device nodes:
> +
> +	usb3: hisi_dwc3 {
> +		compatible = "hisilicon,hi3660-dwc3";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		clocks = <&crg_ctrl HI3660_CLK_ABB_USB>,
> +			 <&crg_ctrl HI3660_ACLK_GATE_USB3OTG>;
> +		clock-names = "clk_usb3phy_ref", "aclk_usb3otg";
> +
> +		assigned-clocks = <&crg_ctrl HI3660_ACLK_GATE_USB3OTG>;
> +		assigned-clock-rates = <229 000 000>;
> +		resets = <&crg_rst 0x90 8>,
> +			 <&crg_rst 0x90 7>,
> +			 <&crg_rst 0x90 6>,
> +			 <&crg_rst 0x90 5>;
> +
> +		dwc3: dwc3@ff100000 {
> +			compatible = "snps,dwc3";
> +			reg = <0x0 0xff100000 0x0 0x100000>;
> +			interrupts = <0 159 4>, <0 161 4>;
> +			phys = <&usb_phy>;
> +			phy-names = "usb3-phy";
> +			dr_mode = "otg";
> +
> +			...
> +		};
> +	};


