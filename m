Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68945C282DD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41C9520870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfDHH1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:27:33 -0400
Received: from charybdis-ext.suse.de ([195.135.221.2]:8526 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725854AbfDHH1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:27:33 -0400
Received: by suse.de (Postfix, from userid 1000)
        id A8CB64890; Mon,  8 Apr 2019 09:27:31 +0200 (CEST)
Date:   Mon, 8 Apr 2019 09:27:31 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     akpm@linux-foundation.org, rafael@kernel.org, david@redhat.com,
        rafael.j.wysocki@intel.com, mhocko@suse.com, vbabka@suse.cz,
        iamjoonsoo.kim@lge.com, bsingharora@gmail.com,
        gregkh@linuxfoundation.org, yangyingliang@huawei.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RESENT PATCH] mm/memory_hotplug: Do not unlock when fails to
 take the device_hotplug_lock
Message-ID: <20190408072723.vbwtc5mruvx3un35@d104.suse.de>
References: <1554696437-9593-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554696437-9593-1-git-send-email-zhongjiang@huawei.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 12:07:17PM +0800, zhong jiang wrote:
> When adding the memory by probing memory block in sysfs interface, there is an
> obvious issue that we will unlock the device_hotplug_lock when fails to takes it.
> 
> That issue was introduced in Commit 8df1d0e4a265
> ("mm/memory_hotplug: make add_memory() take the device_hotplug_lock")
> 
> We should drop out in time when fails to take the device_hotplug_lock.
> 
> Fixes: 8df1d0e4a265 ("mm/memory_hotplug: make add_memory() take the device_hotplug_lock")
> Reported-by: Yang yingliang <yangyingliang@huawei.com>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE L3
