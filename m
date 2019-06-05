Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C65C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 424212086A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfFEH4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 03:56:25 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:57545 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726502AbfFEH4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 03:56:24 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TTTzviS_1559721376;
Received: from Alexs-MacBook-Pro.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TTTzviS_1559721376)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 05 Jun 2019 15:56:16 +0800
Subject: Re: [PATCH v2 09/22] docs: zh_CN: avoid duplicate citation references
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Harry Wei <harryxiyou@gmail.com>
References: <cover.1559656538.git.mchehab+samsung@kernel.org>
 <caf96b7ac3c4a3db66b6d6d2651849d2a70e3e76.1559656538.git.mchehab+samsung@kernel.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <826d06c8-8c41-166d-f821-0a457a11ed0b@linux.alibaba.com>
Date:   Wed, 5 Jun 2019 15:56:16 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <caf96b7ac3c4a3db66b6d6d2651849d2a70e3e76.1559656538.git.mchehab+samsung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/6/4 10:17 下午, Mauro Carvalho Chehab wrote:
> -内核是用C语言 [c-language]_ 编写的。更准确地说，内核通常是用 ``gcc`` [gcc]_
> -在 ``-std=gnu89`` [gcc-c-dialect-options]_ 下编译的：ISO C90的 GNU 方言（
> +内核是用C语言 :ref:`c-language <cn_c-language>` 编写的。更准确地说，内核通常是用 ``gcc`` :ref:`gcc <cn_gcc>`

It looks better to remove ``gcc`` here. otherwise 2 'gcc' words show here is weird. 

> +在 ``-std=gnu89`` :ref:`gcc-c-dialect-options <cn_gcc-c-dialect-options>` 下编译的：ISO C90的 GNU 方言（
>  包括一些C99特性）
>  
> -这种方言包含对语言 [gnu-extensions]_ 的许多扩展，当然，它们许多都在内核中使用。
> +这种方言包含对语言 :ref:`gnu-extensions <cn_gnu-extensions>` 的许多扩展，当然，它们许多都在内核中使用。
>  
> -对于一些体系结构，有一些使用 ``clang`` [clang]_ 和 ``icc`` [icc]_ 编译内核
> +对于一些体系结构，有一些使用 ``clang`` :ref:`clang <cn_clang>` 和 ``icc`` :ref:`icc <cn_icc>` 编译内核

and remove ``clang``, ``icc`` too.

>  的支持，尽管在编写此文档时还没有完成，仍需要第三方补丁。
>  

Thanks
Alex
