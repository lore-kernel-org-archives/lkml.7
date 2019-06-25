Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73D5C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9368D214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbfFYLV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 07:21:57 -0400
Received: from tartarus.angband.pl ([54.37.238.230]:50050 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfFYLV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 07:21:56 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.92)
        (envelope-from <kilobyte@angband.pl>)
        id 1hfjWE-0003Yy-Fc; Tue, 25 Jun 2019 13:21:46 +0200
Date:   Tue, 25 Jun 2019 13:21:46 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-sh@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] remove arch/sh?
Message-ID: <20190625112146.GA9580@angband.pl>
References: <20190625085616.GA32399@lst.de>
 <ccfa78f3-35c2-1d26-98b5-b21a76b90e1e@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ccfa78f3-35c2-1d26-98b5-b21a76b90e1e@physik.fu-berlin.de>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 11:02:36AM +0200, John Paul Adrian Glaubitz wrote:
> On 6/25/19 10:56 AM, Christoph Hellwig wrote:
> > arch/sh seems pretty much unmaintained these days.  The last time I got
> > any reply to sh patches from the list maintainers, and the last maintainer
> > pull request was over a year ago, and even that has been rather sporadic.
> > 
> > In the meantime we've not really seen any updates for new kernel features
> > and code seems to be bitrotting.
> 
> We're still using sh4 in Debian

I wouldn't call it "used": it has popcon of 1, and despite watching many
Debian channels, I don't recall hearing a word about sh4 in quite a while.

Hardware development is dead: we were promised modern silicon by j-core
after original patents expired, but after J2 nothing happened, there was
silence from their side, and now https://j-core.org is down.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀
⣾⠁⢠⠒⠀⣿⡁ Packager's rule #1: upstream _always_ screws something up.  This
⢿⡄⠘⠷⠚⠋⠀ is true especially if you're packaging your own project.
⠈⠳⣄⠀⠀⠀⠀ 
