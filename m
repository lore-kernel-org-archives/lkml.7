Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9A8C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2685C2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391654AbfFKPG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 11:06:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55080 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389502AbfFKPG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 11:06:28 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DFE0430832C9;
        Tue, 11 Jun 2019 15:06:19 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 596CD60C4C;
        Tue, 11 Jun 2019 15:06:16 +0000 (UTC)
Date:   Tue, 11 Jun 2019 11:06:14 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     bsegall@google.com, linux-kernel@vger.kernel.org,
        Xunlei Pang <xlpang@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v2] sched/fair: don't push cfs_bandwith slack timers
 forward
Message-ID: <20190611150614.GF15412@pauld.bos.csb>
References: <xm26ef47yeyh.fsf@bsegall-linux.svl.corp.google.com>
 <eafe846f-d83c-b2f3-4458-45e3ae6e5823@linux.alibaba.com>
 <xm26a7euy6iq.fsf_-_@bsegall-linux.svl.corp.google.com>
 <20190611135325.GY3436@hirez.programming.kicks-ass.net>
 <20190611141219.GD15412@pauld.bos.csb>
 <20190611142443.GZ3436@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611142443.GZ3436@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 11 Jun 2019 15:06:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 04:24:43PM +0200 Peter Zijlstra wrote:
> On Tue, Jun 11, 2019 at 10:12:19AM -0400, Phil Auld wrote:
> 
> > That looks reasonable to me. 
> > 
> > Out of curiosity, why not bool? Is sizeof bool architecture dependent?
> 
> Yeah, sizeof(_Bool) is unspecified and depends on ABI. It is mostly 1,
> but there are known cases where it is 4.

Makes sense. Thanks!

-- 
