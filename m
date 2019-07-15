Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A87C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43838206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563196658;
	bh=jCPjCQEF2hTlNTNSaNDKyc7y2xhLbJk7NYJ30NPKuuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=b3Z14Qixc5CTGcIZ760YlznswwzSTwyUBbJ/8LGaFsEFXYgqDUPLzL+ahRTuSiAGA
	 36nYcsxclPQJ6s3Y+lf87MmvdcWI2jsJWcaMi84Lu0sfi1/ckfq+x6tlLGuCcw/RvU
	 9yebu4VRDaV1Tkaq8u5iGvhpwmm68HDY3WcmRgfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730177AbfGONRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 09:17:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:49938 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730012AbfGONRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 09:17:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0CA51AF7E;
        Mon, 15 Jul 2019 13:17:34 +0000 (UTC)
Date:   Mon, 15 Jul 2019 15:17:32 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     dvyukov@google.com, catalin.marinas@arm.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: page_alloc: document kmemleak's non-blockable
 __GFP_NOFAIL case
Message-ID: <20190715131732.GX29483@dhcp22.suse.cz>
References: <1562964544-59519-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562964544-59519-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 13-07-19 04:49:04, Yang Shi wrote:
> When running ltp's oom test with kmemleak enabled, the below warning was
> triggerred since kernel detects __GFP_NOFAIL & ~__GFP_DIRECT_RECLAIM is
> passed in:

kmemleak is broken and this is a long term issue. I thought that
Catalin had something to address this.

While this patch only adds a comment and discourages future changes of
the warning which is fine and probably something that we should do,
kmemleak really should be fixed sooner than later.
-- 
Michal Hocko
SUSE Labs
