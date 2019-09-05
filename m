Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F72C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 09:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F06882173B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 09:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567675322;
	bh=NH8zw2DsahfYGKLTjXt13ZAAi9PCZWGCt4HzlHNYnmg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ealIxhIcVnKS6x0aRirqBja99CPT8u+Hi59Q9wJkry8subPqseW7mTBgnTuGWhSN6
	 P7Ak3X2u+LG9+b0vJw+FSRWjpIPQH8ccsqAD2MjR608kOmbLc85JHXJUt8mAm2TkLU
	 RJpdeTpLn+YSQHH/wJa45xG2okHW4A2Xt9MUb3TQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733241AbfIEJWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 05:22:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbfIEJWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 05:22:00 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C67C722CF7;
        Thu,  5 Sep 2019 09:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567675319;
        bh=NH8zw2DsahfYGKLTjXt13ZAAi9PCZWGCt4HzlHNYnmg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p+Cw8oNZZy8TNU5UoJYRJV4Ap7/ikU0qxdrMtBCPW17ZQRKsFLRrEc4IWMYoKGpuk
         gkZP9vCkijuJmkwIgXEibbDRT7zPngSvHhw5hDmFWxwaomnskbWL5tWVvoU8vutYgp
         j/RWZi1AZtNa5TKtOtO/pK3tg9rrl0tPHT+dA9jA=
Received: by mail-qt1-f170.google.com with SMTP id r5so2007124qtd.0;
        Thu, 05 Sep 2019 02:21:59 -0700 (PDT)
X-Gm-Message-State: APjAAAU64eb1XfUupwlFgYDBMAeYTg4zgS5Hz2JHOReP7wzMDPaQYTY7
        VLDSt/ewh8Lvs4gTDuvOuy1jUH2BsX72Z+Rf3g==
X-Google-Smtp-Source: APXvYqxeugvAUFLcLYFbxmSaJvKmXtHFs4LVKAqHKRyHX9HN2+iGCFcDCTuMhzgTg8mWgt75I4Yah+VMdMVrWe1lJRE=
X-Received: by 2002:ac8:468c:: with SMTP id g12mr2401498qto.110.1567675318970;
 Thu, 05 Sep 2019 02:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190905081721.1548-1-james.tai@realtek.com>
In-Reply-To: <20190905081721.1548-1-james.tai@realtek.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 5 Sep 2019 10:21:48 +0100
X-Gmail-Original-Message-ID: <CAL_JsqKGX1n-jsi0xtG8_Q=1LAhT=ufe0y2ZNBNoE3fR10K_xQ@mail.gmail.com>
Message-ID: <CAL_JsqKGX1n-jsi0xtG8_Q=1LAhT=ufe0y2ZNBNoE3fR10K_xQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: arm: Convert Realtek board/soc bindings to json-schema
To:     jamestai.sky@gmail.com
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        CY_Huang <cy.huang@realtek.com>,
        Phinex Hung <phinex@realtek.com>,
        "james.tai" <james.tai@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 5, 2019 at 9:19 AM <jamestai.sky@gmail.com> wrote:
>
> From: "james.tai" <james.tai@realtek.com>
>
> Convert Realtek SoC bindings to DT schema format using json-schema.
>
> Signed-off-by: james.tai <james.tai@realtek.com>
> ---
>  .../devicetree/bindings/arm/realtek.txt       | 22 -------------------
>  .../devicetree/bindings/arm/realtek.yaml      | 17 ++++++++++++++
>  2 files changed, 17 insertions(+), 22 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/realtek.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/realtek.yaml

I've already submitted a patch for this that's *still* waiting on
Andreas to apply or comment on the licensing.

Also, your patch isn't valid schema. Please check with 'make dt_binding_check'.
