Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2D9C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 650F2204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbfDPPtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:49:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60614 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbfDPPtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:49:03 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 77CA3F74B5;
        Tue, 16 Apr 2019 15:49:03 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CE825D71A;
        Tue, 16 Apr 2019 15:48:59 +0000 (UTC)
Date:   Tue, 16 Apr 2019 11:48:59 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
        dm-devel@redhat.com
Subject: Re: [PATCH 10/57] docs: device-mapper: convert it to ReST format
Message-ID: <20190416154858.GB22497@redhat.com>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
 <9dd3c4eca01489bd67ea6de88dfedef8b0e81901.1555382110.git.mchehab+samsung@kernel.org>
 <20190416132851.GA22497@redhat.com>
 <20190416080024.7fb65682@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416080024.7fb65682@lwn.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 16 Apr 2019 15:49:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16 2019 at 10:00am -0400,
Jonathan Corbet <corbet@lwn.net> wrote:

> On Tue, 16 Apr 2019 09:28:52 -0400
> Mike Snitzer <snitzer@redhat.com> wrote:
> 
> > Can you help me understand why this is the direction text based
> > Documenation is taking in the Linux kernel?  All I see is markup, and
> > escaping of characters, that is a chore to administer over time.
> 
> This is a discussion that was mostly resolved some years ago...
> 
> Classic Documentation/ is a jumbled collection of unorganized text files,
> some of which contain highly useful information and others of which
> haven't had much to offer since about 1996.  We are working to turn it
> into an organized collection where, hopefully, some thought has actually
> been given to the people who will be reading it.
> 
> The ReST conversion, in particular, allows us to link documents into a
> larger structure, create indexes and cross references, and produce output
> in formats like HTML and PDF.  It lets us present the documentation like
> this:
> 
> 	https://www.kernel.org/doc/html/latest/
> 
> Among other things, making the documentation more accessible in this way
> makes it easier and more rewarding for developers to improve it, and I
> believe we are seeing the results of that.  Linus called out the
> documentation work in the 5.1-rc1 announcement, for example.
> 
> Nobody has complained about the maintenance burden of RST docs - so far as
> I have heard, anyway.  Things do break occasionally, but problems in the
> docs build almost always result from code changes that mess up the
> kerneldoc comments rather than RST changes, and it's been that way for as
> long as I've been paying attention.

Thanks for the context.  I clearly just haven't followed the evolution.
Certainly looks like a solid improvement.

Think the last piece I'm missing is: how does one edit a .rst document
without having to know to sprinkle syntactic sugar around?  Does emacs
have a ReST mode?  If not what client interface are people using to
properly change these documents?

(apologies if this is all spelled out nicely in Documentation/
somewhere, but please help this man learn to fish).

Thanks,
Mike
