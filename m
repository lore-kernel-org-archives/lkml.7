Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A30AC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 19:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37FC420883
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 19:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfE0T4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 15:56:46 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:46823 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfE0T4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 15:56:46 -0400
Received: from [192.168.1.110] ([95.115.42.131]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N18MG-1gUDUG0dsw-012Y0Z; Mon, 27 May 2019 21:56:34 +0200
Subject: Re: [PATCH 2/2] serial: 8250: Add support for 8250/16550 as MFD
 function
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Esben Haabendal <esben@haabendal.dk>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-serial@vger.kernel.org,
        Jiri Slaby <jslaby@suse.com>, Nishanth Menon <nm@ti.com>,
        Vignesh R <vigneshr@ti.com>, Tony Lindgren <tony@atomide.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
References: <87bm05mpmx.fsf@haabendal.dk> <20190514104741.GO4319@dell>
 <20190514122618.GA18859@kroah.com> <87imudky2o.fsf@haabendal.dk>
 <20190521100904.GA13612@kroah.com> <87pnocm59v.fsf@haabendal.dk>
 <20190521111817.GA24911@kroah.com> <87lfz0m3ge.fsf@haabendal.dk>
 <20190521125651.GA6264@kroah.com> <87h89nnajr.fsf@haabendal.dk>
 <20190521144319.GA28747@kroah.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <5c7e21b6-3701-a685-02c6-a584996aa811@metux.net>
Date:   Mon, 27 May 2019 21:56:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190521144319.GA28747@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:K7GEJZtbQJhy4IMLkG1/HregCwPnj0S7Td/78D9wZMC4RrPz3mE
 GngyVqIgDk5XwhKx8Mo/hYcIWUOFY/dJ8MTC6Ij+sQy482FsKAkmBVlzF9lNFGYQo8x1w2X
 cSEG7qHzysKTdoc80JyGfW4nP/hO4l3V69FjSw6r7gETAIdIVDVOH34KvV0TOBoTr2WlFsL
 SptcrrBq/5Jui1CUM0mOQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NeHRnzJkYP0=:6c4Z10cEv6QAFoYDO7mHfR
 xjhz30RJUU3aPxaw91gITyNo8DOJrsTtC5aGRiv8b9YFsv+DP47FGFdoVDnNogQtN/KAPEtkj
 aeG6phlUVUFcr7ShwFtE8CEdEJ3fJaJ0kxy4Gy6YjA63hSo1X0b0H0LSQ69t6xqMl1obJToRU
 EoDY5zl+qtxLUQseyNAgYYfO2ZVkMoi/Izr/f6mFeDLotiUxLmnrpN2UNTFNVFFJ7K+P2x9fU
 O/9Bf0sS64+EYNJF4giRdjMcUMHIqW/O8bYrm3mOQ6Qs6HSDO1IOEZea1O54A+Q4UwP2JD+7+
 j8crVwZKiOdFNCa9UpwKYiQlOapdumXu3lc9TvHbdPey2Uv5knlFRC67JS2OY3Xcju+His2nU
 ohImuPlKrU2ioAznUW9Rxa7RqL0ujF/zr/kNGRfSh/D/vWzZdf/9YIqulpVAz0k/QJJI5YPsS
 cAUvc+BLHUCF/YKQQB0loDB1tvxMgCkamiqf+yiCyZ3429V94ppyOALzZ/xFvZjsOwQH9Flz4
 vvQIPiIzoAMb8seO8BIsXS83YRlu8Tk8cUiUZYrFUnvujoBaQaL5HI/Dgv4txMjOIlnRAUdaS
 oDuRQMQVOfaZZmnz8ZMOQ71+8aAjQgqZkWnzPf/8Kwq+jSSltEsS1z7PI25IwJKi+A+Ok44T+
 IVni29vYsozZM5tFo7NQBo+eyaTDi5xx0pD0xp6ufMDwTBtHQqmiUK38oo5L657wWU3RiYMbT
 4+YT3yHPoQtw4uQ7w/pDR0GGVfwdy7bCJPRhFKUGB9LmBlb8LREbNyhTk5o=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.05.19 16:43, Greg Kroah-Hartman wrote:

Hi,

> Sometimes you need to go tell the hardware/firmware people not to do
> foolish things.  You can not always fix their problems in software.
> Please push back on this.

I've often been in the same situation. It's hopeless with those folks.
Even worse: you give'em a clear spec on how the register interface
shall look like, and they make something really weird out of it
(shuffled byte orders, multiplexing irqs over a single gpio line and
leave the other's empty instead of just one gpio per irq, ...)

The kernel is full of buggy hardware, because hw folks seem not really
capable of doing their homework :(

Actually, the whole existance of these hundreds of different uart
devices, IMHO, is a clear sing of hw folks not doing the homework.


By the way: I've somewhat lost track of what the patch was actually
about ... :o


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
