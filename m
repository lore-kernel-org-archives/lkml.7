Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4963C3A589
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 03:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82D3323407
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 03:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390077AbfHWDvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 23:51:01 -0400
Received: from gate.crashing.org ([63.228.1.57]:48256 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726416AbfHWDvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 23:51:01 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x7N3oO9e029949;
        Thu, 22 Aug 2019 22:50:25 -0500
Message-ID: <6744172c01e6c6798943fb076f4bb336f260bd5b.camel@kernel.crashing.org>
Subject: Re: [PATCH v4 2/4] nvme-pci: Add support for variable IO SQ element
 size
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-kernel@vger.kernel.org, Paul Pawlowski <paul@mrarm.io>
Date:   Fri, 23 Aug 2019 13:50:24 +1000
In-Reply-To: <8545a898-e80c-5ab6-6f9f-f351955db5f0@grimberg.me>
References: <20190807075122.6247-1-benh@kernel.crashing.org>
         <20190807075122.6247-3-benh@kernel.crashing.org>
         <20190822002818.GA10391@lst.de>
         <87e1fea1c297ef98f989175b3041c69e8b7de020.camel@kernel.crashing.org>
         <4fc11568-73fe-c8b5-ac29-d49daee9abad@grimberg.me>
         <fb5aa2db6b54edab69a8abad254b346dd3d7b205.camel@kernel.crashing.org>
         <8545a898-e80c-5ab6-6f9f-f351955db5f0@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-22 at 19:52 -0700, Sagi Grimberg wrote:
> > > I'll fix it. Note that I'm going to take it out of the tree soon
> > > because it will have conflicts with Jens for-5.4/block, so we
> > > will send it to Jens after the initial merge window, after he
> > > rebases off of Linus.
> > 
> > Conflicts too hard to fixup at merge time ? Otherwise I could just
> > rebase on top of Jens and put in a topic branch...
> 
> The quirk enumeration conflicts with 5.3-rc. Not a big deal, just
> thought it'd be easier to handle that way.
> 
> Rebasing on top of Jens won't help because his for-5.4/block which
> does not have the rc code yet.

Ok sure, do as you prefer. Let me know if you want me to do anything.

Cheers,
Ben.


