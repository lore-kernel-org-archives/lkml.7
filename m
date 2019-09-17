Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7265DC4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 17:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B10C20665
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 17:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=aurabindo.in header.i=@aurabindo.in header.b="o9fbnOFe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730813AbfIQRNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 13:13:43 -0400
Received: from mail-40132.protonmail.ch ([185.70.40.132]:45188 "EHLO
        mail-40132.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfIQRNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 13:13:43 -0400
Date:   Tue, 17 Sep 2019 17:13:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aurabindo.in;
        s=protonmail; t=1568740418;
        bh=zbLTKg65FRGbaAMZXqIWuQw8Y6E7IYfG4i4H6e4pYWs=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=o9fbnOFerI9SjR7jDV8Tosglhcbs4IieOWKlLYD28UptUeuC+RN6KbitIpnA3nJPx
         q4ywL9lJhMcQmeYQPkdLjP39SQ3vqL96n9phf95xKwmcYwBBnJIsxkHsiAoexoBjjO
         dDOg4FBCWNIjam0Qf2arYyyu26JtymIryY2VbHmI=
To:     Paul Walmsley <paul.walmsley@sifive.com>
From:   Aurabindo Jayamohanan <mail@aurabindo.in>
Cc:     Baolin Wang <baolin.wang@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Reply-To: Aurabindo Jayamohanan <mail@aurabindo.in>
Subject: Re: [PATCH] spi: sifive: check return value for platform_get_resource()
Message-ID: <KINCBM4noQrzRVzR5KPbVAIlCxDi1_pLvCu6FYZT3Alj83dH1Q6Aspaph78A1c17AxxG1vSVuW-vdPSka8Cr-zdaGJbEZPQg4Q14gax4-H0=@aurabindo.in>
In-Reply-To: <alpine.DEB.2.21.9999.1909170820470.21451@viisi.sifive.com>
References: <20190917085627.4562-1-mail@aurabindo.in>
 <CAMz4kuJczzjTPSohQ=kbZ0Pr7U_9-hzXk-jPgKk79PENOM1-dA@mail.gmail.com>
 <alpine.DEB.2.21.9999.1909170514130.11980@viisi.sifive.com>
 <ij_UksEXUomr_L7KQam02lHBryAppgwKDjG90VbVcRRUeXlKU8TAiBWc3aU8vt20Wvlwt_6NDgz5fuMSwwP1mm-1eP6GYWoR1Kbr0y0ElRk=@aurabindo.in>
 <alpine.DEB.2.21.9999.1909170709070.8198@viisi.sifive.com>
 <alpine.DEB.2.21.9999.1909170820470.21451@viisi.sifive.com>
Feedback-ID: D1Wwva8zb0UdpJtanaReRLGO3iCsewpGmDn8ZDKmpao-Gnxd2qXPmwwrSQ99r5Q15lmK-D8x6vKzqhUKCgzweA==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Tuesday, September 17, 2019 8:51 PM, Paul Walmsley <paul.walmsley@sifive=
.com> wrote:

>
>
> I just recalled that YueHaibing already posted a patch to do this:
>
> https://lore.kernel.org/linux-riscv/alpine.DEB.2.21.9999.1909041520130.13=
502@viisi.sifive.com/
>

Ah, sorry for the noise.

