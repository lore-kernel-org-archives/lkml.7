Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F36AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5867020828
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732069AbfDAIK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:10:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:48274 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726168AbfDAIK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:10:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7D935AE7D;
        Mon,  1 Apr 2019 08:10:54 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0D3991E42C7; Mon,  1 Apr 2019 10:10:54 +0200 (CEST)
Date:   Mon, 1 Apr 2019 10:10:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jan Kara <jack@suse.cz>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        yangerkun <yangerkun@huawei.com>
Subject: Re: linux-next: Fixes tag needs some work in the ext3 tree
Message-ID: <20190401081054.GC4826@quack2.suse.cz>
References: <20190330161939.231c39cd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190330161939.231c39cd@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen

On Sat 30-03-19 16:19:39, Stephen Rothwell wrote:
> In commit
> 
>   47d92aa5d33a ("quota: fix a problem about transfer quota")
> 
> Fixes tag
> 
>   Fixes: 7b9ca4c61("quota: Reduce contention on dq_data_lock")
> 
> has these problem(s):
> 
>   - missing space between the SHA1 and the subject
>   - SHA1 should be at least 12 digits long
>     Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
>     or later) just making sure it is not set (or set to "auto").

Thanks for the notice. I didn't notice the problems when merging the patch.
I've fixed these problems up.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
