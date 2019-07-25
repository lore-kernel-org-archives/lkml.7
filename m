Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF8CC76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 23:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 381E4229F3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 23:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfGYXJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 19:09:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47917 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfGYXJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 19:09:12 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hqmr9-0006fi-T6; Fri, 26 Jul 2019 01:09:04 +0200
Date:   Fri, 26 Jul 2019 01:09:03 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v4 0/2] Support kexec/kdump for clang built kernel
In-Reply-To: <CAKwvOdnBKcEFkv2qEWPaFEjPSmR_SXBo2ZGz7ho9pBc88dZJBA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1907260105280.1791@nanos.tec.linutronix.de>
References: <20190725200625.174838-1-ndesaulniers@google.com> <20190725200625.174838-3-ndesaulniers@google.com> <alpine.DEB.2.21.1907260038580.1791@nanos.tec.linutronix.de> <CAKwvOdnBKcEFkv2qEWPaFEjPSmR_SXBo2ZGz7ho9pBc88dZJBA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jul 2019, Nick Desaulniers wrote:
> On Thu, Jul 25, 2019 at 3:51 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Thu, 25 Jul 2019, Nick Desaulniers wrote:
> >
> > I'm really impressed how you manage to make the cover letter (0/N) a reply
> > to 1/N instead of 1..N/N being a reply to 0/N.
> >
> >   In-Reply-To: <20190725200625.174838-1-ndesaulniers@google.com>
> >   Message-Id: <20190725200625.174838-3-ndesaulniers@google.com>
> >
> > Is that a new git feature to be $corp top-posting compliant?
> 
> It appears to be a hidden bonus feature of:
> $ git-send-email purgatory/v4-000*

Care to poke the git folks?

> > > V4 of: https://lkml.org/lkml/2019/7/23/864
> >
> > Please don't use lkml.org references. I know it's popular but equally
> > unreliable at times.
> 
> Oh?

404 or silent fail are happening on a regular base and of course always
when you really need that information. Murphy's law ...

Thanks,

	tglx
