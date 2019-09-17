Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C43C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 13:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 398282171F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 13:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568728463;
	bh=Zy1gyPFQR5tH17NOVpzMpdx44iyBjVu4jKrnFZKxcoQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lmgEhKbzEBTTvY8Tb3xzetNCohzMsWyKTp0SM0tp5wib/S/n06jsXNa8uByamyN7M
	 sP/UYmg59LCcUElrzGVAbpda+9B+wC79pP/wiyP1KJCvSVNVrKD0SVvZMG0quTZHPJ
	 AW4+pYyxZRGq4cuN4yOIzkZ25DFUNPt52OyEDGS4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfIQNxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 09:53:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:42846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbfIQNx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 09:53:27 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90A86218AE;
        Tue, 17 Sep 2019 13:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568728406;
        bh=Zy1gyPFQR5tH17NOVpzMpdx44iyBjVu4jKrnFZKxcoQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EVqkVWHzmcxNiZfo0XgNASF1UniwBql3I+w9ZLEZ4BOZjU/G47S1dDn1Cz+a737GH
         1WPCg2Xv7XvaO+UGDZg7wqvOSHHJyZM6x8nn34J8nAHb93br7ct3Owa/vrqspo6EvK
         KMYTsgSQATfNxge6HfnclNVUyeZUCcGbvI6ECRaA=
Received: by mail-qt1-f176.google.com with SMTP id d2so4496548qtr.4;
        Tue, 17 Sep 2019 06:53:26 -0700 (PDT)
X-Gm-Message-State: APjAAAUKqTyfZhyUHZ0ChRoYn056xPRLDyGhDM3P+yfP2L5ji0NEsL30
        ZyulM/lAdFs/aTlcAGoImXDDZYKCYMc3gn7liA==
X-Google-Smtp-Source: APXvYqzb6iLIui+fyGRxfioNL0UXi8H6SwK7I3RIJUPjuGGMjLfR7E45y2vRuFrjDr9kSUtNUFl7rmjN32fi7d/wqWI=
X-Received: by 2002:ac8:100d:: with SMTP id z13mr3773831qti.224.1568728405752;
 Tue, 17 Sep 2019 06:53:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190917103052.13456-1-alexandru.ardelean@analog.com>
In-Reply-To: <20190917103052.13456-1-alexandru.ardelean@analog.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 17 Sep 2019 08:53:14 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ8fE4xH0DdtextdJ-+DftC2jDGg6GHbDJ+viCnhO2faw@mail.gmail.com>
Message-ID: <CAL_JsqJ8fE4xH0DdtextdJ-+DftC2jDGg6GHbDJ+viCnhO2faw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: net: dwmac: fix 'mac-mode' type
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     netdev <netdev@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Giuseppe CAVALLARO <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 2:31 AM Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:
>
> The 'mac-mode' property is similar to 'phy-mode' and 'phy-connection-type',
> which are enums of mode strings.
>
> The 'dwmac' driver supports almost all modes declared in the 'phy-mode'
> enum (except for 1 or 2). But in general, there may be a case where
> 'mac-mode' becomes more generic and is moved as part of phylib or netdev.
>
> In any case, the 'mac-mode' field should be made an enum, and it also makes
> sense to just reference the 'phy-connection-type' from
> 'ethernet-controller.yaml'. That will also make it more future-proof for new
> modes.
>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
