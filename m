Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B729BC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 21:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED862133D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 21:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbfEQV4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 17:56:36 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42313 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbfEQV4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 17:56:36 -0400
Received: by mail-pg1-f194.google.com with SMTP id 145so3889718pgg.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 14:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=d5dZcfB3X6Zj3ygJkBL+P8/7M789qNSgZMW0sgFVvfs=;
        b=bZ4HJdtz0WHAF0VobC4uQ2el14hYRRm7sz+fkaQgLM84lr5yGMYCaUhWm1BFhabgUK
         n21g/YviB1xkXG4xdSPgfE/vfrR6GC664Rz+I7CvGI6N+VkysolB918ggTiK1JfcpTPz
         I+P1hxVColNLNmZYvu4CfDBIwL+aqByn4I8oIDRsTDsXUZshqEX0wn0MJnRBcvcAnDFV
         3YVhrY0r+z7A5OQMwYQ4YYq0CY0tWLXWzp8hCsUE8I+fntx7/EQXRM0Kn5AeBiNB96Ie
         ZLOPyKN1MVjDna0ZhcVWjhQFucdpIxOi0HV+KjdEvpOLeNkHjqxdXdfe/MrL2gX+sBk+
         pKtQ==
X-Gm-Message-State: APjAAAXy5imt14qOBsMZ6xGjYT4kChXX45bW4JRVnYYQactzUsfhbeaO
        bL8m5F9Ph8C31ICKrxOvOvilyA==
X-Google-Smtp-Source: APXvYqx1rm9C5knfvY0mBW1OSgki/1ojibebu3uOEnjOaXdhT87hFO6BSFZi6Kbc00RwHW8UEx/Bbw==
X-Received: by 2002:a63:930d:: with SMTP id b13mr47894784pge.18.1558130195460;
        Fri, 17 May 2019 14:56:35 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id 1sm10232391pfn.165.2019.05.17.14.56.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 14:56:34 -0700 (PDT)
Date:   Fri, 17 May 2019 14:56:34 -0700 (PDT)
X-Google-Original-Date: Fri, 17 May 2019 14:56:16 PDT (-0700)
Subject:     Re: linux-next: Tree for May 17
In-Reply-To: <07e1a10a-5348-2d2e-fb6a-c9ef837185fe@virtuozzo.com>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>, atish.patra@wdc.com,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     ktkhai@virtuozzo.com
Message-ID: <mhng-10bb9bbb-5f65-4ed6-8496-317d80be8dfb@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 May 2019 02:43:08 PDT (-0700), ktkhai@virtuozzo.com wrote:
> On 17.05.2019 12:41, Kirill Tkhai wrote:
>> On 17.05.2019 07:21, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> Please do not add any v5.3 material to your linux-next included
>>> trees/branches until after v5.2-rc1 has been released.
>>>
>>> Changes since 20190516:
>>>
>>> The kvm tree gained conflicts against Linus' tree.
>>>
>>> Non-merge commits (relative to Linus' tree): 1023
>>>  1119 files changed, 27058 insertions(+), 7629 deletions(-)
>>
>> Binary file was added:
>>
>> ~/linux-next$ git log --oneline ./modules.builtin.modinfo
>> 4cbb0d07b4d1 RISC-V: Support nr_cpus command line option.
>
> CC Palmer.

Ya, sorry about that.  It should have been fixed as of last night -- I must
have just done something stupid.
