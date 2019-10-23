Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6671C47E49
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B013214B2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571832297;
	bh=UjqborfkvaFg/el+L2SfponqB7+Po+juyp0arLqlCEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I5Kv65DVMg0rOMc0DgR0sh7mVQbcNqIC0Cuplsh+E90BKvxk0kmysJq6PJV8GH7Uq
	 jFy93/11QC9lPRKwM7Sw9ncEDgzwPZBDpcUmO1yjmcyZ/wNf6hO33SirEC88Pd8b6T
	 5JpzPq21XzhzByKpIYc3OGr3otO4cFoskA1NItvM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405207AbfJWME4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 08:04:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:44586 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730034AbfJWME4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:04:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5E655AC4A;
        Wed, 23 Oct 2019 12:04:54 +0000 (UTC)
Date:   Wed, 23 Oct 2019 14:04:52 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Minchan Kim <minchan@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [RFC v1] mm: add page preemption
Message-ID: <20191023120452.GN754@dhcp22.suse.cz>
References: <20191022142802.14304-1-hdanton@sina.com>
 <20191023115350.4956-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023115350.4956-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 23-10-19 19:53:50, Hillf Danton wrote:
> 
> On Wed, 23 Oct 2019 10:17:29 +0200 Michal Hocko wrote:
[...]
> > This doesn't really answer my question.
> > Why cannot you use memcgs as they are now.
> 
> No prio provided.
> 
> > Why exactly do you need a fixed priority?
> 
> Prio comparison in global reclaim is what was added. Because every task has
> prio makes that comparison possible.

That still doesn't answer the question because it doesn't explain why is
the priority really necessary. I am sorry but I have more important
things to deal with than asking the same question again and again.
-- 
Michal Hocko
SUSE Labs
