Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AE9C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 14:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E6A321849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 14:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563545755;
	bh=7voVgpdtafoQyqpHGpr3HIm+GXd3iZv/wz9SMFvW7ck=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VzykZ1FYTdbtIJReBv5qFepFCBFxIIA3RmumzR+RIKo13e1DBA4qFPCk7535CIoeO
	 0nb8bgM+i9/o6U6yP+3zE/arOaU0hLXKbM8UaXLcAAdSWpi8z8efp39u7lnNAqtpKz
	 XN/9ppg1xcGSjUjwG4sY/A/TQwuvTA7ZQvpzxcOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbfGSOPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 10:15:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:43904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728427AbfGSOPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 10:15:53 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98C7A2187F;
        Fri, 19 Jul 2019 14:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563545752;
        bh=7voVgpdtafoQyqpHGpr3HIm+GXd3iZv/wz9SMFvW7ck=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Pm7Y7/tqvPhjBFQNYrTD2ZDZuBEpGhVOx+X8U3Yk6plwmTyAUYJlKqtkVvMClJh63
         I0wUD4utkn/rEMGiNBwZ9kDkw4dHjqV6hMrlhD1aJ1A7AMtOIN36FE6iEP3MHsHVfi
         bqP841/DOOpTUXePYnT8rzKcb3ZpOb+HZLr7Dx2M=
Received: by mail-qk1-f170.google.com with SMTP id s22so23328016qkj.12;
        Fri, 19 Jul 2019 07:15:52 -0700 (PDT)
X-Gm-Message-State: APjAAAVZ6MVz5Rco/nN4gxS2h8asPyKj1Vru3GsKZQyGOBVpwxooTffz
        tgeXk7poJ+6dB0XYzs2nbNUbIyNsvF+1YkGgjQ==
X-Google-Smtp-Source: APXvYqyCQmcUB1GHWepHZBo1tdMFeMAEMSgURcy+OnnXCy3g5sWq0ZnCiiLUjXA2/Nv8F6F0IBpMovoRupCvPyDbNys=
X-Received: by 2002:a37:a44a:: with SMTP id n71mr33826258qke.393.1563545751319;
 Fri, 19 Jul 2019 07:15:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190719121430.9318-1-andradanciu1997@gmail.com> <20190719121430.9318-3-andradanciu1997@gmail.com>
In-Reply-To: <20190719121430.9318-3-andradanciu1997@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 19 Jul 2019 08:15:39 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ6vFdj2fru0_W=Mzkd=JHYB2=WFGtmeYosCc7jCQDDGg@mail.gmail.com>
Message-ID: <CAL_JsqJ6vFdj2fru0_W=Mzkd=JHYB2=WFGtmeYosCc7jCQDDGg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] dt-bindings: arm: fsl: Add the pico-pi-imx8m board
To:     andradanciu1997 <andradanciu1997@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Yang-Leo Li <leoyang.li@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Bhaskar Upadhaya <bhaskar.upadhaya@nxp.com>,
        Pramod Kumar <pramod.kumar_1@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        richard.hu@technexion.com, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 6:14 AM andradanciu1997
<andradanciu1997@gmail.com> wrote:
>
> From: Andra Danciu <andradanciu1997@gmail.com>
>
> Add an entry for TechNexion PICO-PI-IMX8M board based on i.MX8MQ SoC
> Datasheet can be found at:
> https://s3.us-east-2.amazonaws.com/technexion/datasheets/picopiimx8m.pdf
>
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>
