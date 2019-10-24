Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889B4CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 08:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D1342166E
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 08:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571905247;
	bh=g5T65TX59tnUgQRzoJdRnEbctMkMcYoshgwi9TCOi/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VT9NDjF4wjqaASP1zXs5LeulFre6149TP3g7+yCqDsc2rH6RqaKwufUXviIIvV6gy
	 /CzG+5bUAs4j8b9l+6Sk3C6HMrD3/AMmEvO9pThN1Thav2CzAGty3XyqnG326/A//T
	 3+yyjGfH/Zq6Siws4jc2VGfTSWn/qWxJuYSj9dtc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438121AbfJXIUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 04:20:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:58972 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726713AbfJXIUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 04:20:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6462FAF3F;
        Thu, 24 Oct 2019 08:20:43 +0000 (UTC)
Date:   Thu, 24 Oct 2019 10:20:42 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/2] mm/vmstat: Reduce zone lock hold time when
 reading /proc/pagetypeinfo
Message-ID: <20191024082042.GS17610@dhcp22.suse.cz>
References: <20191023095607.GE3016@techsingularity.net>
 <20191023102737.32274-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023102737.32274-1-mhocko@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 23-10-19 12:27:35, Michal Hocko wrote:
[...]
> I went with a bound to the pages iteratred over in the free_list. See
> patch 2.

I will fold http://lkml.kernel.org/r/20191023180121.GN17610@dhcp22.suse.cz
to patch 2 unless there are any objections. If there are no further
comments I will send the two patches without an RFC tomorrow.

Thanks for all the feedback.
-- 
Michal Hocko
SUSE Labs
