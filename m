Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120B1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C392147C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389064AbfC0TPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:15:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:59260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388311AbfC0TPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 15:15:41 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B29C52082F;
        Wed, 27 Mar 2019 19:15:39 +0000 (UTC)
Date:   Wed, 27 Mar 2019 15:15:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ronald =?UTF-8?B?VHNjaGFsw6Ry?= <ronald@innovation.ch>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Federico Lorenzi <federico@travelground.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] Input: add Apple SPI keyboard and trackpad
 driver.
Message-ID: <20190327151538.2ca6ac83@gandalf.local.home>
In-Reply-To: <20190327184526.GA11095@kroah.com>
References: <20190327014807.7472-1-ronald@innovation.ch>
        <20190327014807.7472-5-ronald@innovation.ch>
        <20190327093530.GH9224@smile.fi.intel.com>
        <20190327184526.GA11095@kroah.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2019 19:45:26 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> > > +// SPDX-License-Identifier: GPL-2.0  
> > 
> > According to last changes this should be GPL-2.0-only  
> 
> What "last changes"?  "GPL-2.0" is a totally valid SPDX identifier for
> the kernel.  Don't buy into the "-only" prefix crud that the newer SPDX
> version adopted for crazy reasons.  The in-kernel documentation lists
> the valid identifiers and the version of SPDX we are currently using.

According to: LICENSES/preferred/GPL-2.0

> SPDX-URL: https://spdx.org/licenses/GPL-2.0.html
> Usage-Guide:
>   To use this license in source code, put one of the following SPDX
>   tag/value pairs into a comment according to the placement
>   guidelines in the licensing rules documentation.
>   For 'GNU General Public License (GPL) version 2 only' use:
>     SPDX-License-Identifier: GPL-2.0
>   or
>     SPDX-License-Identifier: GPL-2.0-only
>   For 'GNU General Public License (GPL) version 2 or any later version' use:
>     SPDX-License-Identifier: GPL-2.0+
>   or
>     SPDX-License-Identifier: GPL-2.0-or-later

So, GPL-2.0 is the same as GPL-2.0-only. Changing it from one to the
other doesn't make any difference.

-- Steve
