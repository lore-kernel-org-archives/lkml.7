Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313DBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAEA52087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552414997;
	bh=huYHMCu+cV5JB7avjgeCUAJv3Pq146LAtAkavCDPi+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VDIA+RiHGQNyj6ii3x8yYhqnHeXEIxgNnB4sHAr4cnCW30qW0/Sm3e54KZezMrIzy
	 hew3GWre2VcevJjQ+GYE7ycrg9KIQXbZluW41RucLkb+ifIng40s9r6VC0LmcwiDNw
	 5QYowB4G6adJhSYnzCN1MZIL4IabQNbP3cIRGg88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfCLSXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:23:15 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37851 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfCLSXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 14:23:15 -0400
Received: by mail-oi1-f193.google.com with SMTP id w66so2935249oia.4;
        Tue, 12 Mar 2019 11:23:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MtR/uROcIP2ZKKxWXfoHxV1cDC5Gi853VTEPlMwB4SA=;
        b=B9gWmdFxQYIxrTh2Hxs6jlASqWotQNnwC/gFVk83bkDMbB73IY5GdkN26Jjo9kewQj
         3yKKa1wKQaOQ/dToCfZ2zR2dwb94rV5+n5H4Ga+51IWnxrRucp7yUTnbIrDPzgl5I1hj
         LK1LZf/tNitkZn9OYFEsIYYrcwN1RvXdl5yE6GTSShJWHyYiXSJG5rFQ+0YKBRkhvPc5
         PJhPEyRxQ1cACen/8jt6n92651ggD8CpR8OSvw7/GcVtitkWoppWwDk21oo/V79QRKgN
         r/58gZyTSZV90B1MbtKnVps5AxE6KgJNVbu3HzTPlQ3GyJ828whxTRFGXzUDN2xACR9m
         Xwlg==
X-Gm-Message-State: APjAAAW6rSo6pr8pprE+uQW00PBSoBk2+VRWOMS3vu+j6zm8Jtjulfjy
        WoCz1bXE1jaXmVPFn3gjfg==
X-Google-Smtp-Source: APXvYqx+pOkxpw30qVr1Yg4ci3ubTz+pAp7YBtpcJF8ds1zk+6ersy64sxKubxp4HG4AbWgsGpOVvg==
X-Received: by 2002:aca:df45:: with SMTP id w66mr2462110oig.94.1552414994459;
        Tue, 12 Mar 2019 11:23:14 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w22sm3820004oth.45.2019.03.12.11.23.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 11:23:13 -0700 (PDT)
Date:   Tue, 12 Mar 2019 13:23:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com, devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/8] dt-bindings: phy: Add Amlogic G12A USB3+PCIE
 Combo PHY  Bindings
Message-ID: <20190312182312.GA12396@bogus>
References: <20190304103846.2060-1-narmstrong@baylibre.com>
 <20190304103846.2060-3-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304103846.2060-3-narmstrong@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  4 Mar 2019 11:38:40 +0100, Neil Armstrong wrote:
> Add the Amlogic G12A Family USB3 + PCIE Combo PHY Bindings.
> 
> This PHY can provide exclusively USB3 or PCIE support on shared I/Os.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../bindings/phy/meson-g12a-usb3-pcie-phy.txt | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/meson-g12a-usb3-pcie-phy.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
