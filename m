Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4832BC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A4E820866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbfFNOZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 10:25:45 -0400
Received: from ms.lwn.net ([45.79.88.28]:52266 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728050AbfFNOZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:25:44 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 73B88128A;
        Fri, 14 Jun 2019 14:25:43 +0000 (UTC)
Date:   Fri, 14 Jun 2019 08:25:42 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        David Rientjes <rientjes@google.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3] Add a document on rebasing and merging
Message-ID: <20190614082542.3f8674eb@lwn.net>
In-Reply-To: <CACT4Y+avfTeZTmhti=7nEadthZZpTnOCTdEuG2S7PovmAMkhZQ@mail.gmail.com>
References: <20190612094503.120f699a@lwn.net>
        <CACT4Y+avfTeZTmhti=7nEadthZZpTnOCTdEuG2S7PovmAMkhZQ@mail.gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jun 2019 11:59:03 +0200
Dmitry Vyukov <dvyukov@google.com> wrote:

> I will appreciate if you elaborate a bit on this "scale of the
> project". I wondered about reasons for having the current hierarchy of
> trees and complex merging for a while, but wasn't able to find any
> rationale. What exactly scale do you mean? I know a number of projects
> that are comparable to Linux kernel, with the largest being 2 orders
> of magnitude larger than kernel both in terms of code size and rate of
> change, that use single tree and linear history. 

I'm not sure what projects you're talking about, so it's hard to compare.

During the 5.2 merge window, Linus did 209 pulls, bringing in just over
12,000 changesets, from on the order of 1600 developers.  Even if, at the
beginning of the window, each of those pulls was set up to be a
fast-forward, they would no longer be positioned that way once the first
pull was done.

Are you really saying that subsystem maintainers should be continuously
rebasing their trees to avoid merges at the top level?  Do you see how
much work that would take, how badly it would obscure the development
history, and how many bugs it would introduce?  Or perhaps I misunderstood
what you're arguing for?

Thanks,

jon
