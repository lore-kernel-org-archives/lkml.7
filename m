Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31542C4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 08:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F84920872
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 08:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438766AbfJQIDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 04:03:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:57330 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389100AbfJQIDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 04:03:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2B1E5AF05;
        Thu, 17 Oct 2019 08:03:24 +0000 (UTC)
Date:   Thu, 17 Oct 2019 10:03:21 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm, soft-offline: convert parameter to pfn
Message-ID: <20191017080315.GA31827@linux>
References: <20191016070924.GA10178@hori.linux.bs1.fc.nec.co.jp>
 <e931b14b-da27-2720-5344-b5c0b08b38ad@redhat.com>
 <20191016082735.GB13770@hori.linux.bs1.fc.nec.co.jp>
 <c78962ba-ffa1-90e2-0116-6c94d082de2f@redhat.com>
 <20191016085359.GD13770@hori.linux.bs1.fc.nec.co.jp>
 <997b5b51-db71-3e27-1f84-cbaa24fa66c7@redhat.com>
 <20191016234706.GA5493@www9186uo.sakura.ne.jp>
 <ac4c1ab9-1df6-6a30-30ed-a015622ef591@redhat.com>
 <20191017075018.GA10225@hori.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017075018.GA10225@hori.linux.bs1.fc.nec.co.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 07:50:18AM +0000, Naoya Horiguchi wrote:
> Actually I guess that !pfn_valid() never happens when called from
> madvise_inject_error(), because madvise_inject_error() gets pfn via
> get_user_pages_fast() which only returns valid page for valid pfn.
> 
> And we plan to remove MF_COUNT_INCREASED by Oscar's re-design work,
> so I start feeling that this patch should come on top of his tree.

Hi Naoya,

I am pretty much done with my testing.
If you feel like, I can take the patch and add it on top of [1]
, then I will do some more testing and, if nothing pops up, I will
send it upstream.

[1] https://github.com/leberus/linux/tree/hwpoison-v2

> 
> Thanks,
> Naoya Horiguchi

-- 
Oscar Salvador
SUSE L3
