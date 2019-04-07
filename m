Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36E0C282DE
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 18:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EAD520896
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 18:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfDGSoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 14:44:44 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:60486 "EHLO
        ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfDGSoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 14:44:44 -0400
X-Greylist: delayed 1172 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Apr 2019 14:44:43 EDT
Received: from uucp by ganesha.gnumonks.org with local-bsmtp (Exim 4.84_2)
        (envelope-from <laforge@gnumonks.org>)
        id 1hDCTd-0007CE-Rl; Sun, 07 Apr 2019 20:25:09 +0200
Received: from laforge by nataraja.lan with local (Exim 4.92)
        (envelope-from <laforge@gnumonks.org>)
        id 1hDC98-0000gY-T9; Sun, 07 Apr 2019 20:03:58 +0200
Date:   Sun, 7 Apr 2019 20:03:58 +0200
From:   Harald Welte <laforge@gnumonks.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Antonio Ospite <ao2@ao2.it>, Arnd Bergmann <arnd@arndb.de>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Removing pcap?
Message-ID: <20190407180358.GL25552@nataraja>
References: <20190407140741.GE7480@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190407140741.GE7480@piout.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On Sun, Apr 07, 2019 at 04:07:41PM +0200, Alexandre Belloni wrote:
> Is it worth fixing the RTC driver or could I remove it?

I've left OpenEZX behind quite a long time ago.  Antonio was working
on it for some more time, I don't know if he's still actively using
or maintaining it.

From my personal point of view, it's only historically relevant and
can certainly be removed from current-day mainline kernels.  That's of
course unless some other people are still actively using it, which
I somewhat doubt about a decade since those phones were last made.

Regards,
	Harlad

-- 
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)
