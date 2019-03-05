Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C8BC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 13:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AA1620842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 13:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbfCEN7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 08:59:50 -0500
Received: from www.llwyncelyn.cymru ([82.70.14.225]:42700 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727931AbfCEN7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 08:59:50 -0500
X-Greylist: delayed 942 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Mar 2019 08:59:49 EST
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id x25DhmaK011242;
        Tue, 5 Mar 2019 13:43:48 GMT
Date:   Tue, 5 Mar 2019 13:43:47 +0000
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>, Jann Horn <jannh@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: a.out coredumping: fix or delete?
Message-ID: <20190305134347.4be2449c@alans-desktop>
In-Reply-To: <20190305122218.GD13380@bombadil.infradead.org>
References: <CAG48ez1RVd5mQ_Pb6eygQESaZhpQz765OAZYSoPE0kPqfZEXQg@mail.gmail.com>
        <20190305091904.GB8256@zn.tnic>
        <20190305122218.GD13380@bombadil.infradead.org>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> It's been 25 years since Linux added support for ELF.  Can we just
> delete the a.out support entirely now?  According to the Linux-ELF HOWTO,
> support was added in 1.1.52 (August 1994).  It's pretty much necromancy
> at this point.

In the unlikely event that someone actually has an a.out binary they
can't live with they can also just write an a.out loader as an ELF
program entirely in userspace.

I'd vote for giving it the boot unless there are any architectures that
kept using a.out far longer due to tool chain issues ?

Alan
