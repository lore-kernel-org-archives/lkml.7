Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F92C73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 13:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FFA32171F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 13:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfGINge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 09:36:34 -0400
Received: from verein.lst.de ([213.95.11.211]:42984 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbfGINge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 09:36:34 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C6772227A81; Tue,  9 Jul 2019 15:36:31 +0200 (CEST)
Date:   Tue, 9 Jul 2019 15:36:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Christoph Hellwig <hch@lst.de>, Guenter Roeck <linux@roeck-us.net>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>
Subject: Re: [PATCH] m68k: don't select ARCH_HAS_DMA_PREP_COHERENT for
 nommu or coldfire
Message-ID: <20190709133631.GA2201@lst.de>
References: <20190708175101.19990-1-hch@lst.de> <CAMuHMdVrAVYWvQCh7AF1O7SRbuZb9fQp9fi0yQyZMeaOpfHyEw@mail.gmail.com> <20190708212325.GA17641@lst.de> <CAMuHMdVqCOwxG1ru-wvgDmtNfezgR92qBOVhtEJjaLrXAjaE+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVqCOwxG1ru-wvgDmtNfezgR92qBOVhtEJjaLrXAjaE+A@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 09:08:02AM +0200, Geert Uytterhoeven wrote:
> OK, will do, after a cycle in next.

Thanks.  I'll watch your PRs so that I can send the dma-mapping one
right after this.

> I assume you just forgot to add your SoB, and I can add it?

Yes.  And just for the record:

Signed-off-by: Christoph Hellwig <hch@lst.de>
