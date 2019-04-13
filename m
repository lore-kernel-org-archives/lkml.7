Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A10C282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 05:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 392A221721
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 05:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfDMFRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 01:17:24 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:55972 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbfDMFRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 01:17:23 -0400
Received: from [192.168.1.13] (c-73-128-14-11.hsd1.md.comcast.net [73.128.14.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kumba)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 480A6340F00;
        Sat, 13 Apr 2019 05:17:22 +0000 (UTC)
Subject: Re: [PATCH 2/3] rtc: ds1685: use correct device struct to get
 platform device struct
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190411143323.20945-1-tbogendoerfer@suse.de>
 <20190411143323.20945-2-tbogendoerfer@suse.de>
 <20190412101106.GU3578@piout.net>
 <20190412134459.446ef705c86aa1c7b926abc7@suse.de>
From:   Joshua Kinard <kumba@gentoo.org>
Openpgp: preference=signencrypt
Message-ID: <462d6bfd-c91a-3c5c-1dfd-69d8b48449e6@gentoo.org>
Date:   Sat, 13 Apr 2019 01:17:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412134459.446ef705c86aa1c7b926abc7@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/2019 07:44, Thomas Bogendoerfer wrote:
> On Fri, 12 Apr 2019 12:11:06 +0200
> Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:
> 
>> Every patch need a commit message. Maybe you could indicate that this
>> never gave any issue because parent is the first member of struct
>> device.
> 
> I'll update the commit message, I get a nice stacktrace because of that
> bug, so the path from work_queue calling ds1685_rtc_poweroff never worked.
> 
> Thomas.

I'll wager that's why the thing stopped powering off my Octane.  It *used*
to work when I wrote the driver, but stopped after some unidentified point,
and I never found the time to try and track it down.

Which machine are you testing on, out of curiosity?

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
rsa6144/5C63F4E3F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And
our lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
