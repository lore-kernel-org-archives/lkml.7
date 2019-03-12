Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2425C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14CB214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552416212;
	bh=Kzjqj4gBzAtHnAq41No2joJC8kcBK8G6uW1JhmAXxP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2j3vSwutYYwbDLOt57Mn0QLar12csOiYpJun8Srb7rJUAfsMoqfRI64Sca+5AEmQG
	 VRJU531S9fH55m+gV+0CoDCv7eC2iYMBMjcwqqVOklDHbMCiG12jVtPdS9oWbDw7Vl
	 L5yU3loKxKcRKTQYV6B7K8YYA22lEsOVPP9jscaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfCLSn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:43:26 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36672 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfCLSnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 14:43:25 -0400
Received: by mail-oi1-f194.google.com with SMTP id t206so2995512oib.3;
        Tue, 12 Mar 2019 11:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yDkWwykF6freJf99880HIEi4f8G845leoUKduv8xzhw=;
        b=A5l4ZC2Y0zzohCc91hENAd3jrK4LqyHcLVsLwclp+kWZnOe27kpjY0wMmTi28qCHuB
         VQyxRk17sRCHIs3RiZP+ruIhjB0yKNsiCHoUyC9wkq94P799DYfHXKKYyqntJgsi6yzx
         oMS1gTyGEGl3cCFMTJ38545d8rIRsy9AsTvG7Pth6Ved2Rlvj0OcPneQ9Zl8XHH8kuY4
         4QZiOkwqDdMBdPQtaUMRouYDqreFKkF1jDIZ2HMVRjW+RzKSNNSHPMnrLNU8GfSN7c5C
         q/efjCBZsX5jhrApyrXNrvkjX04Ctaq4bgLuINb4N8UyXgMheZR1OX6D/RFOqM0WkwTP
         /UdQ==
X-Gm-Message-State: APjAAAXiD//vWQEaQMTdBgfXLaGVnU/o/f3knNysA2EzMT0qYibjhAkj
        BkFWD7we/o5l7QYKMRxnmQ==
X-Google-Smtp-Source: APXvYqw/9Ze47Q4VvYCsNqZuD6oac0Lw4DwqNLi168iEoshbSDsyLjnUHm3KAYWR0IXr/2HyNjdmhA==
X-Received: by 2002:aca:5714:: with SMTP id l20mr2494766oib.148.1552416204987;
        Tue, 12 Mar 2019 11:43:24 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a62sm5719621otb.72.2019.03.12.11.43.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 11:43:24 -0700 (PDT)
Date:   Tue, 12 Mar 2019 13:43:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH v2 5/5] dt-bindings: display: armada: Document bus-width
 property
Message-ID: <20190312184324.GA13632@bogus>
References: <20190304202006.3863-1-lkundrak@v3.sk>
 <20190304202006.3863-6-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304202006.3863-6-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  4 Mar 2019 21:20:06 +0100, Lubomir Rintel wrote:
> This makes it possible to choose a different pixel format for the
> endpoint. Modelled after what other LCD controllers use, including
> marvell,pxa2xx-lcdc and atmel,hlcdc-display-controller and perhaps more.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  .../devicetree/bindings/display/marvell,armada-lcdc.txt     | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
