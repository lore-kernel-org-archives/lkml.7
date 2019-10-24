Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53518CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2037721929
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571954489;
	bh=xdkUuckaMOBUTSgtdoX+0pi45xYQHnglOzJcvNws2gY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HAtiY7pnv71HPL4WIMx6fQ92518ogK9BQtSn4/2SKGdmzQFKgfi/cm9KuuiGnXFOn
	 OLa/ILWChFgL+GYkc1HzOGsntPN6668ow5BJ1GnL6QuyhYLOcYPaQTCyxtJCfGJfaA
	 U0vRCPrtE1/QutolN3CiPyH7NlqUlaXxifJFV3PY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbfJXWB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 18:01:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:58292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfJXWB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 18:01:27 -0400
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B87492084C;
        Thu, 24 Oct 2019 22:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571954487;
        bh=xdkUuckaMOBUTSgtdoX+0pi45xYQHnglOzJcvNws2gY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F9sNcutSsj5Fv/b8Pi6ss04WXvRffLCQ3Gr6fFO5LczCpOTqxQUa6E/dg8aIbOL3m
         SWZNxYOzxfu8DkSenzaJqkhDKxR1OXkIz7hfotNLoZzIfB/7Ij41ATARStpLvenDe+
         d9N1aBCsR5eaUKZvQjzfe/61HGg4iyTs5hBBkCQg=
Date:   Fri, 25 Oct 2019 07:01:19 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Stephen Bates <sbates@raithlin.com>,
        Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 3/7] nvmet: Introduce common execute function for
 get_log_page and identify
Message-ID: <20191024220119.GA25484@redsun51.ssa.fujisawa.hgst.com>
References: <20191023163545.4193-1-logang@deltatee.com>
 <20191023163545.4193-4-logang@deltatee.com>
 <20191024011743.GC5190@lst.de>
 <382906f0-ce0b-282a-9665-8317b50fe374@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <382906f0-ce0b-282a-9665-8317b50fe374@deltatee.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 11:18:20AM -0600, Logan Gunthorpe wrote:
> On 2019-10-23 7:17 p.m., Christoph Hellwig wrote:
> > 
> > First signoff needs to be the From line picked up by git.  I don't really
> > care if you keep my attribution or not, but if you do it needs From
> > line for me as the first theing in the mail body, and if not it
> > should drop by signoff and just say based on a patch from me.
> > 
> > Otherwise the series looks fine.
> 
> Ok, understood. Do you want me to fix this up in a v2? Or can you fix it
> up when you pick up the patches?

I'll adjust with the commit. Just let me know which way you'd like to go,
whether attribute author to Christoph or use the "Based-on-a-patch-by:"
option.
