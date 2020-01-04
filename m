Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D50DC32771
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 20:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0957522B48
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 20:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgADU22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 15:28:28 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:41803 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgADU21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 15:28:27 -0500
Received: from [192.168.1.155] ([95.114.65.70]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MMG6Y-1j712f0xM6-00JG57; Sat, 04 Jan 2020 21:28:23 +0100
Subject: Re: Why is CONFIG_VT forced on?
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, Rob Landley <rob@landley.net>
Cc:     linux-kernel@vger.kernel.org
References: <9b79fb95-f20c-f299-f568-0ffb60305f04@landley.net>
 <20191231015515.GB3669@mit.edu>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <8c6a1c95-5c83-f082-5cc2-1273ed9f5d6f@metux.net>
Date:   Sat, 4 Jan 2020 21:27:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191231015515.GB3669@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:v+3xTo5Ji1/ks0rUV82qmW5Y7o09EQkXD0MfYQb2/6t1OHLenb+
 Ho5xM68mv6QlT2l1oIPTbuipM8li4WEuU6X4m/RjhUs5RXaSok957MSJBkuEZjlMdyB1JBt
 z80nC82m0VC44h//IvmXU3IJ0XKmeCJ9zbcCX6/eyTc7i9WuU8i9MPy7fyD3KWwPkc1X8Ah
 8cLX6nCmZkwm7RPyKrGzg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GSM1oa7DXlI=:agk1C5IWMxQ/q45wQvY4xj
 pI5Mpx0DoJrdJwyXzYCN7HFl1/JwgRftCjg+8/lTzUGbM/ax1WO4QzUQjAmxRleuLUVW4ZD6j
 bzktvNotA9/2vHiNBIbuQbsmvM33mXjeMVQ8e/T2z5nBTe0UNrLpA0tGyJ/Nl/VUIavW88Eec
 HqIxRZiB7yAJyqcrFpUbPBG0PyvpNvA6O6uz4aukrH0NKKEhkeIEiWWYnCq2JlQ3zfunIxl36
 sdYXVort3J++lmsVXEj2sBSbxfsCKgI7dk650mIU9fgquYVTd971joAhgUBpVfceN2Q9ghe/b
 lx5yMvxJvP2KN7X3E83wzotxyXejXlNAO3l4fEGNCKB6nhCUZtirfFWiXT7gss14pX7x9vPni
 c8B5kk8mC+BLIrL2VUsDG81tAtlqV6Q+ighNN9wGSuDIZaTcja1GWhqtBVOWnwcTUcVgVpuME
 Tamjrlg21SPQIdS+Zkpt+OCpSFJCzbQ3Oz3XF6cpXovpYqa1+STkGGZbyjqDgrLVIn+iMJ6Oo
 gfAVcC3ZWCArcuG+kvmu08q3WGK5BXzZRqdAkZfp7JGnw2IdW6ejvp+tfjnM04E+AxGFaJQDd
 B5tVbNHjhLTIR3hS51zImkM/Jyg8ZiG++XWyJXd36pJwZGUBoPNVGvre82pBz9jxqnV3+aZEh
 C1V7S5bDaEOxWcazuC6z3PEy82TI0VEuc/gglwy2hntCSich5POpAddY0mpHIce9a/fUZe47h
 dcVkKSkU/NUTdN4sxIJcqFVUHbndwkHelSM9YZAoYEd5vUUdrEOZ70NsYOZsbIW4UyCG8LRNs
 7O5taoEUybpdNeXM9HHBHyX9sinifBSoxrXpW30XrnFMvL/+qfwFGcN6l92URMxATtsdN022f
 dCgLuM1o6FTB9Duo+DRg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.12.19 02:55, Theodore Y. Ts'o wrote:

Hi,


> What this means is that the prompt is shown only if CONFIG_EXPERT is
> enabled.  If CONFIG_EXPERT is not set, then the default value (which
> for CONFIG_VT is "yes") is used, with no way to change it.

So, if one manually changes that in .config and re-runs 'make
menuconfig' again, it will be forced back to the default ?

> What's not there is an explanation for why a parameter like CONFIG_VT
> is enabled. 

That actually would be a good thing to have. I already had lots of cases
where I had to spend quite some time in order to find out what caused
something to be enabled/disabled/disappearing.


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
