Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAF7C4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ABBC2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfFZDrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 23:47:48 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:39821 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727807AbfFZDpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 23:45:43 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TVDVZOt_1561520739;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TVDVZOt_1561520739)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 26 Jun 2019 11:45:39 +0800
Subject: Re: [PATCH] docs: zh_CN: submitting-drivers.rst: Remove a duplicated
 Documentation/
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Harry Wei <harryxiyou@gmail.com>
References: <47f81418930438d1deab8da1307bcd89ba9afd91.1561225663.git.mchehab+samsung@kernel.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <4244437a-1209-9dde-a4d2-1c72d041492c@linux.alibaba.com>
Date:   Wed, 26 Jun 2019 11:45:37 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <47f81418930438d1deab8da1307bcd89ba9afd91.1561225663.git.mchehab+samsung@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for catching.


Reviewed-by: Alex Shi

在 2019/6/23 上午1:47, Mauro Carvalho Chehab 写道:
> Somehow, this file ended with Documentation/ twice.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>   Documentation/translations/zh_CN/process/submitting-drivers.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/translations/zh_CN/process/submitting-drivers.rst b/Documentation/translations/zh_CN/process/submitting-drivers.rst
> index 72c6cd935821..72f4f45c98de 100644
> --- a/Documentation/translations/zh_CN/process/submitting-drivers.rst
> +++ b/Documentation/translations/zh_CN/process/submitting-drivers.rst
> @@ -22,7 +22,7 @@
>   兴趣的是显卡驱动程序，你也许应该访问 XFree86 项目(http://www.xfree86.org/)
>   和／或 X.org 项目 (http://x.org)。
>   
> -另请参阅 Documentation/Documentation/translations/zh_CN/process/submitting-patches.rst 文档。
> +另请参阅 Documentation/translations/zh_CN/process/submitting-patches.rst 文档。
>   
>   
>   分配设备号
