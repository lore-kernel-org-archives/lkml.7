Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F1FC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 12:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF6E4216B7
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 12:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731424AbfHFM6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 08:58:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:31545 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbfHFM6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 08:58:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 470F2C069B52;
        Tue,  6 Aug 2019 12:58:10 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A5074608AB;
        Tue,  6 Aug 2019 12:58:09 +0000 (UTC)
Date:   Tue, 6 Aug 2019 08:58:07 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched: use rq_lock/unlock in online_fair_sched_group
Message-ID: <20190806125807.GA19399@pauld.bos.csb>
References: <20190806060416.11440-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806060416.11440-1-hdanton@sina.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 06 Aug 2019 12:58:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 02:04:16PM +0800 Hillf Danton wrote:
> 
> On Mon, 5 Aug 2019 22:07:05 +0800 Phil Auld wrote:
> >
> > If we're to clear that flag right there, outside of the lock pinning code,
> > then I think we might as well just remove the flag and all associated
> > comments etc, no?
> 
> A diff may tell the Peter folks more about your thoughts?
> 

I provided a diff with my thoughts of how to remove this warning in
the original post :)

This comment was about your patch which, to my mind, makes the flag 
meaningless and so could just remove the whole thing. I was not 
proposing to actually do that. I assumed it was there because it was
thought to be useful. Although, if that is what people want I could 
certainly spin up a patch to that effect. 


Cheers,
Phil

> Hillf
> 

-- 
