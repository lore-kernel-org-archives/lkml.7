Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5DEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A78C32173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbfC2Jh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 05:37:27 -0400
Received: from charybdis-ext.suse.de ([195.135.221.2]:61449 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727387AbfC2Jh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 05:37:27 -0400
Received: by suse.de (Postfix, from userid 1000)
        id 8CF184743; Fri, 29 Mar 2019 10:37:25 +0100 (CET)
Date:   Fri, 29 Mar 2019 10:37:25 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rafael@kernel.org, akpm@linux-foundation.org,
        rppt@linux.ibm.com, willy@infradead.org, fanc.fnst@cn.fujitsu.com
Subject: Re: [PATCH v3 2/2] drivers/base/memory.c: Rename the misleading
 parameter
Message-ID: <20190329093725.blpcyane33fnxvn7@d104.suse.de>
References: <20190329082915.19763-1-bhe@redhat.com>
 <20190329082915.19763-2-bhe@redhat.com>
 <20190329091325.GD28616@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329091325.GD28616@dhcp22.suse.cz>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 10:13:25AM +0100, Michal Hocko wrote:
> On Fri 29-03-19 16:29:15, Baoquan He wrote:
> > The input parameter 'phys_index' of memory_block_action() is actually
> > the section number, but not the phys_index of memory_block. Fix it.
> 
> I have tried to explain that the naming is mostly a relict from the past
> than really a misleading name http://lkml.kernel.org/r/20190326093315.GL28406@dhcp22.suse.cz
> Maybe it would be good to reflect that in the changelog

I think that phys_device variable in remove_memory_section() is also a relict
from the past, and it is no longer used.
Neither node_id variable is used.
Actually, unregister_memory_section() sets those two to 0 no matter what.

Since we are cleaning up, I wonder if we can go a bit further and we can get
rid of that as well.

-- 
Oscar Salvador
SUSE L3
