Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E74EC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 17:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37BBD217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 17:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569607121;
	bh=OVc+bRyRjrZCnSIiqapeUMzMtcTLIi/zUzPnbyy41Tc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SQPTXzuvrxLJnoXddOYRLw2M6kwua9iVyEiSpSgllXyunGf/+Vk6jTlNruYbDL4vr
	 9tj89TZfPWCeyds6EIxxmLHe1X8/EtrVe/FcXUiTrFEWDBu6LwfGBuHY+av/vYiqLU
	 FwEIEjHE0Jv3o9uhh75/tPNXzbr8wRrwXWnvarEU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfI0R6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 13:58:40 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39672 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbfI0R6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 13:58:40 -0400
Received: by mail-ot1-f67.google.com with SMTP id s22so2992593otr.6;
        Fri, 27 Sep 2019 10:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5DqIrMbfbUSxw6P4Viq/PLdOhtJhDfVLbGztJVk8LJE=;
        b=l8GuZtzLZPYMJ+oUbtHgiE5myOKGorXNqXPzXFf4T5NvMyEkHmx7YB5gyx8UnY5PVZ
         4peUMO5ACp+C0ncj3iqSkiCAolte52Z0Tj9Mqpr+Hzq+gcmoc7KPB5jZjp5NZF2wQaOD
         exR+5uKCu9zh6l4NwFdzgTcirdhYR62lMV0AmfunDLedlnFaRgIoFCOMy3v0p3JjYtnW
         X39pPvSfpiEUzbeehnxJ92sVGZaNu/45XmShiMLwcbqw2HnvY6V1PGDS4di+YtvnmxIo
         2Jduev0onRmk8qiy4A6betQaWY9KXMSO8L0n1pyuRDUALkJxfZM4ytw8RXGFR4abhRK3
         0yWQ==
X-Gm-Message-State: APjAAAWoKXJa2vHhG/yaatBNIO0V94MdBLMrMahgDFvebGj7n+n+VQYa
        rNfItgjt2d+WHcjNI++TBQ==
X-Google-Smtp-Source: APXvYqxh7UQtB4K6EwJ90sqVkNEtGKfHhSzYF7AK9XxtQJamydovnwqR9hpgIrckULvXwVW29+hxNw==
X-Received: by 2002:a9d:625a:: with SMTP id i26mr3960317otk.43.1569607119429;
        Fri, 27 Sep 2019 10:58:39 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t207sm1884662oif.11.2019.09.27.10.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 10:58:38 -0700 (PDT)
Date:   Fri, 27 Sep 2019 12:58:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: samsung: Convert Exynos System
 Registers bindings to json-schema
Message-ID: <20190927175838.GA20682@bogus>
References: <20190920162600.7486-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920162600.7486-1-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Sep 2019 18:25:59 +0200, Krzysztof Kozlowski wrote:
> Convert Samsung Exynos System Registers (SYSREG) bindings to DT schema
> format using json-schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v2:
> 1. Use select to skip other syscon nodes,
> 2. Indent example with four spaces (more readable),
> ---
>  .../bindings/arm/samsung/sysreg.txt           | 19 --------
>  .../bindings/arm/samsung/sysreg.yaml          | 45 +++++++++++++++++++
>  2 files changed, 45 insertions(+), 19 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/samsung/sysreg.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/samsung/sysreg.yaml
> 

Applied, thanks.

Rob
