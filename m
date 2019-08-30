Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFAFC3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 05:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AFD421897
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 05:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfH3F0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 01:26:48 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:15291 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725902AbfH3F0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 01:26:48 -0400
X-UUID: b000df7b5a394f26878decbf070042ac-20190830
X-UUID: b000df7b5a394f26878decbf070042ac-20190830
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 235957000; Fri, 30 Aug 2019 13:26:40 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 30 Aug 2019 13:26:44 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 30 Aug 2019 13:26:43 +0800
Message-ID: <1567142798.5542.5.camel@mtksdaap41>
Subject: Re: [PATCH V3 01/10] dt-bindings: soc: Add dvfsrc driver bindings
From:   Henry Chen <henryc.chen@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Viresh Kumar" <vireshk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Fan Chen <fan.chen@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Fri, 30 Aug 2019 13:26:38 +0800
In-Reply-To: <20190829191631.GA15714@bogus>
References: <1566995328-15158-1-git-send-email-henryc.chen@mediatek.com>
         <1566995328-15158-2-git-send-email-henryc.chen@mediatek.com>
         <20190829191631.GA15714@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 30CB98CD34478001F8402BCE6BD99F74EF5527939DA772222DD4EF0D575D9DE82000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-29 at 14:16 -0500, Rob Herring wrote:
> On Wed, 28 Aug 2019 20:28:39 +0800, Henry Chen wrote:
> > Document the binding for enabling dvfsrc on MediaTek SoC.
> > 
> > Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> > ---
> >  .../devicetree/bindings/soc/mediatek/dvfsrc.txt    | 23 ++++++++++++++++++++++
> >  include/dt-bindings/soc/mtk,dvfsrc.h               | 14 +++++++++++++
> >  2 files changed, 37 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt
> >  create mode 100644 include/dt-bindings/soc/mtk,dvfsrc.h
> > 
> 
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
> 
> If a tag was not added on purpose, please state why and what changed.

Hi Rob,

I'm sorry for the mistake. I stand corrected, and will add tags on next
version.

Henry


