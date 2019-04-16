Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B665C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447822239C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbfDPOA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:00:26 -0400
Received: from ms.lwn.net ([45.79.88.28]:38808 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbfDPOAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:00:25 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 368F4537;
        Tue, 16 Apr 2019 14:00:25 +0000 (UTC)
Date:   Tue, 16 Apr 2019 08:00:24 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
        dm-devel@redhat.com
Subject: Re: [PATCH 10/57] docs: device-mapper: convert it to ReST format
Message-ID: <20190416080024.7fb65682@lwn.net>
In-Reply-To: <20190416132851.GA22497@redhat.com>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
        <9dd3c4eca01489bd67ea6de88dfedef8b0e81901.1555382110.git.mchehab+samsung@kernel.org>
        <20190416132851.GA22497@redhat.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2019 09:28:52 -0400
Mike Snitzer <snitzer@redhat.com> wrote:

> Can you help me understand why this is the direction text based
> Documenation is taking in the Linux kernel?  All I see is markup, and
> escaping of characters, that is a chore to administer over time.

This is a discussion that was mostly resolved some years ago...

Classic Documentation/ is a jumbled collection of unorganized text files,
some of which contain highly useful information and others of which
haven't had much to offer since about 1996.  We are working to turn it
into an organized collection where, hopefully, some thought has actually
been given to the people who will be reading it.

The ReST conversion, in particular, allows us to link documents into a
larger structure, create indexes and cross references, and produce output
in formats like HTML and PDF.  It lets us present the documentation like
this:

	https://www.kernel.org/doc/html/latest/

Among other things, making the documentation more accessible in this way
makes it easier and more rewarding for developers to improve it, and I
believe we are seeing the results of that.  Linus called out the
documentation work in the 5.1-rc1 announcement, for example.

Nobody has complained about the maintenance burden of RST docs - so far as
I have heard, anyway.  Things do break occasionally, but problems in the
docs build almost always result from code changes that mess up the
kerneldoc comments rather than RST changes, and it's been that way for as
long as I've been paying attention.

Thanks,

jon
