Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40174C606CD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC5F2064B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404778AbfGHT6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:58:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43071 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbfGHT6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:58:11 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hkZlv-0004Tq-9o; Mon, 08 Jul 2019 21:57:59 +0200
Date:   Mon, 8 Jul 2019 21:57:58 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Qian Cai <cai@lca.pw>
cc:     Ilia Mirkin <imirkin@alum.mit.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, joe@perches.com,
        linux-spdx@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, rfontana@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] gpu/drm_memory: fix a few warnings
In-Reply-To: <1562614919.8510.9.camel@lca.pw>
Message-ID: <alpine.DEB.2.21.1907082150170.1961@nanos.tec.linutronix.de>
References: <1562609151-7283-1-git-send-email-cai@lca.pw>  <CAKb7UvhoW2F5LSf4B=vJhLykPCme_ixwbUBup_sBXjoQa72Fzw@mail.gmail.com> <1562614919.8510.9.camel@lca.pw>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-814371836-1562615879=:1961"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-814371836-1562615879=:1961
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 8 Jul 2019, Qian Cai wrote:
> On Mon, 2019-07-08 at 15:21 -0400, Ilia Mirkin wrote:
> > > -/**
> > > +// SPDX-License-Identifier: MIT
> > > +/*
> > >   * \file drm_memory.c
> > >   * Memory management wrappers for DRM
> > >   *
> > > @@ -12,25 +13,6 @@
> > >   * Copyright 1999 Precision Insight, Inc., Cedar Park, Texas.
> > >   * Copyright 2000 VA Linux Systems, Inc., Sunnyvale, California.
> > >   * All Rights Reserved.
> > > - *
> > > - * Permission is hereby granted, free of charge, to any person obtaining a
> > > - * copy of this software and associated documentation files (the
> > > "Software"),
> > > - * to deal in the Software without restriction, including without
> > > limitation
> > > - * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> > > - * and/or sell copies of the Software, and to permit persons to whom the
> > > - * Software is furnished to do so, subject to the following conditions:
> > > - *
> > > - * The above copyright notice and this permission notice (including the
> > > next
> > > - * paragraph) shall be included in all copies or substantial portions of
> > > the
> > > - * Software.
> > > - *
> > > - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
> > > OR
> > > - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> > > - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> > > - * VA LINUX SYSTEMS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM, DAMAGES
> > > OR
> > 
> > This talks about VA Linux Systems and/or its suppliers, while the MIT
> > licence talks about authors or copyright holders.

That's looks lika a valid substitution and does not change the meaning of
the license, AFAICT. Richard might have a differnt opinion though.
 
> > Are such transformations OK to just do?

Nope.

> From,
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Document
> ation/process/license-rules.rst
> 
> "The Linux kernel requires the precise SPDX identifier in all source files."

That's correct.
 
> That is the closest license I can think of.

Well, it's pretty much plain MIT, but you might have noticed:

 * The above copyright notice and this permission notice (including the next
 * paragraph) shall be included in all copies or substantial portions of the
 * Software.

So in this case, you need to talk to the copyright holder if he agrees to
remove the boiler plate language.

Adding the MIT SPDX identifier without touching the boiler plate is fine.

Thanks,

	tglx
--8323329-814371836-1562615879=:1961--
