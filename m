Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B2FCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 08:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A32B20684
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 08:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437994AbfJXIG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 04:06:29 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59047 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfJXIG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 04:06:29 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1iNY8X-0007nH-GH; Thu, 24 Oct 2019 10:06:25 +0200
Message-ID: <ee1eaf7255a33bea853daaada702c66f1852bda5.camel@pengutronix.de>
Subject: Re: [PATCH v2 00/11] arm64: Realtek RTD1295 reset controllers
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date:   Thu, 24 Oct 2019 10:06:25 +0200
In-Reply-To: <20191023101317.26656-1-afaerber@suse.de>
References: <20191023101317.26656-1-afaerber@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Wed, 2019-10-23 at 12:13 +0200, Andreas Färber wrote:
> Hello,
> 
> This series adds reset controllers for the Realtek RTD1295 and RTD1195 SoCs.
> 
> v2 adopts reset-simple driver and DesignWare bindings as simplification
> and covers RTD1195, too.
> 
> Note that reset-simple driver would allow to cover RTD1195's reset1-3 in one
> DT node, but it only maps the first resource, so RTD1295's reset4 would need
> to remain separate due to a gap in between. I've therefore left them all as
> separate nodes for now.
> 
> Also note that my initial 32-bit arm patch already selects RESET_CONTROLLER,
> to avoid needing a separate patch here to add that one line as done for arm64.
> 
> If I can take the bindings patches through the Realtek tree then I can squash
> the two final DT patches depending on them into the patches added the resets,
> otherwise they need to go into v5.6 or be merged via a topic branch.

I'm fine with the DT binding patches going in through the Realtek tree,
feel free to add

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

to both. I'll just pick up patches 3 and 4.

regards
Philipp

