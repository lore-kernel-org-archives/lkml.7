Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66532C2D0C1
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 03:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F2024680
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 03:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfLTDDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 22:03:52 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:53063 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727020AbfLTDDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 22:03:52 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TlOPdih_1576811025;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TlOPdih_1576811025)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 20 Dec 2019 11:03:45 +0800
Subject: Re: [PATCH v2 2/4] docs/zh_CN: add translator info for
 embargoed-hardware-issues
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Harry Wei <harryxiyou@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1576660243-84140-1-git-send-email-alex.shi@linux.alibaba.com>
 <1576660243-84140-2-git-send-email-alex.shi@linux.alibaba.com>
 <20191219100534.707c0f36@lwn.net>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <ac7c33f8-a00b-5360-b3b5-5c6f037590e9@linux.alibaba.com>
Date:   Fri, 20 Dec 2019 11:03:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191219100534.707c0f36@lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2019/12/20 上午1:05, Jonathan Corbet 写道:
> Alex Shi <alex.shi@linux.alibaba.com> wrote:
> 
>> Let the people know where to complain... ;)
> So I'd like to apply all of these changes; they look fine to me given that
> I don't read Chinese...:)  But I do have a couple of requests:
> 
>  - Please combine the changes into a single patch; adding the translated
>    file, putting it into the toctree, and adding translator credit are all
>    a single action, in the end.  There is no reason to split them apart.
> 
>  - Changelogs like the above are not particularly helpful; please provide
>    changelogs in the usual kernel style describing what was done and why.
> 

Thanks for quick response, Jon!

I will modified all yesterday patches according to your suggestion and Cc to more Chinese as reviewer.

Thanks
Alex
