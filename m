Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791C2C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD2720857
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732041AbfDAHwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:52:15 -0400
Received: from charybdis-ext.suse.de ([195.135.221.2]:8619 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731956AbfDAHwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 03:52:14 -0400
Received: by suse.de (Postfix, from userid 1000)
        id 9C2D3479D; Mon,  1 Apr 2019 09:52:12 +0200 (CEST)
Date:   Mon, 1 Apr 2019 09:52:12 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, david@redhat.com,
        dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 0/4] mm,memory_hotplug: allocate memmap from hotadded
 memory
Message-ID: <20190401075204.zaxgmgyrejjaq3az@d104.suse.de>
References: <20190328134320.13232-1-osalvador@suse.de>
 <91cfdf41-ef43-1f18-36b8-806e246538a0@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91cfdf41-ef43-1f18-36b8-806e246538a0@nvidia.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 03:23:00PM -0700, John Hubbard wrote:
> On 3/28/19 6:43 AM, Oscar Salvador wrote:
> > Hi,
> > 
> > since last two RFCs were almost unnoticed (thanks David for the feedback),
> > I decided to re-work some parts to make it more simple and give it a more
> > testing, and drop the RFC, to see if it gets more attention.
> > I also added David's feedback, so now all users of add_memory/__add_memory/
> > add_memory_resource can specify whether they want to use this feature or not.
> > I also fixed some compilation issues when CONFIG_SPARSEMEM_VMEMMAP is not set.
> > 
> 
> Hi Oscar, say, what tree and/or commit does this series apply to? I'm having some
> trouble finding the right place. Sorry for the easy question, I did try quite
> a few trees already...

Hi John, I somehow forgot to mention it in the cover-letter, sorry.
This patchsed is based on v5.1-rc2-31-gece06d4a8149 + the following fixes
on top:

* https://patchwork.kernel.org/patch/10862609/
* https://patchwork.kernel.org/patch/10862611/
* https://patchwork.kernel.org/patch/10853049/

-- 
Oscar Salvador
SUSE L3
