Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FADBC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68E1208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436683AbfFLIv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:51:59 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:53248 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729538AbfFLIv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:51:58 -0400
Received: from 79.184.253.190.ipv4.supernova.orange.pl (79.184.253.190) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 2d326b2f031bbaf5; Wed, 12 Jun 2019 10:51:56 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing <linux-kernel@vger.kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Subject: Re: Strange regression in hid_llogitech_dj (was: Re: Linux 5.2-rc4)
Date:   Wed, 12 Jun 2019 10:51:56 +0200
Message-ID: <14875910.PnJmU55uV6@kreacher>
In-Reply-To: <nycvar.YFH.7.76.1906121029350.27227@cbobk.fhfr.pm>
References: <CAHk-=wjm7FQxdF=RKa8Xe23CLNNpbGDOACewgo8e-hwDJ8TyQg@mail.gmail.com> <1875376.0DUQQ8o03D@kreacher> <nycvar.YFH.7.76.1906121029350.27227@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, June 12, 2019 10:31:45 AM CEST Jiri Kosina wrote:
> On Wed, 12 Jun 2019, Rafael J. Wysocki wrote:
> 
> > It kind of helps, but there is a catch.
> > 
> > hid-logitech-dj is not loaded after a fresh boot, so I need to modprobe it manually and that
> > appears to be blocking (apparently indefinitely) until terminated with ^C.  But then it turns
> > out that hid-logitech-dj is there in the list of modules and it is in use (by usbhid) and the
> > mouse works.
> 
> My bad, I should've asked you to test with the complete 'for-5.2/fixes' 
> branch which contains two reverts [1] [2] that should fix this issue as 
> well.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/commit/?h=for-5.2/fixes&id=e0b7f9bc0246bc642d1de2ff3ff133730584c956
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/commit/?h=for-5.2/fixes&id=f9482dabfd1686987cc6044e06ae0e4c05915518

Yes, with the two reverts applied in addition to the fix, it all works as expected.

Thanks!



