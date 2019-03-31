Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A101DC10F06
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E9FA21873
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554014455;
	bh=qcAvDLbUkgVE3OVlc0QB6tI6RFxOKpYNX2NzFoJldwU=;
	h=Date:From:Subject:References:In-Reply-To:Cc:Cc:To:List-ID:From;
	b=xIF6nIDmBpD3WMNUNjZIhJAzfshRcmXg+zI8CUeo64VOHBCDuuOGgn8eHmf4jchvw
	 6ddN4fhyZ/X2c37xRGMb0zeICv26IfnM/+2h+v+ns9xgB3by7k9fdH8vQEnRP/c28B
	 97+FKWe/CH5I5Wn+cPbPif1F+BpkMH+SktVu7wK4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfCaGky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 02:40:54 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39898 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfCaGkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 02:40:53 -0400
Received: by mail-pl1-f196.google.com with SMTP id b65so2931017plb.6;
        Sat, 30 Mar 2019 23:40:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:cc:to;
        bh=HFZEx2jg2T33GoHe9R1FwMUeV+jh/KdgivL2e+0YQw0=;
        b=dy8FKXIbljtcd85KgXn4BeFje87aXqBSo6Hff17yBnqLYRC/vygC6euBX1pdrwlTV5
         d+4PiPfgbqqGKb9gmSX9/JAGAlrhcUmYbN8q8wlVlumyGySnnMu7/w8GyYpbLlZYkhHY
         FV0sPpWY7fVcwdhAoT36kYmsNmwfrRPSTmDEwngQDtAkdUdMniqR09hpLDAU7ZlmALFH
         kMdbbGw6ELCLqwrApG/YdHMU5iEMtv7Wvm5gkZF8D/RiiW/0CjgShq7X+sktK+acZjwQ
         99/S8gZd9Kk6H7sFYzlhlE6SEuHDxiiO1MTICnNu1bmDJMywHra6y2qHQFO6eYqdoZTK
         0cmg==
X-Gm-Message-State: APjAAAXShhdZe0YaaZZlTLhwWzZrakPBLRkyLJsHJHKJuXA/HrlpUl+I
        bQBJ0Jo2F+P3JU0DEje9TQ==
X-Google-Smtp-Source: APXvYqxLT2MKs39nII6bnd+8oSUX8kRAGImM5WtOOFXZw5FNM9MQpFsJeXOEBoMVeJVulRMjvMS0Tg==
X-Received: by 2002:a17:902:26f:: with SMTP id 102mr56837399plc.175.1554014452669;
        Sat, 30 Mar 2019 23:40:52 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with ESMTPSA id 4sm7887541pgx.68.2019.03.30.23.40.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 23:40:52 -0700 (PDT)
Message-ID: <5ca060f4.1c69fb81.ce85d.55f9@mx.google.com>
Date:   Sun, 31 Mar 2019 01:40:50 -0500
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: clk: g12a-clkc: add VDEC clock IDs
References: <20190319101138.27520-1-mjourdan@baylibre.com> <20190319101138.27520-2-mjourdan@baylibre.com>
In-Reply-To: <20190319101138.27520-2-mjourdan@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org
Cc:     Maxime Jourdan <mjourdan@baylibre.com>, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Maxime Jourdan <mjourdan@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2019 11:11:37 +0100, Maxime Jourdan wrote:
> Expose the three clocks related to the video decoder.
> 
> Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
> ---
>  include/dt-bindings/clock/g12a-clkc.h | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

