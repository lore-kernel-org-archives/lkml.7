Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE41C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91EDD20673
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="wyAuzEqH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730171AbfJHJTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 05:19:43 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:52642 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728866AbfJHJTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 05:19:43 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9896vYO029256;
        Tue, 8 Oct 2019 11:19:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=+dIaoBBTtn4uHC1StIa2tJsqayvUf706bDI0ytKEsoQ=;
 b=wyAuzEqHkJDYghX8QiCFEQ3qmQ4nTDmJgaRsWqJlTl3KHd3+t8044muCxJpj+JJ3aWaa
 +ZSOQbRypNhpmPawY7gUjvalZ+XtbVrZC9QpkQWn27pL3QTr9KGKuxNeSd1MOeI8XV6V
 24zi3E9StYi8g1KXwYsmMvfil8htnR2J66mZrP9S0QUcw/z3LgwBP1w1wyUQkkg5N8QL
 gYzn1T+bw/etbqs929qWjVORSLFfjPPSFluu9cNs+k1FkZoNVkcEXHP/jpHJc5cYeokN
 ucWhESkKmHzUTSbuiH1IhtuPZzfVj+xF85jqvMnwWsvkTpfJf9nhwtyhR+MnXFWnmm0/ qQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2vej2p7csb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Oct 2019 11:19:26 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AE24010002A;
        Tue,  8 Oct 2019 11:19:24 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A147A2B1E48;
        Tue,  8 Oct 2019 11:19:24 +0200 (CEST)
Received: from SFHDAG5NODE1.st.com (10.75.127.13) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 8 Oct
 2019 11:19:24 +0200
Received: from SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6]) by
 SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6%20]) with mapi id
 15.00.1473.003; Tue, 8 Oct 2019 11:19:24 +0200
From:   Gerald BAEZA <gerald.baeza@st.com>
To:     Jonathan Corbet <corbet@lwn.net>
CC:     Alexandre TORGUE <alexandre.torgue@st.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Documentation: add link to stm32mp157 docs
Thread-Topic: [PATCH] Documentation: add link to stm32mp157 docs
Thread-Index: AQHVXNGu+WgWi0gJwE+sfJwWkTflzacPHSFxgDnL12CABoSfAIABS0jA
Date:   Tue, 8 Oct 2019 09:19:24 +0000
Message-ID: <70e865409cab4d589323692e863dbc49@SFHDAG5NODE1.st.com>
References: <1566908347-92201-1-git-send-email-gerald.baeza@st.com>
        <20190827074825.64a28e88@lwn.net>
        <5257eff7-418b-8e94-1ced-30718dd3f5dc@st.com>
        <8d097a0486e94257952600bf6d20975d@SFHDAG5NODE1.st.com>
 <20191007093208.757554b0@lwn.net>
In-Reply-To: <20191007093208.757554b0@lwn.net>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.45]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-08_03:2019-10-07,2019-10-08 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan

> From: Jonathan Corbet <corbet@lwn.net>
>=20
> On Thu, 3 Oct 2019 10:05:46 +0000
> Gerald BAEZA <gerald.baeza@st.com> wrote:
>=20
> > > > Adding the URL is a fine idea.  But you don't need the extra
> > > > syntax to create a link if you're not going to actually make a link=
 out of it.
> > > > So I'd take the ".. _STM32MP157:" part out and life will be good.
> > > >
> > >
> > > We also did it for older stm32 product. Idea was to not have the "ful=
l"
> > > address but just a shortcut of the link when html file is read. It
> > > maybe makes no sens ? (if yes we will have to update older stm32
> > > overview :))
> >
> > Example in
> > https://www.kernel.org/doc/html/latest/arm/stm32/stm32h743-
> overview.ht
> > ml
> >
> > Do you agree to continue like this ?
>=20
> If you actually use the reference then it's OK, I guess; in the posted
> document that wasn't happening.  I still think it might be a bit more
> straightforward to just put the URL; that will make the plain-text file a=
 little
> more readable.  In the end, though, it's up to you, go with whichever you
> prefer.

So I prefer to keep the patch as it, for better consistency with the others=
 stm32 overviews.
Thank you.

>=20
> Thanks,
>=20
> jon
