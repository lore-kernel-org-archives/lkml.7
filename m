Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7502C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B652075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553694180;
	bh=Ce4eVFYOJXF9TvrFunnvn9dZspJ0TG8trYCMp4EEpWs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=S+5WkjHbJ/cp6MZmCaue3Kt3Q2ANxyJeVkp1KI7oDetcRlx1uDFKavYjbwpjh7vOo
	 PvSPRncd2ZW8FfX1uG5pLUONz4u+aBgwYVyw4aLRM/VQeUj+oRSwDonm4eva6Hup/U
	 2JzHLMjOetRGBYA8lWf1xaL+GOHv3FIhOMppRIHg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbfC0Nm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:42:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:48326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728375AbfC0Nm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:42:58 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0332321738;
        Wed, 27 Mar 2019 13:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553694177;
        bh=Ce4eVFYOJXF9TvrFunnvn9dZspJ0TG8trYCMp4EEpWs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SDY6ciVGT3ZqlMkVliM9c2zknI2WB4iqh5G/uArNPBXpOGsxpg3NoewU2fvwQf2nX
         lvJpbXEXjTppVzakQWr/zc4ctjhb6cRQ2wkmS8+2AVwsT8urBIMVI7KULwCP7Tl0ew
         Cem0+ITkAPb0cnzBSskRZYdsVDj4UjYjbaRCcI+A=
Received: by mail-qt1-f172.google.com with SMTP id h39so18855582qte.2;
        Wed, 27 Mar 2019 06:42:56 -0700 (PDT)
X-Gm-Message-State: APjAAAWNbwNVdAhjnwuoWPvsRoVRnAbLtRT1NF1DVmMOoEs+3AqJmglH
        pzyD8K29zQHT2yJY+qOC2PplmGhb9wXarXUFQg==
X-Google-Smtp-Source: APXvYqxn6SordT2lEWpsnOKqI1vzovY4v/Dk+RAJN2OKnTjBWv2EyqGSeboqTaPTshBf8cCqW8F+oUv4egM+0drUwt4=
X-Received: by 2002:ac8:267c:: with SMTP id v57mr30376931qtv.76.1553694176230;
 Wed, 27 Mar 2019 06:42:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190325182243.16788-1-andrew.smirnov@gmail.com>
In-Reply-To: <20190325182243.16788-1-andrew.smirnov@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 27 Mar 2019 08:42:44 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJxrTT6wJG6eSssBiuMhot6mPQLUJTZRtMTcgKjpK4P7w@mail.gmail.com>
Message-ID: <CAL_JsqJxrTT6wJG6eSssBiuMhot6mPQLUJTZRtMTcgKjpK4P7w@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: arm: fsl: Add supported ZII VF610
 boards to DT schema
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
> Add already supported ZII VF610 boards to DT schema.
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
>  Documentation/devicetree/bindings/arm/fsl.yaml | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
