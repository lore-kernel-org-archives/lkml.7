Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6631DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A3CD218C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbfCOJGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 05:06:49 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:60207 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728623AbfCOJGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 05:06:45 -0400
Received: from [192.168.1.110] ([77.2.38.11]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MSbp1-1hSX4w3pNZ-00SysH; Fri, 15 Mar 2019 10:06:24 +0100
Subject: Re: [PATCH v2 10/45] drivers: tty: serial: zs: use devm_* functions
To:     Greg KH <gregkh@linuxfoundation.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, eric@anholt.net,
        stefan.wahren@i2se.com, f.fainelli@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        matthias.bgg@gmail.com, yamada.masahiro@socionext.com,
        tklauser@distanz.ch, richard.genoud@gmail.com,
        macro@linux-mips.org, u.kleine-koenig@pengutronix.de,
        kernel@pengutronix.de, slemieux.tyco@gmail.com,
        andy.gross@linaro.org, david.brown@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        baohua@kernel.org, jacmet@sunsite.dk, linux-serial@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <1552602855-26086-1-git-send-email-info@metux.net>
 <1552602855-26086-11-git-send-email-info@metux.net>
 <20190314225204.GB1795@kroah.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <3734d588-6b9c-29e2-45b6-82e778f47602@metux.net>
Date:   Fri, 15 Mar 2019 10:06:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190314225204.GB1795@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:+o4SIs6v4ZgDwZgql/OoA36fyA5G9I82AbwrYGDAzoeoS1enF0W
 myQ8zfS75+8ASgxjq0d5DBvrKJXe012Kjnl4UNewqmKx2LYfC7Ag5hPi6O8nfxMsAMkWjFs
 OfNiATKNg8ZCymNpvy0E5YWmHXC0+reP8JaW0EQyXRhFG7Xorw1ASJ7hkyr8/TRfF0zMcT9
 0w59Z53qCG3X/FJmUEY9A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Endfzf+wvUM=:/PtKge9JFPNd7049Agoi9a
 6Rt2MStlT101wMiUTC8CXrkJX9Wo9nwn3YuLPiltWGDxYP4VyGhq5cxhwwab8Xl4C0kFFx806
 Jg6t7h8+UtL9h6YB0il4NLhDd55aY5UzB7ZawAJCGaZcENEAqprzTHBUWS7rFaAH474ss94Ts
 98duNMN1obJg/6qqqr/n5oPQHDS1+kxppBGn4pm1DzgHqdhjRRytPh1oYwAGg01mUORraZ5t0
 Duv4MwtlZLZqpZvWk3Q8tCKLhhusOtcm8I7cG281goA3BJAfrV7sB8L1KfmPS/Gcc84v4XCay
 ES9uy/fodD1OJR3MArD1ivJyvUC17X7cJcmqrRSWqKcceLcIOq6+Qux1AHBLLB96aWAuBLy9t
 ypTJlroSDKi50mmpflwE+T+/NlecpicCbeIEsdzS4ZvjV4pMhchHUSYOSBK+du1+1gydOpHbO
 YTIxC/mfAz4w74oDfnQj9gAJg4RfdaPptd8qRw0mplah9FUT08CZ4dMYKVv6kEsnDHTZ7ZjgV
 Z20mOfyZZb4OCd3/ZA5EUEWnSBKm/jvzXI9mr9VLYWLhDsqQfpt1bXOe+hwr5uGKYDeN5qNSv
 BPpBVEK5yNP7qc+SFTEidvfPr/BQrL6v+wTToi8AeMpNtmCQV2aemLP9t7SJyHOtQYXH46oCu
 uhA141C/TxSdJSVnXkhFNr0dLwY9EU2PEvnpIVZx/+3wyXlCkU2M8eNNbEhomH9JY8zWNiF68
 3+mpcpssjgN/O3omETsxYVi0M4ubIusTpyuoGNh0+FQ4LgII1UDjEjh96b8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.03.19 23:52, Greg KH wrote:
> On Thu, Mar 14, 2019 at 11:33:40PM +0100, Enrico Weigelt, metux IT consult wrote:
>> Use the safer devm versions of memory mapping functions.
> 
> What is "safer" about them?

Garbage collection :)

Several drivers didn't seem to clean up properly (maybe these're just
used compiled-in, so nobody noticed yet).

In general, I think devm_* should be the standard case, unless there's
a really good reason to do otherwise.

<snip>

> Isn't the whole goal of the devm* functions such that you are not
> required to call "release" on them?

Looks that one slipped through, when I was doing that big bulk change
in the middle of the night and not enough coffe ;-)

One problem here is that many drivers do this stuff in request/release
port, instead of probe/remove. I'm not sure yet, whether we should
rewrite that. There're also cases which do request/release, but no
ioremap (doing hardcoded register accesses), others do ioremap w/o
request/release.

IMHO, we should have a closer look at those and check whether that's
really okay (just adding request/release blindly could cause trouble)

> And also, why make the change, you aren't changing any functionality for
> these old drivers at all from what I can tell (for the devm calls).
> What am I missing here?

Okay, there's a bigger story behind, you can't know yet. Finally, I'd
like to move everything to using struct resource and corresponding
helpers consistently, so most of the drivers would be pretty simple
at that point. (there're of course special cases, like devices w/
multiple register spaces, etc)

Here's my wip branch:

https://github.com/metux/linux/commits/wip/serial-res

In this consolidation process, I'm trying to move everything to
devm_*, to have it more generic (for now, I still need two versions
of the request/release/ioremap/iounmap helpers - one w/ and one
w/o devm).

My idea was moving to devm first, so it can be reviewed/tested
independently, before moving forward. Smaller, easily digestable
pieces should minimize the risk of breaking anything. But if you
prefer having this things squashed together, just let me know.

In the queue are also other minor cleanups like using dev_err()
instead of printk(), etc. Should I send these separately ?

By the way: do you have some public branch where you're collecting
accepted patches, which I could base mine on ? (tty.git/tty-next ?)


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
