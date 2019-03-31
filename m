Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63FCC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA03A21873
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554014515;
	bh=3gItHPBr1si87K2467kpGscCl11mz+rRRp4XV1ES+5g=;
	h=Date:From:Subject:References:In-Reply-To:Cc:Cc:To:List-ID:From;
	b=wgGqJw1sEK3/wuioRtEIKQPxqKKxyQPyKz5h234jr+OQ6sf09NJKN4I1eqLMieD60
	 8Ba3UOFIGoEYE8U03krgA3R2vPrcWfLhqvQbtnKdugntIofjoPN+yUDmE9jRdb0SlP
	 jvQ4Tvwieb4Ornmg/cDqSSZL5rhSJ69+568RVp9I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731300AbfCaGly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 02:41:54 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38040 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfCaGlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 02:41:50 -0400
Received: by mail-pl1-f196.google.com with SMTP id g37so2931158plb.5;
        Sat, 30 Mar 2019 23:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:cc:to;
        bh=sgFc6uE0XsqlrZed6OMYcuIFTo1ZGmRUyoxq+EubJfs=;
        b=RRVc0GtMbksOXxqCh2PNnBOUoN7VuZFhFxdGuejKzhiuqjIai8B8dO6+FJYEwNbftN
         3dQ8UZRFlfFs5/zZjaUpYmt+ZJcRSw2BMNKcnh1mY4V0TqIa3iIpPQxQOH3zZRbEriHo
         ZVn9S+6jepilqlGE+WDNKZ2ErjMnCeB3dqYkIK9sxS4kC2zPCRBl8ONAPevYrkt/E14L
         pdghHVOvwqXQnwE39dXQEfQ/SWzMjPUt0pq+cdvoMKtL2mQKq9JJay4Frg1JS86M74Pa
         +aGfbq4icVgiz86P/gIgoTaYC+kRq+EzdXWxjWRLNsMShUuAFIRhPZPU/w4Hsed7mY7d
         nppQ==
X-Gm-Message-State: APjAAAUZeS14LEL5nHxDumpP8YYV9H4RTBkP5WXrOdqQM0jEiIEfYUzb
        MTyO5awv0/1TsZKw7n0h4w==
X-Google-Smtp-Source: APXvYqzrEThhPbhnirOCnsgTPqKYfsebpjhFZ4QUuZGzWxOV3nBokcR0YgqsQf5VD5iTgqN0lr4zfw==
X-Received: by 2002:a17:902:d211:: with SMTP id t17mr22652332ply.214.1554014509967;
        Sat, 30 Mar 2019 23:41:49 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with ESMTPSA id k26sm8759588pfo.111.2019.03.30.23.41.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 23:41:49 -0700 (PDT)
Message-ID: <5ca0612d.1c69fb81.96e6a.76a9@mx.google.com>
Date:   Sun, 31 Mar 2019 01:41:47 -0500
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: meson8b: export the video decoder clocks
References: <20190324151423.19063-1-martin.blumenstingl@googlemail.com> <20190324151423.19063-2-martin.blumenstingl@googlemail.com>
In-Reply-To: <20190324151423.19063-2-martin.blumenstingl@googlemail.com>
Cc:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org, mjourdan@baylibre.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Mar 2019 16:14:22 +0100, Martin Blumenstingl wrote:
> Export the four video decoder clocks so they can be used by the video
> decoder driver:
> - VDEC_1
> - VDEC_HCODEC
> - VDEC_2
> - VDEC_HEVC
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  include/dt-bindings/clock/meson8b-clkc.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

