Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2CFC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 17:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C8F0206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 17:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kam.mff.cuni.cz header.i=@kam.mff.cuni.cz header.b="Dg4Q8hMA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387748AbfHARqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 13:46:33 -0400
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:51790 "EHLO
        nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732471AbfHARqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 13:46:33 -0400
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 3081)
        id 4DE21281AC4; Thu,  1 Aug 2019 19:46:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kam.mff.cuni.cz;
        s=gen1; t=1564681591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UZJPmwQ0kVcDvUUwN38aLK9+F/uu4BDRy3q5bFVWb0Q=;
        b=Dg4Q8hMAw5K3/Ea8D8F3UCo7CH5oAotdl2OX/QOwlgZT4ZhBM7+HWBIpNLlFm3evgRuSvL
        e2EBYCqJflxcZc/bd0nHDmwkJRTdN/6w6QSSuqPu9YjM33OAw5tu37y4QqflwiQrvZ0aiY
        mrUrcJ5uknz5pE/pg5z0AqLTDxiFiEc=
Date:   Thu, 1 Aug 2019 19:46:31 +0200
From:   Jan Hadrava <had@kam.mff.cuni.cz>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        wizards@kam.mff.cuni.cz, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: [BUG]: mm/vmscan.c: shrink_slab does not work correctly with
 memcg disabled via commandline
Message-ID: <20190801174631.ulnlx3pi2g2rznzk@kam.mff.cuni.cz>
References: <20190801134250.scbfnjewahbt5zui@kam.mff.cuni.cz>
 <20190801140610.GM11627@dhcp22.suse.cz>
 <20190801155434.2dftso2wuggfuv7a@kam.mff.cuni.cz>
 <20190801163213.GO11627@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190801163213.GO11627@dhcp22.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 06:32:13PM +0200, Michal Hocko wrote:
> On Thu 01-08-19 17:54:34, Jan Hadrava wrote:
> > Just to be sure, i run my tests and patch proposed in the original thread
> > solves my issue in all four affected stable releases:
> 
> Cc Andrew.

Are you sure? I can't see any change in e-mail headers.

> I assume we can assume your Tested-by tag?

Well, these test only checked, that bug is present without the patch
and disappears after applying it. Anyway: I am ok with it.


-- 
Jan Hadrava
