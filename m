Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A70C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 12:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B243F20679
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 12:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfHMMAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 08:00:53 -0400
Received: from muru.com ([72.249.23.125]:57250 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbfHMMAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 08:00:53 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 1F4BB805C;
        Tue, 13 Aug 2019 12:01:20 +0000 (UTC)
Date:   Tue, 13 Aug 2019 05:00:49 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] ARM: OMAP: dma: Mark expected switch fall-throughs
Message-ID: <20190813120049.GV52127@atomide.com>
References: <20190728232240.GA22393@embeddedor>
 <201907290934.B2053972E3@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201907290934.B2053972E3@keescook>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Kees Cook <keescook@chromium.org> [190729 16:35]:
> On Sun, Jul 28, 2019 at 06:22:40PM -0500, Gustavo A. R. Silva wrote:
> > Mark switch cases where we are expecting to fall through.
> > 
> > This patch fixes the following warnings:
> > 
> > arch/arm/plat-omap/dma.c: In function 'omap_set_dma_src_burst_mode':
> > arch/arm/plat-omap/dma.c:384:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >    if (dma_omap2plus()) {
> >       ^
> > arch/arm/plat-omap/dma.c:393:2: note: here
> >   case OMAP_DMA_DATA_BURST_16:
> >   ^~~~
> > arch/arm/plat-omap/dma.c:394:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >    if (dma_omap2plus()) {
> >       ^
> > arch/arm/plat-omap/dma.c:402:2: note: here
> >   default:
> >   ^~~~~~~
> > arch/arm/plat-omap/dma.c: In function 'omap_set_dma_dest_burst_mode':
> > arch/arm/plat-omap/dma.c:473:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >    if (dma_omap2plus()) {
> >       ^
> > arch/arm/plat-omap/dma.c:481:2: note: here
> >   default:
> >   ^~~~~~~
> > 
> > Notice that, in this particular case, the code comment is
> > modified in accordance with what GCC is expecting to find.
> > 
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Applying into fixes thanks.

Tony
