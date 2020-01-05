Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LOTS_OF_MONEY,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DEAC33C8C
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 21:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB23320801
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 21:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgAEV2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 16:28:35 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38656 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726792AbgAEV2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 16:28:35 -0500
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 005LSV87017267
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 5 Jan 2020 16:28:31 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 531144200AF; Sun,  5 Jan 2020 16:28:31 -0500 (EST)
Date:   Sun, 5 Jan 2020 16:28:31 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Evan Rudford <zocker76@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Is the Linux kernel underfunded? Lack of quality and security?
Message-ID: <20200105212831.GD4253@mit.edu>
References: <CAE90CG6SGWKXToVhY5VH-AzUjC6UEwRzoisUXM0OQe9XgcCHRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE90CG6SGWKXToVhY5VH-AzUjC6UEwRzoisUXM0OQe9XgcCHRA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 05, 2020 at 04:47:33AM +0100, Evan Rudford wrote:
> The problem of underfunding plagues many open source projects.
> I wonder whether the Linux kernel suffers from underfunding in
> comparison to its global reach.
> Although code reviews and technical discussions are working well, I
> argue that the testing infrastructure of the kernel is lacking.
> Severe bugs are discovered late, and they are discovered by developers
> that should not be exposed to that amount of breakage.
> Moreover, I feel that security issues do not receive enough resources.

It sounds like you are unaware of the Kernel Self Protection Project
(KSPP), which is focused on proactively improving the kernel's
security features, and the KernelCI project.  There is quite a lot of
work happening already.

One of the challenges is that is an extremely large number of
different ways a kernel can be configured, and that a *very* large
number of the bugs tend to be hardware specific.  Running CI on all
possible hardware that might run Linux is really not practical; but
there is a very large number of tests being run on both VM's and on
those hardware platforms that companies who are donating hardware to
KernelCI care about.

Keep in mind that there is *always* the opportunity to do more testing
and QA work.  Companies which care about specific hardware and
software configurations are contributing resources (both money and
engineering headcount) to improve the quality for those specific
configurations.  So there is *always* opportunities where more
resources can improve any product.  This is true whether you are
talking about, say, a $15,000 Ford Fiesta or a $115,000 Porsche 911.

If you have access to resources that you would like to contribute, and
have some specific areas where you would like to see improvement, we
can certainly put you in touch with the various organizations, such as
the Linux Foundation, which are organizing efforts such as KernelCI.
There are also a number of engineers from a goodly number of companies
contributing to the Kernel Self Protection Project.  If you are
interested in getting involved, please see:

    https://kernsec.org/wiki/index.php/Kernel_Self_Protection_Project

Cheers,

					- Ted
