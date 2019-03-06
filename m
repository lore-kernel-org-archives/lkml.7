Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2892C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 01:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C86F20663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 01:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbfCFB5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 20:57:15 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:46768 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726069AbfCFB5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 20:57:15 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TM3zbX._1551837426;
Received: from Alexs-MacBook-Pro.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TM3zbX._1551837426)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 06 Mar 2019 09:57:06 +0800
Subject: Re: [RFC PATCH] doc: translation disclaimer
To:     Federico Vaga <federico.vaga@vaga.pv.it>, linux-doc@vger.kernel.org
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, harryxiyou@gmail.com,
        Li Zefan <lizefan@huawei.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Fengguang Wu <fengguang.wu@intel.com>
References: <20190305220611.13136-1-federico.vaga@vaga.pv.it>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <02cb673f-eaf0-f78a-49f3-e95340748694@linux.alibaba.com>
Date:   Wed, 6 Mar 2019 09:57:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190305220611.13136-1-federico.vaga@vaga.pv.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generally It looks good! A short guide to translator is good as well as a disclaimer.


On 2019/3/6 6:06 上午, Federico Vaga wrote:
> This is only an example to propose a structure for translation's
> disclaimers. The actual text needs some thoughs.
>
> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
> ---
>  Documentation/translations/index.rst           | 18 ++++++++++++++++++
>  .../translations/it_IT/disclaimer-ita.rst      | 13 +++----------
>  Documentation/translations/it_IT/index.rst     |  6 ++++++
>  3 files changed, 27 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/translations/index.rst b/Documentation/translations/index.rst
> index 7f77c52d33aa..b46c8ce98d6e 100644
> --- a/Documentation/translations/index.rst
> +++ b/Documentation/translations/index.rst
> @@ -4,6 +4,24 @@
>  Translations
>  ============
>  
> +.. _translations_disclaimer:
> +
> +Disclaimer
> +----------
> +Write some text in English here to explain that:
> +
> +- its purpose is to ease reading and understanding in other languages
> +- this is not a fork
> +- the only official documentation is :ref:`linux_doc`
Could we merge the 2nd and 3rd into one, like this is not a fork of original file :ref:`xxxx`
> +- there are not guarantee about translations being in line with the
> +  main documentation
Could we merge this one with 1st item, like its purpose is to xxxx without any guarantee of translations ....
> +- translation's maintainer can help people who can't write in English
> +- only comments and patches about translations are accepted, any other
> +  discussion about Documentation does not belong here.

I am not very good at English. is the following words are bit more clear? like, only translation related update are accepted here, contents change need goes to original files ...


> +
> +Translations
> +------------
> +
>  .. toctree::
>     :maxdepth: 1
>  
> diff --git a/Documentation/translations/it_IT/disclaimer-ita.rst b/Documentation/translations/it_IT/disclaimer-ita.rst
> index d68e52de6a5d..aacc1a0346db 100644
> --- a/Documentation/translations/it_IT/disclaimer-ita.rst
> +++ b/Documentation/translations/it_IT/disclaimer-ita.rst
> @@ -1,13 +1,6 @@
>  :orphan:
why the orphan here? does that mean no maintainer for it_IT currently?

Thanks
Alex
>  
> -.. note::
> -   This document is maintained by Federico Vaga <federico.vaga@vaga.pv.it>.
> -   If you find any difference between this document and the original file or a
> -   problem with the translation, please contact the maintainer of this file.
> -   Following people helped to translate or review:
> -   Alessia Mantegazza <amantegazza@vaga.pv.it>
> -
>  .. warning::
> -   The purpose of this file is to be easier to read and understand for Italian
> -   speakers and is not intended as a fork. So, if you have any comments or
> -   updates for this file please try to update the original English file first.
> +   Short (to not pollute the document) text in Italian to explain that for any
> +   doubt about the documentation content people should refer to the English
> +   documentation. Read the :ref:`it_disclaimer`.
> diff --git a/Documentation/translations/it_IT/index.rst b/Documentation/translations/it_IT/index.rst
> index ea9b2916b3e4..4b0b3da97c73 100644
> --- a/Documentation/translations/it_IT/index.rst
> +++ b/Documentation/translations/it_IT/index.rst
> @@ -4,6 +4,12 @@
>  Traduzione italiana
>  ===================
>  
> +.. _it_disclaimer:
> +
> +Disclaimer
> +==========
> +The following text should be the translation of :ref:`translations_disclaimer`
> +
>  L'obiettivo di questa traduzione è di rendere più facile la lettura e
>  la comprensione per chi preferisce leggere in lingua italiana.
>  Tenete presente che la documentazione di riferimento rimane comunque

