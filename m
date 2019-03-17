Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67209C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 16:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DE1A20835
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 16:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfCQQww convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 12:52:52 -0400
Received: from unicorn.mansr.com ([81.2.72.234]:47470 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726493AbfCQQww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 12:52:52 -0400
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 8AD6D15060; Sun, 17 Mar 2019 16:52:51 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] auxdisplay: charlcd: make backlight initial state configurable
References: <20190301184816.784-1-mans@mansr.com>
        <20190301184816.784-3-mans@mansr.com>
        <CAHp75VfZUN0PVwveB9FM6QvyJicVE5WjCX3b5rfCGZOQs9hO8A@mail.gmail.com>
        <yw1xo96g2ix5.fsf@mansr.com>
        <CANiq72mjLo94nK9i927FDgv3YzTQVBowMhb0EcDXKYKFh5tbkA@mail.gmail.com>
Date:   Sun, 17 Mar 2019 16:52:51 +0000
In-Reply-To: <CANiq72mjLo94nK9i927FDgv3YzTQVBowMhb0EcDXKYKFh5tbkA@mail.gmail.com>
        (Miguel Ojeda's message of "Sun, 17 Mar 2019 08:43:51 +0100")
Message-ID: <yw1x7ecx30kc.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> writes:

> On Tue, Mar 12, 2019 at 4:48 PM Måns Rullgård <mans@mansr.com> wrote:
>>
>> The current code unconditionally flashes the light once.  I though it
>> best to keep that behaviour as default, even if it's not seen as ideal.
>
> Sent into -next. If no one else says anything after a few days, I will
> send the series for -rc2.
>
> By the way, what about the other comment Andy mentioned? i.e.
> "defined(_OFF)" (in case you missed to answer it).

With a correct config, there should be no difference.  If someone
managed to create a config without any of the alternatives selected,
a compiler error would result.  I don't really have much of an opinion
on which behaviour is preferable in that situation.

-- 
Måns Rullgård
