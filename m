Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDA5C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 19:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38058206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 19:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733229AbfDQTLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 15:11:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:49068 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730285AbfDQTLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 15:11:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 94528ADE3;
        Wed, 17 Apr 2019 19:11:13 +0000 (UTC)
Message-ID: <d01f3c2c68f9e852b15526904f8dfd8cbcece120.camel@suse.de>
Subject: Re: linux-next: manual merge of the scsi tree with the block tree
From:   Martin Wilck <mwilck@suse.de>
To:     Bart Van Assche <bvanassche@acm.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Date:   Wed, 17 Apr 2019 21:11:11 +0200
In-Reply-To: <84c02649-1eeb-3d28-6cc2-0a5d0f5f6b7d@acm.org>
References: <20190415155939.35325ef1@canb.auug.org.au>
         <84c02649-1eeb-3d28-6cc2-0a5d0f5f6b7d@acm.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-04-15 at 06:48 -0700, Bart Van Assche wrote:
> On 4/14/19 10:59 PM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Today's linux-next merge of the scsi tree got a conflict in:
> > 
> >   drivers/scsi/sd.c
> > 
> > between commit:
> > 
> >   c92e2f04b359 ("block: disk_events: introduce event flags")
> > 
> > from the block tree and commit:
> > 
> >   21e6ba3f0e02 ("scsi: sd: Rely on the driver core for asynchronous
> > probing")
> >   d16ece577bf2 ("scsi: sd: Inline sd_probe_part2()")
> > 
> > from the scsi tree.
> > 
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your
> > tree
> > is submitted for merging.  You may also want to consider
> > cooperating
> > with the maintainer of the conflicting tree to minimise any
> > particularly
> > complex conflicts.
> 
> Thanks Stephen for having resolved this conflict. The conflict
> resolution
> looks good to me.

Yes, it looks good to me as well.

Thanks,
Martin


