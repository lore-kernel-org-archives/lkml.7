Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF57C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 05:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C879218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 05:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbfCOFuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 01:50:11 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:35990 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727151AbfCOFuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 01:50:10 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04392;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TMlFV7q_1552628996;
Received: from Alexs-MacBook-Pro.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TMlFV7q_1552628996)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 15 Mar 2019 13:49:56 +0800
Subject: Re: [PATCH] doc: add translation disclaimer
To:     Federico Vaga <federico.vaga@vaga.pv.it>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190314204516.10890-1-federico.vaga@vaga.pv.it>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <15f416d6-79a5-604b-109b-b4f788933cda@linux.alibaba.com>
Date:   Fri, 15 Mar 2019 13:49:55 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190314204516.10890-1-federico.vaga@vaga.pv.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/3/15 4:45 上午, Federico Vaga wrote:
> Add the translation disclaimer in English as reference
> for other languages.  Translations must include this disclaimer
> in their language so that readers are properly informed.
>
> This very same patch updates the Italian translation accordingly.
>
> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
> ---
>  Documentation/translations/index.rst          | 42 ++++++++++++++
>  .../translations/it_IT/disclaimer-ita.rst     | 13 +----
>  Documentation/translations/it_IT/index.rst    | 57 +++++++++++++------
>  3 files changed, 85 insertions(+), 27 deletions(-)
>
> diff --git a/Documentation/translations/index.rst b/Documentation/translations/index.rst
> index 7f77c52d33aa..d7a38fd28b50 100644
> --- a/Documentation/translations/index.rst
> +++ b/Documentation/translations/index.rst
This part looks good for me. I don't understand Italian. :)

Cheers
Alex
