Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C490C282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 15:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC5427955
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 15:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfFBPBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 11:01:40 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:56082 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726084AbfFBPBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 11:01:40 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TTDV38c_1559487683;
Received: from Alexs-MacBook-Pro.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TTDV38c_1559487683)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 02 Jun 2019 23:01:23 +0800
Subject: Re: [PATCH 13/22] docs: zh_CN: avoid duplicate citation references
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Harry Wei <harryxiyou@gmail.com>
References: <cover.1559171394.git.mchehab+samsung@kernel.org>
 <9d3b9729663f75249b514dd3910309eb418d9e46.1559171394.git.mchehab+samsung@kernel.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <04bca27d-3c59-5cc7-576b-44e399fa893f@linux.alibaba.com>
Date:   Sun, 2 Jun 2019 23:01:21 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <9d3b9729663f75249b514dd3910309eb418d9e46.1559171394.git.mchehab+samsung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/5/30 7:23 上午, Mauro Carvalho Chehab wrote:
>     Documentation/process/management-style.rst:35: WARNING: duplicate label decisions, other instance in     Documentation/translations/zh_CN/process/management-style.rst
>     Documentation/process/programming-language.rst:37: WARNING: duplicate citation c-language, other instance in     Documentation/translations/zh_CN/process/programming-language.rst
>     Documentation/process/programming-language.rst:38: WARNING: duplicate citation gcc, other instance in     Documentation/translations/zh_CN/process/programming-language.rst
>     Documentation/process/programming-language.rst:39: WARNING: duplicate citation clang, other instance in     Documentation/translations/zh_CN/process/programming-language.rst
>     Documentation/process/programming-language.rst:40: WARNING: duplicate citation icc, other instance in     Documentation/translations/zh_CN/process/programming-language.rst
>     Documentation/process/programming-language.rst:41: WARNING: duplicate citation gcc-c-dialect-options, other instance in     Documentation/translations/zh_CN/process/programming-language.rst
>     Documentation/process/programming-language.rst:42: WARNING: duplicate citation gnu-extensions, other instance in     Documentation/translations/zh_CN/process/programming-language.rst
>     Documentation/process/programming-language.rst:43: WARNING: duplicate citation gcc-attribute-syntax, other instance in     Documentation/translations/zh_CN/process/programming-language.rst
>     Documentation/process/programming-language.rst:44: WARNING: duplicate citation n2049, other instance in     Documentation/translations/zh_CN/process/programming-language.rst
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  .../zh_CN/process/management-style.rst        |  4 +--
>  .../zh_CN/process/programming-language.rst    | 28 +++++++++----------
>  2 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/translations/zh_CN/process/management-style.rst b/Documentation/translations/zh_CN/process/management-style.rst
> index a181fa56d19e..c6a5bb285797 100644
> --- a/Documentation/translations/zh_CN/process/management-style.rst
> +++ b/Documentation/translations/zh_CN/process/management-style.rst
> @@ -28,7 +28,7 @@ Linux内核管理风格
>  
>  不管怎样，这里是：
>  
> -.. _decisions:
> +.. _cn_decisions:
>  
>  1）决策
>  -------
> @@ -108,7 +108,7 @@ Linux内核管理风格
>  但是，为了做好作为内核管理者的准备，最好记住不要烧掉任何桥梁，不要轰炸任何
>  无辜的村民，也不要疏远太多的内核开发人员。事实证明，疏远人是相当容易的，而
>  亲近一个疏远的人是很难的。因此，“疏远”立即属于“不可逆”的范畴，并根据
> -:ref:`decisions` 成为绝不可以做的事情。
> +:ref:`cn_decisions` 成为绝不可以做的事情。

It's good to have.

>  
>  这里只有几个简单的规则：
>  
> diff --git a/Documentation/translations/zh_CN/process/programming-language.rst b/Documentation/translations/zh_CN/process/programming-language.rst
> index 51fd4ef48ea1..9de9a3108c4d 100644
> --- a/Documentation/translations/zh_CN/process/programming-language.rst
> +++ b/Documentation/translations/zh_CN/process/programming-language.rst
> @@ -8,21 +8,21 @@
>  程序设计语言
>  ============
>  
> -内核是用C语言 [c-language]_ 编写的。更准确地说，内核通常是用 ``gcc`` [gcc]_
> -在 ``-std=gnu89`` [gcc-c-dialect-options]_ 下编译的：ISO C90的 GNU 方言（
> +内核是用C语言 [cn_c-language]_ 编写的。更准确地说，内核通常是用 ``gcc`` [cn_gcc]_

this change isn't good. cn_gcc will show in docs, it looks wired and confusing for peoples. other changes have the same issue. Could you find other way to fix the warning? or I'd rather tolerant it.

Thanks
Alex
