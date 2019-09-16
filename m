Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2123FC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 07:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E7D2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 07:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730657AbfIPHNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 03:13:14 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:65157 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729732AbfIPHNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 03:13:13 -0400
X-UUID: 1f818f2cd1ec455da55e4f37a1a78aee-20190916
X-UUID: 1f818f2cd1ec455da55e4f37a1a78aee-20190916
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 372390825; Mon, 16 Sep 2019 15:13:01 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 16 Sep
 2019 15:12:59 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 16 Sep 2019 15:12:59 +0800
Message-ID: <1568617979.7317.76.camel@mhfsdcap03>
Subject: Re: [Patch V9 6/8] arm64: tegra: Enable xudc on Jetson TX1
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
CC:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Date:   Mon, 16 Sep 2019 15:12:59 +0800
In-Reply-To: <1568354873-24073-7-git-send-email-nkristam@nvidia.com>
References: <1568354873-24073-1-git-send-email-nkristam@nvidia.com>
         <1568354873-24073-7-git-send-email-nkristam@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: SMEX-12.5.0.1684-8.5.1010-24914.004
X-TM-AS-Result: No-6.260900-8.000000-10
X-TMASE-MatchedRID: scwq2vQP8OHmLzc6AOD8DfHkpkyUphL9D+jls0cSwJNSMUnCl2ZytCiq
        snPUKvF6nb6Z+uUpsD2j9EeGSOD5uMHmypFRLzeBfJy8LojR0khLXPA26IG0hN9RlPzeVuQQnVt
        gvxMdrIPqUiXvyK0vLoAsU4eLkb8YsQmM31S41hxum3JC5AA1Oo1j+mrGi/PFCuSPuSVW5+7BWk
        ElSj6UUV0SX0p6tZfVoFW8SPM0GkJNfs8n85Te8oMbH85DUZXylBlY5S+EP6fUZxEAlFPo846HM
        5rqDwqty+X6UXAKBSEz7qcN3PQZ47SIFtlWoFdIV8SeOB1iUWenhwMcCUuGfA9pt9Vuvq9t50g1
        BO70D8VyM5AenUwMMVrd8gRCyZfKBt93KmsktusUeH4FmTCnq7pmNLE8W69nMkY/2LNYoZQ10g7
        fr0IQXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--6.260900-8.000000
X-TMASE-Version: SMEX-12.5.0.1684-8.5.1010-24914.004
X-TM-SNTS-SMTP: 22076F1786B60BA1606AA38DFE81EF11B6F61B78F46793633D2B0E77A51737742000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-09-13 at 11:37 +0530, Nagarjuna Kristam wrote:
> Enable XUSB device mode driver for USB0 slot on Jetson TX1.
> 
> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
> Reviewed-by: JC Kuo <jckuo@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi | 31 +++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
> index a7dc319..c1e106e 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
> @@ -1362,7 +1362,7 @@
>  				status = "okay";
>  
>  				lanes {
> -					usb2-0 {
> +					micro_b: usb2-0 {
>  						nvidia,function = "xusb";
>  						status = "okay";
>  					};
> @@ -1483,6 +1483,21 @@
>  		vmmc-supply = <&vdd_3v3_sd>;
>  	};
>  
> +	usb@700d0000 {
> +		status = "okay";
> +		phys = <&micro_b>;
> +		phy-names = "usb2";
> +		avddio-usb-supply = <&vdd_3v3_sys>;
> +		hvdd-usb-supply = <&vdd_1v8>;
> +		usb-role-switch;
> +
> +		port {
> +			usb_role_switch: endpoint {
> +				remote-endpoint = <&usb_b_conn_ep>;
> +			};
> +		};
> +	};
> +
>  	regulators {
>  		compatible = "simple-bus";
>  		#address-cells = <1>;
> @@ -1641,4 +1656,18 @@
>  			linux,code = <KEY_VOLUMEUP>;
>  		};
>  	};
> +
> +	usb_type_b: connector {
> +		compatible = "linux,usb-b-connector", "gpio-usb-b-connector";
use standard compatible "usb-b-connector" instead of
"linux,usb-b-connector"

> +		label = "micro-USB";
> +		type = "micro";
> +		vbus-gpio = <&gpio TEGRA_GPIO(Z, 0) GPIO_ACTIVE_LOW>;
> +
> +		port {
> +			usb_b_conn_ep: endpoint {
> +				remote-endpoint = <&usb_role_switch>;
> +			};
> +		};
> +	};
> +
>  };


