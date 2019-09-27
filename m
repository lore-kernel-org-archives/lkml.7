Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA8DC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 13:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BEC220872
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 13:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbfI0NxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 09:53:22 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60719 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfI0NxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 09:53:22 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 1C7B980551; Fri, 27 Sep 2019 15:53:06 +0200 (CEST)
Date:   Fri, 27 Sep 2019 15:53:13 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Portege Z930 extra keys and leds
Message-ID: <20190927135313.GC3557@bug>
References: <09e715a0-08d2-100d-4bc3-c4f6c87f2a98@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09e715a0-08d2-100d-4bc3-c4f6c87f2a98@metux.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> does anybody happen to know how to drive the extra keys and leds
> of Toshiba Portege Z930 notebook ?
> 
> It has two extra keys above the keyboard (right next to the power
> button) and some indicator leds underneath the touch panel buttons.
> 
> Toshiba originally ships the notebook with some strange Windows software
> (for some mysterious "ECO" mode) that reacts on these two buttons and
> drives at least the rightmost LED directly - so there has to be *some*
> way to control them by software.
> 
> When in a terminal (on the console only when /dev/input/event10 -
> "Toshiba input device" is opened), both keys seem to generate an "x"
> keypress, but nothing coming in in the event device.

You may want to play with evtest.

And you may want to dump the ACPI tables, I'd expect it would be driven from
there.

You may also want to search drivers/platform/x86 (or something like that) on
the latest kernel...

Best regards,
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
