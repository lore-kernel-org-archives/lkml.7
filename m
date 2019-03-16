Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6A3C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 11:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D9021871
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 11:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfCPL1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 07:27:44 -0400
Received: from mailoutvs10.siol.net ([185.57.226.201]:39580 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726105AbfCPL1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 07:27:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id B77C6520CFD;
        Sat, 16 Mar 2019 12:27:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id XaRzEm2zMPAt; Sat, 16 Mar 2019 12:27:40 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 5B1305210DA;
        Sat, 16 Mar 2019 12:27:40 +0100 (CET)
Received: from jernej-laptop.localnet (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Zimbra) with ESMTPA id B3D03520CFD;
        Sat, 16 Mar 2019 12:27:39 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, maxime.ripard@bootlin.com,
        wens@csie.org, mark.rutland@arm.com, dan.j.williams@intel.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 1/6] dt-bindings: arm64: allwinner: h6: Add binding for DMA controller
Date:   Sat, 16 Mar 2019 12:27:38 +0100
Message-ID: <1976600.rIVPXpSncm@jernej-laptop>
In-Reply-To: <20190316105711.GG5348@vkoul-mobl>
References: <20190307165829.9086-1-jernej.skrabec@siol.net> <20190307165829.9086-2-jernej.skrabec@siol.net> <20190316105711.GG5348@vkoul-mobl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 16. marec 2019 ob 11:57:11 CET je Vinod Koul napisal(a):
> On 07-03-19, 17:58, Jernej Skrabec wrote:
> > DMA in H6 is similar to other DMA controller, except it is first which
> > supports more than 32 request sources and has 16 channels. It also needs
> > additional clock to be enabled.
> 
> Please see DT folks on this patch, when in doubt, use get_maintainers.pl
> Need an ack on this patch before applying

They are already in CC.

> 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > ---
> > 
> >  Documentation/devicetree/bindings/dma/sun6i-dma.txt | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/dma/sun6i-dma.txt
> > b/Documentation/devicetree/bindings/dma/sun6i-dma.txt index
> > 7fccc20d8331..cae31f4e77ba 100644
> > --- a/Documentation/devicetree/bindings/dma/sun6i-dma.txt
> > +++ b/Documentation/devicetree/bindings/dma/sun6i-dma.txt
> > 
> > @@ -28,12 +28,17 @@ Example:
> >  	};
> >  
> >  -------------------------------------------------------------------------
> >  -----> 
> > -For A64 DMA controller:
> > 
> > +For A64 and H6 DMA controller:
> >  Required properties:
> > -- compatible:	"allwinner,sun50i-a64-dma"
> > +- compatible:	Must be one of
> > +		  "allwinner,sun50i-a64-dma"
> > +		  "allwinner,sun50i-h6-dma"
> > 
> >  - dma-channels: Number of DMA channels supported by the controller.
> >  
> >  		Refer to Documentation/devicetree/bindings/dma/dma.txt
> > 
> > +- clocks:	In addition to parent AHB clock, it should also contain mbus
> > +		clock (H6 only)
> > +- clock-names:	Should contain "bus" and "mbus" (H6 only)
> > 
> >  - all properties above, i.e. reg, interrupts, clocks, resets and
> >  #dma-cells
> >  
> >  Optional properties:




