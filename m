Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798D7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 08:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41731218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 08:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="2FZ+20hv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbfCOIKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 04:10:03 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:3976 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728442AbfCOIKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 04:10:02 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id 807F57D2;
        Fri, 15 Mar 2019 09:10:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1552637399; x=1554451800; bh=MntVy7pDmmN4mo2J9IgWxKR1N0n7ac7YMNm
        oTHwfaQ0=; b=2FZ+20hvPiFEDjY8QBtD3O7CjVwLVmhuudgcPCuPGDWD8DSk/SS
        ZkvVZJmBRouBTI39KTXtTPFXVEmuUuWf2uCeuuDOoTm10xsPKwx8ZR85druczHIH
        m/LHlyIiq5o3MCs2+skNKIhs/rWLhseAxsMmr4o2hxgQfIzXIYTNAqiuef3wM4xu
        cWRjxH+lXuCsMOWlFBxyF2rDRcUyi0GCXP5WeaIbtLMIE7FIpc6GtEt3K3rOWr0+
        TgO7Vx82xNtydYZoPISVySSnZlonTXOv9GRMXW6KlgSJnipzOzq9VrndUAiuR/m9
        BQtEGDmBExA7vP/zBn5177ii63cYAFitHosKmtWFHixV01JRTh6G34P/WpW7s0K6
        HTPKO5RZnDb1q8rePH6JCbJgnYiKifoVnMQ8jLM1FoW3+ic7CRBQaZk3n9fdx7Cz
        7NuarHtl81IAeFhI6E/VtOMN1NQAi+Gtl2rKk4mhNWfylpezau4dz/7SCgT/tfly
        gWH11TwUNXdbJsLUgoG4Sjgj4Fz6Z8LfUKvJLMrIxSlDD7w4V646GZJ45d05hbmN
        5d/vUiROjhVu/zjYyimeuaTx7WOo4E+lzAJ5cEOI/Hyh6zxNHTa0MmKbDIkAqJ4U
        WN5uHBN2a8Bm3j6FiUQaY8+bn2fB9gaelbfFPbZMjqZ9N67I6assufiU=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 06FyneHdVF_p; Fri, 15 Mar 2019 09:09:59 +0100 (CET)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id 56E69625;
        Fri, 15 Mar 2019 09:09:59 +0100 (CET)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 33EA5216;
        Fri, 15 Mar 2019 09:09:59 +0100 (CET)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: add translation disclaimer
Date:   Fri, 15 Mar 2019 09:09:58 +0100
Message-ID: <1919274.WkmdDqLOpc@pcbe13614>
In-Reply-To: <15f416d6-79a5-604b-109b-b4f788933cda@linux.alibaba.com>
References: <20190314204516.10890-1-federico.vaga@vaga.pv.it> <15f416d6-79a5-604b-109b-b4f788933cda@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, March 15, 2019 6:49:55 AM CET Alex Shi wrote:
> On 2019/3/15 4:45 =E4=B8=8A=E5=8D=88, Federico Vaga wrote:
> > Add the translation disclaimer in English as reference
> > for other languages.  Translations must include this disclaimer
> > in their language so that readers are properly informed.
> >=20
> > This very same patch updates the Italian translation accordingly.
> >=20
> > Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
> > ---
> >=20
> >  Documentation/translations/index.rst          | 42 ++++++++++++++
> >  .../translations/it_IT/disclaimer-ita.rst     | 13 +----
> >  Documentation/translations/it_IT/index.rst    | 57 +++++++++++++------
> >  3 files changed, 85 insertions(+), 27 deletions(-)
> >=20
> > diff --git a/Documentation/translations/index.rst
> > b/Documentation/translations/index.rst index 7f77c52d33aa..d7a38fd28b50
> > 100644
> > --- a/Documentation/translations/index.rst
> > +++ b/Documentation/translations/index.rst
>=20
> This part looks good for me. I don't understand Italian. :)

The idea is that you (or someone who knows Chinese) translate that disclaim=
er=20
from English to Chinese and put it in the Chinese index.rst page (like I di=
d=20
for the Italian one).

Let me write here the translation to English for the disclaimer-ita.rst fil=
e=20
that I'm including in all documents:

=2D------
+   In caso di dubbi sulla correttezza del contenuto di questa traduzione,
+   l'unico riferimento valido =C3=A8 la documentazione ufficiale in ingles=
e.
+   Per maggiori informazioni consultate le :ref:`avvertenze <it_disclaimer=
>`.

If you have any doubt about the content of this translation, the only valid=
=20
reference is the English official documentation. For more information pleas=
e=20
read :ref:`disclaimer <it_disclaimer>`
=2D------

The idea is the have a quick warning that points you to the full disclaimer.


>=20
> Cheers
> Alex


=2D-=20
=46ederico Vaga
http://www.federicovaga.it/


