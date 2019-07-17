Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D23C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 08:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEAD52077C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 08:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563351490;
	bh=5GNQoM7T3OZ2EwjYuZ7fJtx8Y6qQF3hP9lT0ttHPpvQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wgld/sAAe3PIZdB1lfK/tfAHCLTkH8ufZpLoKwRs4Kpa4DVHuQfXeLWqwTAH4eGaC
	 Zc3v2Lql0EuDAkusKfpMf0pwEfnHpIbGXwYO8XruA4A+ZapRC+bdKbkAcK3wgPOnb2
	 dmlU3HRSDIMNHyfHNBN/oEEd/GicLCL2PeOFhk60=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbfGQISJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 04:18:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:40150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfGQISJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 04:18:09 -0400
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A60142173B;
        Wed, 17 Jul 2019 08:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563351488;
        bh=5GNQoM7T3OZ2EwjYuZ7fJtx8Y6qQF3hP9lT0ttHPpvQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BMk82FbNEX+ScgsGCO0TrFEo5sKOIUbK5ki+a7Wp3dBgcRxNpGjwSOStaJ8QPCblm
         KAKapKaVZTat/7/27NdE3ZLBc2oBo1+69lm3o387UzZc5uNX5PEPq7pqZHF0/lmGFM
         OoSvbBOnZkfov7Tz20pMcQ1yN75tnvNVZPksyyuk=
Received: by mail-lj1-f169.google.com with SMTP id p17so22723185ljg.1;
        Wed, 17 Jul 2019 01:18:07 -0700 (PDT)
X-Gm-Message-State: APjAAAUt7rdp+AVb1gC6sjNHwoY+sJ/Ic54JLXlXhIhtbSPn12qekBFS
        4FiumNToRDC+zhhd5vAPglvRl4dyJjMPC/hWwZo=
X-Google-Smtp-Source: APXvYqylYz7gNmzlXqUoO2oJVnfuYOhDlPlxB7yrdES0wr8vBhhh8uj9yF8LJHi/hEx9u2UnvjdI9FfTGNOF6wdZ8Fc=
X-Received: by 2002:a2e:3008:: with SMTP id w8mr20519868ljw.13.1563351485856;
 Wed, 17 Jul 2019 01:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190712141242.4915-1-krzk@kernel.org> <cde6f251-4b15-a4f0-57ed-ca2ed014b511@kontron.de>
In-Reply-To: <cde6f251-4b15-a4f0-57ed-ca2ed014b511@kontron.de>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 17 Jul 2019 10:17:54 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcLdfo6XCc--HneYjCHOYKdKgWDBDSVjxQBR+pc+1mcfg@mail.gmail.com>
Message-ID: <CAJKOXPcLdfo6XCc--HneYjCHOYKdKgWDBDSVjxQBR+pc+1mcfg@mail.gmail.com>
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

On Tue, 16 Jul 2019 at 17:38, Schrempf Frieder
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
>
> We will use a new naming scheme for these and other boards. The new
> names would be:
>
> 1. Kontron N6310 SOM    (i.MX6UL SoM with 256MB RAM/NAND)
> 2. Kontron N6310 S      (Evalkit with SoM)
> 3. Kontron N6310 S 43   (Evalkit with SoM and 4.3" display)
> 4. Kontron N6310 S 50   (Evalkit with SoM and 5.0" display)

OK (and OK for all other comments which I will skip below).

(...)

> > +
> > +     memory@80000000 {
> > +             reg = <0x80000000 0x10000000>;
> > +     };
> > +};
> > +
> > +&cpu0 {
> > +     clock-frequency = <528000000>;
> > +     operating-points = <
> > +             /* kHz  uV */
> > +             528000  1175000
> > +             396000  1025000
> > +             198000  950000
> > +     >;
> > +     fsl,soc-operating-points = <
> > +             /* KHz  uV */
> > +             528000  1175000
> > +             396000  1175000
> > +             198000  1175000
> > +     >;
> > +};
>
> What's the reason behind overwriting the operating-points and setting
> clock-frequency? Doesn't imx6q-cpufreq.c already read the speed grades
> from the hardware and adjust the operating-points accordingly?

Good point. From the driver point of view overwriting of opps is not
needed. As you said, the driver will adjust the speed to the reported
grade. This could have meaning for the completeness of hardware
description however I see that there are no even bindings for CPU and
other boards do not overwrite it. I'll skip it then.

(...)

> > +
> > +     regulators {
> > +             compatible = "simple-bus";
> > +             #address-cells = <1>;
> > +             #size-cells = <0>;
>
> We copied this from some other devicetree and I'm not sure in what case
> we should really group the regulators in a simple-bus, or what's the
> reason behind this. But others do it like this, so it's probably not so
> wrong.

Either simple-bus with regulator@address or unique regulator node
names (regulator-1, no unit address). Both are popular but I think in
recent submissions and comments Rob Herring was proposing the second
option - unique regulator names without addresses. I can use such
approach (unless DTC complains).

Thanks for review and feedback!

Best regards,
Krzysztof
