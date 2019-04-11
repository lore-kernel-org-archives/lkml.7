Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AD9C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35E182173C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfDKR2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:28:48 -0400
Received: from verein.lst.de ([213.95.11.211]:37132 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726538AbfDKR2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 13:28:47 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id C3C0A68AFE; Thu, 11 Apr 2019 19:28:35 +0200 (CEST)
Date:   Thu, 11 Apr 2019 19:28:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Scott Wood <swood@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] dma-debug: Only skip one stackframe entry
Message-ID: <20190411172835.GA30904@lst.de>
References: <20190410215925.8458-1-swood@redhat.com> <20190411172658.GA30605@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411172658.GA30605@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 07:26:58PM +0200, Christoph Hellwig wrote:
> Thomas just posted a major rework in this area.  I think you are
> best off rebasing it on top of that series and feeding it to him.

Actually..  Given that this series hasn't been merged yet and given
how trivial this change is I might just feed it to Linus with my
next merge request tomorrow.  That is probably easier for everyone.
