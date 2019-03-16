Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40359C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 09:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A5A42087C
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 09:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfCPJRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 05:17:44 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:47217 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfCPJRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 05:17:44 -0400
Received: from [192.168.1.110] ([95.117.13.126]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MMFdY-1hMCLq1ldW-00JGKe; Sat, 16 Mar 2019 10:17:16 +0100
Subject: Re: [PATCH v2 10/45] drivers: tty: serial: zs: use devm_* functions
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org, eric@anholt.net,
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
 <3734d588-6b9c-29e2-45b6-82e778f47602@metux.net>
 <20190315142628.GA30650@kroah.com>
 <d81364fc-c5da-c1b2-f38a-3a23c701c50d@metux.net>
 <20190316032630.GB2499@kroah.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <fd8d6a9b-3e85-9904-2195-1f1bbc42bd2d@metux.net>
Date:   Sat, 16 Mar 2019 10:17:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190316032630.GB2499@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:EeDIdx/ZofCsDCjDCqDBdwJVn2vFx/eYFegD5Ya7VFYNybfet1J
 3wxuCJlxu9QfJi1PtUMeEtTgSfAdwo4QO+us5aMtiqM63gXLmhu7Y9FeqCw0/ZHUNjQmemp
 C+M1lQ4UgmbcYBlv1Ft+qZ1DiSjF0yDMNnl6HfdPyGE2GSeQvnFmC3+EH51ObeMhGujIb8v
 q2aiqoqoSmDh9MGiT+XQQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P9NI7bTY56M=:R3xN1Mqy2RRkBDf8qpUd8m
 6/ilptxmqeSdfhOojd3Oahqhbhc6SzWzY+i5d/zfWYaHMc0zfdkJ7XCF7+V49T6NOtZt0BOmP
 DBYLB+kfLWYDq6RaMeQYMvpo6ZsMqCWb/dRz70YPAHQ4LdA26tPwF/2vWX+jUm/2QV4yihzU4
 M1nXjxZwuXO9RPRolDYhQARZzV8L5N4zj6ZFO+IjbAH5iR3K9eoXjRCF7PS+fK7rhyBpFuucq
 tA3wk6A7Ljl08ltvGopfnrVI20CbziAEybIxtH/yD/S6M6DhJB5KPKSbT8AS1yTcOGMcIxCdU
 HNh/bz2+K17NsPZVOf5wPXq52T26etgaXDr6KoXxdavqPWuPIgtwVmtRro6hF+9nfvpbrtvc2
 n/ICtcs7yzPa7/UwM4ZDrkKLtOdsjTluh6XrUOxvtZ9h2ZHXxtxg3BO7BigBSgKBBDQBRTOyN
 No9uFS95NCNrGnU0o/k7a0s9JTse+R+qlbXwUnCVSPGc25SiHjrVaGt7+X42Nlp3nBGbBpI5I
 mkfEfBoOQtY6EynGZ8qS9leCGqtmJHNDMHZG3cyMuaYiB13F7btHRSVXGhIexVpOap2ZJmxMr
 PMiCx/93wXhGGerfju0CVrSizsycdc0Hi9pL/dQxIX2HpIn0aaRnPjm1ZBAWLn6omBEbCYzqH
 Di/UUQpmP+VFA90CmDyBFGKVeXyclpBWmNtCOivhu8hLgPc/2f7x7bXINYrXZzgZXnuojlhcO
 B6Bu7sxkRzPEcQxerG1ThvTnKgVxBfmRL8DOzXh6volzOn88FG5DaEHFq5g=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.03.19 04:26, Greg KH wrote:

> No, it's just that those systems do not allow those devices to be
> removed because they are probably not on a removable bus.

Ok, devices (hw) might not be removable - that also the case for uarts
builtin some SoCs, or the good old PC w/ 8250. But does that also mean
that the driver should not be removable ?

IMHO, even if that's the case, it's still inconsistent. The driver then
shouldn't support a remove at all (or even builtin only), not just
incomplete remove.

>> Okay, I was on a wrong track here - I had the silly idea that it would
>> make things easier if we'd do it the same way everywhere.
> 
> "Consistent" is good, and valid, but touching old drivers that have few
> users is always risky, and you need a solid reason to do so.

Understood.

By the way: do we have some people who have those old hw and could test?
Should we (try to) create some ? Perhaps some "tester" entry in
MAINTAINERS file ? (I could ask around several people who might have
lots of old / rare hardware.)

>> Understood. Assuming I've found some of these cases, shall I use devm
>> oder just add the missing release ?
> 
> If it actually makes the code "simpler" or "more obvious", sure, that's
> fine.  But churn for churns sake is not ok.

Ok.

> I put the review of new patch submissions on hold, yes.  Almost all
> maintainers do that as we can not add new patches to our trees at that
> point in time.

hmm, looks like a pipeline stall ;-)
why not collecting in a separate branch, which later gets rebased to
mainline when rc is out ?

> And I do have other things I do during that period so it's not like I'm
> just sitting around doing nothing :)

So it's also a fixed schedule for your other work. Understood.

It seems that this workflow can confuse people. Few days ago, somebody
became nervous about missing reactions on patches. Your autoresponder
worked for me, but maybe not for everybody.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
