Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C26C5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 23:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8CC2082F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 23:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfGEXDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 19:03:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:59876 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725878AbfGEXDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 19:03:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9284BACB8;
        Fri,  5 Jul 2019 23:03:18 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6CB3A1E300F; Sat,  6 Jul 2019 01:03:12 +0200 (CEST)
Date:   Sat, 6 Jul 2019 01:03:12 +0200
From:   Jan Kara <jack@suse.cz>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
        Qian Cai <cai@lca.pw>, Jan Kara <jack@suse.cz>,
        kirill.shutemov@linux.intel.com, songliubraving@fb.com,
        william.kucharski@oracle.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: kernel BUG at mm/swap_state.c:170!
Message-ID: <20190705230312.GB6485@quack2.suse.cz>
References: <CABXGCsN9mYmBD-4GaaeW_NrDu+FDXLzr_6x+XNxfmFV6QkYCDg@mail.gmail.com>
 <CABXGCsNq4xTFeeLeUXBj7vXBz55aVu31W9q74r+pGM83DrPjfA@mail.gmail.com>
 <20190529180931.GI18589@dhcp22.suse.cz>
 <CABXGCsPrk=WJzms_H+-KuwSRqWReRTCSs-GLMDsjUG_-neYP0w@mail.gmail.com>
 <CABXGCsMjDn0VT0DmP6qeuiytce9cNBx8PywpqejiFNVhwd0UGg@mail.gmail.com>
 <ee245af2-a0ae-5c13-6f1f-2418f43d1812@suse.cz>
 <CABXGCsOpj_E7jL9OpMX4wZbMktiF=9WOyeTv1R-W59gFMGC7mw@mail.gmail.com>
 <CABXGCsOizgLhJYUDos+ZVPZ5iV3gDeAcSpgvg-weVchgOsTjcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXGCsOizgLhJYUDos+ZVPZ5iV3gDeAcSpgvg-weVchgOsTjcA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 05-07-19 20:19:48, Mikhail Gavrilov wrote:
> Hey folks.
> Excuse me, is anybody read my previous message?
> 5.2-rc7 is still affected by this issue [the logs in file
> dmesg-5.2rc7-0.1.tar.xz] and I worry that stable 5.2 would be released
> with this bug because there is almost no time left and I didn't see
> the attention to this problem.
> I confirm that reverting commit 5fd4ca2d84b2 on top of the rc7 tag is
> help fix it [the logs in file dmesg-5.2rc7-0.2.tar.xz].
> I am still awaiting any feedback here.

Yeah, I guess revert of 5fd4ca2d84b2 at this point is probably the best we
can do. Let's CC Linus, Andrew, and Greg (Linus is travelling AFAIK so I'm
not sure whether Greg won't do release for him).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
