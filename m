Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BC6C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7E582173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390101AbfHHQdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 12:33:55 -0400
Received: from namei.org ([65.99.196.166]:39470 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfHHQdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 12:33:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x78GXbYN032334;
        Thu, 8 Aug 2019 16:33:37 GMT
Date:   Fri, 9 Aug 2019 02:33:37 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Jessica Yu <jeyu@kernel.org>
cc:     Matthew Garrett <matthewgarrett@google.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH V38 19/29] Lock down module params that specify hardware
 parameters (eg. ioport)
In-Reply-To: <20190808111246.GA29211@linux-8ccs>
Message-ID: <alpine.LRH.2.21.1908090232530.31143@namei.org>
References: <20190808000721.124691-1-matthewgarrett@google.com> <20190808000721.124691-20-matthewgarrett@google.com> <20190808111246.GA29211@linux-8ccs>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Aug 2019, Jessica Yu wrote:

> > +#ifdef CONFIG_MODULES
> > +#define mod_name(mod) ((mod)->name)
> > +#else
> > +#define mod_name(mod) "unknown"
> > +#endif
> > +
> 
> Hm, I don't think mod_name is used anywhere?
> 
> But other than that:
> 
> Acked-by: Jessica Yu <jeyu@kernel.org>
> 

Matthew: no need to respin the patchset just for this. 

-- 
James Morris
<jmorris@namei.org>

