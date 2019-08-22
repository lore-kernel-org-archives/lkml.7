Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152D6C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 12:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E54E42341B
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 12:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388086AbfHVMti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 08:49:38 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:35209 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388061AbfHVMti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 08:49:38 -0400
Received: from [192.168.1.110] ([77.4.120.101]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M91Tq-1huk7L3zc6-0068YY; Thu, 22 Aug 2019 14:49:30 +0200
Subject: Re: Status of Subsystems
To:     Sebastian Duda <sebastian.duda@fau.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
References: <2529f953-305f-414b-5969-d03bf20892c4@fau.de>
 <20190820131422.2navbg22etf7krxn@pali>
 <3cf18665-7669-a33c-a718-e0917fa6d1b9@fau.de>
 <20190820171550.GE10232@mit.edu>
 <475ea59c-8942-c19d-c660-164fcb44d179@fau.de>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <e222bc6c-aff0-899c-b113-47f7f1798fe1@metux.net>
Date:   Thu, 22 Aug 2019 14:49:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <475ea59c-8942-c19d-c660-164fcb44d179@fau.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:DEQE4p9Q/SgYCR56ptB5W4Pq6YJsYcmprlOkc8swly7MCTvFyRs
 zigXa6H8BcHhg0FuFMaYbgIsImxg8KY92a+BzQ5Co/DgCSE6Jmh9vyF8tuF7W14kIS8NuBo
 V8crYzG9KGk/JZO5w/iqjJhW7eMyvRs20v0B52X8ac0vtIyNpYBpWtdZeZF7IS2msrPiE14
 Jk9RzZQDT3FY7f5nP/YcA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eNAevpgP5G8=:hWranH3GBXqoTvP8KfocQY
 m5emHMTKG97TBFUD7gl9Dx0h6/X5/NSld7IdDKA+OH998Yzces40n40AoZJiNgeAHGsZeyif7
 NN+p+BjIeR2q8KQujRHismRLGbuVyE3jS5LlsYo/JiilH8Gjcz5pxuYAiyG4XZjK69b+xrCJO
 au9kogD+JHN3Zvoe+32OBn4NqzuqtAqTgYaPI6UV5MWWuLAFSmBwnDPqo74TB2l9kz7adf4lb
 PejP5yqJsTtu6gxnf2JStS+nAqgw1qVq6X1pWwcgQUb8k1/OONe6/xwb5emAYN1PpVd307QJF
 Y7TTvXGQpTpvZYQWX8bY3qFx25EQSVYyp9KcF6ztnKdMSYTwif7228uBYGV2cqcc2UCN4o6Jw
 ykvrHmJqQFoAe6l+n6FtoIPiFdQYyukhOXrtl3+hvAi2pP8y4SyFAGRhSGLoWaHzvwzd5tokT
 YR+A4C8KS6y5rIRJD/m1TviRszn3mtWG5o9QNIdANevKooCyhV9t2dMrSbc72e4wGl8gLSjjC
 ZN5G+R4crRgL3ZKQctVyeWfaZUh7kZRAKiKhLD9fnZIChbXfeWbguyKPvRzRuLxSbDw3ALT3c
 BdRXwFB15TrAYHxUkD0kFbjqvA0aT4N8HQ+ALvBXo345mSwuSTsmPEJLeFJKGUrLjM+T+JqXp
 vAoDD4puENZqP6MBaUCD1cIgsDdQ8MuwNEgPbP6S7tw27wkbspz5nhWolvOZPWtT1V55KhG+a
 uDBHCaHjVwF6G8urutG6cKDpZ7vEITA7qU6OgDyU9JD1F2kqhcagfDHEBzc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.08.19 11:28, Sebastian Duda wrote:

Hello Sabastian,


> We have seen some incidents of developers sending patches to wrong
> recipients, missing recipients or sending patches to orphaned
> subsystems. Consequently, some of those patches never make it to a
> reviewer or a maintainer (or only after some further adjustments on
> the list of recipients).

yes, I've stumpled into this myself :(

Do you see any chance for some tool-based assistance ?

Few ideas coming into my mind:

a) kernel.org ops could collect bouncing addresses and match them
    against the MAINTAINERS file. Maybe post an alert with specific
    syntax (so it's easy to filter/monitor), so we can look around
    how to reach the missing folks (already did so myself). Sometimes
    those messages reach the missing folks by some other channel.

b) automatic scan/report for duplicate or unclaimed files.
    maybe this topic just needs more awareness.

    IMHO, every file should have a maintainer, because just posting to
    lkml globally has high risk of getting unnoticed.

c) automatic report of potentially unmaintained areas, so


By the way: if you prefer a more personal conversation, feel free to
call me (I'm settled @Schwabach)

I'm already keen on reading your thesis paper. (and if there's a public
presentation, I'd like to be there). You've picked a very good, useful
topic - we need more of that :)

> Whereas that cannot be avoided entirely, as it is a human, social and
> flexible process and not everything can be encoded in simple rules,
> the maintainer, reviewer, list information in MAINTAINERS and
> get_maintainer.pl does a good job at assisting that these hickups
> happen rather seldomly.

Yes, but it can only work well with good data. So it's good that you
take care of that. And if you can improve the performance of this
script, I'd highly welcome that.

I'd like to recommend you as the maintainer of the MAINTAINERS file ;-)

> Similarly, the status can already indicate:
>   - to a contributor fixing an issues or providing a patch, that the
> code is possibly already orphaned and not maintained, set expectations
> on the possible responses, or to focus on other parts of the code.

Orphaned code IMHO deserves it's own discussion. Maybe we should have
some comments on why exactly orphaned/obsolete but still there (just no
maintainer anymore ? obsoleted by something else ? ...).

> The MAINTAINERS files contains 2088 entries [1].
> 12 of these entries have no status and fall into different categories:
> - Additionally Reviewed
>    - ALPS PS/2 TOUCHPAD DRIVER
>    - NOKIA N900 POWER SUPPLY DRIVERS
>    - RENESAS ETHERNET DRIVERS
>    - SPMI SUBSYSTEM
>    - TI BQ27XXX POWER SUPPLY DRIVER
> - Maintained
>    - ABI/API
>    - ACPI APEI
>    - CONTROL GROUP - BLOCK IO CONTROLLER (BLKIO)
>    - I2C/SMBUS ISMT DRIVER
>    - IFE PROTOCOL
>    - MICROCHIP SAMA5D2-COMPATIBLE PIOBU GPIO
> - Obsolete
>    - NETWORKING [WIRELESS]
>      This is an old entry, which can be omitted

There're also some with status "Orphaned / Obsolete" - did you already
catch them ?

--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
