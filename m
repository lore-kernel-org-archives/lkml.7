Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12001C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 07:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F2921920
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 07:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570002809;
	bh=9YKyBtuPMSIl3flPjwSfshk4mhrzvbJIGrd5GInJPaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eI9JttsH3tqeXj486cQUTEwZ3X/DpgOB21ZhKCRD6AvaLqGf8BxJWCF2m+FvOxmZP
	 BoXscRMFCIbDAaJc/3Gca41Brv3BJU6wLRIk9xKzeA/raealtF6W6miAupuODJ5SxA
	 EpBycUpDIqd0r99Rk2MGXu4DsfUW7x4JUf6eZh/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfJBHx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 03:53:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:38016 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725852AbfJBHx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 03:53:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 45BBEAD73;
        Wed,  2 Oct 2019 07:53:27 +0000 (UTC)
Date:   Wed, 2 Oct 2019 09:53:26 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>, Tejun Heo <tj@kernel.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] mm/memcontrol.c: fix another unused function warning
Message-ID: <20191002075326.GF15624@dhcp22.suse.cz>
References: <20191001142227.1227176-1-arnd@arndb.de>
 <1569940805.5576.257.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569940805.5576.257.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 01-10-19 10:40:05, Qian Cai wrote:
> On Tue, 2019-10-01 at 16:22 +0200, Arnd Bergmann wrote:
> > Removing the mem_cgroup_id_get() stub function introduced a new warning
> > of the same kind when CONFIG_MMU is disabled:
> 
> Shouldn't CONFIG_MEMCG depends on CONFIG_MMU instead?

I wanted to do that in the past but there was a clear disagreement from
Johannes.
-- 
Michal Hocko
SUSE Labs
