Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82C0C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 16:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8604822DD6
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 16:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566319128;
	bh=6FYRS/A1SglxEqTNiCzN/bAF4NCGfJyUGVqo/rmqsTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cQDNw6tWYEcS4XE9RwjaCBTuulbjviKatuLrK3LovKB8fT7bAzRXZz10pMqF77iXT
	 qydVLwTdIU8ky+r0b5GsuMSPL6BM1ZMiJfYZOKmypr6HlIt3T0Xa4QbuO3ARtrrIZl
	 j5XF4PDPvWCgC5jxTkmuRwI405rtsDrhDeV1O7uU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730569AbfHTQis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 12:38:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:57822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbfHTQip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 12:38:45 -0400
Received: from localhost (unknown [106.201.62.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF1BD214DA;
        Tue, 20 Aug 2019 16:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566319124;
        bh=6FYRS/A1SglxEqTNiCzN/bAF4NCGfJyUGVqo/rmqsTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rU6LK+CgwJBjiBIqmo831Zzigy347iRqQ9FxvGZEGMOMnym65QRqUQkJ91HgmVhga
         h/9qIpDuFuLjhSSUnAYOwQr7G86qdFxBaAoCPFINGF2bA1QDsNeUY7Ms2w8kBA/BwJ
         6k/ar9RSJ9hM+ovIFUzEGCwmH+mq71vVk2Qg0IZk=
Date:   Tue, 20 Aug 2019 22:07:32 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amit Kucheria <amit.kucheria@verdurent.com>
Cc:     Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/8] arm64: dts: qcom: sm8150: add base dts file
Message-ID: <20190820163732.GF12733@vkoul-mobl.Dlink>
References: <20190820064216.8629-1-vkoul@kernel.org>
 <20190820064216.8629-2-vkoul@kernel.org>
 <CAHLCerOBbaOuPf+WfsG8gKzAxs+9kTMbW7k4MAkmciwyWyeQww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHLCerOBbaOuPf+WfsG8gKzAxs+9kTMbW7k4MAkmciwyWyeQww@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-08-19, 19:03, Amit Kucheria wrote:
> On Tue, Aug 20, 2019 at 12:14 PM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > This add base DTS file with cpu, psci, firmware, clock, tlmm and
> > spmi nodes which enables boot to console
> >
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sm8150.dtsi | 305 +++++++++++++++++++++++++++
> >  1 file changed, 305 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/qcom/sm8150.dtsi
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> > new file mode 100644
> > index 000000000000..d9dc95f851b7
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> > @@ -0,0 +1,305 @@
> > +// SPDX-License-Identifier: BSD-3-Clause
> 
> This is fine.
> 
> > +// Copyright (c) 2017-2019, The Linux Foundation. All rights reserved.
> > +// Copyright (c) 2019, Linaro Limited
> 
> These two lines should be in /* */

Yeah I made it same as previous, lets do right style.

> > +       timer {
> > +               compatible = "arm,armv8-timer";
> > +               interrupts = <GIC_PPI 1 IRQ_TYPE_LEVEL_LOW>,
> > +                            <GIC_PPI 2 IRQ_TYPE_LEVEL_LOW>,
> > +                            <GIC_PPI 3 IRQ_TYPE_LEVEL_LOW>,
> > +                            <GIC_PPI 0 IRQ_TYPE_LEVEL_LOW>;
> 
> Any particular reason why these are defined in this order - 1, 2, 3, 0?

Copied from downstream :)

-- 
~Vinod
