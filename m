Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9DBC282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 17:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11BFD2175B
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 17:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbfDVR4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 13:56:40 -0400
Received: from verein.lst.de ([213.95.11.211]:40904 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726132AbfDVR4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 13:56:39 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 8A81E68B02; Mon, 22 Apr 2019 19:56:23 +0200 (CEST)
Date:   Mon, 22 Apr 2019 19:56:23 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     Thomas Hellstrom <thellstrom@vmware.com>
Cc:     "hch@lst.de" <hch@lst.de>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Deepak Singh Rawat <drawat@vmware.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: revert dma direct internals abuse
Message-ID: <20190422175623.GA32411@lst.de>
References: <20190408105525.5493-1-hch@lst.de> <7d5f35da4a6b58639519f0764c7edbfe4dd1ba02.camel@vmware.com> <20190409095740.GE6827@lst.de> <5f0837ffc135560c764c38849eead40269cebb48.camel@vmware.com> <20190409133157.GA10876@lst.de> <466e658c73607fca5112d718972e87c0b78653ad.camel@vmware.com> <20190409152538.GA12816@lst.de> <da06614b308500392c179651ef9c6fb835ee4045.camel@vmware.com> <20190410064359.GC5543@lst.de> <0c897b24b234f8d42ef597dbe31fa8293519a4b2.camel@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c897b24b234f8d42ef597dbe31fa8293519a4b2.camel@vmware.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 03:01:14PM +0000, Thomas Hellstrom wrote:
> > So can you please respin a version acceptable to you and submit it
> > for 5.1 ASAP?  Otherwise I'll need to move ahead with the simple
> > revert.
> 
> I will. 
> I need to do some testing to investigate how to best choose between the
> options, but will have something ready for 5.1.

I still don't see anything in -rc6..
