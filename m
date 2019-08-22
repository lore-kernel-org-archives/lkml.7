Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BD1C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 08:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5087E20870
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 08:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732152AbfHVIMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 04:12:52 -0400
Received: from shell.v3.sk ([90.176.6.54]:35371 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732158AbfHVIMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 04:12:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id E5CD749470;
        Thu, 22 Aug 2019 10:12:45 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id DGrO6zawJa6R; Thu, 22 Aug 2019 10:12:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 5D8A34941E;
        Thu, 22 Aug 2019 10:12:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lvSPKS5MRZ-2; Thu, 22 Aug 2019 10:12:40 +0200 (CEST)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 3B934494AD;
        Thu, 22 Aug 2019 10:12:40 +0200 (CEST)
Message-ID: <c859d12167d18c21dda13b30c2dd3256f407d1d9.camel@v3.sk>
Subject: Re: [PATCH 02/19] dt-bindings: arm: mrvl: Document MMP3 compatible
 string
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Rob Herring <robh@kernel.org>
Cc:     Olof Johansson <olof@lixom.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
Date:   Thu, 22 Aug 2019 10:12:38 +0200
In-Reply-To: <20190821210349.GA29732@bogus>
References: <20190809093158.7969-1-lkundrak@v3.sk>
         <20190809093158.7969-3-lkundrak@v3.sk> <20190821210349.GA29732@bogus>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-08-21 at 16:03 -0500, Rob Herring wrote:
> On Fri, Aug 09, 2019 at 11:31:41AM +0200, Lubomir Rintel wrote:
> > Marvel MMP3 is a successor to MMP2, containing similar peripherals with two
> > PJ4B cores.
> > 
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > ---
> >  Documentation/devicetree/bindings/arm/mrvl/mrvl.txt | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/mrvl/mrvl.txt b/Documentation/devicetree/bindings/arm/mrvl/mrvl.txt
> > index 951687528efb0..66e1e1414245b 100644
> > --- a/Documentation/devicetree/bindings/arm/mrvl/mrvl.txt
> > +++ b/Documentation/devicetree/bindings/arm/mrvl/mrvl.txt
> > @@ -12,3 +12,7 @@ Required root node properties:
> >  MMP2 Brownstone Board
> >  Required root node properties:
> >  	- compatible = "mrvl,mmp2-brownstone", "mrvl,mmp2";
> > +
> > +MMP3 SoC
> > +Required root node properties:
> > +	- compatible = "marvell,mmp3";
> 
> Please convert this file to DT schema before adding new SoCs.

Is this something that should generally be done for all new or changed
DT bindings?

> 
> Rob

Thanks
Lubo

