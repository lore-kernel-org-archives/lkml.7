Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC2DECE58C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 01:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3392920835
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 01:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbfJHBZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 21:25:39 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:52193 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729327AbfJHBZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 21:25:38 -0400
X-UUID: fdc1729b23f040bcba897059c71b9714-20191008
X-UUID: fdc1729b23f040bcba897059c71b9714-20191008
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 307946823; Tue, 08 Oct 2019 09:25:32 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 8 Oct 2019 09:25:30 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 8 Oct 2019 09:25:30 +0800
Message-ID: <1570497930.1483.0.camel@mtksdaap41>
Subject: Re: [PATCH v7 02/13] dt-bindings: soc: Add MT8183 power dt-bindings
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, Yong Wu <yong.wu@mediatek.com>
Date:   Tue, 8 Oct 2019 09:25:30 +0800
In-Reply-To: <48655b84-fd20-f417-529c-b81a7d64d63d@gmail.com>
References: <1566983506-26598-1-git-send-email-weiyi.lu@mediatek.com>
         <1566983506-26598-3-git-send-email-weiyi.lu@mediatek.com>
         <48655b84-fd20-f417-529c-b81a7d64d63d@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 578EE69AAD1693E32ACFE0DC740AB3F9176CFE3AF9905C35F6FC95A5F7A7086C2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-08-28 at 11:39 +0200, Matthias Brugger wrote:
> 
> On 28/08/2019 11:11, Weiyi Lu wrote:
> > Add power dt-bindings of MT8183 and introduces "BASIC" and
> > "SUBSYS" clock types in binding document.
> > The "BASIC" type is compatible to the original power control with
> > clock name [a-z]+[0-9]*, e.g. mm, vpu1.
> > The "SUBSYS" type is used for bus protection control with clock
> > name [a-z]+-[0-9]+, e.g. isp-0, cam-1.
> > 
> > Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> > ---
> >  .../devicetree/bindings/soc/mediatek/scpsys.txt    | 14 ++++++++++++
> >  include/dt-bindings/power/mt8183-power.h           | 26 ++++++++++++++++++++++
> >  2 files changed, 40 insertions(+)
> >  create mode 100644 include/dt-bindings/power/mt8183-power.h
> > 
> > diff --git a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
> > index 876693a..00eab7e 100644
> > --- a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
> > +++ b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
> > @@ -14,6 +14,7 @@ power/power_domain.txt. It provides the power domains defined in
> >  - include/dt-bindings/power/mt2701-power.h
> >  - include/dt-bindings/power/mt2712-power.h
> >  - include/dt-bindings/power/mt7622-power.h
> > +- include/dt-bindings/power/mt8183-power.h
> >  
> >  Required properties:
> >  - compatible: Should be one of:
> > @@ -25,18 +26,31 @@ Required properties:
> >  	- "mediatek,mt7623a-scpsys": For MT7623A SoC
> >  	- "mediatek,mt7629-scpsys", "mediatek,mt7622-scpsys": For MT7629 SoC
> >  	- "mediatek,mt8173-scpsys"
> > +	- "mediatek,mt8183-scpsys"
> >  - #power-domain-cells: Must be 1
> >  - reg: Address range of the SCPSYS unit
> >  - infracfg: must contain a phandle to the infracfg controller
> >  - clock, clock-names: clocks according to the common clock binding.
> >                        These are clocks which hardware needs to be
> >                        enabled before enabling certain power domains.
> > +                      The new clock type "BASIC" belongs to the type above.
> > +                      As to the new clock type "SUBSYS" needs to be
> > +                      enabled before releasing bus protection.
> 
> The new clock type won't be new in a couple of month, better reword this. E.g.:
> Some SoCs have to groups of clocks. BASIC clocks need to be enabled before
> enabling the corresponding power domain. SUBSYS clocks need to be enabled before
> releasing the bus protection.
> 

Got it, I'll reword in next version. Many thanks.

> >  	Required clocks for MT2701 or MT7623: "mm", "mfg", "ethif"
> >  	Required clocks for MT2712: "mm", "mfg", "venc", "jpgdec", "audio", "vdec"
> >  	Required clocks for MT6797: "mm", "mfg", "vdec"
> >  	Required clocks for MT7622 or MT7629: "hif_sel"
> >  	Required clocks for MT7623A: "ethif"
> >  	Required clocks for MT8173: "mm", "mfg", "venc", "venc_lt"
> > +	Required clocks for MT8183: BASIC: "audio", "mfg", "mm", "cam", "isp",
> > +					   "vpu", "vpu1", "vpu2", "vpu3"
> > +				    SUBSYS: "mm-0", "mm-1", "mm-2", "mm-3",
> > +					    "mm-4", "mm-5", "mm-6", "mm-7",
> > +					    "mm-8", "mm-9", "isp-0", "isp-1",
> > +					    "cam-0", "cam-1", "cam-2", "cam-3",
> > +					    "cam-4", "cam-5", "cam-6", "vpu-0",
> > +					    "vpu-1", "vpu-2", "vpu-3", "vpu-4",
> > +					    "vpu-5"
> >  
> >  Optional properties:
> >  - vdec-supply: Power supply for the vdec power domain
> > diff --git a/include/dt-bindings/power/mt8183-power.h b/include/dt-bindings/power/mt8183-power.h
> > new file mode 100644
> > index 0000000..5c0c8c7
> > --- /dev/null
> > +++ b/include/dt-bindings/power/mt8183-power.h
> > @@ -0,0 +1,26 @@
> > +/* SPDX-License-Identifier: GPL-2.0
> > + *
> > + * Copyright (c) 2018 MediaTek Inc.
> > + * Author: Weiyi Lu <weiyi.lu@mediatek.com>
> > + */
> > +
> > +#ifndef _DT_BINDINGS_POWER_MT8183_POWER_H
> > +#define _DT_BINDINGS_POWER_MT8183_POWER_H
> > +
> > +#define MT8183_POWER_DOMAIN_AUDIO	0
> > +#define MT8183_POWER_DOMAIN_CONN	1
> > +#define MT8183_POWER_DOMAIN_MFG_ASYNC	2
> > +#define MT8183_POWER_DOMAIN_MFG		3
> > +#define MT8183_POWER_DOMAIN_MFG_CORE0	4
> > +#define MT8183_POWER_DOMAIN_MFG_CORE1	5
> > +#define MT8183_POWER_DOMAIN_MFG_2D	6
> > +#define MT8183_POWER_DOMAIN_DISP	7
> > +#define MT8183_POWER_DOMAIN_CAM		8
> > +#define MT8183_POWER_DOMAIN_ISP		9
> > +#define MT8183_POWER_DOMAIN_VDEC	10
> > +#define MT8183_POWER_DOMAIN_VENC	11
> > +#define MT8183_POWER_DOMAIN_VPU_TOP	12
> > +#define MT8183_POWER_DOMAIN_VPU_CORE0	13
> > +#define MT8183_POWER_DOMAIN_VPU_CORE1	14
> > +
> > +#endif /* _DT_BINDINGS_POWER_MT8183_POWER_H */
> > 


