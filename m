Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D21C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4057206CD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403993AbfIFMX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 08:23:59 -0400
Received: from gate.crashing.org ([63.228.1.57]:51751 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731928AbfIFMX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 08:23:58 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x86CNoUZ027069;
        Fri, 6 Sep 2019 07:23:50 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x86CNnID027066;
        Fri, 6 Sep 2019 07:23:49 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 6 Sep 2019 07:23:49 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>
Subject: Re: [PATCH v2 4/6] compiler-gcc.h: add asm_inline definition
Message-ID: <20190906122349.GZ9749@gate.crashing.org>
References: <20190829083233.24162-1-linux@rasmusvillemoes.dk> <20190830231527.22304-1-linux@rasmusvillemoes.dk> <20190830231527.22304-5-linux@rasmusvillemoes.dk> <CAKwvOdktYpMH8WnEQwNE2JJdKn4w0CHv3L=YHkqU2JzQ6Qwkew@mail.gmail.com> <a5085133-33da-6c13-6953-d18cbc6ad3f5@rasmusvillemoes.dk> <20190905134535.GP9749@gate.crashing.org> <CANiq72nXXBgwKcs36R+uau2o1YypfSFKAYWV2xmcRZgz8LRQww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72nXXBgwKcs36R+uau2o1YypfSFKAYWV2xmcRZgz8LRQww@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 05:52:44PM +0200, Miguel Ojeda wrote:
> On Thu, Sep 5, 2019 at 3:45 PM Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> >
> > [ That's not what a feature test macro is; a feature test macro allows the
> >   user to select some optional behaviour.  Things like _GNU_SOURCE.  ]
> 
> Yes and no. GNU libc defines feature test macros like you say, but
> C++'s feature macros are like Rasmus/Nick are saying. I think libc's

I can't find anything with "feature" and "macros" in the C++ standard,
it's "predefined macros" there I guess?  In C, it is also "predefined
macros" in general, and there is "conditional feature macros".

> definition is weird, I would call those "feature selection macros"
> instead, because the user is selecting between some features (whether
> to enable or not, for instance), rather than testing for the features.

Sure.  But the name is traditional, many decades old, it predates glibc.
Using an established name to mean pretty much the opposite of what it
normally does is a bit confusing, never mind if that usage makes much
sense ;-)


Segher
