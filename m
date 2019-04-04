Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E73C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A18204EC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbfDDKwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 06:52:05 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:52777 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfDDKwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 06:52:05 -0400
Received: from [192.168.1.110] ([95.114.151.90]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MEV7U-1hALGF1NrG-00G3DV; Thu, 04 Apr 2019 12:51:37 +0200
Subject: Re: [PATCH] pinctrl: intel: Implements gpio free function
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        zhuchangchun <zhuchangchun@cvte.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hendychu@aliyun.com
References: <1553135724-38331-1-git-send-email-zhuchangchun@cvte.com>
 <20190321084420.GG3622@lahna.fi.intel.com>
 <20190321092330.GK9224@smile.fi.intel.com>
 <140c6ec0-7c11-6aa9-8434-f14d77be9a8c@metux.net>
 <CACRpkdZ1xPJ=NS=o=-PYqCO4d-VVZM1=f=xBZa5Dwx78LFPYtA@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <cb643914-2c3f-0c63-13e4-8171fa9a37e7@metux.net>
Date:   Thu, 4 Apr 2019 12:51:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CACRpkdZ1xPJ=NS=o=-PYqCO4d-VVZM1=f=xBZa5Dwx78LFPYtA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:9NyvXIJz5mvYfcj/sH8HQPWASMEHcXLJF8cEB+E+DyLBlkRyI7h
 RxnxYWqQCKM6aALgtBwM7FbnhBCRWsqPE9HjjokkOCf11dxqjB+QkXfP//ZbsZPPs3N4Cln
 KbwVlJtq3KWLQEiTSeO5snqw9lyI3gCT5bJfQXaqgNXuAQsDUA9Z2kJ0TFSIGqT1qXx7OOy
 oehbEMrWAQA1zd9QtxYIQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EsGcX/CTXgg=:MmuXYMcQlJw6/zjfbPNfiH
 R3OeIouR+sel6hRcA+7LPIwpmcdig+uPTDZvns4whi4FW6Aryx0q60zGXe+NUCSDeSBHc+E0X
 k+f/bNFIiPIPj90kAQbd0PpRDYKOGP6KJdNgT67TYuToj7twL1YBohzoKJrcpefSKRxQ7T50S
 6PZJJ65uJ4Uj2OGUu0VxyE7zjWCHNPrOKkFmI2H/ZpjH4dYUV6NJ/+1RG2GHyBP3/cL6wFceg
 UCmHIj7Zjc0ExB1Hoh4Fb/z7kHnggHjXz2lV+Wif+Lx6RePbNM87/ZOR4VSc6LyhXp6bRVP93
 9eA4BV8tc5TIEnaE/TcAfNdRiaaejxCj4WhnudO5B5QdzDcQ2v13w4O8XugQ1Q7YsDy/Rl7Zw
 3h0hdHz+58pBIzWiR8mW4Qc88RhfD7UQ8wtEcYFoFKNe/Pfpl6IpSuHdVWc8TZrm5atmWRyzn
 iw098wrN7siQB7mDdMjm6h8d+2MFmskKGtXW2ieStlXKJpMVwObihdPOz464ON1f2RLs/xGjF
 YOzJY82WXbHRSHTNbd6tBVnIhzEGPalP839Eyn7xKOuqKv6zmCKY3nGflon63ZcD06LlptlZH
 kGJrPkJGSYYGiLgycObAtoX9lyedJRwqbuXZdOZF6AwzCgyIuf14KQE97JyXWkFkj/0VYetIC
 U2Z/ypuMV9aJ+cMD/O+Yw44WIIhewZp7wSihdh7l/BL1sY//dFRwyNfaaNR15lEBzYAWcFY5S
 1hGXkRMomdZNZ7SjBAxNVnTcpeXwpX5eY3U/uHbPa6db9JDNM/P9LRPSuVY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.04.19 06:13, Linus Walleij wrote:

> But the chardev on the other hand will protect you from all this.> > If the program crashes, the lines will be free:ed.> > If two scripts
try to access the same GPIO, they will be denied.
Right, when you want this concurrency protection and cleanup stiff
the chardev is the better choice. But I've already had several cases
where the simplicity of the sysfs interface is a big win - all you need
few trivial fs operations.

That's also nice for exporting in a grid, eg. via 9P (eg. nice for
quickly building up HIL environments)

ioctls have the bad side effect that they can't be exported via
network in a generic way - your remote fs protocol must support all of
them - even worse: it needs to cope with overlapping ioctl-nr's that
can have entirely different data structures depending on the actual
device. And now try to do that w/ reasonable effort and w/o creating
a shared memory between server and client :p

Another interesting usecase is permission handling:

a) some ioctls need special privileges (oh, how I hate all these "if
   (!capable(CAP_SYS_ADMIN)) ..." lines in the drivers), but you wanna
   give some unprivileged user access to them
b) you wanna give an unprivileged user access to specific gpio's,
   but not to all at once.

With pure filesystem based approach, you can easly define permissions
for each filesystem object.

Yes, these usecases aren't so common for average Jon Doe, but the gpio
subsystem is used that way, out there in the field, and it would be bad
if that functionality would go away someday.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
