Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DBDC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D102190F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbfGVNa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 09:30:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:44388 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726925AbfGVNa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 09:30:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 705ADB06B;
        Mon, 22 Jul 2019 13:30:55 +0000 (UTC)
Date:   Mon, 22 Jul 2019 15:30:53 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Qian Cai <cai@lca.pw>, Christoph Hellwig <hch@lst.de>,
        iommu <iommu@lists.linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iommu/amd: fix a crash in iova_magazine_free_pfns
Message-ID: <20190722133053.GI19068@suse.de>
References: <1562861865-23660-1-git-send-email-cai@lca.pw>
 <CAHk-=wgwd9vT1h7jKMU_E4ae2QLFFH69UxcXpO3J9YqEApdUNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgwd9vT1h7jKMU_E4ae2QLFFH69UxcXpO3J9YqEApdUNg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Sun, Jul 21, 2019 at 09:58:04AM -0700, Linus Torvalds wrote:
> This one seems to have fallen through the cracks.
> 
> Applied directly.

Thanks!

> Maybe it's hiding in some fixes tree that I haven't gotten a pull
> request for yet?

No, I havn't had it applied anywhere yet. I usually don't pay close
attention to patches sent to me during the merge window, as I won't
update my tree anyway before -rc1.

I only take care of important fixes, but this one seems to have
fallen through my heuristic. Thanks for applying it directly.


Regards,

	Joerg
