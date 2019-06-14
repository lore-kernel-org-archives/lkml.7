Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F843C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D5F20850
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfFNMWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 08:22:14 -0400
Received: from verein.lst.de ([213.95.11.211]:46520 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727362AbfFNMWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 08:22:13 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 7061168AFE; Fri, 14 Jun 2019 14:21:44 +0200 (CEST)
Date:   Fri, 14 Jun 2019 14:21:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Greentime Hu <green.hu@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Vincent Chen <deanbo422@gmail.com>,
        iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] switch nds32 to use the generic remapping DMA allocator
Message-ID: <20190614122143.GA26467@lst.de>
References: <20190614100928.9791-1-hch@lst.de> <CAEbi=3dnZNfMeLeuf9Y-d0HxTe_v1F_45Tb_TZwaat_LJq66SQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEbi=3dnZNfMeLeuf9Y-d0HxTe_v1F_45Tb_TZwaat_LJq66SQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 07:35:29PM +0800, Greentime Hu wrote:
> It looks good to me. I just verified in nds32 platform and it works fine.
> Should I put it in my next-tree or you will pick it up in your tree? :)

Either way works for me, let me know what you prefer.
