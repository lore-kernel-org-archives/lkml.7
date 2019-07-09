Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6302C73C50
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 14:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95BA20844
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 14:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfGIOal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 10:30:41 -0400
Received: from verein.lst.de ([213.95.11.211]:43360 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfGIOal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 10:30:41 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C51FA68B02; Tue,  9 Jul 2019 16:30:38 +0200 (CEST)
Date:   Tue, 9 Jul 2019 16:30:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: hmm_range_fault related fixes and legacy API removal v2
Message-ID: <20190709143038.GA3092@lst.de>
References: <20190703220214.28319-1-hch@lst.de> <20190705123336.GA31543@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190705123336.GA31543@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 05, 2019 at 09:33:36AM -0300, Jason Gunthorpe wrote:
> On Wed, Jul 03, 2019 at 03:02:08PM -0700, Christoph Hellwig wrote:
> > Hi Jérôme, Ben and Jason,
> > 
> > below is a series against the hmm tree which fixes up the mmap_sem
> > locking in nouveau and while at it also removes leftover legacy HMM APIs
> > only used by nouveau.
> 
> As much as I like this series, it won't make it to this merge window,
> sorry.

Note that patch 4 fixes a pretty severe locking bug, and 1-3 is just
preparation for that.  
