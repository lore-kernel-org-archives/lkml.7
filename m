Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F3CC10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 07:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93C0A2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 07:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfCRHbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 03:31:36 -0400
Received: from nat.nue.novell.com ([195.135.221.2]:21253 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726135AbfCRHbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 03:31:36 -0400
Received: by suse.de (Postfix, from userid 1000)
        id B626C45E0; Mon, 18 Mar 2019 08:31:34 +0100 (CET)
Date:   Mon, 18 Mar 2019 08:31:34 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, david@redhat.com, mike.kravetz@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/2] Unlock 1GB-hugetlb on x86_64
Message-ID: <20190318073130.mgqvtwbxw23hpdok@d104.suse.de>
References: <20190304085147.556-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304085147.556-1-osalvador@suse.de>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 09:51:45AM +0100, Oscar Salvador wrote:
> RFC -> V1:
> 	- Split up the patch
> 	- Added Michal's Acked-by
> 
> The RFC version of this patch was discussed here [1], and it did not find any
> objection.
> I decided to split up the former patch because one of the changes enables
> offlining operation for 1GB-hugetlb pages, while the other change is a mere
> cleanup.
> 
> Patch1 contains all the information regarding 1GB-hugetlb pages change.
> 
> [1] https://lore.kernel.org/linux-mm/20190221094212.16906-1-osalvador@suse.de/
> 
> Oscar Salvador (2):
>   mm,memory_hotplug: Unlock 1GB-hugetlb on x86_64
>   mm,memory_hotplug: Drop redundant hugepage_migration_supported check
> 
>  mm/memory_hotplug.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

Andrew, now that the merge window is closed, do you want me to re-base and
re-send this, or will you pick it up as is?

Thanks

-- 
Oscar Salvador
SUSE L3
