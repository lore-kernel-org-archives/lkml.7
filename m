Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD52C3A589
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 01:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B189421773
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 01:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfHSBkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 21:40:04 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:47283 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726103AbfHSBkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 21:40:04 -0400
X-UUID: c5f7e131f2824118b0d5750a10258271-20190819
X-UUID: c5f7e131f2824118b0d5750a10258271-20190819
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 1043923481; Mon, 19 Aug 2019 09:39:54 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 19 Aug 2019 09:39:54 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 19 Aug 2019 09:39:54 +0800
Message-ID: <1566178794.6371.8.camel@mtksdaap41>
Subject: Re: [RFC V2 08/11] dt-bindings: interconnect: add MT8183
 interconnect dt-bindings
From:   Henry Chen <henryc.chen@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Georgi Djakov <georgi.djakov@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Fan Chen <fan.chen@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Mon, 19 Aug 2019 09:39:54 +0800
In-Reply-To: <20190501202753.GA2862@bogus>
References: <1556614265-12745-1-git-send-email-henryc.chen@mediatek.com>
         <1556614265-12745-9-git-send-email-henryc.chen@mediatek.com>
         <20190501202753.GA2862@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Sorry for late reply.

On Wed, 2019-05-01 at 15:27 -0500, Rob Herring wrote:
> On Tue, Apr 30, 2019 at 04:51:02PM +0800, Henry Chen wrote:
> > Add interconnect provider dt-bindings for MT8183.
> > 
> > Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> > ---
> >  .../bindings/interconnect/mtk,mt8183.txt           | 24 ++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/interconnect/mtk,mt8183.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/interconnect/mtk,mt8183.txt b/Documentation/devicetree/bindings/interconnect/mtk,mt8183.txt
> > new file mode 100644
> > index 0000000..1cf1841
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interconnect/mtk,mt8183.txt
> > @@ -0,0 +1,24 @@
> > +Mediatek MT8183 interconnect binding
> 
> This should be part of the dvfsrc binding.
ok, will add these into dvfsrc binding.
> 
> > +
> > +MT8183 interconnect providers support dram bandwidth requirements. The provider
> > +is able to communicate with the DVFSRC and send the dram bandwidth to it.
> > +Provider nodes must reside within an DVFSRC device node.
> > +
> > +Required properties :
> > +- compatible : shall contain only one of the following:
> > +			"mediatek,mt8183-emi-icc"
> > +- #interconnect-cells : should contain 1
> > +
> > +Examples:
> > +
> > +dvfsrc@10012000 {
> > +	compatible = "mediatek,mt8183-dvfsrc";
> > +	reg = <0 0x10012000 0 0x1000>;
> > +	clocks = <&infracfg CLK_INFRA_DVFSRC>;
> > +	clock-names = "dvfsrc";
> > +	ddr_emi: interconnect {
> > +		compatible = "mediatek,mt8183-emi-icc";
> > +		#interconnect-cells = <1>;
> 
> No need for a child node here. Just move #interconnect-cells to the 
> parent.
Ihave tried and it cannot work if move "#interconnect-cells" to the
parent.
The provider nodes must reside within an DVFSRC device node.
> 
> Rob


