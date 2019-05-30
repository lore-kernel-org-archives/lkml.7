Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB182C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 22:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 909EC262B8
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 22:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="oR2b24SJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfE3WxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 18:53:04 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:65112 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbfE3WxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 18:53:04 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id CF0A26D0;
        Fri, 31 May 2019 00:53:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1559256781; x=1561071182; bh=QcOXpoIxgkg8acEgJatkKKSiMx3RLlkbdzy
        mN17X6Yo=; b=oR2b24SJvTz44gbOwaVVi6dfb/f5FfbbZwG4OukY1tqEnjBw4+o
        hRzLY4vJ4acQCh8J5Xo/+do2LKyNb10KFr9SAIPXoMmziBq1uYmPraZeTc89UAeZ
        XI5wu0OVyS89yGDuwQ300pCo12ey7g2QOJ/N8nTTHXfpLztUvG3cxyaEla6VhQKC
        9Mep/RN/Jvhhfebtu6Kf3Tpj20W1JIa/qpT89VxOGzKu8gP11h4wsHRW/PXg8M1p
        bXPv5EldT8QhreAfLlHpcHzvjO06pXUulsceSnnKwzMXTv0IO5Pw7opXPAL0spAJ
        MjuLcM8gmm/+JzaT9mx/zNrBLzuVBlTieuNE+MAG7lwOYwUAAj/N6TYuPmdcXIfg
        VqMvSrvWCtcC+l+wVbJk1odPvvgzenB6aN/ayXJnZLXckS70uOBcZ4fEYiiMQVEO
        dWFRGZ1Zix+cvTdBuY53PI9aqJjB77SzeEB8knNdDe6PyLapCbR/OZzutziC9QYZ
        6LkN2713MvCBJze+yMHr0BRB68taKZx6vlccV/bHrtzgQ2ZL9a9b1adtiJ5y7kwe
        Ih53CeFW+uOO40Fw44oS4AY19DParhDzptlBmQaUqs3OzDuGyJrLjEfzV6O8mRHv
        GAoaiD82bUXuGTZ/+OCgshCYF2jFXFZKBRnJHFyZSARBlkzQETKyYT/4=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uxi0oO6LRzyh; Fri, 31 May 2019 00:53:01 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id 41DDC3E1;
        Fri, 31 May 2019 00:53:01 +0200 (CEST)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 411902D26;
        Thu, 30 May 2019 22:23:29 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 15/22] docs: it: license-rules.rst: get rid of warnings
Date:   Thu, 30 May 2019 22:23:28 +0200
Message-ID: <2186050.8dyCrXZyFW@harkonnen>
In-Reply-To: <d4cbc22108a75339d1c1e18cbc6b6463e93ea782.1559171394.git.mchehab+samsung@kernel.org>
References: <cover.1559171394.git.mchehab+samsung@kernel.org> <d4cbc22108a75339d1c1e18cbc6b6463e93ea782.1559171394.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, May 30, 2019 1:23:46 AM CEST Mauro Carvalho Chehab wrote:
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
> ---
>  .../it_IT/process/license-rules.rst           | 28 +++++++++----------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/translations/it_IT/process/license-rules.rst
> b/Documentation/translations/it_IT/process/license-rules.rst index
> f058e06996dc..06abeb7dd307 100644
> --- a/Documentation/translations/it_IT/process/license-rules.rst
> +++ b/Documentation/translations/it_IT/process/license-rules.rst
> @@ -303,7 +303,7 @@ essere categorizzate in:
>       LICENSES/dual
> 
>     I file in questa cartella contengono il testo completo della rispettiva
> -   licenza e i suoi `Metatags`_.  I nomi dei file sono identici agli
> +   licenza e i suoi `Metatags`.  I nomi dei file sono identici agli

Remove 's' instead of '_' and then the link is correct

`Metatag`_

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




