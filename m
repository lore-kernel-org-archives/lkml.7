Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6FAC433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 11:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FADD21655
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 11:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564313938;
	bh=OvEepJy3oT6ksyvUS9RloPjZaalZWvVPFCQys9FpK20=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NH8zrFYb4Ok0GgFezEOoRYp5mzg75odX8XmN0O/JjYHebiaTwipjjSBLvD92cWAj7
	 0jgcXMu9XOxm0fLab7Crrh16YPYRK6ejGcHZCOk/EtskozSw7oZXmu2Lb3QbnacFfq
	 dF9FVBz6JP9mBBLeeMe6FUfj5w8x1j6rMi37O5Ek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfG1Li5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 07:38:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:32890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbfG1Li5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 07:38:57 -0400
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30DAC21655;
        Sun, 28 Jul 2019 11:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564313936;
        bh=OvEepJy3oT6ksyvUS9RloPjZaalZWvVPFCQys9FpK20=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XH2IW9A/PFvzGBOhmozRvRDzUtZVAvlP9K4dffnnude5Yx+FYZqAwFmBRxuosuEj1
         9jv2ZrB053WFws1st8+iq5dQr8UmQaU1xleK4BPNCTE+z0K1FjXTMFZ+rGvtNydIRq
         xxG5hyHHGll+5V3H1yLfgQQNiqbW8rWT50oufLhk=
Received: by mail-lj1-f179.google.com with SMTP id r9so55710201ljg.5;
        Sun, 28 Jul 2019 04:38:56 -0700 (PDT)
X-Gm-Message-State: APjAAAULOZm5q+v85LeLzTXaA5EObh1otGyfoMOzqg8gcFL90h54XTsI
        wginyr73hjSVsUtNRohDaYZdVaq7DDG5/NU/e4s=
X-Google-Smtp-Source: APXvYqzGiWzksa+0jU05XqUycO/HjQrSHPzvRlDT0Jo8FWgXXh/SpTMp5KGnsiA7nL4OAWdNIpdMgskzMUpKABzGP1M=
X-Received: by 2002:a2e:6e0c:: with SMTP id j12mr10171576ljc.123.1564313934212;
 Sun, 28 Jul 2019 04:38:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190727142736.23188-1-krzk@kernel.org> <20190727142736.23188-2-krzk@kernel.org>
 <86910491.m50tbimVMv@phil>
In-Reply-To: <86910491.m50tbimVMv@phil>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Sun, 28 Jul 2019 13:38:43 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcHB9969bqw+aqRh1HYHKDazhhpKy_+uKKcA=5Gkg6+EA@mail.gmail.com>
Message-ID: <CAJKOXPcHB9969bqw+aqRh1HYHKDazhhpKy_+uKKcA=5Gkg6+EA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: rockchip: Add missing unit address to
 memory node on rk3288-veyron
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jul 2019 at 17:33, Heiko Stuebner <heiko@sntech.de> wrote:
>
> Hi Krzysztof,
>
> Am Samstag, 27. Juli 2019, 16:27:36 CEST schrieb Krzysztof Kozlowski:
> > Fix DTC warning:
> >
> >     arch/arm/boot/dts/rk3288-veyron.dtsi:21.9-24.4:
> >     Warning (unit_address_vs_reg): /memory: node has a reg or ranges property, but no unit name
>
> please see the comment directly above the memory node on why that needs
> to stay that way. So no, we'll keep the veyron memory node as is.

Damn it, I missed it.

Best regards,
Krzysztof
