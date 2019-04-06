Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98ECAC282DA
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 06:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6952521855
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 06:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554530783;
	bh=1sW/JIuvaGwPRpfWIGXWFOuGkBGjXVYSa+DTwgwaXN0=;
	h=Date:From:Subject:References:In-Reply-To:Cc:To:List-ID:From;
	b=oMYV3xrQ/jDJMxwaQCq9fxX8UNmu21eKldyZrMDQRV0TcLn76bhEpRCtaJ172j6OF
	 l/mBoZlX/oGgb82OV4V9jeqBhBVQf5bizmwlEM/vZHGFo1dBaqIrsBvsHXlNwunWOV
	 4qe3k1V1IFUaIKmOCpQfXHK/CCdmmjAYOkpHotAQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfDFGGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 02:06:22 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45109 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfDFGGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 02:06:21 -0400
Received: by mail-pg1-f196.google.com with SMTP id y3so4180430pgk.12;
        Fri, 05 Apr 2019 23:06:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:to;
        bh=9YVOaT7zRZ+Oyis0vpGloPUiizlv+2usyvmC5EZwrlA=;
        b=GgVC1eR9uK9xNL3uA1JoNqR0Oq9VrLN+U+DNlz44dWv2LqqDEpMqxeB9YUmMFiRJwD
         bPI/eDaVmCg7oBWwppZyEqZCidwiZ8EP5pQSbL1utBmD/MObRQd3iHz13Ekfj68+Dmql
         XX2bFmX8VVznlOe4CevWpOhfc1Ah8Limvi67WEpU5IiTBr3PRgGdvpIkv6G6xRGVPzEv
         PJWZnnU/gpvRqLLs1AwHnvAdENqqv+LuOUx7UHpoIMmI8/GvH4/AgfXZ7QOCeydTOIpI
         VsLikIeTGjjTT7U+FlQMU9ZeYUjPuiINCwjQAm218SP7X1phM+301BQRqACx5v79MutF
         6pmQ==
X-Gm-Message-State: APjAAAX0mgRjCTk2ycJvX3OEcn9meO7lhUnVhozQuAgW2FEgKFIryjAM
        pZ77QcwBYCxYetkPkUwK1g==
X-Google-Smtp-Source: APXvYqxBO2s0bITA6OG6AH3zySICfJe1C9JqVCrxGMZYitG5WUDwvDY61K0t3VoW18cim543C8iqSQ==
X-Received: by 2002:aa7:8c84:: with SMTP id p4mr17244133pfd.164.1554530780595;
        Fri, 05 Apr 2019 23:06:20 -0700 (PDT)
Received: from localhost ([210.160.217.71])
        by smtp.gmail.com with ESMTPSA id r11sm51782237pga.87.2019.04.05.23.06.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 23:06:19 -0700 (PDT)
Message-ID: <5ca841db.1c69fb81.42eb2.891d@mx.google.com>
Date:   Sat, 06 Apr 2019 01:06:15 -0500
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v8 1/2] dt-bindings: phy: Add documentation for mixel dphy
References: <cover.1554113192.git.agx@sigxcpu.org> <15b5adaeae3d5ab9020f98d067394a581522f6f4.1554113192.git.agx@sigxcpu.org>
In-Reply-To: <15b5adaeae3d5ab9020f98d067394a581522f6f4.1554113192.git.agx@sigxcpu.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>, Li Jun <jun.li@nxp.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
To:     =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  1 Apr 2019 12:13:35 +0200, =?UTF-8?q?Guido=20G=C3=BCnther?= wrote:
> Add support for the MIXEL DPHY IP as found on NXP's i.MX8MQ SoCs.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  .../bindings/phy/mixel,mipi-dsi-phy.txt       | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

