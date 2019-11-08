Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D75FC6195
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 15:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7853721D7E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 15:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfKHPho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 10:37:44 -0500
Received: from gentwo.org ([3.19.106.255]:39006 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfKHPho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 10:37:44 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id 649CF3E89B; Fri,  8 Nov 2019 15:37:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 637063E89A;
        Fri,  8 Nov 2019 15:37:43 +0000 (UTC)
Date:   Fri, 8 Nov 2019 15:37:43 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Knut Omang <knut.omang@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: provide interface for retrieving kmem_cache name
In-Reply-To: <20191107131342.GT8314@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1911081534470.32431@www.lameter.com>
References: <20191107115404.3030723-1-knut.omang@oracle.com> <20191107115806.GP8314@dhcp22.suse.cz> <27006f47b0b85fb99acee2a638207268aef8d010.camel@oracle.com> <20191107131342.GT8314@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Nov 2019, Michal Hocko wrote:

> On Thu 07-11-19 13:26:09, Knut Omang wrote:
> > On Thu, 2019-11-07 at 12:58 +0100, Michal Hocko wrote:
> > > On Thu 07-11-19 12:54:04, Knut Omang wrote:
> > > > With the restructuring done in commit 9adeaa226988
> > > > ("mm, slab: move memcg_cache_params structure to mm/slab.h")
> > > >
> > > > it is no longer possible for code external to mm to access

That patch only affected the memcg_cache_params structure and not
kmem_cache.

And I do not see any references to the memcg_cache_param?

The fields that all allocators need to expose are listed in
the struct kmme_cache definition in linux/mm/slab.h.

