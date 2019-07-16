Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C335C76195
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 07:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 545A52145D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 07:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563263450;
	bh=0UmmVZtPcgufX1spbbHJzqSldBTXlWueN2BuCVoZhtg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Xg8QwbEP0CYS54w5tdUcipMj+KxB/loS5FLv0/tN7AAQ3+Pl8E6bXXMaKJMAVA6Jt
	 4AB3RC07Yqmj+X2vc6tD1S7WW5eSry/J7bmEHlMzQMDQJAQMgSw3mGhOMPspfpWAVF
	 7bp5NLvS7xXCwymvdKB1FoKepzgdobDUVDGRxndw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730144AbfGPHut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 03:50:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:55084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbfGPHut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 03:50:49 -0400
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 513AA2145D;
        Tue, 16 Jul 2019 07:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563263447;
        bh=0UmmVZtPcgufX1spbbHJzqSldBTXlWueN2BuCVoZhtg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vAKN+cInqh6ojQkzRQq0bO8+kPyehMGn002WS4EnWoXBT0lLrqcgOsODAxIsdMTEX
         B0oip5LHkzjFIkOTr17j8Lr9SFig4G0bXXIf0CpGIiVAgGxd60Fz4EBlyYw8l7oWQ4
         6uIk2Pue29GdM6v/ptpAoFPNEd8BKeGrZdQFTFfM=
Received: by mail-lj1-f169.google.com with SMTP id m8so18914968lji.7;
        Tue, 16 Jul 2019 00:50:47 -0700 (PDT)
X-Gm-Message-State: APjAAAURItKi/kVpDED7sTjBS2FNKR0TviCPgKXLzHZX1adm2DN5GsLU
        V9iBN9hu8KcBzrY6T5JGAZfDGpslxitG/CU7WjU=
X-Google-Smtp-Source: APXvYqwUhOxh8UOJbhBIygKJV/kpgmaRf+P/4G648IT4Cl8zq7T16IkCD7Ahb+VXbSCuPy2+L7Dg1cqNZimdSRobYxU=
X-Received: by 2002:a2e:50e:: with SMTP id 14mr16875717ljf.5.1563263445565;
 Tue, 16 Jul 2019 00:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190712141242.4915-1-krzk@kernel.org> <5cbd8bb2-6ecb-7e55-1580-e580e2c340dd@kontron.de>
In-Reply-To: <5cbd8bb2-6ecb-7e55-1580-e580e2c340dd@kontron.de>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 16 Jul 2019 09:50:34 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdq5e1OPmxamicAVf4ZDoSAuD=yvfOgZD04aQD9PtnCEQ@mail.gmail.com>
Message-ID: <CAJKOXPdq5e1OPmxamicAVf4ZDoSAuD=yvfOgZD04aQD9PtnCEQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6ul-kontron-ul2: Add Exceet/Kontron iMX6-UL2 SoM
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jul 2019 at 17:21, Schrempf Frieder
<frieder.schrempf@kontron.de> wrote:
>
> Hi Krzysztof,
>
> On 12.07.19 16:12, Krzysztof Kozlowski wrote:
> > Add support for iMX6-UL2 modules from Kontron Electronics GmbH (before
> > acquisition: Exceet Electronics) and evalkit boards based on it:
> >
> > 1. i.MX6 UL System-on-Module, a 25x25 mm solderable module (LGA pads and
> >     pin castellations) with 256 MB RAM, 1 MB NOR-Flash, 256 MB NAND and
> >     other interfaces,
> > 1. UL2 evalkit, w/wo eMMC, without display,
> > 2. UL2 evalkit with 4.3" display,
> > 3. UL2 evalkit with 5.0" display.
> >
> > This includes device nodes for unsupported displays (Admatec
> > T043C004800272T2A and T070P133T0S301).
> >
> > The work is based on Exceet source code (GPLv2) with numerous changes:
> > 1. Reorganize files,
> > 2. Rename Exceet -> Kontron,
> > 3. Fix coding style errors,
> > 4. Fix DTC warnings,
> > 5. Extend compatibles so eval boards inherit the SoM compatible,
> > 6. Use defines instead of GPIO flag values,
> > 7. Adjust operating points of CPU0,
> > 8. Sort nodes alphabetically.
> >
> > In downstream BSP the Exceet name still appears in multiple places
> > therefore I left it in the model names.
>
> First, thanks for your work. I planned to upstream these boards myself
> after the FSL QSPI spi-mem driver was merged in 5.1, but didn't have
> time to finalize and send the patches.
>
> Meanwhile we came up with a new naming scheme for our boards, that
> hasn't been implemented yet. But I would like to take this chance to
> implement the new scheme.

Sure, I see no problem in using different names, matching downstream
kernel. Just point me to proper names.

> Also there are some more flavors of the SoM (with i.MX6ULL instead of
> i.MX6UL, with 512MiB instead of 256MiB flash/RAM), that I would like to
> add and for which common parts of the SoM dtsi would need to be factored
> out to a separate file.

I have only this one particular flavor so I would prefer to upstream
only this one. I do not know all the possible combinations or for
example the most interesting ones. I think after this patchset we can
refactor the DTS whenever its needed - split common parts, add new
files.

> I would prefer to at least apply the naming changes before merging. The
> additional board flavors could be added before merging or I could send
> them as follow-up patches. What do you think?

Let's change the naming and add new flavors as follow ups?

Best regards,
Krzysztof
