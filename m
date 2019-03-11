Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E99C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C82402087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfCKWnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 18:43:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38672 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbfCKWnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 18:43:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1DC7E3087BA7;
        Mon, 11 Mar 2019 22:43:37 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7730E5DAAF;
        Mon, 11 Mar 2019 22:43:34 +0000 (UTC)
Date:   Mon, 11 Mar 2019 18:43:33 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Nikos Tsironis <ntsironis@arrikto.com>, agk@redhat.com,
        dm-devel@redhat.com, mpatocka@redhat.com, iliastsi@arrikto.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] list_bl: Add hlist_bl_add_before/behind helpers
Message-ID: <20190311224333.GA16968@redhat.com>
References: <20181220180651.4879-1-ntsironis@arrikto.com>
 <20181220180651.4879-2-ntsironis@arrikto.com>
 <20190228213201.GB23527@redhat.com>
 <20190311181607.GA9388@infradead.org>
 <20190311221321.GP13351@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311221321.GP13351@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 11 Mar 2019 22:43:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11 2019 at  6:13pm -0400,
Paul E. McKenney <paulmck@linux.ibm.com> wrote:

> On Mon, Mar 11, 2019 at 11:16:08AM -0700, Christoph Hellwig wrote:
> > On Thu, Feb 28, 2019 at 04:32:02PM -0500, Mike Snitzer wrote:
> > > Hi Paul and Christoph,
> > > 
> > > You've added your Signed-off-by to include/linux/list_bl.h commits in
> > > the past.  I'm not sure how this proposed patch should be handled.
> > > 
> > > These new hlist_bl_add_{before,behind} changes are a prereq for
> > > dm-snapshot changes that Nikos has proposed, please see:
> > > https://patchwork.kernel.org/patch/10739265/
> > > 
> > > Any assistance/review you, or others on LKML, might be able to provide
> > > would be appreciated.
> > 
> > I just killed two helpers.  That being said assuming that we only
> > rely on the next pointer for the lockless traversals the changes look
> > fine to me, but the code might be beyond my paygrade..
> 
> First, apologies for being slow on this one.

No problem.
 
> Second, were the two helpers hlist_bl_add_{before,behind}()?  If so, I
> guess there is not much point in me looking them over.  Though perhaps
> I should be looking something else over?

No, think Christoph was referring to his commit 1879fd6a26571fd4e8e1f
from 2011.

Anyway, I'd like you to look over this new proposed patch that
introduces hlist_bl_add_{before,behind}(), please see:
https://patchwork.kernel.org/patch/10835713/

If you're happy with the patch, and can provide your Reviewed-by or
Acked-by, I'll then pick it up as a prereq for the broader dm-snapshot
changes that Nikos has provided.

Thanks!
Mike
