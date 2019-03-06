Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B4BC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 650B720663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbfCFQxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 11:53:08 -0500
Received: from www.llwyncelyn.cymru ([82.70.14.225]:53436 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727964AbfCFQxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 11:53:08 -0500
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id x26GqVK0011338;
        Wed, 6 Mar 2019 16:52:31 GMT
Date:   Wed, 6 Mar 2019 16:52:30 +0000
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Matthew Wilcox <willy@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jann Horn <jannh@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        kernel list <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: a.out coredumping: fix or delete?
Message-ID: <20190306165230.75b7d110@alans-desktop>
In-Reply-To: <20190306141144.GD7930@mit.edu>
References: <CAG48ez1RVd5mQ_Pb6eygQESaZhpQz765OAZYSoPE0kPqfZEXQg@mail.gmail.com>
        <20190305091904.GB8256@zn.tnic>
        <20190305122218.GD13380@bombadil.infradead.org>
        <alpine.DEB.2.21.1903061323030.1646@nanos.tec.linutronix.de>
        <20190306141144.GD7930@mit.edu>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Mar 2019 09:11:44 -0500
"Theodore Y. Ts'o" <tytso@mit.edu> wrote:

> On Wed, Mar 06, 2019 at 01:25:17PM +0100, Thomas Gleixner wrote:
> > > It's been 25 years since Linux added support for ELF.  Can we just
> > > delete the a.out support entirely now?  According to the Linux-ELF HOWTO,
> > > support was added in 1.1.52 (August 1994).  It's pretty much necromancy
> > > at this point.  
> > 
> > The Kernel-Necrophilia cult members might disagree. :)
> > 
> > But yes, good riddance.  
> 
> Doesn't Minix 1.0 use a.out?  It *is* cool to be able to binaries from
> run dead operating systems.  :-)

Minixemu compiled fine ELF last time I checked 8). It does need  a 32bit
system as it still uses virtual 86 model.

Alan
