Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB57DC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6A52084B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731262AbfFYKPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 06:15:46 -0400
Received: from verein.lst.de ([213.95.11.211]:33470 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727070AbfFYKPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 06:15:46 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 93DE268B05; Tue, 25 Jun 2019 12:15:15 +0200 (CEST)
Date:   Tue, 25 Jun 2019 12:15:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/12] iomap: add tracing for the address space
 operations
Message-ID: <20190625101515.GL1462@lst.de>
References: <20190624055253.31183-1-hch@lst.de> <20190624055253.31183-13-hch@lst.de> <20190624234921.GE7777@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624234921.GE7777@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 09:49:21AM +1000, Dave Chinner wrote:
> > +#undef TRACE_SYSTEM
> > +#define TRACE_SYSTEM iomap
> 
> Can you add a comment somewhere here that says these tracepoints are
> volatile and we reserve the right to change them at any time so they
> don't form any sort of persistent UAPI that we have to maintain?

Sure.  Note that we don't have any such comment in xfs either..
