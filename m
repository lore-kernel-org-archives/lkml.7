Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FD0C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9981206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfDLLlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:41:37 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:33241 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbfDLLlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 07:41:37 -0400
Received: from [192.168.1.110] ([77.9.22.14]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MIMXE-1h2lTy1Dng-00EMpw; Fri, 12 Apr 2019 13:40:58 +0200
Subject: Re: [PATCH] tty: Add NULL TTY driver
To:     "Adamski, Krzysztof (Nokia - PL/Wroclaw)" 
        <krzysztof.adamski@nokia.com>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190403113327.3628-1-vincent.whitchurch@axis.com>
 <20190403131213.GA4246@kroah.com> <20190403141109.3mdmqbt3mjxrie6k@axis.com>
 <e8b1618a-545b-ee35-ec51-f831cbdff7fa@metux.net>
 <20190405090043.vnsftwpdm56cx2hr@axis.com>
 <de23cde3-c77f-cdbf-0968-d7f44c723120@metux.net>
 <20190411130458.GA11390@localhost.localdomain>
 <c77474fd-96d6-392b-9a54-fd7e6a29b72d@metux.net>
 <0a50343e-6ebe-f725-82f7-5c127b5ce2e6@nokia.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <eb11752c-7c20-2a39-d4a7-3be7282b4144@metux.net>
Date:   Fri, 12 Apr 2019 13:40:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <0a50343e-6ebe-f725-82f7-5c127b5ce2e6@nokia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:KUO+jlPG4RZ8CibFtebAyjFR3PrLDu9mEK0zpBgyqywqeOc3lVl
 VSdb3UBsF7GBjO32RL4RhBgB9+fZ26rQNXqu2IwPrNgGO4zGD52j6CAQXuBFuPleleaz2K+
 RUOjEqwC4wMAbMgdQCb9NbJiIltEfTBuMwCpVq93mRyMuWjPIn01kpAppknnA8LRdSzpkG6
 s3CMrguVSj77IBW6Chg4Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RXDQbnOx2/Y=:cBu0IsBaBhy/+X22zMDs8t
 Ysxn0aO33phdu1SmJYHox/v5fz/BwNgf7iikTiupa/jVTu2U9cRQzQXSlz7SRlmm7huOyLNdE
 Tu/nqE8QbLQZ7mBRsTk9S16EOT7st3acCrv7+92fJeVUvmo1wSuB/EnmUjd9yoKBHT8U1d7hf
 m6Sq38s9V8nAtNR+mM3+bvJf+FTBlLd/5lNesB0ee5dRNegpf99pFMIU1gobzxqPqfTsN1h04
 KizdV4WOkyVuLAu9W7Q9yuvambSCAC93t7T2uN70VKzkT4Wmv4wOubeAIbiJJ/2hHA+pJYZHL
 SggXf7lnx50OwukpDfwxFIJT6e0HZBVWmveCWNL9CVjy/S1sVuH2ywgRqY/nhpHREUSITTn3m
 MHsb6BR27RjOJA9vSx82G1jakRdbWO+9sASmRtYeqr2zejK8kHr2zTYZsYvkZADeaEuG1clfZ
 KVyKlehnX1OQVN+DNU2o99WSVkRz9Hus3JDD/MuetRFH9JthnFriFaLqMlgPwgtq3svRyZ2mi
 8HojWjxxiw3xVOofAmV8p3+Da8xB7toh3rWXjFSIzOXrdJGkH3RyCFp0hROIEQ1Xfic4Q4aEL
 2rVyTIQtFCLmwldMVre7zCLrosxUIj4GeMDgG6kpul9Bj41QJKyD/PURyoQewq0G99ofSYCDw
 eN7ztzTgXPWNVvFaaBuq3MCWtYUJFQu0RCzt82HY3p1nR63MJtDSDXxcb1t9Qmo11l7Nj/Zgg
 kgcUNOkFP+HyMjBrX23s0OieoxibUvudT31LxJltNuUhBDdAZHh7nD1d31Y=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.04.19 09:30, Adamski, Krzysztof (Nokia - PL/Wroclaw) wrote:

> Well, that depends. If the program doing those writes expects /dev/console
> to be a tty device, then it cannot be any file. 

According to Vincent's mail, the actual problem is just systemd.
Changing the kernel just for making one specific userland program
(which happens to be written by somebody, who even doesn't know the
semantics of rm -R) happy, sounds pretty strange for me.

I'm not opposed to the general idea of having a dummy tty driver,
but please for some actually sane usecases, not just working around
broken userland :p


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
