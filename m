Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A450C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 05:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB49D2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 05:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfDZFQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 01:16:30 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57998 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfDZFQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 01:16:29 -0400
Received: from localhost (unknown [12.154.31.185])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 52F2B13D7EF50;
        Thu, 25 Apr 2019 22:16:28 -0700 (PDT)
Date:   Fri, 26 Apr 2019 01:16:20 -0400 (EDT)
Message-Id: <20190426.011620.305509836638141511.davem@davemloft.net>
To:     yamada.masahiro@socionext.com
Cc:     sparclinux@vger.kernel.org, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, frowand.list@gmail.com,
        mingo@kernel.org
Subject: Re: [PATCH] sparc: vdso: add FORCE to the build rule of %.so
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAK7LNAQL0GFHRkYmvTT=Oa8PPkF0FBdgUK_BUQvjwrwNRBEBnQ@mail.gmail.com>
References: <1554280344-10741-1-git-send-email-yamada.masahiro@socionext.com>
        <CAK7LNAQL0GFHRkYmvTT=Oa8PPkF0FBdgUK_BUQvjwrwNRBEBnQ@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 25 Apr 2019 22:16:28 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 26 Apr 2019 09:40:46 +0900

> Hi David,
> 
> 
> On Wed, Apr 3, 2019 at 5:34 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>>
>> $(call if_changed,...) must have FORCE as a prerequisite.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
> 
> Ping?

Sorry, I'm really busy and taking a short vacation before the LSF/MM
summit.

I will get to this when I have a chance.

Thank you.
