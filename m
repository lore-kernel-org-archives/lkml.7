Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B16C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 13:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26ADB2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 13:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbfCENuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 08:50:46 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:35633 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbfCENup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 08:50:45 -0500
Received: from [192.168.1.110] ([95.118.29.230]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MP2zs-1gblrD1IwG-00PLVf; Tue, 05 Mar 2019 14:50:35 +0100
Subject: Re: [PATCH 2/3] x86: apuv2: fix input dependencies
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linus Walleij <linusw@kernel.org>,
        Enrico Weigelt <info@metux.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        yamada.masahiro@socionext.com, linux-kbuild@vger.kernel.org
References: <20190304201930.1622839-1-arnd@arndb.de>
 <20190304201930.1622839-2-arnd@arndb.de>
 <a94c3c6a-481e-96a5-74e1-8c3299c74129@metux.net>
 <CAK8P3a0vdhCTNTF-K0mXjRWkPvv0qr3nf_52=8n6zTa7p3ELLw@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <54a7d035-155f-c47b-1db1-acb851b3aec6@metux.net>
Date:   Tue, 5 Mar 2019 14:50:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0vdhCTNTF-K0mXjRWkPvv0qr3nf_52=8n6zTa7p3ELLw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:5w8Oy1QUP5D8GKRoukweESEcD6DrQtd2KJaYl22I70X3OHYBMTb
 LYNcnx78pwsxP3bbohY6Rd8mtJ6IMRmxC2h1MRbYEthPUNWUDVLx24QpLQhlxJvhvv01bUc
 +5Fm4v1E0Q5bW7PSrNoTqGHS4vsrdWeBxAdoOSRCjCSt4mXBjJgyAIOUnsGGCWK2LRnwQQq
 VXnhIKNqI8dZLpifeoiMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2+NYjR/F27U=:KC1JLCWyWr8aUFntvuTwJX
 pMlLvNWQYn8lIgL7OT0q0tDjJbBZH4L20zLO4jgIT70bfXU+tQF+1e7IA7cObDXDrvD9b1aFq
 lVcYlKxdXZ8dM5Nf44+EcLaTK80o8S8cBwo3jQZno3nHp4kQrknON3M8Q/smtal8/a741OpEy
 ew9ZOqaEptQEldEHFCAd6ZgnW9NxiaDlam5umdsSJIrAgZcceBssoJKJM+LljQdLeIM6+CZeZ
 ghRB0lpTPePKqPr+2sVmddew4tX+zRxCRwXrrUXKFF7hCBfzU2D8Fw+zeLlMbRbxdCkVPPRsS
 VJ0UxDnfko+LXXUrWJM5ypbmteb5fwZIrVldh8KDSJBXKHffKRC7TviGOaIXtrqVj2YHYdEux
 iST5onXQ5KW2jEzB+G0poZ3vXt0XADtOYHvcGE5Wdkl6pKkER4nhJ3CF8ZqtlIPUvP4wojTaI
 FXsSg0V6uz+LK8kDY8g4fbPIUS/n+3LYb5LEnpbhwPHZ8UDGFItTSJw7ELFEm/17v6P50ybAl
 qrYKmVqKrUU6J9TP9dVpCxIaGV3pLDAnbgmcLKSAqCMKARQitG5i6znSLO9pc7j8LYzYth6Zg
 OpuOzkjeJmJ9APvPyujdrTB8gEZ/6GdfDnXy6FSmfjIPgeJcNOBxwr0ji8P0QO2rmjhD/62q3
 vmgtB+SGG1m8PqE0p507eb6sV39hEszuPR5fbWr/3wJwFAvLl6pK6/3gVlnakEpYwBXtAwA1X
 qk8SBT7vlaUjxSLyVZhsYtPd798WBU8nUqZdBep5UWaj49VuUJ8X+LPVg3g=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.03.19 09:23, Arnd Bergmann wrote:

(CC'ing kbuild maintainer + list, hoping for better ideas :)


> No, that wouldn't be good here. In effect that means that with INPUT disabled,
> most of the x86 platform drivers are disabled, until you enable the
> PCENGINES_APU2 symbol, which then ends up showing all the other
> symbols at once, and changing them to their default states.

Okay, I didn't consider the defaults.

Maybe we should talk about step by step getting away from these defaults
(perhaps move them to the defconfigs ?) on a broader scale ... but yeah,
that's far out of scope now.

So, you've conviced me.
Add me to Reviewed-By to your patches and forget about mine.

> Another problem is that you likely run into circular dependency chains
> after trying that. The best practice for select vs. depends are

hmm, if circular deps happen, wouldn't that mean we've got some deeper
problems in here ? IMHO, dependencies should always form a DAG (except
for some really rare cases).

Do you recall any actual problem w/ input vs gpio vs. drivers ?
I'd like to have a closer look at it.

> 1. try to use 'depends on' if you can

Well, this has the unpleasant side effect that we often have to enable
a lot of things, just to even see the individual driver. For people who
just wanna configure a kernel for their board, this is a bit nasty.

But, okay, I'm going to do this w/ my own tool - I've written a small
tool that allows easy kernel reconfiguration on a higher level: you
can just pick some board templates and enable high level features like
eth, gpu, etc - it automatically creates a .config for you. I'm going
announce it on lkml soon.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
