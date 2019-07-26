Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B449C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 10:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A5F229F9
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 10:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564135361;
	bh=7MJ+vCNVbPSQe5xb35xJesroJsELZsRfJAQgN2m8Yo0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=W6Jk0jbgkuBY+PPGe672/hMSOZlaKyeiu5FHl9ZlCbQ0hafBZ2Z1KwgVk8+bwRyT6
	 /Ialj7MlUR7JA7srEZovXCTFrZBz6veA2rFQrRuabMURh9NDgGMK1X3AimZfGi4LJL
	 JtXKwIATd3CiOtAxIQ32sQ32VNOmE3qF5PWJpuGc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfGZKCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 06:02:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:37180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfGZKCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 06:02:39 -0400
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 544AE22CB9;
        Fri, 26 Jul 2019 10:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564135358;
        bh=7MJ+vCNVbPSQe5xb35xJesroJsELZsRfJAQgN2m8Yo0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YqZlO8xaCrORR7NUWRK1YWzCAoX0fQGCAruiUvd0EbGpIcxG7y98zfuBT2WRffOtp
         rLYVGVw70r+Q97IxDQosEpuYSC7i+iFzWd0XKqxj7MT33yDLIHZqL/5Qvv9kvIfAb3
         47QnWfX36rb6cJH5/SPwNc6vSmEE34SAQhP1ANMY=
Received: by mail-lj1-f171.google.com with SMTP id z28so50991900ljn.4;
        Fri, 26 Jul 2019 03:02:38 -0700 (PDT)
X-Gm-Message-State: APjAAAVVLHp4//7eIhsfcrIpr22da/wwNVI4UkjL/RNeZf00VkgFWUvY
        Vnlv5T6rKHjc1wKNHGoUYQjUZmGD6c/VvH1LPWs=
X-Google-Smtp-Source: APXvYqyOZ17x945oZf2yalALHm6hxXvu7W9AcifjqVUkBG7YT744y3x06dMet0dxxzuVhl2gudIP27bO87jyn3ITadI=
X-Received: by 2002:a2e:7818:: with SMTP id t24mr21589590ljc.210.1564135356368;
 Fri, 26 Jul 2019 03:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190726061705.14764-1-krzk@kernel.org> <963ba555-dde0-9c3c-1e15-740ca200853f@kontron.de>
In-Reply-To: <963ba555-dde0-9c3c-1e15-740ca200853f@kontron.de>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 26 Jul 2019 12:02:25 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdbBXEy0zzjZ1ytts0y5STQ5x9xQVBmU1vn46tmu8uCGg@mail.gmail.com>
Message-ID: <CAJKOXPdbBXEy0zzjZ1ytts0y5STQ5x9xQVBmU1vn46tmu8uCGg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: vendor-prefixes: Add Admatec AG
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
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

On Fri, 26 Jul 2019 at 11:48, Schrempf Frieder
<frieder.schrempf@kontron.de> wrote:
>
> On 26.07.19 08:17, Krzysztof Kozlowski wrote:
> > Add vendor prefix for Admatec AG.
>
> We get the displays used with the Kontron eval kits from "admatec GmbH"
> in Hamburg, not "Admatec AG" in Switzerland. I think we have to
> differentiate here.
>
> I will review patch 2/2 soon...

What a coincidence... they have so similar portfolio. After looking at
vendor prefixes that would be the first duplication of name.

To avoid conflict, how about: "admatecde"?

Best regards,
Krzysztof
