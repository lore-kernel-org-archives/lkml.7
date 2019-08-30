Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0DFC3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 13:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D6F23428
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 13:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfH3NWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 09:22:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:37582 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727135AbfH3NWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 09:22:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6F54CB03D;
        Fri, 30 Aug 2019 13:22:41 +0000 (UTC)
Date:   Fri, 30 Aug 2019 15:22:39 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Jinyu Qi <jinyuqi@huawei.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH] iommu/iova: avoid false sharing on fq_timer_on
Message-ID: <20190830132239.GK17192@suse.de>
References: <20190828131338.89832-1-edumazet@google.com>
 <20190830104925.GI17192@suse.de>
 <3ffd6989-229b-9c67-d9fb-7a8e413c1336@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ffd6989-229b-9c67-d9fb-7a8e413c1336@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 01:27:25PM +0100, Robin Murphy wrote:
> On 30/08/2019 11:49, Joerg Roedel wrote:
> > Looks good to me, but adding Robin for his opinion.
> 
> Sounds reasonable to me too - that should also be true for the majority of
> Arm systems that we know of. Will suggested that atomic_try_cmpxchg() might
> be relevant, but AFAICS that's backwards compared to what we want to do
> here, which I guess is more of an "atomic_unlikely_cmpxchg".
> 
> Acked-by: Robin Murphy <robin.murphy@arm.com>

Great, thanks for looking into it, Robin.

Applied now, thanks Eric.
