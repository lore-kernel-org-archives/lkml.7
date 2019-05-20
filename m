Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD4FC04AB4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 02:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80FC62082E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 02:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbfETCCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 22:02:54 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:33930 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726786AbfETCCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 22:02:54 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TSAJJbQ_1558317770;
Received: from Alexs-MacBook-Pro.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TSAJJbQ_1558317770)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 20 May 2019 10:02:51 +0800
Subject: Re: [PATCH 1/3] kselftest/cgroup: fix unexcepted testing failure on
 test_memcontrol
To:     Roman Gushchin <guro@fb.com>
Cc:     Shuah Khan <shuah@kernel.org>, Tejun Heo <tj@kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jay Kamat <jgkamat@fb.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190515090704.56929-1-alex.shi@linux.alibaba.com>
 <20190517172930.GA5525@tower.DHCP.thefacebook.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <966c3598-9197-bc1d-5b24-148f43679666@linux.alibaba.com>
Date:   Mon, 20 May 2019 10:02:50 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190517172930.GA5525@tower.DHCP.thefacebook.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi Alex!
> 
> Sorry for the late reply, somehow I missed your e-mails.
> 
> The patchset looks good to me, except a typo in subjects/commit logs:
> you probably meant "unexpected failures".
> 
> Please, fix and feel free to use:
> Reviewed-by: Roman Gushchin <guro@fb.com>
> for the series.

Hi Roman,

Thanks for the typo correct and review. I will resend them with your suggestion.

BTW, How do you test cgroup2 except kselftest? Any other function/performance testing case?

Thanks a lot!
Alex
