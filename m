Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CD1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93E22075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553694205;
	bh=PPF4M+TFBO5cAsOhMbYFDoI4wZbodduo/Mg3WGwov6Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=woqRjmpZDgTw5S0fCktXnhIw0QCCF1HXTN4JnitXLMmUp2Z7rJrp+59GV/ZHi0maT
	 elNWmkcJAqNMy9Ar41U4lvuW5saOW+VM61LHoMq32Inta2pJsyh+whiUh8aese43Ht
	 Yu9egmv2vmmU05mwOkSpdTh2dzbvhKBcrNmmN60Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbfC0NnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:43:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:48676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728213AbfC0NnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:43:24 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02CCE2146F;
        Wed, 27 Mar 2019 13:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553694203;
        bh=PPF4M+TFBO5cAsOhMbYFDoI4wZbodduo/Mg3WGwov6Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=An5SI/fTpVc5rU6hFiu20MZFZP3fJdU4NIFumm3DPV+5oY1LnkEff440F6/ah44YI
         HDyNanpcR+Ew57aSszJL/dQ7DTFACJtMHXZy/hJDbfMJ/5vk43fjFeaaMfz9a9ZCV/
         k76GWix95pEyv7fSRvZnt7j4jYvcwpmwpHqL9Fr4=
Received: by mail-qt1-f169.google.com with SMTP id d13so14131306qth.5;
        Wed, 27 Mar 2019 06:43:22 -0700 (PDT)
X-Gm-Message-State: APjAAAWGY7Tn6XgPo057n5eRSVYR8bAGHbU5cYPNLrN3AEopXUWgLr9x
        qgRi4MXpQ6hYBSggMvEIrutjy2sypkWS2dSrKA==
X-Google-Smtp-Source: APXvYqxozagMOF/buPOxrY8x7Y6+T/i6knM5k/s6ABWrYM0xlQs5IOHT8njPNPyMJtIEtYcEGF9OGSima5aVx1I1MAY=
X-Received: by 2002:a0c:8685:: with SMTP id 5mr20419914qvf.246.1553694202299;
 Wed, 27 Mar 2019 06:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190325182243.16788-1-andrew.smirnov@gmail.com> <20190325182243.16788-2-andrew.smirnov@gmail.com>
In-Reply-To: <20190325182243.16788-2-andrew.smirnov@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 27 Mar 2019 08:43:10 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+7m1pRwoXH6ZM-Es-ZMprpazX8xsx6+nPkidKwOEYd=g@mail.gmail.com>
Message-ID: <CAL_Jsq+7m1pRwoXH6ZM-Es-ZMprpazX8xsx6+nPkidKwOEYd=g@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: arm: fsl: Add support for ZII VF610 SPB4
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Chris Healy <cphealy@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Fabio Estevam <festevam@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 1:23 PM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> Add support for ZII VF610 SPB4.
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>
