Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368F4C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 19:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0356D208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 19:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfCET7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 14:59:36 -0500
Received: from smtprelay0251.hostedemail.com ([216.40.44.251]:47128 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726695AbfCET7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 14:59:36 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 3234F1804DF7E;
        Tue,  5 Mar 2019 19:59:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: light17_8d7e215a2710d
X-Filterd-Recvd-Size: 2239
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Tue,  5 Mar 2019 19:59:32 +0000 (UTC)
Message-ID: <e244390e3d245c94d6d2fb036943e63111ada86d.camel@perches.com>
Subject: Re: [PATCH] docs: add extra integer types to printk-formats
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Louis Taylor <louis@kragniz.eu>, Jonathan Corbet <corbet@lwn.net>,
        pmladek@suse.com, geert+renesas@glider.be,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        Jon Flatley <jflat@chromium.org>
Date:   Tue, 05 Mar 2019 11:59:30 -0800
In-Reply-To: <CAKwvOdm4uCWCtSMVQDVTSKavpT0dCo+ayuwvoXtewmk+ksn5sA@mail.gmail.com>
References: <20190303123647.22020-1-louis@kragniz.eu>
         <20190303201016.GO9224@smile.fi.intel.com>
         <CAKwvOdm4uCWCtSMVQDVTSKavpT0dCo+ayuwvoXtewmk+ksn5sA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-04 at 09:59 -0800, Nick Desaulniers wrote:
> On Sun, Mar 3, 2019 at 12:10 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Sun, Mar 03, 2019 at 12:36:47PM +0000, Louis Taylor wrote:
> > > A few commonly used integer types were absent from this table, so add
> > > them.
> > 
> > I'm not against the patch, but isn't obvious by reading POSIX and / or man
> > printf(3)?
> 
> You'd think; but based on the sheer number of -Wformat warnings
> (~450), I'm not so sure.

<shrug>  software defects are always present.

Many of the -Wformat warnings are bogus too.

There's nothing wrong with using %x for a unsigned int
of less than long size. (u8/u16)

>   At least with this patch they're "above the
> fold."

I'd personally go with
"posix plus kernel specific deletions and extensions"

> The kernel also has its own format flag extensions, and does not
> implement %n (for good reason), so it's better to be explicit than
> imply posix or glibc compat.

%i is also supported and used a few hundred times


