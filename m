Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F096CC3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1FBF22CE9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567147648;
	bh=5LjMWUNpaI+rMObVQBZvBftzjCPcBUm24BdPcREXVR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vee8FK9w4Fb9lbf8cqd4hZNVgUr2saVBImCnodD9wpJ6sBjNubYKyJ4PaW1x9LByQ
	 iMistxT4P+GsQQjZ8fPW9EkrzIFJV33XfzSuyne+pjDSowGD4W/MZ94jx3MxLGEuB9
	 4AtdgWrWsgHd87MOMAfOJgXhQQqpMEHrSm0nqm/Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfH3Gr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 02:47:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:49650 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726144AbfH3Gr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 02:47:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9A6BAB04C;
        Fri, 30 Aug 2019 06:47:25 +0000 (UTC)
Date:   Fri, 30 Aug 2019 08:47:24 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH v2 3/6] mm/memory_hotplug: Process all zones when
 removing memory
Message-ID: <20190830064724.GT28313@dhcp22.suse.cz>
References: <20190826101012.10575-1-david@redhat.com>
 <20190826101012.10575-4-david@redhat.com>
 <20190829153936.GJ28313@dhcp22.suse.cz>
 <c01ceaab-4032-49cd-3888-45838cb46e11@redhat.com>
 <20190829162704.GL28313@dhcp22.suse.cz>
 <b5a9f070-b43a-c21d-081b-9926b2007f5c@redhat.com>
 <20190830060100.GP28313@dhcp22.suse.cz>
 <18aed12d-0611-7d35-2994-075d09269513@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18aed12d-0611-7d35-2994-075d09269513@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 30-08-19 08:20:32, David Hildenbrand wrote:
[...]
> Regarding shrink_zone_span(), I suspect it was introduced by
>
> d0dc12e86b31 ("mm/memory_hotplug: optimize memory hotplug")

zone shrinking code is much older - 815121d2b5cd5. But I do not think
this is really needed for Fixes tag.

-- 
Michal Hocko
SUSE Labs
