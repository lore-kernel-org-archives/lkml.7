Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5374AC3F68F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 20:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31BB1206C3
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 20:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfLUUlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 15:41:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:59416 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbfLUUlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 15:41:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9B196ACE1;
        Sat, 21 Dec 2019 20:41:06 +0000 (UTC)
Subject: Re: [RFC 22/25] leds: tm1826: Add combined glyph support
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-realtek-soc@lists.infradead.org, linux-leds@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <20191212033952.5967-1-afaerber@suse.de>
 <20191212033952.5967-23-afaerber@suse.de> <20191221202755.GN32732@amd>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <506d0697-1820-7811-1b38-910355812948@suse.de>
Date:   Sat, 21 Dec 2019 21:41:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191221202755.GN32732@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel,

Am 21.12.19 um 21:27 schrieb Pavel Machek:
> On Thu 2019-12-12 04:39:49, Andreas Färber wrote:
>> Allow to squeeze the text "HEllO" into a 4-digit display,
>> as seen on MeLE V9 TV box.
>>
>> Enable this combining mode only if the text would overflow.
> 
> "HEll,nO"!
> 
> :-)
> 
> Ok, it is kind of cool, but... Can you take a look at
> drivers/auxdisplay/charlcd.c ? It seems to support some kind of text
> displays...

Why don't you look at it before making such a suggestion? ;) It is in no 
way useful, as I pointed out in my cover letter. The only thing related 
today, as Geert pointed out, is in the input subsystem.

If you don't want this in leds, you'll have to help make leds subsystem 
more useful to external users - the latest function refactoring has been 
anything but helpful here, as you've seen with the indicators, and we're 
completely lacking any indexing or bulk operations on the LED controller 
level, since you treat each LED as a standalone device. That's precisely 
why this code is here in leds although - as I pointed out - it shouldn't 
belong here.

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
