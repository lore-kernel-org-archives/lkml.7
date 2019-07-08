Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EEDC606CA
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF078217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404591AbfGHToi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:44:38 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:43563 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729234AbfGHToi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:44:38 -0400
Received: from [192.168.1.110] ([95.117.164.184]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N5FtF-1iTM7u3Hyn-011E2v; Mon, 08 Jul 2019 21:44:31 +0200
Subject: Re: [PATCH 1/3] platform/x86/pcengines-apuv2: add mpcie reset gpio
 export
To:     Florian Eckert <fe@dev.tdt.de>, Eckert.Florian@googlemail.com,
        info@metux.net, dvhart@infradead.org, andy@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190704090205.19400-1-fe@dev.tdt.de>
 <20190704090205.19400-2-fe@dev.tdt.de>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <3c469213-f2d7-aa7e-4028-e8ce463a4441@metux.net>
Date:   Mon, 8 Jul 2019 21:44:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190704090205.19400-2-fe@dev.tdt.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:gIMTdACTh5zJfJGnRQmnqYuTaHcSfSjTTs22et/Q1dKfU3mVaSh
 BTAnlNobUwm3aytVGI9Q6j6/LEUVgzDBZBXO8gm17RbFG0TZHxyCDkYXCM3hY+sYcbC0Uwm
 gCYFD4XaArmK8a3ZnxIlmXP84FW8dk7giVfG1+rltinA6TzQ2d7S4hwlq7I382u7lIx/wHO
 6X7n4Qd7gHdVc+RY/zoUQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rf3mH9IaJlw=:yHHNcCCx3slMgb1Nw7Qy1v
 6spnXvV3i0eci+7mFx77EIDcKXehjBgG1aTNuYO3gBhjdzuUcby+vhNQFnLGWL3snmIc66Bgi
 6mwgfUL/1f8osMUcukF6NVfPh9A+Bib8bUxAjt1N+sRco1B/9msMKcZOeDs8DIcE04eIqBWeU
 83Ivf4dqPSEeH9QkLLpniW2vTeotK3RYP2QTNYoQ0DaqVK7I3+kUX+T7hs0wvOX3y720KvQA4
 U9jWS3Ahg95MvbOIb6dE50QKV4GTuYRyZujPSjfQZ1OHAUIw2at2sjCKqpA91rrJVn9ptAHn1
 GsXzfgck+11IO7fpdglq2/pk+Bsq8x0dcyePTSLD/iZAOy7PM+tOaK4YWzWsOgGlHcmNOvtUd
 5zOofUdQ31FMxXLDqoAjSMgwz7cFWYcidAv2GdbPRi4z4iQase9avJqU1bSVQHTGX1i1Ln9iQ
 r9d9OIyj1o3Zc3LuZ2b/KW9LN1vhTg4WF/UPUBbDJQOdetF14TzXyZS6rpwpIixs7u6TLuq/s
 5a6i8iR5VxF6XdqAQM4k2Aw/EgeZDfZ7ELC2uVaZlgfIQL8nzDOYHWNea5elVTwZ4gxOmBTyq
 KQ/qWx1N2KsIYzieAt1YfRGhm+/otPef2bPMTam8YltUuCy9jS6zRCmOT3Rw3qNkBu5BgZStj
 0uLfR3ETZnURgwGHlfX90TdpbOoA0uwurDh4LIxv/UutBLVObVtYjDiGvFy4zEZHuWsfNxG3h
 VQjylgmecRk/Gqs3wVLY8Aa/ci9NoAQarSisjVHX4o2bq/Njwwl1zhW4tRI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.07.19 11:02, Florian Eckert wrote:
> On APUx we have also mpcie2/mpcie3 reset pins. To make it possible to reset
> the ports from the userspace, add the definition to this platform
> device. The gpio can then be exported by the legancy gpio subsystem to
> toggle the mpcie reset pin.

Are you sure they're also available on APUv2 (not just v3) ?

--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
