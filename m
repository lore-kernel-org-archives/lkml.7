Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38494C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155B42085A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfGDQA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 12:00:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33182 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbfGDQA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 12:00:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 419D5C01DE89;
        Thu,  4 Jul 2019 16:00:22 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id BE18D99AFF;
        Thu,  4 Jul 2019 16:00:18 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  4 Jul 2019 18:00:21 +0200 (CEST)
Date:   Thu, 4 Jul 2019 18:00:18 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>, Qian Cai <cai@lca.pw>,
        hch@lst.de, gkohli@codeaurora.org, mingo@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: fix a crash in do_task_dead()
Message-ID: <20190704160017.GB29995@redhat.com>
References: <1559161526-618-1-git-send-email-cai@lca.pw>
 <20190530080358.GG2623@hirez.programming.kicks-ass.net>
 <82e88482-1b53-9423-baad-484312957e48@kernel.dk>
 <20190603123705.GB3419@hirez.programming.kicks-ass.net>
 <ddf9ee34-cd97-a62b-6e91-6b4511586339@kernel.dk>
 <alpine.LSU.2.11.1906301542410.1105@eggly.anvils>
 <97d2f5cc-fe98-f28e-86ce-6fbdeb8b67bd@kernel.dk>
 <20190702150615.1dfbbc2345c1c8f4d2a235c0@linux-foundation.org>
 <20190703173546.GB21672@redhat.com>
 <alpine.LSU.2.11.1907031039180.1132@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.1907031039180.1132@eggly.anvils>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 04 Jul 2019 16:00:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03, Hugh Dickins wrote:
>
> Thank you, Oleg. But, with respect, I'd caution against making it cleverer
> at the last minute: what you posted already is understandable, works, has
> Jen's Reviewed-by and my Acked-by: it just lacks a description and signoff.

OK, agreed. I am sending that patch as-is with yours and Jen's acks applied.

Oleg.

