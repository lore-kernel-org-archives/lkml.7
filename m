Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6665C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 11:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B66BD21479
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 11:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567940577;
	bh=P6tKgDmnS2bjo5pXVzGOH4m0pUJGdUD9hDyDviqlvQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pAEzHd/xoV6cjVUTFpzygGExWPIbmTKBAfOnAeHeJIy5hT4fU9uGoIuFDcLyOD9po
	 pEm+Uq2z81Fv+JHsQUmqLYMmY6KRglSCjqc1Bmp2qKgVgQ2FMcLY5KAgfec+5KfU1O
	 oWBMxleLKNLTak+Rran8p1gDd1lxZKrLqYrkzm1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbfIHLC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 07:02:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728608AbfIHLC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 07:02:56 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 506DC207FC;
        Sun,  8 Sep 2019 11:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567940575;
        bh=P6tKgDmnS2bjo5pXVzGOH4m0pUJGdUD9hDyDviqlvQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XhgEmj9cMPHp720A3DVHsNdGS6MMX4zQRUW35SOlkpvZ4SfR3SixP7NCC9rrMoofW
         AQnqoH2YoUBjnwpDwmtJV64QusocMvIkmQnjc8kok+H8g1dfkcYffozhS2I/5vH1fa
         U7Ovm4k95z9hCJVJrpHuzlOHgXdlLG3C3Q8em5kk=
Date:   Sun, 8 Sep 2019 07:02:53 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Bandan Das <bsd@redhat.com>
Subject: Re: Linux 5.3-rc7
Message-ID: <20190908110253.GC2012@sasha-vm>
References: <CAHk-=wi_nBULUyO=OKtNBCZ+VSqdOcEiUeFqXTQY_D5ga5k4gQ@mail.gmail.com>
 <156785100521.13300.14461504732265570003@skylake-alporthouse-com>
 <alpine.DEB.2.21.1909071628420.1902@nanos.tec.linutronix.de>
 <156786727951.13300.15226856788926071603@skylake-alporthouse-com>
 <alpine.DEB.2.21.1909071657430.1902@nanos.tec.linutronix.de>
 <CAHk-=wikdDMYqhygJYkoWw7YxpGNx7O2kFRxbG91NNeFO7yu3w@mail.gmail.com>
 <alpine.DEB.2.21.1909072243570.1902@nanos.tec.linutronix.de>
 <CAHk-=wg5dS9QsC5Ay0BpLBQdBRcy0qCE2hP=K4_nJ4b6Lumf_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAHk-=wg5dS9QsC5Ay0BpLBQdBRcy0qCE2hP=K4_nJ4b6Lumf_Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 07, 2019 at 02:13:22PM -0700, Linus Torvalds wrote:
>On Sat, Sep 7, 2019 at 1:44 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> That's what I just replied to Chris. Can you do it right away or should I queue it up?
>
>Done.

I'd like to bring back a discussion we had last year on ksummit-discuss:
https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2018-May/005122.html
. I've pointed out that some of the commits that go in the -rc cycles
are of low quality and are untested, you seemed to agree but said that
it's "by-design" because late -rc cycle commits are more complex.

Is this commit and it's fallout really how our development process
should be working?

This commit was rushed through the process: it was authored and merged
into -tip of the same day, and pulled in by you just a few days later.
There was no meaningful time for review, testing, or really any sort of
QA.

We really do have a better story now for catching the sort of issues
introduced by these patch: multiple CI systems tripped on this, but
people still need the time to look into it, make sure that the failure
is real and bisect it.

What was the rush in making it skip all of our safeguards? The "bug" has
been there forever, the fix isn't urgent, and no one seemed to care for
quite a while.

Even if this patch was fixing a bug introduced in this merge window, is
the tradeoff around rushing an untested fix worth it vs giving it more
time and shipping it as part of our stable tree?

I'm not trying to pick on this patch in particular - I feel that this is
a systematic issue and should be addressed as part of our process.

--
Thanks,
Sasha
