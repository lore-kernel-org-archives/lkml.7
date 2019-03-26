Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508C1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FBC920863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553589593;
	bh=gcLfiGPZ3NuWPr9xHxZdXcaaK4Sc9G0b7vGJXYUk19U=;
	h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:
	 From;
	b=PGbLeRG0KiRqIt390IsQ75Gg0Y2ZnAmW/xDKFb1XpNJc/WMgrkt2pM/llfMwiOxTc
	 KFKhcla3Kch9edO32jHHqIsLQWkUX+08FhAf5zAy1THayEMFjB2oFFC359P0fwiWaB
	 Dp5kYLS0uxmG/sJrj6yH+CfCYlEjaUItkVOf644w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731182AbfCZIjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 04:39:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:57668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbfCZIjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 04:39:51 -0400
Received: from [192.168.0.20] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C62832084B;
        Tue, 26 Mar 2019 08:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553589590;
        bh=gcLfiGPZ3NuWPr9xHxZdXcaaK4Sc9G0b7vGJXYUk19U=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LA04y1ocoOE9QyoDzlppQJuRqOaF/RQCcI95tpukIojGTtF/pID8ar8zfCY6IEViJ
         1sbyKBXZgiwziWhnMeg/5qKjaIJZ2B6nq6x275Y+uFNZsflljJJxQDG+69VrWVgXyy
         RUFN2KNPoxvLLyEP/flDepDMTYiYx8QYQ1vDOCME=
Reply-To: kbingham@kernel.org
Subject: Re: [PATCH 0/4] gdb script for kconfig and timer list
To:     Stephen Boyd <swboyd@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Douglas Anderson <dianders@chromium.org>,
        Nikolay Borisov <n.borisov.lkml@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Jackie Liu <liuyun01@kylinos.cn>
References: <20190325184522.260535-1-swboyd@chromium.org>
From:   Kieran Bingham <kbingham@kernel.org>
Openpgp: preference=signencrypt
Message-ID: <0cb6bd11-b98e-2d76-f464-b06afab74e97@kernel.org>
Date:   Tue, 26 Mar 2019 08:39:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190325184522.260535-1-swboyd@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Thank you for these patches,

Could you check them through with PEP8 please?

While we are not entirely "pep8 clean", Your series adds the following
warnings:

linux/config.py:10:1: E302 expected 2 blank lines, found 1
linux/config.py:17:41: E128 continuation line under-indented for visual
indent
linux/config.py:30:9: E722 do not use bare 'except'
linux/config.py:35:41: E128 continuation line under-indented for visual
indent
linux/config.py:40:9: E722 do not use bare 'except'
linux/config.py:48:1: E305 expected 2 blank lines after class or
function definition, found 1

linux/rbtree.py:18:17: E128 continuation line under-indented for visual
indent
linux/rbtree.py:29:1: E302 expected 2 blank lines, found 1
linux/rbtree.py:34:17: E128 continuation line under-indented for visual
indent
linux/rbtree.py:45:1: E302 expected 2 blank lines, found 1
linux/rbtree.py:49:1: E302 expected 2 blank lines, found 1
linux/rbtree.py:52:1: E302 expected 2 blank lines, found 1
linux/rbtree.py:57:17: E128 continuation line under-indented for visual
indent
linux/rbtree.py:75:1: E302 expected 2 blank lines, found 1
linux/rbtree.py:80:17: E128 continuation line under-indented for visual
indent
linux/rbtree.py:115:1: E305 expected 2 blank lines after class or
function definition, found 1
linux/rbtree.py:117:1: E302 expected 2 blank lines, found 1
linux/rbtree.py:133:1: E305 expected 2 blank lines after class or
function definition, found 1
linux/rbtree.py:135:1: E302 expected 2 blank lines, found 1
linux/rbtree.py:151:1: E305 expected 2 blank lines after class or
function definition, found 1
linux/rbtree.py:153:1: E302 expected 2 blank lines, found 1
linux/rbtree.py:169:1: E305 expected 2 blank lines after class or
function definition, found 1

