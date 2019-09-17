Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139F6C4CECE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 22:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E245621848
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 22:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfIQW0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 18:26:47 -0400
Received: from smtprelay0092.hostedemail.com ([216.40.44.92]:50117 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726283AbfIQW0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 18:26:46 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id E206918225B0E;
        Tue, 17 Sep 2019 22:26:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bulb69_1c956a5c79822
X-Filterd-Recvd-Size: 2973
Received: from XPS-9350 (unknown [14.161.9.139])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Tue, 17 Sep 2019 22:26:36 +0000 (UTC)
Message-ID: <45dd0d8dffa6718d8cbcd24720e9e39dddb08134.camel@perches.com>
Subject: Re: treewide replacement of fallthrough comments with "fallthrough"
 macro (was Re: [RFC PATCH] compiler_attributes.h: Add 'fallthrough' pseudo
 keyword for switch/case use)
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     hpa@zytor.com, Peter Zijlstra <peterz@infradead.org>,
        Pavel Machek <pavel@ucw.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Shawn Landden <shawn@git.icu>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 17 Sep 2019 15:26:32 -0700
In-Reply-To: <201909161516.A68C8239A@keescook>
References: <e0dd3af448e38e342c1ac6e7c0c802696eb77fd6.1564549413.git.joe@perches.com>
         <1d2830aadbe9d8151728a7df5b88528fc72a0095.1564549413.git.joe@perches.com>
         <20190731171429.GA24222@amd>
         <ccc7fa72d0f83ddd62067092b105bd801479004b.camel@perches.com>
         <765E740C-4259-4835-A58D-432006628BAC@zytor.com>
         <20190731184832.GZ31381@hirez.programming.kicks-ass.net>
         <201907311301.EC1D84F@keescook> <201908151049.809B9AFBA9@keescook>
         <201909161516.A68C8239A@keescook>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-09-16 at 15:19 -0700, Kees Cook wrote:
> On Thu, Aug 15, 2019 at 11:15:53AM -0700, Kees Cook wrote:
> > With that out of the way, yes, let's do a mass conversion. As mentioned
> > before, I think "fallthrough;" should be used here (to match "break;").
> > Let's fork the C language. :)
> 
> FWIW, last week I asked Linus at the maintainer's summit which he
> preferred ("__fallthrough" or "fallthrough") and he said "fallthrough".

Nice.  I think that's better style/taste.

> Joe, if you've still got the series ready, do you want to send it for
> this merge window before -rc1 gets cut?

The first bits that add fallthrough and converts the one existing
use of fallthrough as a label can be sent now.  I'll do that in
a few days as I'm not able to do that right now.

Sending any actual comment conversion patches before -rc1 might
require changes in already queued up and tested patches

I do think a scripted conversion by major subsystem/directory
might be a better mechanism than individual patches, especially
if applied directly before releasing what will be -rc1.



