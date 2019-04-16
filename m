Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02794C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFCD72073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbfDPIfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:35:24 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:10818 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726930AbfDPIfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:35:24 -0400
X-UUID: 8a53a8365cf54ccaa3cfac119c1ca4ae-20190416
X-UUID: 8a53a8365cf54ccaa3cfac119c1ca4ae-20190416
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <seiya.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 51808286; Tue, 16 Apr 2019 16:35:03 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 16 Apr 2019 16:35:01 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 16 Apr 2019 16:35:01 +0800
Message-ID: <1555403701.26958.1.camel@mtksdaap41>
Subject: Re: [PATCH v1 1/1] arm64: dts: mt8173: add pmu nodes for mt8173
From:   Seiya Wang <seiya.wang@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Date:   Tue, 16 Apr 2019 16:35:01 +0800
In-Reply-To: <38a56fc1-09fa-a35a-fcef-e265f1608b83@gmail.com>
References: <20190109082143.26468-1-seiya.wang@mediatek.com>
         <38a56fc1-09fa-a35a-fcef-e265f1608b83@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: E4978CA5BCB7764597FC9C857C2AED0B1D7B1E46E7DD35DAA004DDF1ED1452912000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-02-08 at 16:04 +0100, Matthias Brugger wrote:
> 
> On 09/01/2019 09:21, Seiya Wang wrote:
> > This patch adds the device nodes of ARM Performance Monitor Uint
> > for mt8173.
> > 
> > Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > index 412ffd4d426b..44374c506a1c 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > @@ -216,6 +216,20 @@
> >  		};
> >  	};
> >  
> > +	pmu_a53 {
> > +		compatible = "arm,cortex-a53-pmu";
> > +		interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_LOW>,
> > +			     <GIC_SPI 9 IRQ_TYPE_LEVEL_LOW>;
> > +		interrupt-affinity = <&cpu0>, <&cpu1>;
> > +	};
> > +
> > +	pmu_a72 {
> > +		compatible = "arm,cortex-a72-pmu";
> > +		interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_LOW>,
> > +			     <GIC_SPI 13 IRQ_TYPE_LEVEL_LOW>;
> > +		interrupt-affinity = <&cpu2>, <&cpu3>;
> > +	};
> 
> There is no a72 but a a57 CPU present.
> Typo?
> 
> Regards,
> Matthias

Please also apply this (if no problems) since we have changed to ca72.
Thanks.

> > +
> >  	psci {
> >  		compatible = "arm,psci-1.0", "arm,psci-0.2", "arm,psci";
> >  		method = "smc";
> > 


