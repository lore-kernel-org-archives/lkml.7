Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC23C00454
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 22:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28DE42253D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 22:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576276143;
	bh=HumsUb6DngHZZwIY+Pmk7uXnoAcbgXP5tQbgOUftgic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2CcSacrnifjodC+GTC08TGhz+dbwBnsqJb3FRCSN5ys1qocLq7zcqSDh4ardFBnAI
	 IrQBdxnZ7iUOJSZ+Jzk+vBkeV8EWHY2jua5cK//62DbqgqWP1svPRx7avPs3DhQVAq
	 Ld72xdFTAslGJEe+yHA7CY8ypoXevSXwI/BuQnNo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfLMW3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 17:29:02 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40637 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfLMW3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 17:29:02 -0500
Received: by mail-ot1-f66.google.com with SMTP id i15so869667oto.7;
        Fri, 13 Dec 2019 14:29:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=k6DJOU33upCsVwOlbVPH1O+wtZeZ93iLBWJzQBVEX30=;
        b=YlFQW4bEMrHOqgrNVtGnn2PZVXqxjSrr3rOsqVFxpegU8ZPRa0bNsBx90k6ty0PJeD
         lHSWP8xhtcB0CBKBhDsf5dU53J2Kwpd+nVXcduFljfes/+piZ3sM4jxfiTZWuAk0CyIE
         jSn0avfDP5AxkT6828L+I2OsO5rwaJ96b5A9VZ3E6XkP87F0mczJqwPL2epQ8AqLNcfG
         4qfiRvCAcOk+zRR40w8QcIs64dm+qhmv7M1kTbyLrZfbklIxXKiYPxkB/JIbDTwneO3Z
         ZouZ4r2A7TFhgLwJn5sshvj5/7qTfz/xyPCa3Z55yiLd4Obdua9th0kBT7FHbteWvl81
         0mXQ==
X-Gm-Message-State: APjAAAUPQu8cBhoNg9smpJ6017RmcfN18Z2H+pzIm8PN9GV+Pc0wwJK8
        n/1LvqVDpzSth6UfSeIU/Q==
X-Google-Smtp-Source: APXvYqy4E7eJGU7hZLAl6o9sR/e9LBUygUfvXqQC5vCF8XGIxUdSSAU0iQU4uChZ13ru2IYjDxLo2A==
X-Received: by 2002:a9d:74d8:: with SMTP id a24mr18149054otl.100.1576276141090;
        Fri, 13 Dec 2019 14:29:01 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x15sm3807109otq.30.2019.12.13.14.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 14:29:00 -0800 (PST)
Date:   Fri, 13 Dec 2019 16:29:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     linux-realtek-soc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 8/9] dt-bindings: arm: realtek: Add Realtek Lion Skin
 EVB
Message-ID: <20191213222900.GA7876@bogus>
References: <20191202102910.26916-1-afaerber@suse.de>
 <20191202102910.26916-9-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191202102910.26916-9-afaerber@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  2 Dec 2019 11:29:09 +0100, =?UTF-8?q?Andreas=20F=C3=A4rber?= wrote:
> Define a compatible string for Realtek RTD1395 Lion Skin eval board.
> 
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>  v2: New
>  
>  Documentation/devicetree/bindings/arm/realtek.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
