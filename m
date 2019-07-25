Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12286C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 07:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD65D2238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 07:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387986AbfGYHWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 03:22:34 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:45753 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387951AbfGYHWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 03:22:34 -0400
Received: from [192.168.1.110] ([77.9.64.13]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MsqMq-1ifCnO1BAu-00t9wS; Thu, 25 Jul 2019 09:22:30 +0200
Subject: Re: AMD Drivers
To:     Gilberto Nunes <gilberto.nunes32@gmail.com>,
        linux-kernel@vger.kernel.org,
        dri devel <dri-devel@lists.freedesktop.org>
References: <CAOKSTBs-cHMr7xbJVVUjZ9C3__bY6jZU-_TZ0RmMRMJ3dBk3PA@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <0c3f445d-1e37-1531-d3d5-f7ad75c58343@metux.net>
Date:   Thu, 25 Jul 2019 09:22:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAOKSTBs-cHMr7xbJVVUjZ9C3__bY6jZU-_TZ0RmMRMJ3dBk3PA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:659jE6DNqxATIz6lVOvFCp//CjtOqPsWVkvHo3c2gH0Z9BnolE/
 7E02SQSPqT3EXNqNqKQHpo9pNLqXIrjBLgSZ35p+FLFj+9uAfcE3s3uxpjCwEddXW2lT8TA
 zYUuGjfQoU+DSlVeX8Y797vlaJys0GJbU4Ouf5kTCaaBngNL1leKjiWEVwEvnXd1gP2EVNb
 ByFNaTu55yZ7orXAW9hfg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:18pTWSl+wSI=:u79uo7fZm4iSH46IVznB4x
 BM3e8D3G+q/Vsf3DesUmX1N5BTg5+fYFUBXXggBIWMKJyFk4byDFXyGCnpLghV4nPwdP02kCZ
 if4v6A7e1A2Ju0apUUiS627vdcnEhJZpIP92MFCSRXQuVFdQvayYxLCb3CQaF8wFhbk4JSpdn
 unAG+q7mKeDwnbNdFU3m+hE+AgpzdW3cMJdcsSAhnFz/cgwa0m2zO6e1cgkFDUDQ4NNJByKrH
 RS0Bhs0rCuTA5nYTp86C3xN/KJ/F+l/dWYBYVl3G7dzvBc/MKtFjmJPL9rjGfLLAy8AC7PK/q
 H/4wxmLajPHD3eMBEXEUsgiRhc78BCpWK/DFn3zaYhnbdHKAwc6xQvqPbI0TzGkd+xL6ukU+w
 7XL3uk3tHjJrTfYAIBa06cXjYpelXepvP63eyDMjirz9js/1OKXdT8g/PImbA94DraT6nZm70
 1wyDs2zqSUeCzhmRtcOPJ5P3o0cncJdTf19x69yloBJAsjstsUqW9wlY9+X3ixbHQH8rNQOWM
 mdulsMgeOqJCCcDGtYKBR97JAwU/zfoid/g3IOAN+HED8ud9CxQIPrmbfFWgncYsQAxZP6XLG
 T+shpWnhmo2Mybql9qT0ftDSOZ4c7twGckuJqdyxnRvF9vV6xr/o3q9kDMizqFaxIUHEcgOzY
 qoT5wgxeANOZAlII48PLfW1oTygihlwidlbuU5XY+pxab6rrdbC6xGAX1oXiICQJ+EkjbP6rF
 9NGAQcSNvdiaAyyrxrI9YLDq3WQ2Tjb9e1WFZD7rXcyw6qynph93jnIHUsY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.07.19 16:17, Gilberto Nunes wrote:

Hi,

crossposting to dri-devel, as it smells like a problem w/ amdgpu driver.

> CPU - AMD A12-9720P RADEON R7, 12 COMPUTE CORES 4C+8G
> GPU - Wani [Radeon R5/R6/R7 Graphics] (amdgpu)
> Network Interface card:
> 01:00.1 Ethernet controller: Realtek Semiconductor Co., Ltd.
> RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 12)
> 
> When I install kernel 4.18.x or 5.x, the network doesn't work anymore...

What about other versions (eg. v4.19) ?
Which is the last working version ?

> I can loaded the modulo r8169 andr8168.
> I saw enp1s0f1 as well but there's no link at all!
> Even when I fixed the IP none link!
> I cannot ping the network gateway or any other IP inside LAN!
> Right now, I booted my laptop with kernel
> Linux version 5.2.2-050202-generic (kernel@kathleen) (gcc version
> 9.1.0 (Ubuntu 9.1.0-9ubuntu2)) #201907231250 SMP Tue Jul 23 12:53:21
> UTC 2019

Could you also try 5.3 ?

> The system boot slowly, and I have a SSD Samsung, which in kernel
> 4.15, boot quickly.
> And there's many errors in dmesg command, like you can see in this pastbin
> 
> https://paste.ubuntu.com/p/YhbjnzYYYh/

looks like something's wrong w/ reading gpu registers (more precisely
waiting for some changing), that's causing the soft lockup. (maybe too
big timeout ?)

> Oh! By the way, the network card r8169 are work wonderful!

Didn't you say (above) that it does not work ?
Or is it just an immediate fail and later comes back ?


--mtx


-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
