Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61A3C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C310E205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfEGNx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 09:53:26 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:60658 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfEGNxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 09:53:25 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 636D725B762;
        Tue,  7 May 2019 23:53:23 +1000 (AEST)
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 4FE809403F2; Tue,  7 May 2019 15:53:21 +0200 (CEST)
Date:   Tue, 7 May 2019 15:53:21 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] irqchip: Add Renesas RZ/A1 Interrupt Controller
 driver
Message-ID: <20190507135321.nuukbsbhwcsc7afc@verge.net.au>
References: <20190502123220.3016-1-geert+renesas@glider.be>
 <20190502123220.3016-3-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502123220.3016-3-geert+renesas@glider.be>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 02:32:17PM +0200, Geert Uytterhoeven wrote:
> Add a driver for the Renesas RZ/A1 Interrupt Controller.
> 
> This supports using up to 8 external interrupts on RZ/A1, with
> configurable sense select.
> 
> NMI edge select is not yet supported.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Chris Brandt <chris.brandt@renesas.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

