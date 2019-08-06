Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57761C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 05:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 329C421872
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 05:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731713AbfHFF1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 01:27:02 -0400
Received: from gate.crashing.org ([63.228.1.57]:49635 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfHFF1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 01:27:02 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x765Qc1C016879;
        Tue, 6 Aug 2019 00:26:39 -0500
Message-ID: <eda217b2572c94a1811ef8a1a0fe214a502b942e.camel@kernel.crashing.org>
Subject: Re: [PATCH v3] nvme-pci: Support shared tags across queues for
 Apple 2018 controllers
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Pawlowski <paul@mrarm.io>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Date:   Tue, 06 Aug 2019 15:26:38 +1000
In-Reply-To: <de65f6f8-afb5-ce54-eb8a-b04b2e59628b@grimberg.me>
References: <b1f9bdf0294b8d87d292de3c7462c8e99551b02d.camel@kernel.crashing.org>
         <20190730153044.GA13948@localhost.localdomain>
         <2030a028664a9af9e96fffca3ab352faf1f739e5.camel@kernel.crashing.org>
         <6290507e1b2830b1729fc858cd5c20b85d092728.camel@kernel.crashing.org>
         <20190805134907.GC18647@localhost.localdomain>
         <40a6acc2-beae-3e36-ca20-af5801038a1e@grimberg.me>
         <caa04d02-05a0-dd1f-2072-df41a21f2aa8@fb.com>
         <f34af208-2707-f326-0451-354a8b482586@grimberg.me>
         <de65f6f8-afb5-ce54-eb8a-b04b2e59628b@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-08-05 at 13:07 -0700, Sagi Grimberg wrote:
> > > > > > Ping ? I had another look today and I don't feel like mucking around
> > > > > > with all the AQ size logic, AEN magic tag etc... just for that sake of
> > > > > > that Apple gunk. I'm happy to have it give up IO tags, it doesn't seem
> > > > > > to make much of a difference in practice anyway.
> > > > > > 
> > > > > > But if you feel strongly about it, then I'll implement the "proper" 
> > > > > > way
> > > > > > sometimes this week, adding a way to shrink the AQ down to something
> > > > > > like 3 (one admin request, one async event (AEN), and the empty slot)
> > > > > > by making a bunch of the constants involved variables instead.
> > > > > 
> > > > > I don't feel too strongly about it. I think your patch is fine, so
> > > > > 
> > > > > Acked-by: Keith Busch <keith.busch@intel.com>
> > > > 
> > > > Should we pick this up for 5.3-rc?
> > > 
> > > No, it's not a regression fix. Queue it up for 5.4 instead.
> > 
> > OK, will queue it up for nvme-5.4
> 
> Doesn't apply..
> 
> Ben, can you please respin a patch that applies on nvme-5.4?
> 
> http://git.infradead.org/nvme.git/shortlog/refs/heads/nvme-5.4

Sure, will do in the next couple of days !

Cheers,
Ben.

