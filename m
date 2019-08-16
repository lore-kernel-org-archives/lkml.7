Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABC1C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 08:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5478820644
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 08:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfHPI1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 04:27:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:43054 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725945AbfHPI1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 04:27:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 79DA6AFC3;
        Fri, 16 Aug 2019 08:27:53 +0000 (UTC)
Date:   Fri, 16 Aug 2019 10:27:53 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 4/8] printk: Replace strncmp with str_has_prefix
Message-ID: <20190816082753.wvaj7hzn4zu3jgjd@pathway.suse.cz>
References: <20190809071034.17279-1-hslester96@gmail.com>
 <20190814104941.qt66ozcau5fdswcs@pathway.suse.cz>
 <20190815075033.GA26479@tigerII.localdomain>
 <20190815135221.qcgerido7aahmpgn@pathway.suse.cz>
 <CANhBUQ3Gco8kR7xiMknFv3ryyfnfeiJO1R-rHzNWBux8b8=LSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANhBUQ3Gco8kR7xiMknFv3ryyfnfeiJO1R-rHzNWBux8b8=LSw@mail.gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-08-15 23:33:01, Chuhong Yuan wrote:
> On Thu, Aug 15, 2019 at 9:52 PM Petr Mladek <pmladek@suse.com> wrote:
> >
> > On Thu 2019-08-15 16:50:33, Sergey Senozhatsky wrote:
> > > On (08/14/19 12:49), Petr Mladek wrote:
> > > > On Fri 2019-08-09 15:10:34, Chuhong Yuan wrote:
> > > > > strncmp(str, const, len) is error-prone because len
> > > > > is easy to have typo.
> > > > > The example is the hard-coded len has counting error
> > > > > or sizeof(const) forgets - 1.
> > > > > So we prefer using newly introduced str_has_prefix()
> > > > > to substitute such strncmp to make code better.
> > > > >
> > > > > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> > > >
> > > > Reviewed-by: Petr Mladek <pmladek@suse.com>
> > >
> > > Reviewed-by:  Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> >
> > Chuong Yuan, should I take this patch via printk.git? Or will
> > the entire series go via some other tree, please?
> >
> 
> I think that it goes via printk.git is okay, thanks!

The patch is commited into printk.git, branch for-5.4.

Best Regards,
Petr
