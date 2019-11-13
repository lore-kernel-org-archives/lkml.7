Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D37C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 07:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3FEE21D7F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 07:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cZqvoK7W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfKMHRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 02:17:22 -0500
Received: from m12-14.163.com ([220.181.12.14]:34575 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbfKMHRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 02:17:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=oxCjX
        mUOspQTaP7Tq+vq3pr1IbDXj42KX2LjX+xk/p0=; b=cZqvoK7WPThZGEv+GUPqD
        oLG9DvsM7fNycrmu/E2Eifk2paSy8D+qmrwMW2kIwbr8P2Ej1xUhUZM8fGglpVJk
        /4V/eyMl/YFm27FO7dGpsK/6hZm0oR0uaztaUMkefdoSGbdOPRCEe0kkSTNuzU1n
        WRDIue7gNeJiGL42Cn8c3A=
Received: from [192.168.1.133] (unknown [112.25.212.39])
        by smtp10 (Coremail) with SMTP id DsCowACXnLDVrctd72TNCg--.49S2;
        Wed, 13 Nov 2019 15:16:38 +0800 (CST)
Subject: Re: Question about "asm/rwonce.h: No such file or directory"
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Will Deacon <will@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
References: <1da2db04-da6a-cedb-e85a-6ded68dada82@163.com>
 <20191112123125.GD17835@willie-the-truck>
 <CAK7LNARA99UUTY2v6rS=Nb4Cg5pB4RsR0PogLqdT9uNLcH20ew@mail.gmail.com>
 <32a3b660-f4d2-268e-2206-d50073298c0c@iogearbox.net>
 <CAK7LNASR=R=gyuaMO=VzdXrY3gaQ_FVE4es60bzXf=9ASR2qUw@mail.gmail.com>
 <021e7b46-047e-d381-9dca-bd61db08e4f8@163.com>
 <CAK7LNARKh3-cAqsYgcxFwq9CGk-CgBfkiQgfNSULkxwO0xa2vw@mail.gmail.com>
From:   Xiao Yang <ice_yangxiao@163.com>
Message-ID: <ac4577d4-c0f2-9596-df6f-3fcc563bde3e@163.com>
Date:   Wed, 13 Nov 2019 15:16:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNARKh3-cAqsYgcxFwq9CGk-CgBfkiQgfNSULkxwO0xa2vw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: DsCowACXnLDVrctd72TNCg--.49S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUDApnDUUUU
X-Originating-IP: [112.25.212.39]
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/1tbiqBZsXlc7L3HmwgAAsa
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/19 2:57 PM, Masahiro Yamada wrote:
> Sorry, I really do not understand what you are doing.
>
> include/linux/compiler.h is only for kernel-space.
> Shrug if a user-land program includes it.

Hi Masahiro,

For building tools/bpf, it is good to fix the compiler error by Daniel's 
patch(i.e. use linux/filter from linux header).

linux/compiler.h may be used by other code in kernel.  Is it possible to 
trigger the same error when the other code

including linux/compiler.h is built? Is this kind of code able to find 
the location of <asm/rwonce.h>?

Best Regards,

Xiao Yang


