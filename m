Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD73CC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 06:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E27214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 06:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfFTGE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 02:04:29 -0400
Received: from verein.lst.de ([213.95.11.211]:57839 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfFTGE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 02:04:28 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E2B3368BFE; Thu, 20 Jun 2019 08:03:55 +0200 (CEST)
Date:   Thu, 20 Jun 2019 08:03:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     Christoph Hellwig <hch@lst.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] powerpc/powernv: remove dead NPU DMA code
Message-ID: <20190620060354.GA20279@lst.de>
References: <20190523074924.19659-1-hch@lst.de> <20190523074924.19659-4-hch@lst.de> <db502ec4-2e8f-fbc3-9db2-3fe98464a62c@ozlabs.ru> <20190619072837.GA6858@lst.de> <b0ce7d72-5de7-63d3-cb4e-ea78342cb3fa@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b0ce7d72-5de7-63d3-cb4e-ea78342cb3fa@ozlabs.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

this goes back to the discussion at last years kernel summit, where
we had the discussion on removing code never used by any in-kernel
user an no prospects of one.  The IBM folks are unfortunately still
dragging their feet on the powerpc side.  Can we revise this discussion?

The use case here is a IBM specific bus for which they only have an
out of tree driver that their partner doesn't want to submit for mainline,
but keep insisting on keeping the code around (which is also built
uncondіtionally for the platform).

I hope we had settled that argument back then, but it seems like Big
Blue insists they are special.

On Thu, Jun 20, 2019 at 11:45:42AM +1000, Alexey Kardashevskiy wrote:
> 
> 
> On 19/06/2019 17:28, Christoph Hellwig wrote:
> > On Wed, Jun 19, 2019 at 10:34:54AM +1000, Alexey Kardashevskiy wrote:
> >>
> >>
> >> On 23/05/2019 17:49, Christoph Hellwig wrote:
> >>> None of these routines were ever used since they were added to the
> >>> kernel.
> >>
> >>
> >> It is still being used exactly in the way as it was explained before in
> >> previous respins. Thanks.
> > 
> > Please point to the in-kernel user, because that is the only relevant
> > one.  This is not just my opinion but we had a clear discussion on that
> > at least years kernel summit.
> 
> 
> There is no in-kernel user which still does not mean that the code is
> dead. If it is irrelevant - put this to the commit log instead of saying
> it is dead; also if there was a clear outcome from that discussion, then
> please point me to that, I do not get to attend these discussions. Thanks,
> 
> 
> -- 
> Alexey
---end quoted text---
