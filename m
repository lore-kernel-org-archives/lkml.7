Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04126C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D541320880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbfDHTOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:14:51 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:41442 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728879AbfDHTOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 15:14:49 -0400
Received: from belgarion ([90.76.58.102])
        by mwinf5d81 with ME
        id xvEk1z00A2CLFkS03vElm2; Mon, 08 Apr 2019 21:14:46 +0200
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Mon, 08 Apr 2019 21:14:46 +0200
X-ME-IP: 90.76.58.102
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Antonio Ospite <ao2@ao2.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Harald Welte <laforge@gnumonks.org>, linux-rtc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Removing pcap? (EZX support in mainline linux)
References: <20190407140741.GE7480@piout.net>
        <20190408085812.db187b4a6f8ffc76d3d5ebdc@ao2.it>
        <CAK8P3a0TKUQC7GkYsWrJGFaRsvK5AQjPn74AnkRcPioXUFef-Q@mail.gmail.com>
X-URL:  http://belgarath.falguerolles.org/
Date:   Mon, 08 Apr 2019 21:14:44 +0200
In-Reply-To: <CAK8P3a0TKUQC7GkYsWrJGFaRsvK5AQjPn74AnkRcPioXUFef-Q@mail.gmail.com>
        (Arnd Bergmann's message of "Mon, 8 Apr 2019 16:02:11 +0200")
Message-ID: <87d0lwpavv.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Mon, Apr 8, 2019 at 8:58 AM Antonio Ospite <ao2@ao2.it> wrote:
>> On Sun, 7 Apr 2019 16:07:41 +0200
>> Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:
>> adding Robert to CC as he is listed as the current maintainer of
>> ARM/EZX SMARTPHONES in the MAINTAINERS file.
>>
>> > I've had a look at the PCAP RTC driver because I'm removing a few
>> > deprecated APIs. While doing so, I've discovered that the driver has
>> > never worked properly because PCAP_RTC_TOD_MASK and PCAP_RTC_DAY_MASK
>> > are both missing a bit so every day would roll over at 18:12:15 and the
>> > whole the date would roll over in 2014.
>> >
>> > I discussed with Arnd about 59ee93a528b9 ("ARM: pxa: remove irq_to_gpio
>> > from ezx-pcap driver") and it seems the whole EZX support has been
>> > broken for a while.
>> >
>>
>> As Harald said in another message I tried taking over OpenEZX for a
>> while, but eventually lost interest.
>>
>> JFTR some parts of the project has been backed up here:
>> https://gitlab.com/openezx
>>
>> I should also have a git backup of the wiki somewhere.
>>
>> > Is it worth fixing the RTC driver or could I remove it?
>> >
>>
>> I am not aware of any active user but I'd leave the final word to
>> Robert, IIRC he received some EZX hardware "recently".
>>
>> FWIW I think EZX code can be removed if it is a maintenance burden for
>> anyone.
>
> I would prefer if we could either keep or remove all of the ezx code, but not
> just remove a particular driver. Removing it all now would let us skip that
> discussion the next time someone has a problem with another device driver
> for it.

I'm on the same page here.  I'm not strongly either for or against EZX removal
(which would impact AFAIK 6 old Motorola smartphones).

If I can find the wiki archives to cross-check the mask issue (especially
PCAP_RTC_DAY_MASK), I wouldn't mind seeing a patch on that if it is kept.

If I can make the EZX boot (the one I got from Antonia), I could even test
it. As if it's worth it, I'm not personally an active user of this specific
platform, so if no one is, one less would be less maintainance burden.

Cheers.

-- 
Robert
