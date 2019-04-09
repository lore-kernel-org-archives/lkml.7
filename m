Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F7AC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F36420830
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfDIOWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:22:06 -0400
Received: from muru.com ([72.249.23.125]:44998 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbfDIOWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 10:22:05 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 004258027;
        Tue,  9 Apr 2019 14:22:19 +0000 (UTC)
Date:   Tue, 9 Apr 2019 07:22:01 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Keerthy <j-keerthy@ti.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the rtc tree with the omap tree
Message-ID: <20190409142201.GC2839@atomide.com>
References: <20190409152226.5fecccd1@canb.auug.org.au>
 <1e3bc22e-97b5-3f63-c202-e04cfad48222@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e3bc22e-97b5-3f63-c202-e04cfad48222@ti.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [190409 13:25]:
> 
> 
> On 09/04/19 10:52 AM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Today's linux-next merge of the rtc tree got a conflict in:
> > 
> >    drivers/rtc/rtc-omap.c
> > 
> > between commit:
> > 
> >    6256f7f7f217 ("rtc: OMAP: Add support for rtc-only mode")
> > 
> > from the omap tree and commit:
> > 
> >    35118b7a4ea0 ("rtc: omap: let the core handle range")
> > 
> > from the rtc tree.
> > 
> > I fixed it up (I used the latter resolution around tm2bcd() changes) and
> > can carry the fix as necessary. This is now fixed as far as linux-next
> > is concerned, but any non trivial conflicts should be mentioned to your
> > upstream maintainer when your tree is submitted for merging.  You may
> > also want to consider cooperating with the maintainer of the conflicting
> > tree to minimise any particularly complex conflicts.
> 
> 
> Thanks Stephen. I have tested with Latest next and rtc+ddr mode is
> functional with an additional fix that Tony is about to queue.
> 
> I also reviewed the rtc driver and looks fine.

Thanks, it's probably better to keep the merge conflict rather
than bring in all the rest of the rtc tree changes in this
case.

Regards,

Tony
