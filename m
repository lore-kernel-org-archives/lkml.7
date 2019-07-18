Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A12C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 18:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A591F2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 18:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390901AbfGRSJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 14:09:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60044 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726715AbfGRSJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 14:09:02 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DA9DC81DE5;
        Thu, 18 Jul 2019 18:09:01 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-160.bos.redhat.com [10.18.17.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B827360922;
        Thu, 18 Jul 2019 18:09:00 +0000 (UTC)
Subject: Re: [PATCH v2 0/2] mm, slab: Extend slab/shrink to shrink all memcg
 caches
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
References: <20190718180733.18596-1-longman@redhat.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <4d2ca559-4a59-1368-7b40-f05b9aefe84e@redhat.com>
Date:   Thu, 18 Jul 2019 14:09:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190718180733.18596-1-longman@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 18 Jul 2019 18:09:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/19 2:07 PM, Waiman Long wrote:
>  v2:
>   - Just extend the shrink sysfs file to shrink all memcg caches without
>     adding new semantics.
>   - Add a patch to report the time of the shrink operation.
>
> This patchset enables the slab/shrink sysfs file to shrink all the
> memcg caches that are associated with the given root cache. The time of
> the shrink operation can now be read from the shrink file.
>
> Waiman Long (2):
>   mm, slab: Extend slab/shrink to shrink all memcg caches
>   mm, slab: Show last shrink time in us when slab/shrink is read
>
>  Documentation/ABI/testing/sysfs-kernel-slab | 14 +++++---
>  include/linux/slub_def.h                    |  1 +
>  mm/slab.h                                   |  1 +
>  mm/slab_common.c                            | 37 +++++++++++++++++++++
>  mm/slub.c                                   | 14 +++++---
>  5 files changed, 59 insertions(+), 8 deletions(-)
>
Sorry, it is a mistake. Please ignore it.

-Longman

