Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00884C282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 14:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D150627907
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 14:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfFBOgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 10:36:33 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:1992 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726084AbfFBOgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 10:36:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TTDV.nj_1559486189;
Received: from Alexs-MacBook-Pro.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TTDV.nj_1559486189)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 02 Jun 2019 22:36:29 +0800
Subject: Re: [PATCH 04/22] docs: zh_CN: get rid of basic_profiling.txt
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Harry Wei <harryxiyou@gmail.com>
References: <cover.1559171394.git.mchehab+samsung@kernel.org>
 <81f5848d02cafb986d9145dbff17beb1e4427dea.1559171394.git.mchehab+samsung@kernel.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <a172f513-b26b-539a-c26f-08715448511e@linux.alibaba.com>
Date:   Sun, 2 Jun 2019 22:36:28 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <81f5848d02cafb986d9145dbff17beb1e4427dea.1559171394.git.mchehab+samsung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/5/30 7:23 上午, Mauro Carvalho Chehab wrote:
> Changeset 5700d1974818 ("docs: Get rid of the "basic profiling" guide")
> removed an old basic-profiling.txt file that was not updated over
> the last 11 years and won't reflect the post-perf era.
> 
> It makes no sense to keep its translation, so get rid of it too.
> 
> Fixes: 5700d1974818 ("docs: Get rid of the "basic profiling" guide")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---

Acked-by: Alex Shi <alex.shi@linux.alibaba.com>
