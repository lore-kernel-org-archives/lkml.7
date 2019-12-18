Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5000C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 04:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D67621582
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 04:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfLRE4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 23:56:05 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:41027 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726518AbfLRE4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 23:56:05 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TlFHBEg_1576644961;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TlFHBEg_1576644961)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 18 Dec 2019 12:56:02 +0800
Subject: Re: [Ocfs2-devel] [PATCH v3] ocfs2: call journal flush to mark
 journal as empty after journal recovery when mount
To:     Andrew Morton <akpm@linux-foundation.org>,
        Joseph Qi <jiangqi903@gmail.com>
Cc:     Kai Li <li.kai4@h3c.com>, mark@fasheh.com, jlbec@evilplan.org,
        chge@linux.alibaba.com, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com
References: <20191217020140.2197-1-li.kai4@h3c.com>
 <339c2bfc-fc40-77f1-3515-eb90e34854f6@gmail.com>
 <20191217182311.6696bbe6f03b5ea81bc96082@linux-foundation.org>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <b4bc5200-56bb-f8e4-4f9b-dfc2472a5af1@linux.alibaba.com>
Date:   Wed, 18 Dec 2019 12:56:01 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191217182311.6696bbe6f03b5ea81bc96082@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/12/18 10:23, Andrew Morton wrote:
> On Tue, 17 Dec 2019 10:12:14 +0800 Joseph Qi <jiangqi903@gmail.com> wrote:
> 
>>> Due to first commit seq 13 recorded in journal super is not consistent
>>> with the value recorded in block 1(seq is 14), journal recovery will be
>>> terminated before seq 15 even though it is an unbroken commit, inode
>>> 8257802 is a new file and it will be lost.
>>>
>>> Signed-off-by: Kai Li <li.kai4@h3c.com>
>>
>> Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> 
> Do we think this fix should be backported into -stable kernels?
> 
Since this is not an usual usecase, we don't have to.
It is enough to let it go into upstream.

Thanks,
Joseph
