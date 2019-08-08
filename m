Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2219C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 09:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EA582173C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 09:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732236AbfHHJ1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 05:27:17 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:42045 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732123AbfHHJ1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:27:17 -0400
Received: from [192.168.1.110] ([77.4.95.67]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MPXQi-1hhqu83dNy-00MZBc; Thu, 08 Aug 2019 11:27:14 +0200
Subject: Re: Merge branch 'floppy'
To:     Alex Henrie <alexhenrie24@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Denis Efremov <efremov@linux.com>
References: <CAMMLpeQMPJjSx-hqZ75LCV0wC-kQBmqEe7wjb2oU5iq-pc5bfw@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <976e78be-cfbc-0744-c04f-8a2361af0fa4@metux.net>
Date:   Thu, 8 Aug 2019 11:27:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAMMLpeQMPJjSx-hqZ75LCV0wC-kQBmqEe7wjb2oU5iq-pc5bfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:W1Gb2S0ORtMZQoseDiCygcdXEwPwajKJPhGNrpcj3UBbCWA9o/k
 Mjn2L6SbwMVkTYW/gOFfJEJZzOxGLY+JToDgDtLgqmYbw19EyCM577m7vAgh9eM141kRiSw
 W+FHV6yYGFofGFWiXQdzPWvFzTcPwMsqW7+MpGhq324/vuercbnYdO7NTBL794+7Uux3+60
 qRp4T0d/y3/ueuGHlTWLw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8mJVUKDtIeQ=:nTsNy0grwOgAWCHROrdqi6
 1SOKO76NZ5WpgjOwLk0zM5OHI82/EnQg+1cnXlQXHmQ3SyboLVMeoOisU7FAqvmfdIpS5lxA0
 oCBSgvVnpZ6bwvZ/7dsp/fBtWfPAxgVI+Vi4WKgdeZGtSDPmj95XK+5yDh+uOGmS06YLL/qWE
 KXkHwoHBOlrPOYRJ+PxbPJkLwaV9iqcPUDqc2XGz/i1VhBVSnPArZxMCpRD51iwn0ae1kzr9V
 HZcbc/X+fcKFcesOHUZfZwnpX94PRr3o6mzcrHa3dpGTTenBtYzLYPtj8LdO77cCQt1yPDKso
 4o67CaRuWnO482RUzX99C/y4S8JEEgLuwz4fOl4vDlbQw4Cppo4AcG0wRkswdg/LQXOALW6dE
 m6s37YVvvsmORekGxuaW9QVF0sNDIuBIb30CUbQBDqJjOKz4GBq7LAJMdHj/7hYRn3i9oK1sn
 dtG+RWMr3PMvtgBT0hWpurfqdrB8Ac3ZiZldSpBM+Ou0nVria4ywi0i/VPYnnVtYYUGU8+P2q
 WwX4KyUx2geyEifu8URWByCtNYS+GHtBynXWihcaxXVYm+fRs/vrl+oFDH1x6tmQYiln79lXl
 sDHy4RWcsu6RmqlO6a1Ou1vQ7dJidXpl6CGhWHaK+HdWwsbaVMGZN0Zuf5mM2iFBqx43OuGJf
 uEbEaMycEiW3ZS6+a0pzIf7NK4Jz94fdsMo7ukKvgbKr3byz1Gb1Os0Vutan5uZ4VnWyLpxvh
 y7Kit44BlavHC011CA3Bv7h5J4LVdW/OdIj4qfLtW8u5ZkUdUuqwqJL/6JE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.07.19 22:36, Alex Henrie wrote:

> Just for the record: I have an Ubuntu machine, still in daily use,
> that has a floppy disk connector on the motherboard. The motherboard
> was made in 2006 if I remember correctly and has a quad-core Intel
> CPU. It has both a 3.5" and a 5.25" drive installed and they get used
> every time somebody finds another pile of floppy disks in Grandpa's
> garage.

I also have a stack of floppy drives (3.5'' and 5.25'') in storage,
and several machines with fdd ports (also classic ISA and IDE ports).
Haven't turned them on for long time, but should still be working.

If anyone's interested in the HW, just let me know.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
