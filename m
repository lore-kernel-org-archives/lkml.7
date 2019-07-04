Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DECC06517
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 10:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 482D22189E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 10:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfGDKd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 06:33:57 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:55529 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbfGDKd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 06:33:56 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id f64b375983fe7ff7; Thu, 4 Jul 2019 12:33:54 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: linux-next: build failure after merge of the pm tree
Date:   Thu, 04 Jul 2019 12:33:54 +0200
Message-ID: <1831286.bib1kMyzdQ@kreacher>
In-Reply-To: <20190704094834.xbfjvdmly6maw75b@vireshk-i7>
References: <20190704194114.086d6a17@canb.auug.org.au> <20190704094834.xbfjvdmly6maw75b@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 4, 2019 11:48:34 AM CEST Viresh Kumar wrote:
> On 04-07-19, 19:41, Stephen Rothwell wrote:
> > Hi all,
> > 
> > After merging the pm tree, today's linux-next build (x86_64 allnoconfig)
> > failed like this:
> > 
> > In file included from kernel/power/qos.c:33:
> > include/linux/pm_qos.h: In function 'dev_pm_qos_read_value':
> > include/linux/pm_qos.h:205:9: error: expected '(' before 'type'
> >   switch type {
> >          ^~~~
> >          (
> > include/linux/pm_qos.h:205:9: warning: statement with no effect [-Wunused-value]
> >   switch type {
> >          ^~~~
> > include/linux/pm_qos.h:216:1: warning: no return statement in function returning non-void [-Wreturn-type]
> >  }
> >  ^
> > include/linux/pm_qos.h: At top level:
> > include/linux/pm_qos.h:231:4: error: expected identifier or '(' before '{' token
> >     { return 0; }
> >     ^
> > In file included from kernel/power/qos.c:33:
> > include/linux/pm_qos.h:228:19: warning: 'dev_pm_qos_add_notifier' declared 'static' but never defined [-Wunused-function]
> >  static inline int dev_pm_qos_add_notifier(struct device *dev,
> >                    ^~~~~~~~~~~~~~~~~~~~~~~
> > 
> > Caused by commits
> > 
> >   024a47a2732d ("PM / QOS: Pass request type to dev_pm_qos_{add|remove}_notifier()")
> >   57fa6137402b ("PM / QOS: Pass request type to dev_pm_qos_read_value()")
> 
> Yeah, I have already sent the replacement patchset to Rafael.

And which has been applied promptly.

Thanks,
Rafael



