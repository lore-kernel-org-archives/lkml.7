Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6074C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 16:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9580825D5F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 16:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbfE3QLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 12:11:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51240 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbfE3QLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 12:11:09 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 26820859FF;
        Thu, 30 May 2019 16:11:09 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C18591001E93;
        Thu, 30 May 2019 16:11:04 +0000 (UTC)
Date:   Thu, 30 May 2019 12:11:03 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, dm-devel@redhat.com,
        agk@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: dm-init: fix 2 incorrect use of kstrndup()
Message-ID: <20190530161103.GA30026@redhat.com>
References: <20190529013320.GA3307@zhanggen-UX430UQ>
 <fcf2c3c0-e479-9e74-59d5-79cd2a0bade6@acm.org>
 <20190529152443.GA4076@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529152443.GA4076@zhanggen-UX430UQ>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 30 May 2019 16:11:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29 2019 at 11:24am -0400,
Gen Zhang <blackgod016574@gmail.com> wrote:

> On Wed, May 29, 2019 at 05:23:53AM -0700, Bart Van Assche wrote:
> > On 5/28/19 6:33 PM, Gen Zhang wrote:
> > > In drivers/md/dm-init.c, kstrndup() is incorrectly used twice.
> > > 
> > > It should be: char *kstrndup(const char *s, size_t max, gfp_t gfp);
> > 
> > Should the following be added to this patch?
> > 
> > Fixes: 6bbc923dfcf5 ("dm: add support to directly boot to a mapped
> > device") # v5.1.
> > Cc: stable
> > 
> > Thanks,
> > 
> > Bart.
> Personally, I am not quite sure about this question, because I am not 
> the maintainer of this part.

Yes, it should have the tags Bart suggested.

I'll take care it.

Thanks,
Mike
