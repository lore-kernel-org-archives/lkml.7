Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34484C606CA
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1239D217D8
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404403AbfGHT2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:28:10 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:39173 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404375AbfGHT2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:28:06 -0400
Received: from [192.168.1.110] ([95.117.164.184]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M4s91-1hkqgS06j9-001xKQ; Mon, 08 Jul 2019 21:27:59 +0200
Subject: Re: [PATCH 3/3] platform//x86/pcengines-apuv2: update gpio button
 definition
To:     Florian Eckert <fe@dev.tdt.de>, Eckert.Florian@googlemail.com,
        info@metux.net, dvhart@infradead.org, andy@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190704090205.19400-1-fe@dev.tdt.de>
 <20190704090205.19400-4-fe@dev.tdt.de>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <add03c08-da1c-20f4-8d07-8ba2ecaf605c@metux.net>
Date:   Mon, 8 Jul 2019 21:27:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190704090205.19400-4-fe@dev.tdt.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:XTU1I8yyvapDQ1yZpWPgbGfrnAWtmhbqMcSITB3/pr9v7OA/zTM
 zU6rgXDwC37IEnIU4GQg9m/6xWISYNuqD62/LUkF7ywpCxn0lzJPiGrPW54gA3LHQVKdTId
 xCDRQyQehyQf+DtgRczc44HQusoopYacQPwi0JSMrYWwUVweDbtqA/FLd1KTdfdjMRz1l/v
 rTq9v0N60w0ZeWozgJuWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Mux62PNQ/oA=:7ZrzmV2BCrFlUFLAJhHi3s
 nAzeLdrP+lJiyMrpg2KKSjMiFDVMo+eKzOmdw48DIjerR3HujBdBIBolMXkJEMIyQrzExjw3d
 qBL/hei14WRq7bIaEzl5optjZNTK4HYIKRnq4ogixeD+25pdq0BOb0Chu9imzrRYVTXx1aeJR
 L4Jo0VcnII86khqKoN8isIH1T8DLIj69XnR+qqdfxLOfgQQ1/om4v6U3Lb6mav+X4o1DbXxcI
 kJZUrsEDvol1WaDzcb9Tm0rMeZqp7IOwRgOgsgXzOpILo+m+/6zsL+/kCcwJ2OIo5Lhk/ACVE
 0ipcLllNo60qQERM+y4C9ugKhKTZN5E3W+kv/Ezm5Vs3+42FNqGh5I3yxtKDaBR1dqoGt9Aih
 QF10Vjt6xAi4ds3ocYWSs1dM5Jcl16gTARhBVmF8GdUDSgmgdxuDX12cB15k4f0/YNP0k+MYD
 W1YiqH6pg51AulWqTdLI8YAkJLPOa9R9QKXYjjDweV3EPS5iiif+CPvafTDMYmUYv3WwhVkeL
 Y4b4j/lyKFiVAgPbUIxtu755jcOet+AxS3DVFQfQ3uY2k0vIjRw3St5rW3xEXuDdu+U+Fho41
 Nficnv1d2g2cyQ1ScsvV2NxlH4XbNv2NXlQKyzVMNx2jmaWOkS8xlgAMUpyfyJD2Pie6h1buB
 3BVx0lrv27s5wUXbcKCXWf5IWPxzoaiSdT1D2EZxhubVc4Y7nAMq9FYYeZ53Yx4tR3GimRoTA
 IEEeBvHei+V5+8OYt2PF9qssTB9m841r1OO1Bpw9acOJ8D3AZ93BufyCzb8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.07.19 11:02, Florian Eckert wrote:
> * Add the gpio number, so the button subsystem can find the right gpio.
> * Change also the keycode from KEY_SETUP to KEY_RESTART, because it
>   seems more expressive to me and in the Alix-Board, which is the
>   predecessor, there isthis keycode defined too. I think this is also
>   intended by Pcengines. Also many embedded systems defined in the kernel
>   use this key code as well.

In general, I'm not opposed to that, but I'll first have to check trough
various userland code to make sure that it doesn't break
anything in the field, before I can give my ack.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
