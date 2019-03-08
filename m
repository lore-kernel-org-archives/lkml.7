Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF42CC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 09:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8195620811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 09:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfCHJTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 04:19:00 -0500
Received: from verein.lst.de ([213.95.11.211]:52625 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfCHJTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 04:19:00 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id CDCAF68C4E; Fri,  8 Mar 2019 10:18:53 +0100 (CET)
Date:   Fri, 8 Mar 2019 10:18:53 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ben Dooks <ben-linux@fluff.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: remove block layer bounce buffering for MMC v2
Message-ID: <20190308091853.GA14021@lst.de>
References: <20190212072528.13167-1-hch@lst.de> <CAPDyKFr6gDYttazFJJzyFm04qiy=9oQAeW9a-cFxHE1vP+DhLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFr6gDYttazFJJzyFm04qiy=9oQAeW9a-cFxHE1vP+DhLA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 02:54:13PM +0100, Ulf Hansson wrote:
> This looks good to me, however the lack of feedback/tests worries me a
> bit. So, unless you think it's a bad idea, I intend to apply this when
> v5.1 rc1 is out, which allows a lengthy test period in linux-next.

Please don't rush to merge this.  Based on a talk to some folks I
have an idea for a sg iterator that can hide the kmapping from
the drivers, which should allow for some less scary driver code and
clean this up a bit further.
