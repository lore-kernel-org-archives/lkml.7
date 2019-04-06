Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2CFC10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 06:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AF2821855
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 06:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554530767;
	bh=V3JDASwA3uA0SmDtkeNQDjsbk4VMoPvB84mZ7puXPx4=;
	h=Date:From:Subject:References:In-Reply-To:Cc:Cc:To:List-ID:From;
	b=1PJceuZqiO9iURBbOkDFzMUVlq+A4reI18yJRc/KqWT0L+Q7Fswkf/u6EWVn7aTFS
	 mEMzl8WJ9hOrTk6zNUwx03Em78JPjc2z6lohbs8I1KW4YTki/yWgZO/CqRFbYmpuuf
	 bRQ1CMc5x4ghBVTydKQ7MSCu8btIbXVgR0ZmJpiI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfDFGGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 02:06:06 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33506 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfDFGGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 02:06:05 -0400
Received: by mail-pf1-f195.google.com with SMTP id i19so4466969pfd.0;
        Fri, 05 Apr 2019 23:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:cc:to;
        bh=VAkylfrTfbz0gEMoItcRn+k4XynHeD1zMiHLwsyJDgI=;
        b=Z+aZnMGGEl4sJwpqPG6rOkwv9kMjm1ychUm7v3LdsYFJFCwAxL4WaDtPD7Pf60qYoQ
         Hkj7QkhdzK+Bc6TZgno4qOkB5uqbMW6LQKrArpSVANzn/G1kYrPVvBAPVKyfWJcMg0vH
         H6+H9dUqjEfGPfhTUBx5rrMOth19znUvf2IxlEOVXa577gmwCrnmAYvK1SySP8PYRu1L
         x0gGaCs31a1F2UIlK6ehFbVEDXN5VI7FNFCFhSeDQM8l4bG4KpNttlhijFDLNTZqJatF
         l/LME4hGB6S1A74MxKayUVYUF/qd5gMAsXxXXIsoh6dIdN2dgSYTSwEc78B39HeTYzUc
         RMOA==
X-Gm-Message-State: APjAAAUp2YE0rh3NJXiUt6Wckr8npF2BYo4aBid/cZq0LN9K2YEHWfyt
        ACGQMysux7SBuywkRcYKqw==
X-Google-Smtp-Source: APXvYqzEtoiaZorg6Vug9oQQWAo06dY1h91+gEQri+uXod6cEp5HQ77OyHR7HfzJHZu0sH62bMxhMQ==
X-Received: by 2002:a63:30c5:: with SMTP id w188mr16073522pgw.76.1554530764294;
        Fri, 05 Apr 2019 23:06:04 -0700 (PDT)
Received: from localhost ([210.160.217.71])
        by smtp.gmail.com with ESMTPSA id c25sm34275279pfo.69.2019.04.05.23.06.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 23:06:03 -0700 (PDT)
Message-ID: <5ca841cb.1c69fb81.d3339.9abd@mx.google.com>
Date:   Sat, 06 Apr 2019 01:06:01 -0500
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v1 2/3] dt-bindings: rockchip-thermal: Support the PX30 SoC compatible
References: <1554100985-11385-1-git-send-email-zhangqing@rock-chips.com> <1554100985-11385-3-git-send-email-zhangqing@rock-chips.com>
In-Reply-To: <1554100985-11385-3-git-send-email-zhangqing@rock-chips.com>
Cc:     heiko@sntech.de
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com,
        Elaine Zhang <zhangqing@rock-chips.com>
To:     Elaine Zhang <zhangqing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  1 Apr 2019 14:43:04 +0800, Elaine Zhang wrote:
> Add a new compatible for thermal founding on PX30 SoCs.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/thermal/rockchip-thermal.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

