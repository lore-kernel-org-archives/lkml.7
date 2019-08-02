Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30E3C0650F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 22:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A028F2067D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 22:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564785511;
	bh=XfJixi4xuzcnFxHwrFJTVHUtmkreXUi87OxBiFEUMKo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eiJYqAEV3EvUT1xV6VMcJ3gn7DTR+PxHoEuyl2j+smXN5yoegmfCbISsIezeOuFRA
	 TSJn+qzRpIlq1UBtRWnO+L7J95jROlIpyKCpN2o5eDvGm92G+4lYVQ6SV+n5pshzuR
	 Kt3lUDagbUWDles0DCWS5/0tlUxVyRXme2AdvBrE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392434AbfHBWia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 18:38:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729980AbfHBWia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 18:38:30 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB68521783;
        Fri,  2 Aug 2019 22:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564785508;
        bh=XfJixi4xuzcnFxHwrFJTVHUtmkreXUi87OxBiFEUMKo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aSn893t31UbGBbwVOIjEJFzyTo05qyeU8Z1mVQoWKRKN/V8SKHEt7p8lcu4bhQdoI
         LGazNnJJ3nnOiQMaYlF+4ZZ7UFOSPAr/X86UuwCexuT9qWvzpaVVgUfRtpyhc82OrR
         U8FhSJeICQX8MDSwmuXnFtbftTCZliA7haLbg9/w=
Received: by mail-qk1-f178.google.com with SMTP id t187so3363444qke.8;
        Fri, 02 Aug 2019 15:38:28 -0700 (PDT)
X-Gm-Message-State: APjAAAWrXcuNdN7JIox/L4oU/gpgxEq3RXYRhrvJaS23x+LiFkxsFhm4
        yIMIVuIKesfgmZgJZzGFWnJsz1xd0jbfd4YpRg==
X-Google-Smtp-Source: APXvYqzvziBgm/niAlkvKF2WYa8Hbu7XGWy01L47nrb5nZ3ZHKliqGHMB7nfWXJln2n9jPWHICNYT9LuhALcS/C0eLI=
X-Received: by 2002:a37:a48e:: with SMTP id n136mr94788423qke.223.1564785507833;
 Fri, 02 Aug 2019 15:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190802194702.30249-1-stefan-gabriel.mirea@nxp.com> <20190802194702.30249-2-stefan-gabriel.mirea@nxp.com>
In-Reply-To: <20190802194702.30249-2-stefan-gabriel.mirea@nxp.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 2 Aug 2019 16:38:16 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL++GZBxczxePni9ysNq06kObB4EzJEi1e4M=PurPZFgQ@mail.gmail.com>
Message-ID: <CAL_JsqL++GZBxczxePni9ysNq06kObB4EzJEi1e4M=PurPZFgQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: arm: fsl: Add the S32V234-EVB board
To:     Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Eddy Petrisor <eddy.petrisor@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 2, 2019 at 1:47 PM Stefan-gabriel Mirea
<stefan-gabriel.mirea@nxp.com> wrote:
>
> From: Eddy Petri=C8=99or <eddy.petrisor@nxp.com>
>
> Add entry for the NXP S32V234 Customer Evaluation Board to the board/SoC
> bindings.
>
> Signed-off-by: Eddy Petri=C8=99or <eddy.petrisor@nxp.com>
> Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentati=
on/devicetree/bindings/arm/fsl.yaml
> index 7294ac36f4c0..104d60a11177 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -309,4 +309,10 @@ properties:
>                - fsl,ls2088a-rdb
>            - const: fsl,ls2088a
>
> +      - description: S32V234 Customer Evaluation Board

Most of the entries in this file are for all the boards for an SoC.

> +        items:
> +          - enum:
> +              - fsl,s32v234-evb

If that's not going to be the case here, you can use 'const' here.

> +          - const: fsl,s32v234
> +
>  ...
> --
> 2.22.0
>
