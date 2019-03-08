Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BD1C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 20:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137E2205C9
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 20:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfCHUAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 15:00:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39636 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbfCHUAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 15:00:22 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A0A143019893;
        Fri,  8 Mar 2019 20:00:22 +0000 (UTC)
Received: from treble (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 81CE2600C1;
        Fri,  8 Mar 2019 20:00:19 +0000 (UTC)
Date:   Fri, 8 Mar 2019 14:00:15 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, luto@kernel.org,
        bp@alien8.de, dvlasenk@redhat.com, linux-kernel@vger.kernel.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: Re: [PATCH 13/20] objtool: Hande function aliases
Message-ID: <20190308200014.35aglaxjrr5f252c@treble>
References: <20190307114511.870090179@infradead.org>
 <20190307115200.238778618@infradead.org>
 <20190308192358.65kzunthwzvsdifg@treble>
 <20190308195254.GG32494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190308195254.GG32494@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 08 Mar 2019 20:00:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 08:52:54PM +0100, Peter Zijlstra wrote:
> On Fri, Mar 08, 2019 at 01:23:58PM -0600, Josh Poimboeuf wrote:
> > 
> > On Thu, Mar 07, 2019 at 12:45:24PM +0100, Peter Zijlstra wrote:
> > > Function aliases result in different symbols for the same set of
> > > instructions; track a canonical symbol so there is a unique point of
> > > access.
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > 
> > s/Hande/Handle/ in $SUBJECT
> 
> Whoops :-)
> 
> > Also you can clarify why we need to track aliases?
> 
> Function attributes (as per that previous patch) and: git grep "alias"
> mm/kasan.

Ok, such details would be good in the patch description.

-- 
Josh
