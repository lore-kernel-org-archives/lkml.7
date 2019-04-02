Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C19C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635A72070D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfDBUQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 16:16:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:38000 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725812AbfDBUQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 16:16:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E90F1AEA3;
        Tue,  2 Apr 2019 20:16:31 +0000 (UTC)
Message-ID: <1554236175.2828.5.camel@suse.de>
Subject: Re: [PATCH] mm/hugetlb: Get rid of NODEMASK_ALLOC
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     mike.kravetz@oracle.com, n-horiguchi@ah.jp.nec.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Tue, 02 Apr 2019 22:16:15 +0200
In-Reply-To: <20190402130153.338e59c6cfda1ed3ec882517@linux-foundation.org>
References: <20190402133415.21983-1-osalvador@suse.de>
         <20190402130153.338e59c6cfda1ed3ec882517@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-04-02 at 13:01 -0700, Andrew Morton wrote:
> It took a bit of sleuthing to figure out that this patch applies to
> Mike's "hugetlbfs: fix potential over/underflow setting node specific
> nr_hugepages".  Should they be folded together?  I'm thinking not.

Sorry Andrew, I should have mentioned that this patch was based on
Mike's "hugetlb fix potential over/underflow" patch.

Given said that, I would keep the two patches separated, as that one
is a fix, and this one is a cleanup.

> (Also, should "hugetlbfs: fix potential over/underflow setting node
> specific nr_hugepages" have been -stableified?  I also think not, but
> I
> bet it happens anyway).

I am not sure of the consequences in older branches, but if it is not
too much of a hassle, it might be worth? Mike might know better here.

-- 
Oscar Salvador
SUSE L3
