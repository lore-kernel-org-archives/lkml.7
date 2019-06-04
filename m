Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1E0C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 21:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A899B20866
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 21:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="woWTuf4i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfFDVxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 17:53:36 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:28104 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbfFDVxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 17:53:36 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id CBEED2A4;
        Tue,  4 Jun 2019 23:53:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1559685212; x=1561499613; bh=+pKmo5rEjjUYCg8+riQLlupj6rfgE8dZj1x
        b6ZruVuY=; b=woWTuf4i37XoQ7zK4pII4n6jCZfRH7htKOXt4H2nd3Uiy/yX3Zu
        vW7pUWhUlqyPrgZ6T8EnzJDjb9Rc1qvhn1mKC7m5ZS7r04tLCMPuUAw08UbEyq7K
        BGY0GfIwBlz6htMO4c1RpL5LtoGKscZ0TEo/CmfpR8QgzR32w88UNFSt/xkZZb1z
        7LrTqGNPAYW2bHgc/83into8mAAG5Qqx8f7/07IKh4Nb0ZL8oy0p+nxgscKLK2SR
        jcysIv9NPksrpb9TfuTqIiJbPDSmzzMlvNlh1rJEqEXroi2zBzWGB2HNhTvjqjQp
        WCsdshp9dyZOlWgyslICoaR4IRSGXOED3NWH2408VLB+ClJ5sisoPwkk+aWC+CDy
        +HtJC/B3kaaEI7JJ4d3JN4iSovgCGOBRI5DZaZ1yPzkTT7hgx/az+yaT93ZGlqqc
        aZ9sfuuAT6zf5+C8IWcCLtEHs89sFqp8AXUaVnuF7Ezo1vjgDSL4d85egWaWp8rI
        mPKcHTMdf1ovjPGj72vxBQKgejoWrRyJyz1qqTJZMkWq8KeHAyCYCs/PIb0xsC+X
        F4kIiiUD09EizNwi0JijSsIzF2YSQ+62XU4Sgg0zzzJH9C11D7iOXWNI4v2HbEFI
        /J7XYPVoZhIePTDGr20ySEugaWA/1dyxWGzE7eWIMmH298bNb0d/y/a0=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0d0adnEw4ynJ; Tue,  4 Jun 2019 23:53:32 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id 3C87A157;
        Tue,  4 Jun 2019 23:53:32 +0200 (CEST)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id D5E7F389;
        Tue,  4 Jun 2019 23:53:31 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 11/22] docs: it: license-rules.rst: get rid of warnings
Date:   Tue, 04 Jun 2019 23:53:30 +0200
Message-ID: <1681166.PAMux6uQF1@harkonnen>
In-Reply-To: <6a7cfac6d9a2f14475c8b9baef0f55e4996b9210.1559656538.git.mchehab+samsung@kernel.org>
References: <cover.1559656538.git.mchehab+samsung@kernel.org> <6a7cfac6d9a2f14475c8b9baef0f55e4996b9210.1559656538.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, June 4, 2019 4:17:45 PM CEST Mauro Carvalho Chehab wrote:
> There's a wrong identation on a code block, and it tries to use
> a reference that was not defined at the Italian translation.
> 
>     Documentation/translations/it_IT/process/license-rules.rst:329: WARNING:
> Literal block expected; none found.
> Documentation/translations/it_IT/process/license-rules.rst:332: WARNING:
> Unexpected indentation.
> Documentation/translations/it_IT/process/license-rules.rst:339: WARNING:
> Block quote ends without a blank line; unexpected unindent.
> Documentation/translations/it_IT/process/license-rules.rst:341: WARNING:
> Unexpected indentation.
> Documentation/translations/it_IT/process/license-rules.rst:305: WARNING:
> Unknown target name: "metatags".
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Reviewed-by: Federico Vaga <federico.vaga@vaga.pv.it>

> ---
>  .../it_IT/process/license-rules.rst           | 28 +++++++++----------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/translations/it_IT/process/license-rules.rst
> b/Documentation/translations/it_IT/process/license-rules.rst index
> f058e06996dc..4cd87a3a7bf9 100644
> --- a/Documentation/translations/it_IT/process/license-rules.rst
> +++ b/Documentation/translations/it_IT/process/license-rules.rst
> @@ -303,7 +303,7 @@ essere categorizzate in:
>       LICENSES/dual
> 
>     I file in questa cartella contengono il testo completo della rispettiva
> -   licenza e i suoi `Metatags`_.  I nomi dei file sono identici agli
> +   licenza e i suoi `Metatag`_.  I nomi dei file sono identici agli
>     identificatori di licenza SPDX che dovrebbero essere usati nei file
>     sorgenti.
> 
> @@ -326,19 +326,19 @@ essere categorizzate in:
> 
>     Esempio del formato del file::
> 
> -   Valid-License-Identifier: MPL-1.1
> -   SPDX-URL: https://spdx.org/licenses/MPL-1.1.html
> -   Usage-Guide:
> -     Do NOT use. The MPL-1.1 is not GPL2 compatible. It may only be used
> for -     dual-licensed files where the other license is GPL2 compatible. -
>     If you end up using this it MUST be used together with a GPL2
> compatible -     license using "OR".
> -     To use the Mozilla Public License version 1.1 put the following SPDX
> -     tag/value pair into a comment according to the placement guidelines in
> -     the licensing rules documentation:
> -   SPDX-License-Identifier: MPL-1.1
> -   License-Text:
> -     Full license text
> +    Valid-License-Identifier: MPL-1.1
> +    SPDX-URL: https://spdx.org/licenses/MPL-1.1.html
> +    Usage-Guide:
> +      Do NOT use. The MPL-1.1 is not GPL2 compatible. It may only be used
> for +      dual-licensed files where the other license is GPL2 compatible.
> +      If you end up using this it MUST be used together with a GPL2
> compatible +      license using "OR".
> +      To use the Mozilla Public License version 1.1 put the following SPDX
> +      tag/value pair into a comment according to the placement guidelines
> in +      the licensing rules documentation:
> +    SPDX-License-Identifier: MPL-1.1
> +    License-Text:
> +      Full license text




