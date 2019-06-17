Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA28C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A472084A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfFQPt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 11:49:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:47386 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725863AbfFQPt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 11:49:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ADE99ADEC;
        Mon, 17 Jun 2019 15:49:27 +0000 (UTC)
Date:   Mon, 17 Jun 2019 17:49:23 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Alastair D'Silva <alastair@d-silva.org>
Cc:     'Michal Hocko' <mhocko@kernel.org>,
        'Alastair D'Silva' <alastair@au1.ibm.com>,
        'Arun KS' <arunks@codeaurora.org>,
        'Mukesh Ojha' <mojha@codeaurora.org>,
        'Logan Gunthorpe' <logang@deltatee.com>,
        'Wei Yang' <richard.weiyang@gmail.com>,
        'Peter Zijlstra' <peterz@infradead.org>,
        'Ingo Molnar' <mingo@kernel.org>, linux-mm@kvack.org,
        'Qian Cai' <cai@lca.pw>,
        'Thomas Gleixner' <tglx@linutronix.de>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        'Mike Rapoport' <rppt@linux.vnet.ibm.com>,
        'Baoquan He' <bhe@redhat.com>,
        'David Hildenbrand' <david@redhat.com>,
        'Josh Poimboeuf' <jpoimboe@redhat.com>,
        'Pavel Tatashin' <pasha.tatashin@soleen.com>,
        'Juergen Gross' <jgross@suse.com>,
        'Oscar Salvador' <osalvador@suse.com>,
        'Jiri Kosina' <jkosina@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] mm/hotplug: Avoid RCU stalls when removing large
 amounts of memory
Message-ID: <20190617154923.GB2407@linux>
References: <20190617043635.13201-1-alastair@au1.ibm.com>
 <20190617043635.13201-5-alastair@au1.ibm.com>
 <20190617074715.GE30420@dhcp22.suse.cz>
 <068b01d524e2$4a5f5c30$df1e1490$@d-silva.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <068b01d524e2$4a5f5c30$df1e1490$@d-silva.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 05:57:16PM +1000, Alastair D'Silva wrote:
> I was getting stalls when removing ~1TB of memory.

Would you mind sharing one of those stalls-splats?
I am bit spectic here because as I Michal pointed out, we do cond_resched
once per section removed.

-- 
Oscar Salvador
SUSE L3
