Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B895C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 12:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2846922CF7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 12:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbfICMhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 08:37:00 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:58599 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727667AbfICMg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 08:36:59 -0400
X-UUID: 7669e14dbab141eca1b31623064821ed-20190903
X-UUID: 7669e14dbab141eca1b31623064821ed-20190903
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1725135840; Tue, 03 Sep 2019 20:36:52 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 3 Sep 2019 20:36:51 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 3 Sep 2019 20:36:51 +0800
Message-ID: <1567514210.31403.8.camel@mtksdaap41>
Subject: Re: [PATCH V3 08/10] dt-bindings: interconnect: add MT8183
 interconnect dt-bindings
From:   Henry Chen <henryc.chen@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Georgi Djakov <georgi.djakov@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Fan Chen <fan.chen@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Tue, 3 Sep 2019 20:36:50 +0800
In-Reply-To: <20190902033045.GA10734@bogus>
References: <1566995328-15158-1-git-send-email-henryc.chen@mediatek.com>
         <1566995328-15158-9-git-send-email-henryc.chen@mediatek.com>
         <20190902033045.GA10734@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-09-02 at 14:38 +0100, Rob Herring wrote:
Hi Rob,
> On Wed, Aug 28, 2019 at 08:28:46PM +0800, Henry Chen wrote:
> > Add interconnect provider dt-bindings for MT8183.
> > 
> > Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> > ---
> >  .../devicetree/bindings/soc/mediatek/dvfsrc.txt        |  9 +++++++++
> >  include/dt-bindings/interconnect/mtk,mt8183-emi.h      | 18 ++++++++++++++++++
> >  2 files changed, 27 insertions(+)
> >  create mode 100644 include/dt-bindings/interconnect/mtk,mt8183-emi.h
> > 
> > diff --git a/Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt b/Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt
> > index 7f43499..da98ec9 100644
> > --- a/Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt
> > +++ b/Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt
> > @@ -12,6 +12,11 @@ Required Properties:
> >  - clock-names: Must include the following entries:
> >  	"dvfsrc": DVFSRC module clock
> >  - clocks: Must contain an entry for each entry in clock-names.
> > +- #interconnect-cells : should contain 1
> > +- interconnect : interconnect providers support dram bandwidth requirements.
> > +	The provider is able to communicate with the DVFSRC and send the dram
> > +	bandwidth to it. shall contain only one of the following:
> > +	"mediatek,mt8183-emi"
> >  
> >  Example:
> >  
> > @@ -20,4 +25,8 @@ Example:
> >  		reg = <0 0x10012000 0 0x1000>;
> >  		clocks = <&infracfg CLK_INFRA_DVFSRC>;
> >  		clock-names = "dvfsrc";
> > +		ddr_emi: interconnect {
> 
> The EMI is a sub-module in the DVFSRC? This is the DDR controller or 
> something else?
Yes, EMI is a sub-module in the DVFSRC, the EMI through interconnect
framework to collect DRAM bandwidth from other device drivers and will
send the bandwidth result to DVFSRC driver.
> 
> 
> > +			compatible = "mediatek,mt8183-emi";
> > +			#interconnect-cells = <1>;
> > +		};
> >  	};
> 


