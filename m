Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE546C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E55F20645
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555499179;
	bh=rCV7DBcbAgLegNdKuefTcqPP82xV+FKAqXBuhpr1S4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d1xwSy5RNKDSrnU5ttm6USbBCG8zrDn5Xg2grHMNgcZmXrnjfakVN0LcWGkwDYDPa
	 a5Qu57XltHjtahWJCKFgu7bqyh2IyMamtKBbmfQKSZJrkT84pC5O4bzvYTTjuRQCyz
	 HT/9SpkFHytvGPzFaXjpuJ1MEk3W2J5HFyhRDdDk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731721AbfDQLGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 07:06:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:36258 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726695AbfDQLGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 07:06:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BEA68AE1B;
        Wed, 17 Apr 2019 11:06:16 +0000 (UTC)
Date:   Wed, 17 Apr 2019 13:06:15 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Roman Gushchin <guro@fb.com>, Jeff Layton <jlayton@redhat.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH] mm/workingset : judge file page activity via
 timestamp
Message-ID: <20190417110615.GC5878@dhcp22.suse.cz>
References: <1555487246-15764-1-git-send-email-huangzhaoyang@gmail.com>
 <CAGWkznFCy-Fm1WObEk77shPGALWhn5dWS3ZLXY77+q_4Yp6bAQ@mail.gmail.com>
 <CAGWkznEzRB2RPQEK5+4EYB73UYGMRbNNmMH-FyQqT2_en_q1+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznEzRB2RPQEK5+4EYB73UYGMRbNNmMH-FyQqT2_en_q1+g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-04-19 18:55:15, Zhaoyang Huang wrote:
> fix one mailbox and update for some information
> 
> Comparing to http://lkml.kernel.org/r/1554348617-12897-1-git-send-email-huangzhaoyang@gmail.com,
> this commit fix the packing order error and add trace_printk for
> reference debug information.
> 
> For johannes's comments, please find bellowing for my feedback.

OK, this suggests there is no strong reason to poset a new version of
the patch then. Please do not fragment discussion and continue
discussing in the original email thread until there is some conclusion
reached.

Thanks!
-- 
Michal Hocko
SUSE Labs
