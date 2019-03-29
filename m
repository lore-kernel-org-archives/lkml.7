Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA6CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 12:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A627217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 12:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbfC2MzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 08:55:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57382 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729464AbfC2MzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 08:55:13 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CA3CB80E5D;
        Fri, 29 Mar 2019 12:55:12 +0000 (UTC)
Received: from localhost (ovpn-12-24.pek2.redhat.com [10.72.12.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 345D46B48A;
        Fri, 29 Mar 2019 12:55:06 +0000 (UTC)
Date:   Fri, 29 Mar 2019 20:55:03 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rafael@kernel.org, akpm@linux-foundation.org,
        rppt@linux.ibm.com, willy@infradead.org, fanc.fnst@cn.fujitsu.com
Subject: Re: [PATCH v3 2/2] drivers/base/memory.c: Rename the misleading
 parameter
Message-ID: <20190329125503.GK7627@MiWiFi-R3L-srv>
References: <20190329082915.19763-1-bhe@redhat.com>
 <20190329082915.19763-2-bhe@redhat.com>
 <20190329091325.GD28616@dhcp22.suse.cz>
 <20190329093725.blpcyane33fnxvn7@d104.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329093725.blpcyane33fnxvn7@d104.suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 29 Mar 2019 12:55:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/29/19 at 10:37am, Oscar Salvador wrote:
> On Fri, Mar 29, 2019 at 10:13:25AM +0100, Michal Hocko wrote:
> > On Fri 29-03-19 16:29:15, Baoquan He wrote:
> > > The input parameter 'phys_index' of memory_block_action() is actually
> > > the section number, but not the phys_index of memory_block. Fix it.
> > 
> > I have tried to explain that the naming is mostly a relict from the past
> > than really a misleading name http://lkml.kernel.org/r/20190326093315.GL28406@dhcp22.suse.cz
> > Maybe it would be good to reflect that in the changelog
> 
> I think that phys_device variable in remove_memory_section() is also a relict
> from the past, and it is no longer used.
> Neither node_id variable is used.
> Actually, unregister_memory_section() sets those two to 0 no matter what.
> 
> Since we are cleaning up, I wonder if we can go a bit further and we can get
> rid of that as well.

Yes, certainly. I would like to post a new one to carry this.
