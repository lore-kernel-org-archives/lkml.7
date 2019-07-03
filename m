Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D2AC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 11:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD01218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 11:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfGCLel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 07:34:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37558 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbfGCLel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 07:34:41 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4EF5780F81;
        Wed,  3 Jul 2019 11:34:41 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id DC90A16D2B;
        Wed,  3 Jul 2019 11:34:37 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed,  3 Jul 2019 13:34:41 +0200 (CEST)
Date:   Wed, 3 Jul 2019 13:34:37 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        syzkaller-bugs@googlegroups.com
Subject: Re: Reminder: 22 open syzbot bugs in perf subsystem
Message-ID: <20190703113436.GA21672@redhat.com>
References: <20190702054342.GB27702@sol.localdomain>
 <5a99f556-7449-55da-d901-0249352a5e15@linux.ibm.com>
 <20190703035550.GA633@sol.localdomain>
 <4d6ce02e-9325-4247-3d9b-51cdfcfaee07@linux.ibm.com>
 <20190703041918.GB633@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703041918.GB633@sol.localdomain>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 03 Jul 2019 11:34:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02, Eric Biggers wrote:
>
> Even if it's a lockdep false positive you can't ignore it.  People rely on
> lockdep to find bugs, and they will keep sending you bug reports.  So someone
> has to fix something.  Did you see Oleg's suggestion to change mmput() to
> mmput_async() in binder_alloc_free_page()?
> https://marc.info/?l=linux-kernel&m=155119805728815&w=2
> If you believe that is the right fix, I can reassign this report to binder
> subsystem and nag the binder maintainers instead...

Yes, please. To me s/mmput/mmput_async/ looks like the "obviously correct fix",
but of course I don't understand this code and can't test it.

Oleg.

