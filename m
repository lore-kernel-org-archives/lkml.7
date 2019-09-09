Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39952C49ED5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 08:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 095D821920
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 08:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568016726;
	bh=tH3lZKBQ0LXr97/i7bvxIazD5GOoEEJunwPoFaBXM4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WkZ2WHkjM1qsiv9jBY58dRm29dZ7ockWLI4HRVVNYJMtDhH6Fgbc9+wq2JShGLteT
	 5fFUXGUv6J3YP5LnSHj3oa+OHkvbQyQbRGm7yZxMxkHekscSraMXRmdMXU7XsmCSJK
	 Pad7mCemYSU5GGyypcJQyj+5J+PyRZLBuL59/s1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388756AbfIIIMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 04:12:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:57992 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388733AbfIIIME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 04:12:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 310F0B6A0;
        Mon,  9 Sep 2019 08:12:02 +0000 (UTC)
Date:   Mon, 9 Sep 2019 10:12:00 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, akpm@linux-foundation.org,
        david@redhat.com, osalvador@suse.com, pasha.tatashin@soleen.com,
        dan.j.williams@intel.com, richard.weiyang@gmail.com, cai@lca.pw,
        linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Remove __online_page_set_limits()
Message-ID: <20190909081200.GB27159@dhcp22.suse.cz>
References: <cover.1567889743.git.jrdr.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1567889743.git.jrdr.linux@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 08-09-19 03:17:01, Souptick Joarder wrote:
> __online_page_set_limits() is a dummy function and an extra call
> to this can be avoided.
> 
> As both of the callers are now removed, __online_page_set_limits()
> can be removed permanently.
> 
> Souptick Joarder (3):
>   hv_ballon: Avoid calling dummy function __online_page_set_limits()
>   xen/ballon: Avoid calling dummy function __online_page_set_limits()
>   mm/memory_hotplug.c: Remove __online_page_set_limits()
> 
>  drivers/hv/hv_balloon.c        | 1 -
>  drivers/xen/balloon.c          | 1 -
>  include/linux/memory_hotplug.h | 1 -
>  mm/memory_hotplug.c            | 5 -----
>  4 files changed, 8 deletions(-)

To the whole series
Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!
-- 
Michal Hocko
SUSE Labs
