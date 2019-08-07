Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24127C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 10:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3DC121E6B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 10:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387430AbfHGK3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 06:29:41 -0400
Received: from foss.arm.com ([217.140.110.172]:46058 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727464AbfHGK3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 06:29:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7F0828;
        Wed,  7 Aug 2019 03:29:40 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D439A3F575;
        Wed,  7 Aug 2019 03:29:39 -0700 (PDT)
Date:   Wed, 7 Aug 2019 11:29:37 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     Tri Vo <trong@google.com>, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH] ARM: UNWINDER_FRAME_POINTER implementation for Clang
Message-ID: <20190807102935.GE10425@arm.com>
References: <20190801231046.105022-1-nhuck@google.com>
 <01222982-4206-9925-0482-639a79384451@arm.com>
 <CAJkfWY6StuyMuKG7XdEJrqMsA_Xy02QZKp8r0K2jwSZwBCt+9Q@mail.gmail.com>
 <20190805133940.GA10425@arm.com>
 <CAJkfWY5EL+MyRzSfcfJF2H8WoX73FEO0bOrwcoR4c4ekvaWvOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJkfWY5EL+MyRzSfcfJF2H8WoX73FEO0bOrwcoR4c4ekvaWvOQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 02:29:16PM -0700, Nathan Huckleberry wrote:
> I'm not sure that we should disable a broken feature instead of
> attempting a fix.
> 
> CONFIG_FUNCTION_GRAPH_TRACER is dependent on CONFIG_FRAME_POINTER and
> there have been reports by MediaTek that the frame pointer unwinder is
> faster in some cases.

Fair enough, just wanted to be sure we weren't doing something pointless.

[...]

Cheers
---Dave
