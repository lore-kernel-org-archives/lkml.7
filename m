Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E18ECE58E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95941206C2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbfJGS3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 14:29:00 -0400
Received: from smtprelay0148.hostedemail.com ([216.40.44.148]:46744 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728031AbfJGS26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 14:28:58 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 190F9182251CC;
        Mon,  7 Oct 2019 18:28:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: neck58_87ecfa613314b
X-Filterd-Recvd-Size: 2424
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Mon,  7 Oct 2019 18:28:53 +0000 (UTC)
Message-ID: <0e5abed9afe267155cc8601d0fd7fdaa63883920.camel@perches.com>
Subject: Re: [PATCH 2/4] compiler_attributes.h: Add 'fallthrough' pseudo
 keyword for switch/case use
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pavel Machek <pavel@ucw.cz>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Shawn Landden <shawn@git.icu>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Date:   Mon, 07 Oct 2019 11:28:53 -0700
In-Reply-To: <CAKwvOdkVZ64sLppKxF1XRgarPmCbhw1WLsSq1VcV1tagPgWtUg@mail.gmail.com>
References: <cover.1570292505.git.joe@perches.com>
         <79237afe056af8d81662f183491e3589922b8ddd.1570292505.git.joe@perches.com>
         <CANiq72kU2_s=58HqdN6VMGDAh_+G+dtns9xzoc4huSVwP+ZXUg@mail.gmail.com>
         <CAKwvOdkVZ64sLppKxF1XRgarPmCbhw1WLsSq1VcV1tagPgWtUg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-10-07 at 11:14 -0700, Nick Desaulniers wrote:
> > On Sat, Oct 5, 2019 at 6:46 PM Joe Perches <joe@perches.com> wrote:
> > > Reserve the pseudo keyword 'fallthrough' for the ability to convert the
> 
> Have we precedent already for "pseudo keywords?"

Many.  see bool vs _Bool, u32 vs uint32_t, etc.

> I kind of like the
> double underscore prefix we use for attributes (which this is one of),

Linus apparently (and rightly IMO) prefers
fallthrough over __fallthrough.

https://lore.kernel.org/lkml/201909161516.A68C8239A@keescook/


