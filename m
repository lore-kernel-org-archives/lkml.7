Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4D3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 03:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F12E2177E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 03:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfCMD4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 23:56:24 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:55469 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726426AbfCMD4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 23:56:23 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TMb0JCt_1552449380;
Received: from Alexs-MacBook-Pro.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TMb0JCt_1552449380)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 13 Mar 2019 11:56:21 +0800
Subject: Re: [PATCH v4 00/31] clean up and reorg Chinese kernel docs
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     harryxiyou@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190312032501.62056-1-alex.shi@linux.alibaba.com>
 <4e9fbf0d-cf9a-63a3-4e94-902b1ae5a6cf@linux.alibaba.com>
 <20190312075823.31240738@lwn.net>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <e644f08d-cae9-1ee9-7b27-36a5440bda20@linux.alibaba.com>
Date:   Wed, 13 Mar 2019 11:56:20 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190312075823.31240738@lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/3/12 9:58 下午, Jonathan Corbet wrote:
> On Tue, 12 Mar 2019 12:06:45 +0800
> Alex Shi <alex.shi@linux.alibaba.com> wrote:
>
>> This series is ok for pick up.
> I'll get to it after the merge window, thanks.
>
> One request: if you have to update and resend a patch set for any reason,
> please update the version number.  I'll get the right "v4" set this time,
> but one shouldn't count on that.

You're right. Thanks for point out! :)

Cheers!
Alex

