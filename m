Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C99C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 21:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34990208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 21:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfJJVe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 17:34:59 -0400
Received: from smtprelay0048.hostedemail.com ([216.40.44.48]:53601 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726942AbfJJVe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 17:34:58 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id A9E0F182CED5B;
        Thu, 10 Oct 2019 21:34:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bag93_2b1d66130f213
X-Filterd-Recvd-Size: 1788
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Thu, 10 Oct 2019 21:34:56 +0000 (UTC)
Message-ID: <889073497c3f8bed25acb0015049837141a3b688.camel@perches.com>
Subject: Re: [PATCH 3/3] tracing/hwlat: Fix a few trivial nits
From:   Joe Perches <joe@perches.com>
To:     "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc:     amakhalov@vmware.com, akaher@vmware.com, anishs@vmware.com,
        bordoloih@vmware.com, srivatsab@vmware.com
Date:   Thu, 10 Oct 2019 14:34:55 -0700
In-Reply-To: <157073346821.17189.8946944856026592247.stgit@srivatsa-ubuntu>
References: <157073343544.17189.13911783866738671133.stgit@srivatsa-ubuntu>
         <157073346821.17189.8946944856026592247.stgit@srivatsa-ubuntu>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-10-10 at 11:51 -0700, Srivatsa S. Bhat wrote:
> Update the source file name in the comments, and fix a grammatical
> error.
[]
> diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
[]
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * trace_hwlatdetect.c - A simple Hardware Latency detector.
> + * trace_hwlat.c - A simple Hardware Latency detector.

trivia:

Generally it's not useful to have the filename in a comment
so I think maybe delete the "trace_hwlatdetect.c - ".

btw:

$ git ls-files -- '*.[ch]' | \
  while read file ; do git grep $file -- $file; done | wc -l

About 5% (2500 of the 50000 or so) *.[ch] files in the kernel
source tree contain their filename in a comment, so it's
certainly not that unusual.


