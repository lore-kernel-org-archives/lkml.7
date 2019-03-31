Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA82C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A42220882
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554014628;
	bh=LDOAMkCDQzCABJY+q0dZ0XFTSULwIwiUkJcDbggiLDE=;
	h=Date:From:Subject:References:In-Reply-To:Cc:Cc:To:List-ID:From;
	b=c6ZUeQ1GPYx4Bi+DAp3oPGE3KS/X8E5yMAUnRLaWzS0dea8aMHBi1JDx3AYFHPtRr
	 9w0swIiD3890Qvd5woiQaqO1D8FZCS4nHu8wZwSjQM9385BtKelQ9zg77WMtOq5z8N
	 ThTeBgsvJYP0j9I3uuulIa7Td1vXHuaZkRsLD3PQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfCaGnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 02:43:46 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38037 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731265AbfCaGls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 02:41:48 -0400
Received: by mail-pl1-f195.google.com with SMTP id g37so2931137plb.5;
        Sat, 30 Mar 2019 23:41:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:cc:to;
        bh=8stkG2HqfVF6xNg5tRXaJQ0/Dizn3Nd32xCs772cOZM=;
        b=OonOzbOW0GPqxD5xPXeAjSkowrmSOY9YAAybcDExW82Ab91nM3FeKl1Swux2FbGIK8
         Gzi8biqxzdPN18j+R+RUIw/xKHAY1bYrMhfTw+i1ZB+oCraf9cyPWvz5uyEtq4PiQk1k
         Tdl9pQaXTIk4VR8zvGOWekvmZ9ERDGXDdD83qayvnxi3p+mx46eYlvYs9RS0/EDe3dJM
         FQjs2x7Igok52kX0gjPePGJUY7sBnVugOs8IA4ggcVOCEAUclOOSUyqOUwkaceAT1OUL
         bcPK26sAQBri6q6urdO9TN7TuXXtyIM3Hr+WcOBXYUmPD8ck8rzaXp8F5fpTAgiCHkj/
         G0GQ==
X-Gm-Message-State: APjAAAUyse21Fo20FUoBpVaqW+W+8hCUdz+AutCgCET/C+tu8NxbL4ih
        we85tFuZEcdLY2yl+YFK1A==
X-Google-Smtp-Source: APXvYqwozQYVPk8Fkon4b0p7OOBNRJwyFfHtg+jtrtreLRfwY6SYj9oAyrmTrA4+ZgN6aDWZfE+d8w==
X-Received: by 2002:a17:902:2947:: with SMTP id g65mr57595543plb.258.1554014507452;
        Sat, 30 Mar 2019 23:41:47 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with ESMTPSA id j6sm8593798pfe.107.2019.03.30.23.41.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 23:41:46 -0700 (PDT)
Message-ID: <5ca0612a.1c69fb81.9bbef.7249@mx.google.com>
Date:   Sun, 31 Mar 2019 01:41:45 -0500
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: clock: meson8b: export the VPU clock
References: <20190324151104.18397-1-martin.blumenstingl@googlemail.com> <20190324151104.18397-2-martin.blumenstingl@googlemail.com>
In-Reply-To: <20190324151104.18397-2-martin.blumenstingl@googlemail.com>
Cc:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Mar 2019 16:11:01 +0100, Martin Blumenstingl wrote:
> The VPU clock is an input the the "VPU" (Video Processing Unit), which is
> one of the components of the display controller.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  include/dt-bindings/clock/meson8b-clkc.h | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

