Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6BFC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 11:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 403FC2189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 11:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfH1LhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 07:37:15 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:37193 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfH1LhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 07:37:15 -0400
Received: from [192.168.1.110] ([77.7.60.253]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N7yuz-1iFuZG3qoV-0150xU; Wed, 28 Aug 2019 13:37:06 +0200
Subject: Re: [PATCH] platform: x86: pcengines-apuv2: detect apuv4 board
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
References: <1566294992-703-1-git-send-email-info@metux.net>
 <CAHp75VfFf7y5iLHSgS+mXa4cE78BC=maF6PWtwEGfgyi2pXKCg@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <8e9ee2a1-3731-9427-bd04-2d4327913aa3@metux.net>
Date:   Wed, 28 Aug 2019 13:37:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VfFf7y5iLHSgS+mXa4cE78BC=maF6PWtwEGfgyi2pXKCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:KLKDaCMaQBqKOY8KqvVqASnTA9aw0yZC1pGs+qu5ZVtHdNVb6/J
 etxkh3l4FqfAwn62U7llMjuh/X1v3tOH1DhVLPSXhDUW6aoFPA7sqnzSXUoZtUZBQKV65at
 pCaSOsO/qQ3Qw2isCKXvKOpfZ6hgyMSSRdEocisWECH/1A+6IFX7OIqV9jr9CChQeqbaaqS
 aZpbLzXzXgt1s8wiEolxA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SBNgbehj8sc=:/vbR3tYqUgif/8iocPuZPy
 gSHAD/tSZU7Zy+bod7rjnPWlpV9ksq4q3+4Rafw8pGt22bGOMVzrI/tlNaZze5m0z5hLfaLDW
 qdmyOUsIP6+FKaGlMavku3sldhJShMwGL0FcyvSygN967kAY8HBaB/a9NVIfBDJdMAG00W/3L
 iOPiwqUyMCyDYJrel1aQZltc9JhcLakzOmAgnH2nIp588pSJX2zpENn0YNdWdMt+hioS0p9Z5
 XT3j28jgNLc3/7uTXZpg/rIS995UBk2OoMqBqT4E/21MWKHqvcD9Jn/bwemmmAiN/0V62cgGb
 NZkoySzbapR0qk0kUhCiv35qNtJxGLuawqAe5IxBskDYr691+jLzTGh6UqoagvPPGNSCaeyP4
 /Pe6wiSx0XeM4cfF9QrgnET9FmE6jYHg3f3H7CZJkzAFBfaqibz4ISVig+S5zJ/aDm+e3NPUm
 Jzek3qNny9z5PSZJpXSiFsIUgpun7hqx/19cwkFEN69e0PCR7C9HTLWvCSIIAUmMu1fnofc3B
 KGHMO3M1GEJhmZkwncvMoxAcCgWywZaRUtEgGnfrTaKwwtPLbnjylqJGg+ru2CuVYgivWwVfN
 yoRI8Di8rdNsO5HV/nC376s1SRzCd6ehsPN/TXx/NL1N+x87m5BQXhB1qCchRzwyE/X8Tony6
 +ruvsQKvt21a8/8choLhPzC/l+eWc1NomDJA4XpkhKwcMr3i2Os7FxKf6w+zoM5eb+gaqGi7Q
 4B6GIwgeHaCmgKPiQPq7AEyrfsqiCw3zLq5SQIhKb8froubyWDvRSIU0jiU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.08.19 21:47, Andy Shevchenko wrote:

>> Fixes: f8eb0235f65989fc5521c40c78d1261e7f25cdbe
> 
> Wrong format.
> 
> W/o SoB tag I can't take it.

What's the correct format (what command shall I use to
create it correctly ?)


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
