Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F274C76196
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 06:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C7121850
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 06:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563516855;
	bh=iW4bg/IssV3CeKgwRI8HXM0LrNdI1gKaMvQLoZTjA2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nN8yHtPEnXDVVGPUH+0II2AFZJgciNIC4i5Tev/SQdCVw6rN1O/hnXPQBSUXErhoA
	 voYU0KqsXM97yGzackf6HGb6kIyCcdv+EJ5UiYBVv8TtFZ6akohW/YbasZfitMT5gI
	 1gF9SBfltKc2cNwjFeHvVKmT3FzthCjkI0lO5VZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfGSGON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 02:14:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:60806 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726072AbfGSGON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 02:14:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 376D3ACCE;
        Fri, 19 Jul 2019 06:14:12 +0000 (UTC)
Date:   Fri, 19 Jul 2019 08:14:10 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH v2 2/2] mm, slab: Show last shrink time in us when
 slab/shrink is read
Message-ID: <20190719061410.GJ30461@dhcp22.suse.cz>
References: <20190717202413.13237-1-longman@redhat.com>
 <20190717202413.13237-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717202413.13237-3-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-07-19 16:24:13, Waiman Long wrote:
> The show method of /sys/kernel/slab/<slab>/shrink sysfs file currently
> returns nothing. This is now modified to show the time of the last
> cache shrink operation in us.

Isn't this something that tracing can be used for without any kernel
modifications?
-- 
Michal Hocko
SUSE Labs
