Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BAEC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 10:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 549E62054F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 10:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfGBKFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 06:05:21 -0400
Received: from mailgw01.mediatek.com ([216.200.240.184]:49620 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfGBKFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 06:05:21 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Jul 2019 06:05:21 EDT
X-UUID: 54741aff087e4c8a930e649c99b9ac13-20190702
X-UUID: 54741aff087e4c8a930e649c99b9ac13-20190702
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1894146130; Tue, 02 Jul 2019 02:00:18 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 2 Jul 2019 03:00:17 -0700
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 2 Jul 2019 18:00:15 +0800
Message-ID: <1562061615.29303.2.camel@mtkswgap22>
Subject: Re: [PATCH 1/3] add doc and MAINTAINERS for poweroff
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Frank Wunderlich <frank-w@public-files.de>,
        Sean Wang <Sean.Wang@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Josef Friedl <josef.friedl@speed.at>
Date:   Tue, 2 Jul 2019 18:00:15 +0800
In-Reply-To: <20190702094045.3652-2-frank-w@public-files.de>
References: <20190702094045.3652-1-frank-w@public-files.de>
         <20190702094045.3652-2-frank-w@public-files.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Sean

On Tue, 2019-07-02 at 11:40 +0200, Frank Wunderlich wrote:
> From: Josef Friedl <josef.friedl@speed.at>
> 
> poweroff for BPI-R2
> Suggested-by: Frank Wunderlich <frank-w@public-files.de>
> 
> Signed-off-by: Josef Friedl <josef.friedl@speed.at>
> ---
>  .../devicetree/bindings/mfd/mt6397.txt        | 10 ++++++-
>  .../bindings/power/reset/mt6323-poweroff.txt  | 20 +++++++++++++
>  .../devicetree/bindings/rtc/rtc-mt6397.txt    | 29 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++++
>  4 files changed, 64 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt
>  create mode 100644 Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
> index 0ebd08af777d..44acb9827716 100644
> --- a/Documentation/devicetree/bindings/mfd/mt6397.txt
> +++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
> @@ -8,6 +8,7 @@ MT6397/MT6323 is a multifunction device with the following sub modules:
>  - Clock
>  - LED
>  - Keys
> +- Power controller
> 
>  It is interfaced to host controller using SPI interface by a proprietary hardware
>  called PMIC wrapper or pwrap. MT6397/MT6323 MFD is a child device of pwrap.
> @@ -22,8 +23,10 @@ compatible: "mediatek,mt6397" or "mediatek,mt6323"
>  Optional subnodes:
> 
>  - rtc
> -	Required properties:
> +	Required properties: Should be one of follows
> +		- compatible: "mediatek,mt6323-rtc"
>  		- compatible: "mediatek,mt6397-rtc"
> +	For details, see Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
>  - regulators
>  	Required properties:
>  		- compatible: "mediatek,mt6397-regulator"
> @@ -46,6 +49,11 @@ Optional subnodes:
>  		- compatible: "mediatek,mt6397-keys" or "mediatek,mt6323-keys"
>  	see Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
> 
> +- power-controller
> +	Required properties:
> +		- compatible: "mediatek,mt6323-pwrc"
> +	For details, see Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt
> +
>  Example:
>  	pwrap: pwrap@1000f000 {
>  		compatible = "mediatek,mt8135-pwrap";
> diff --git a/Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt b/Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt
> new file mode 100644
> index 000000000000..933f0c48e887
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt
> @@ -0,0 +1,20 @@
> +Device Tree Bindings for Power Controller on MediaTek PMIC
> +
> +The power controller which could be found on PMIC is responsible for externally
> +powering off or on the remote MediaTek SoC through the circuit BBPU.
> +
> +Required properties:
> +- compatible: Should be one of follows
> +       "mediatek,mt6323-pwrc": for MT6323 PMIC
> +
> +Example:
> +
> +       pmic {
> +               compatible = "mediatek,mt6323";
> +
> +               ...
> +
> +               power-controller {
> +                       compatible = "mediatek,mt6323-pwrc";
> +               };
> +       }
> diff --git a/Documentation/devicetree/bindings/rtc/rtc-mt6397.txt b/Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
> new file mode 100644
> index 000000000000..ebd1cf80dcc8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
> @@ -0,0 +1,29 @@
> +Device-Tree bindings for MediaTek PMIC based RTC
> +
> +MediaTek PMIC based RTC is an independent function of MediaTek PMIC that works
> +as a type of multi-function device (MFD). The RTC can be configured and set up
> +with PMIC wrapper bus which is a common resource shared with the other
> +functions found on the same PMIC.
> +
> +For MediaTek PMIC MFD bindings, see:
> +Documentation/devicetree/bindings/mfd/mt6397.txt
> +
> +For MediaTek PMIC wrapper bus bindings, see:
> +Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
> +
> +Required properties:
> +- compatible: Should be one of follows
> +       "mediatek,mt6323-rtc": for MT6323 PMIC
> +       "mediatek,mt6397-rtc": for MT6397 PMIC
> +
> +Example:
> +
> +       pmic {
> +               compatible = "mediatek,mt6323";
> +
> +               ...
> +
> +               rtc {
> +                       compatible = "mediatek,mt6323-rtc";
> +               };
> +       };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 01a52fc964da..ec6ff342aa3c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9920,6 +9920,12 @@ S:	Maintained
>  F:	drivers/net/dsa/mt7530.*
>  F:	net/dsa/tag_mtk.c
> 
> +MEDIATEK BOARD LEVEL SHUTDOWN DRIVERS
> +M:	Sean Wang <sean.wang@mediatek.com>
> +L:	linux-pm@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt

It's odd that there's no Sean's SOB tag in the series but add him in the
entry.

>  MEDIATEK JPEG DRIVER
>  M:	Rick Chang <rick.chang@mediatek.com>
>  M:	Bin Liu <bin.liu@mediatek.com>
> --
> 2.17.1
> 
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek


