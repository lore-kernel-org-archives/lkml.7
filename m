Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEDCC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 10:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD1A229ED
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 10:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfGXKDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 06:03:03 -0400
Received: from verein.lst.de ([213.95.11.211]:49516 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbfGXKDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 06:03:02 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5003468B20; Wed, 24 Jul 2019 12:03:01 +0200 (CEST)
Date:   Wed, 24 Jul 2019 12:03:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 5.3-rc1 BUGS in dma_addressing_limited
Message-ID: <20190724100301.GA5390@lst.de>
References: <cda1952f-0265-e055-a3ce-237c59069a3f@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda1952f-0265-e055-a3ce-237c59069a3f@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 10:43:13AM +0300, Nikolay Borisov wrote:
> Hello Christoph, 
> 
> 5.3-rc1 crashes for me when run in qemu with scsi disks. 
> Quick investigation shows that the following triggers a BUG_ON: 

I've queued up the fix here:

http://git.infradead.org/users/hch/dma-mapping.git/commitdiff/06532750010e06dd4b6d69983773677df7fc5291

it will be on the way to Linus soon, I just wanted to give it a cycle
in linux-next.
