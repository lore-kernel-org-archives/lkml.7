Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7ADC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55407206F2
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573689791;
	bh=syJDZEtQZScFh/sQCA1XmB4C/+Er8yQeSAZnLGuG5No=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fhORNFbCbEzbpLtZp33rrMoECKKGZP7XR/z3ZX9lFZ28WSLZJ1MlAqKieAzsBFQwQ
	 nx5tFfiHRs9ko8jARlziKNpZUVD84qDdNLrFYRRc+/Pi3GwCVyyUmy5Rw7Z80ftzaP
	 i1X+4O0bybuG5TkmmdI8Mgq/1ePntgGnJzVI0zyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfKNADK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 19:03:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:44408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbfKNADJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 19:03:09 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C2DA206F2;
        Thu, 14 Nov 2019 00:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573689789;
        bh=syJDZEtQZScFh/sQCA1XmB4C/+Er8yQeSAZnLGuG5No=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xha/T2/pzTnZ4wdODDmlGlQkyue/e2on1Wb4tyNoQQtPUWiRhLltt6tVIsvVxjKdq
         2Jchwydt597A9SvOieYcdvAOuDKTwxt9ulVUOnstsKy0UdKrKSIk+EO9Zxd4c3vVeU
         KQPeU1l7iBE0QHPcX9rxzLANqo351Tgj/gSdo2fk=
Received: by mail-qt1-f182.google.com with SMTP id i17so4754289qtq.1;
        Wed, 13 Nov 2019 16:03:08 -0800 (PST)
X-Gm-Message-State: APjAAAVPbQuVbx75Rydxkz1F8Ao0F67udWtLtHrMN6V+S3E7ql5Sq88W
        ml3Cqx1hBgICJ/emUIkaz5T0XRiUBg9BmJujkA==
X-Google-Smtp-Source: APXvYqzh6vOO3rB2AG7i9gTuq9Xi+mhxHoVYlV+J6Jr9WEMUIr7PWOcm61D2XbYmlTxjkC7l1n2afk7Ke1UOcG5Jy8U=
X-Received: by 2002:ac8:73ce:: with SMTP id v14mr5619806qtp.136.1573689787902;
 Wed, 13 Nov 2019 16:03:07 -0800 (PST)
MIME-Version: 1.0
References: <20191106225527.9121-1-mihailescu2m@gmail.com> <20191107091657.GA1828@pi3>
In-Reply-To: <20191107091657.GA1828@pi3>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 13 Nov 2019 18:02:54 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+b_7ELTp+cShPJWwAv3arJ-Fp3C+Eor2dX3O_d4pmUvA@mail.gmail.com>
Message-ID: <CAL_Jsq+b_7ELTp+cShPJWwAv3arJ-Fp3C+Eor2dX3O_d4pmUvA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: gpu: mali-midgard: add samsung exynos
 5420 compatible
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Marian Mihailescu <mihailescu2m@gmail.com>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 7, 2019 at 3:17 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Thu, Nov 07, 2019 at 09:25:26AM +1030, Marian Mihailescu wrote:
> > Add "samsung,exynos5420-mali" binding
> >
> > Signed-off-by: Marian Mihailescu <mihailescu2m@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
> > index 47bc1ac36426..41b928bce4ea 100644
> > --- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
> > +++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
> > @@ -38,9 +38,12 @@ properties:
> >            - enum:
> >               - samsung,exynos5433-mali
> >            - const: arm,mali-t760
> > +      - items:
> > +          - enum:
> > +             - samsung,exynos5420-mali
> > +          - const: arm,mali-t628
>
> I would prefer to order it logically/alphabetically, so after 5250 and
> before 5433. With that change:

I didn't see your comment, but that's what I did. This has been
re-ordered to be sorted by Mali part numbers (though partially to
avoid a conflict). Good thing Arm and Samsung agree
newer/better/faster should be higher numbers. :)

Rob
