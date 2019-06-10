Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBD4C28CC5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 03:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B2442082E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 03:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387654AbfFJDwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 23:52:51 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:50357 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387475AbfFJDwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 23:52:50 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TToRiUT_1560138766;
Received: from Alexs-MacBook-Pro.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TToRiUT_1560138766)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 10 Jun 2019 11:52:47 +0800
Subject: Re: [PATCH v3 08/20] docs: zh_CN: avoid duplicate citation references
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Harry Wei <harryxiyou@gmail.com>
References: <ff457774d46d96e8fe56b45409aba39d87a8672a.1559933665.git.mchehab+samsung@kernel.org>
 <3c26852c46db3a56cb5f42765db0cc5c64334986.1559933665.git.mchehab+samsung@kernel.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <a2c607e2-61cf-1888-7186-ae2ae84670de@linux.alibaba.com>
Date:   Mon, 10 Jun 2019 11:52:46 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <3c26852c46db3a56cb5f42765db0cc5c64334986.1559933665.git.mchehab+samsung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked!

Thanks!
Alex

On 2019/6/8 2:54 上午, Mauro Carvalho Chehab wrote:
>     Documentation/process/programming-language.rst:44: WARNING: duplicate citation n2049, other instance in     Documentation/translations/zh_CN/process/programming-language.rst
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