linux/timerlist.py:26:1: E302 expected 2 blank lines, found 1
linux/timerlist.py:27:80: E501 line too long (95 > 79 characters)
linux/timerlist.py:28:80: E501 line too long (85 > 79 characters)
linux/timerlist.py:37:80: E501 line too long (81 > 79 characters)
linux/timerlist.py:38:13: E128 continuation line under-indented for
visual indent
linux/timerlist.py:41:1: E302 expected 2 blank lines, found 1
linux/timerlist.py:50:1: E302 expected 2 blank lines, found 1
linux/timerlist.py:63:1: E302 expected 2 blank lines, found 1
linux/timerlist.py:81:12: E122 continuation line missing indentation or
outdented
linux/timerlist.py:82:12: E122 continuation line missing indentation or
outdented
linux/timerlist.py:83:12: E122 continuation line missing indentation or
outdented
linux/timerlist.py:84:12: E122 continuation line missing indentation or
outdented
linux/timerlist.py:85:12: E122 continuation line missing indentation or
outdented
linux/timerlist.py:103:12: E122 continuation line missing indentation or
outdented
linux/timerlist.py:104:12: E122 continuation line missing indentation or
outdented
linux/timerlist.py:105:12: E122 continuation line missing indentation or
outdented
linux/timerlist.py:106:12: E122 continuation line missing indentation or
outdented
linux/timerlist.py:107:12: E122 continuation line missing indentation or
outdented
linux/timerlist.py:108:12: E122 continuation line missing indentation or
outdented
linux/timerlist.py:109:12: E122 continuation line missing indentation or
outdented
linux/timerlist.py:110:12: E122 continuation line missing indentation or
outdented
linux/timerlist.py:111:12: E122 continuation line missing indentation or
outdented
linux/timerlist.py:112:12: E122 continuation line missing indentation or
outdented
linux/timerlist.py:113:12: E122 continuation line missing indentation or
outdented
linux/timerlist.py:114:12: E122 continuation line missing indentation or
outdented
linux/timerlist.py:115:12: E122 continuation line missing indentation or
outdented
linux/timerlist.py:116:12: E122 continuation line missing indentation or
outdented
linux/timerlist.py:122:1: E302 expected 2 blank lines, found 1
linux/timerlist.py:150:15: E124 closing bracket does not match visual
indentation
linux/timerlist.py:160:1: E302 expected 2 blank lines, found 1
linux/timerlist.py:183:65: E261 at least two spaces before inline comment
linux/timerlist.py:183:80: E501 line too long (88 > 79 characters)
linux/timerlist.py:186:77: E261 at least two spaces before inline comment
linux/timerlist.py:186:80: E501 line too long (100 > 79 characters)
linux/timerlist.py:190:80: E501 line too long (125 > 79 characters)
linux/timerlist.py:194:1: E305 expected 2 blank lines after class or
function definition, found 1

--
Regards

Kieran



On 25/03/2019 18:45, Stephen Boyd wrote:
> This is a handful of changes to the kernel's gdb scripts to do some more
> debugging with kgdb. The first patch allows the vmlinux to be reloaded
> from where it was specified on the command line so that this set of
> scripts can be used from anywhere. The second patch adds a script to
> dump the config.gz to a file on the host debugging machine. The third
> patch adds some rb tree utilities and the last patch uses those rb tree
> walking utilities to dump out the contents of /proc/timer_list from a
> system under debug.
> 
> I'm guessing that Andrew will pick these patches up. I don't know who
> maintains these gdb scripts but it looks like Andrew has been doing the
> lifting recently.
> 
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Nikolay Borisov <n.borisov.lkml@gmail.com>
> Cc: Kieran Bingham <kbingham@kernel.org>
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> Cc: Jackie Liu <liuyun01@kylinos.cn> 
> 
> Stephen Boyd (4):
>   scripts/gdb: Find vmlinux where it was before
>   scripts/gdb: Add kernel config dumping command
>   scripts/gdb: Add rb tree iterating utilities
>   scripts/gdb: Add a timer list command
> 
>  scripts/gdb/linux/config.py       |  48 ++++++++
>  scripts/gdb/linux/constants.py.in |   8 ++
>  scripts/gdb/linux/rbtree.py       | 169 ++++++++++++++++++++++++++
>  scripts/gdb/linux/symbols.py      |   6 +-
>  scripts/gdb/linux/timerlist.py    | 194 ++++++++++++++++++++++++++++++
>  scripts/gdb/vmlinux-gdb.py        |   3 +
>  6 files changed, 427 insertions(+), 1 deletion(-)
>  create mode 100644 scripts/gdb/linux/config.py
>  create mode 100644 scripts/gdb/linux/rbtree.py
>  create mode 100644 scripts/gdb/linux/timerlist.py
> 
> 
> base-commit: 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b
> 


-- 
--
Kieran
