Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B59C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 13:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3327620693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 13:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387591AbfGPNfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 09:35:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:32872 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726039AbfGPNfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 09:35:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3FADBAD8A;
        Tue, 16 Jul 2019 13:35:35 +0000 (UTC)
Date:   Tue, 16 Jul 2019 15:35:34 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Vincent Whitchurch <rabinv@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] printk: Do not lose last line in kmsg buffer dump
Message-ID: <20190716133534.oyau67ocjvfegkex@pathway.suse.cz>
References: <20190711142937.4083-1-vincent.whitchurch@axis.com>
 <20190712091251.or4bitunknzhrigf@pathway.suse.cz>
 <20190712092253.GA7922@jagdpanzerIV>
 <20190712131158.5wgy5wxjtqn6uqly@pathway.suse.cz>
 <20190713060300.GA1038@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190713060300.GA1038@tigerII.localdomain>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2019-07-13 15:03:00, Sergey Senozhatsky wrote:
> On (07/12/19 15:11), Petr Mladek wrote:
> > > Looks correct to me as well.
> > > 
> > > Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > 
> > The patch has been committed into printk.git, branch for-5.3-fixes.
> > 
> > I am still a bit undecided whether to send pull request the following
> > week or wait for 5.4. On one hand, it is very old bug (since 3.5).
> > On the other hand, I think that it was not reported/fixed earlier
> > only because it was hard to notice. And loosing the very last message
> > is quite pity.
> 
> My call would be - let's wait till next merge window.

Thanks for your opinion.

I'll leave it for 5.4 unless there is another urgent fix that would
trigger earlier pull request.

Best Regards,
Petr
