Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE7CC43141
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 09:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE5020857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 09:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfKSJ6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 04:58:24 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35928 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfKSJ6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 04:58:23 -0500
Received: by mail-ot1-f67.google.com with SMTP id f10so17342014oto.3;
        Tue, 19 Nov 2019 01:58:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R2QfOLQ66mKJM4oqvv+8/7SnafH2D5zzrRD8WOBy5DA=;
        b=L1Xf8EC5Q4JoXOCzw1uJNx7tPF6TYhUwg32F0prwdYlMC6vPLwRf4Vfwyc/YxXrB3J
         JR+IRNPw5P4ij9RVyKUdAbWqdJxergZgvW0P1d7r+7X9YLXTN2jeYUr6C6vbH1Dq+Ttb
         rP2G1BZx7oBnqjUf43a5NtK/665r9sD/cDnHlt1Ss1h+s4AZ24cVRPLvFu5UJ9hnncNq
         lc+2/s1XEmqOTpjXvLot3fLuv/TAvoloOSKpCyHSdTCJ6FfY/XpwiNThNv5BNyo9snkk
         mINqcGQPdgEjh4zgXRoDjLP5V4IJP/braHHKgUif9AlEZyRaMCyfSF+nnmTcRdZEd4Bo
         Vpnw==
X-Gm-Message-State: APjAAAVWIpmH1QPui5NFopgp44O49lwr2ExvBHLCFRNd0Kpu4p36Atr5
        3H8KE4FbRx5a2fOzUKVvHBsIurpDwGNhhkWKCTE=
X-Google-Smtp-Source: APXvYqzXEAB1RN2ztsSPnJrNlveKBRzWXzUVBsrYqaVf7OxCOQc193FoRkJyyExGk2AxheB0N+YhwRziF7J9QuWRKJQ=
X-Received: by 2002:a9d:5511:: with SMTP id l17mr3048301oth.145.1574157502733;
 Tue, 19 Nov 2019 01:58:22 -0800 (PST)
MIME-Version: 1.0
References: <20191030173216.5993-1-krzk@kernel.org> <20191105194257.GA16066@bogus>
 <20191114125923.GA3084@kozik-lap> <CAL_JsqJCps_s1OGt2SvPa4uBj9EQp0ZqyeHVw8fMR+rSSVh9ow@mail.gmail.com>
In-Reply-To: <CAL_JsqJCps_s1OGt2SvPa4uBj9EQp0ZqyeHVw8fMR+rSSVh9ow@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Nov 2019 10:58:11 +0100
Message-ID: <CAMuHMdXYg4u1SF+j=doJqaDFw+O61g2th8ppt+CBrez8QAgJRA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: power: Convert Generic Power Domain
 bindings to json-schema
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob, Krzysztof,

On Thu, Nov 14, 2019 at 5:42 PM Rob Herring <robh@kernel.org> wrote:
> On Thu, Nov 14, 2019 at 6:59 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > On Tue, Nov 05, 2019 at 01:42:58PM -0600, Rob Herring wrote:
> > > On Wed, 30 Oct 2019 18:32:15 +0100, Krzysztof Kozlowski wrote:
> > > > Convert Generic Power Domain bindings to DT schema format using
> > > > json-schema.
> > > >
> > > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > Acked-by: Stephen Boyd <sboyd@kernel.org>
> > > >
> > > > ---
> > > >
> > > > Changes since v2:
> > > > 1. Keep description of consumers in power-domain.txt,
> > > > 2. Rename power_domain.txt to power-domain.txt,
> > > > 3. Indent example with four spaces (more readable).
> > > >
> > > > Changes since v1:
> > > > 1. Select all nodes for consumers,
> > > > 2. Remove from consumers duplicated properties with dt-schema,
> > > > 3. Fix power domain pattern,
> > > > 4. Remove unneeded types.
> > > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > > ---
> > > >  .../devicetree/bindings/arm/arm,scmi.txt      |   2 +-
> > > >  .../devicetree/bindings/arm/arm,scpi.txt      |   2 +-
> > > >  .../bindings/arm/freescale/fsl,scu.txt        |   2 +-
> > > >  .../bindings/clock/renesas,cpg-mssr.txt       |   2 +-
> > > >  .../bindings/clock/ti/davinci/psc.txt         |   2 +-
> > > >  .../firmware/nvidia,tegra186-bpmp.txt         |   2 +-
> > > >  .../bindings/power/amlogic,meson-gx-pwrc.txt  |   2 +-
> > > >  .../devicetree/bindings/power/fsl,imx-gpc.txt |   2 +-
> > > >  .../bindings/power/fsl,imx-gpcv2.txt          |   2 +-
> > > >  .../{power_domain.txt => power-domain.txt}    |  95 +------------
> > > >  .../bindings/power/power-domain.yaml          | 133 ++++++++++++++++++
> > > >  .../bindings/power/renesas,sysc-rmobile.txt   |   2 +-
> > > >  .../bindings/power/xlnx,zynqmp-genpd.txt      |   2 +-
> > > >  .../bindings/soc/bcm/brcm,bcm2835-pm.txt      |   2 +-
> > > >  .../bindings/soc/mediatek/scpsys.txt          |   2 +-
> > > >  .../bindings/soc/ti/sci-pm-domain.txt         |   2 +-
> > > >  MAINTAINERS                                   |   2 +-
> > > >  17 files changed, 149 insertions(+), 109 deletions(-)
> > > >  rename Documentation/devicetree/bindings/power/{power_domain.txt => power-domain.txt} (51%)
> > > >  create mode 100644 Documentation/devicetree/bindings/power/power-domain.yaml
> > > >
> > >
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> >
> > The patches should apply cleanly in top of your tree so maybe you can
> > pick them up?
>
> I didn't on this one because it touches a lot of files. Though on
> second thought, they are all across the tree, so I might as well apply
> them.

There are still several leftover references to power_domain.txt.
Krzysztof: Do you plan to convert these, too, or do you expect the
individual maintainers to handle that?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
