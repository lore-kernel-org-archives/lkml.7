Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB916C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A838821850
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555578152;
	bh=UE4W7VKVVwEGwQTcBVy4w09bSvdkMTQUcCa4i1tBaBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AODOIAwYIPSINB+Bl3Pf4fcdZq0XFBPFE1baMflzUyPJsWPlD1AYkbuVzIARbEF71
	 oAZcS45/OjqdEIEDWbcpXXTzhL/gb9GLR/77mnxJSLP+npt33n96YQmyeK0qWFKqK4
	 9NNlNKxJ3tQlr3GHK6IjfgOZsXot8izZIIpl0r6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388367AbfDRJCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:02:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:46622 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388036AbfDRJCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 05:02:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8FE47AEBB;
        Thu, 18 Apr 2019 09:02:28 +0000 (UTC)
Date:   Thu, 18 Apr 2019 11:02:27 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mgorman@techsingularity.net, riel@surriel.com, hannes@cmpxchg.org,
        akpm@linux-foundation.org, dave.hansen@intel.com,
        keith.busch@intel.com, dan.j.williams@intel.com,
        fengguang.wu@intel.com, fan.du@intel.com, ying.huang@intel.com,
        ziy@nvidia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 RFC PATCH 0/9] Another Approach to Use PMEM as NUMA Node
Message-ID: <20190418090227.GG6567@dhcp22.suse.cz>
References: <1554955019-29472-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190412084702.GD13373@dhcp22.suse.cz>
 <a68137bb-dcd8-4e4a-b3a9-69a66f9dccaf@linux.alibaba.com>
 <20190416074714.GD11561@dhcp22.suse.cz>
 <876768ad-a63a-99c3-59de-458403f008c4@linux.alibaba.com>
 <c0fe0c54-b61a-4f5d-8af5-59818641e747@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0fe0c54-b61a-4f5d-8af5-59818641e747@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-04-19 13:43:44, Yang Shi wrote:
[...]
> And, I'm wondering whether this optimization is also suitable to general
> NUMA balancing or not.

If there are convincing numbers then this should be a preferable way to
deal with it. Please note that the number of promotions is not the only
metric to watch. The overal performance/access latency would be another one.

-- 
Michal Hocko
SUSE Labs
