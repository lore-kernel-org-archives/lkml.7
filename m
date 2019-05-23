Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B63C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 15:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D8282175B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 15:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558626953;
	bh=V4ZP2/dLscXLDqbQgJUnoACFi9scmweeDdhvMUiUVh4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0u/aq9RlDMvwCisU+C6WyGZVxOciK4MgZPsQnHBYIXEbQXnKMYOJeZoSNDJAbIdgL
	 EK/ocm4swNjvwwB+rwhMybZLtBgnhDdWTKOPDqITJWeBnwvQW1ShGWM3131KKUWr1A
	 c5tlopTBNlLLMyqrLH1lu5hWKnKjmCkOcAfdw/rM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731048AbfEWPzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 11:55:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730752AbfEWPzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 11:55:52 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 984E82175B;
        Thu, 23 May 2019 15:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558626951;
        bh=V4ZP2/dLscXLDqbQgJUnoACFi9scmweeDdhvMUiUVh4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R1S7fOzWe8tdEyXVX7h19w9DQxhcSM92aUWdB/iADTIYN0XEIgRAggtOg4hqkL9M5
         Dm3q0yUpkHcv/Uu16ehRFFLNnzELyOQawj+f0RVr8Jp7FIH7lc4INPCAQlua1KZAyA
         /pE+WzEwXsUudS1sX0d6S+EbYVwYZCg3nBx8umPw=
Received: by mail-qt1-f173.google.com with SMTP id a17so7337101qth.3;
        Thu, 23 May 2019 08:55:51 -0700 (PDT)
X-Gm-Message-State: APjAAAXcHt6z9MXinuWmGRdxfDnZgv/2WbvvcTJhORm601JdGppYuHwl
        s79NM8lkVENi2WWnLkT18FqpPwRge63gh7I3qQ==
X-Google-Smtp-Source: APXvYqxzVHY9bCwMYV6NnW1uDWYDuENIPBg7zeYyQdXiHoh8OpVci9+JMjFdbOqPVhnY0iofHv0h/fEWtKyl/RUYnFI=
X-Received: by 2002:a0c:8aad:: with SMTP id 42mr78521685qvv.200.1558626950891;
 Thu, 23 May 2019 08:55:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190522131550.9034-1-manivannan.sadhasivam@linaro.org> <20190522131550.9034-2-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190522131550.9034-2-manivannan.sadhasivam@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 23 May 2019 10:55:39 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKeiY=k8n+d_7ug_DG=qZdj_cAPSCeSU-37Ds3ogKQZmg@mail.gmail.com>
Message-ID: <CAL_JsqKeiY=k8n+d_7ug_DG=qZdj_cAPSCeSU-37Ds3ogKQZmg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: Document 96Boards Meerkat96
 devicetree binding
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Robinson <pbrobinson@gmail.com>, yossi@novtech.com,
        nazik@novtech.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 8:16 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Document 96Boards Meerkat96 devicetree binding based on i.MX7D SoC.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>
