Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5220DC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 22:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D7332166E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 22:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404581AbfHHWnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 18:43:18 -0400
Received: from namei.org ([65.99.196.166]:39598 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732938AbfHHWnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 18:43:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x78Mh5V0015311;
        Thu, 8 Aug 2019 22:43:05 GMT
Date:   Fri, 9 Aug 2019 08:43:05 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Matthew Garrett <mjg59@google.com>
cc:     Jessica Yu <jeyu@kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH V37 04/29] Enforce module signatures if the kernel is
 locked down
In-Reply-To: <CACdnJuu6gFQUQQOVj2MwL5+dx+XsBKY=Uq58r7F8Lr2C0Gi_TA@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1908090842390.14740@namei.org>
References: <20190731221617.234725-1-matthewgarrett@google.com> <20190731221617.234725-5-matthewgarrett@google.com> <20190801142157.GA5834@linux-8ccs> <CACdnJusD_9W9tFqwKptDTA8fZU8HrSvsEQhKo0WS9QxLpgz5tA@mail.gmail.com> <20190808100059.GA30260@linux-8ccs>
 <CACdnJuu6gFQUQQOVj2MwL5+dx+XsBKY=Uq58r7F8Lr2C0Gi_TA@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Aug 2019, Matthew Garrett wrote:

> On Thu, Aug 8, 2019 at 3:01 AM Jessica Yu <jeyu@kernel.org> wrote:
> > If you're confident that a hard dependency is not the right approach,
> > then perhaps we could add a comment in the Kconfig (You could take a
> > look at the comment under MODULE_SIG_ALL in init/Kconfig for an
> > example)? If someone is configuring the kernel on their own then it'd
> > be nice to let them know, otherwise having a lockdown kernel without
> > module signatures would defeat the purpose of lockdown no? :-)
> 
> James, what would your preference be here? Jessica is right that not
> having CONFIG_MODULE_SIG enabled means lockdown probably doesn't work
> as expected, but tying it to the lockdown LSM seems inappropriate when
> another LSM could be providing lockdown policy and run into the same
> issue. Should this just be mentioned in the CONFIG_MODULE_SIG Kconfig
> help?

I agree and yes mention it in the help.  A respin of just this patch is 
fine.

-- 
James Morris
<jmorris@namei.org>

