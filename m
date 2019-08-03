Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE39BC433FF
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 13:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ABE62075C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 13:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390896AbfHCNX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 09:23:28 -0400
Received: from tartarus.angband.pl ([54.37.238.230]:33372 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388206AbfHCNX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 09:23:27 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.92)
        (envelope-from <kilobyte@angband.pl>)
        id 1htu0J-000265-9U; Sat, 03 Aug 2019 15:23:23 +0200
Date:   Sat, 3 Aug 2019 15:23:23 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Donald Buczek <buczek@molgen.mpg.de>
Subject: Re: Device to write to all (serial) consoles
Message-ID: <20190803132323.GB6703@angband.pl>
References: <32c2d26f-ec4a-b9a6-b42c-07b27f99ea28@molgen.mpg.de>
 <20190802160243.GA15484@kroah.com>
 <cab1fe06-0dc7-e7c1-50ac-cc01773c5ef5@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cab1fe06-0dc7-e7c1-50ac-cc01773c5ef5@molgen.mpg.de>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 09:59:06PM +0200, Paul Menzel wrote:
> On 02.08.19 18:02, Greg Kroah-Hartman wrote:
> > On Fri, Aug 02, 2019 at 03:23:08PM +0200, Paul Menzel wrote:
> > > On a lot of devices, like servers, you have more than one serial console,
> > > and you do not always know, how they are numbered. Therefore, we start a
> > > console on ttyS0 and ttyS1.
> 
> Because the cable is always connected to the port on the back side, and
> sometimes the port in the front has ID 0, and the one in the back 1, and
> other times vice versa. We do not want to track that, and it would be
> convenient to just write to both ports.

Sounds like an XY problem then: what you want is not writing to all ports,
but to have the port assignments stable (see also: disk device reordering).


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ Latin:   meow 4 characters, 4 columns,  4 bytes
⣾⠁⢠⠒⠀⣿⡁ Greek:   μεου 4 characters, 4 columns,  8 bytes
⢿⡄⠘⠷⠚⠋  Runes:   ᛗᛖᛟᚹ 4 characters, 4 columns, 12 bytes
⠈⠳⣄⠀⠀⠀⠀ Chinese: 喵   1 character,  2 columns,  3 bytes <-- best!
