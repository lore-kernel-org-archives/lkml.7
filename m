Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A0BC10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1AD92147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552408385;
	bh=45V6WHZtBHhMh2RK4oUj6EaslPNU+dibvt8x+PyCv34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZmBqLUpc/Lx4iYe08YQxFH5vsSCstgYYJqF2VbDWSRV6WdLrJEh/PQyLVxis7fqIg
	 /OPMC867yFJR/wG+fdaB+5P/x5bVJ5BBnxZbyl80mStilGRCC9zAyHp6p7GRh9AtGI
	 rHOGghtC1MbWEnOEGzFqFXvhY29PdC1J2eQjsqJo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfCLQdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:33:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbfCLQdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 12:33:04 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 659F32083D;
        Tue, 12 Mar 2019 16:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552408383;
        bh=45V6WHZtBHhMh2RK4oUj6EaslPNU+dibvt8x+PyCv34=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BM+LtH5YL6NCXI6WfxhLMb4tvYmZnWWNsBsV1XirkInQY5c9Mgba1GciFK57g/hye
         9ovF5VEuRaaYWClwfh3Op6r9XCxMJKF8pgaAzdJ56eDoLPVEtiGKANUmFI2YANBgvb
         dZ1TRG4ClBZIgTwDyoN6XpUnTA6PFpL266+VJTyw=
Date:   Tue, 12 Mar 2019 09:33:02 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Erin Lo <erin.lo@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        devicetree@vger.kernel.org,
        srv_heupstream <srv_heupstream@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, yingjoe.chen@mediatek.com,
        mars.cheng@mediatek.com, eddie.huang@mediatek.com,
        linux-clk@vger.kernel.org, zhiyong.tao@mediatek.com,
        Mengqi.Zhang@mediatek.com
Subject: Re: [PATCH v8 1/2] dt-bindings: serial: Add compatible for Mediatek
 MT8183
Message-ID: <20190312163302.GA13549@kroah.com>
References: <1552294472-32929-1-git-send-email-erin.lo@mediatek.com>
 <1552294472-32929-2-git-send-email-erin.lo@mediatek.com>
 <d824b15d-49b4-ef6c-779a-0c21c8c05d62@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d824b15d-49b4-ef6c-779a-0c21c8c05d62@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 03:41:57PM +0100, Matthias Brugger wrote:
> 
> 
> On 11/03/2019 09:54, Erin Lo wrote:
> > This adds dt-binding documentation of uart for Mediatek MT8183 SoC
> > Platform.
> > 
> > Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> > Acked-by: Rob Herring <robh@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/serial/mtk-uart.txt | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/serial/mtk-uart.txt b/Documentation/devicetree/bindings/serial/mtk-uart.txt
> > index 742cb47..bcfb131 100644
> > --- a/Documentation/devicetree/bindings/serial/mtk-uart.txt
> > +++ b/Documentation/devicetree/bindings/serial/mtk-uart.txt
> > @@ -16,6 +16,7 @@ Required properties:
> >    * "mediatek,mt8127-uart" for MT8127 compatible UARTS
> >    * "mediatek,mt8135-uart" for MT8135 compatible UARTS
> >    * "mediatek,mt8173-uart" for MT8173 compatible UARTS
> > +  * "mediatek,mt8183-uart", "mediatek,mt6577-uart" for MT8183 compatible UARTS
> >    * "mediatek,mt6577-uart" for MT6577 and all of the above
> >  
> >  - reg: The base address of the UART register bank.
> > 
> 
> Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
> 
> Greg will you take this through your branch or do you prefer me to queue it?

I can take it, let's wait for 5.1-rc1 to come out first please.

thanks,

greg k-h
