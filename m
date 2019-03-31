Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398B3C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB3FF20882
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554014451;
	bh=PEl1NvFkPcYFBPtApmYZblvoZN+tncC8Sij1b+mDtg0=;
	h=Date:From:Subject:References:In-Reply-To:Cc:Cc:To:List-ID:From;
	b=eLKKVUKS7H9ad3mcZnurt5LCJ0eyDMdweyGQr2W08odqXxHTspaW6JfdMeRMERZYA
	 fLyIcL/2YSBm7dqcwjkRsALH8qFe6X61aC6C5kWwKVZ48t9MQCZktCXNmnngWIMwsf
	 vAuWhjSxpIdAiMfxphhKUbZfop2IlNkvE8FUQaw4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfCaGkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 02:40:49 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38138 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfCaGkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 02:40:46 -0400
Received: by mail-pg1-f193.google.com with SMTP id j26so3161800pgl.5;
        Sat, 30 Mar 2019 23:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:cc:to;
        bh=41Zqk7TrCmg2eU2nhcgiSZ1EhWAs70uu4WuG+aQfBBw=;
        b=H4xmklojAyavDvXnkkDlUAbvI2brs0n3Kg6VkkUxkkUGbLh3KMxsxJ7PHGCAAzOF3G
         38R4O/5MM1O4hegaPnE8pFXM3XSyMID/znVu69TmzfOjPLFvuVH2IJGQKoEQx1wbyUPX
         Poy6kOxkLcsTZg0Rj9B6J35fLhBSjPDxJ5mlloI7tFw8bzsRJhH/UsYnqEXoKroVua7D
         PWyoTblXYDaDR+7iNXE44bwAnByWipqZQiKMzl8xtC6qFyW8S8Ji7jerooB+w0nHOL1T
         j6mwUKuMcQYBhp4ECnYYi7i9jxRlyB/gZeoTksx8GLSGxBF6EhxAV+aoJy3ErfQRuUaZ
         oPMA==
X-Gm-Message-State: APjAAAWxLQR30LPQAa1VXAgbfI/tsXQyiVY/lprbhsiOayppUVPG3LEg
        gNYJBuw7WQmDh70Sn5DF1w==
X-Google-Smtp-Source: APXvYqzSY0qFQ1TOms8oNWPBc3GxJKGwwXltqnaU1JTnIz/sukYYeUQ0qUoopZCf+ROiflXeJQNG3w==
X-Received: by 2002:a63:bd52:: with SMTP id d18mr30291735pgp.52.1554014445380;
        Sat, 30 Mar 2019 23:40:45 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with ESMTPSA id p17sm9693873pfn.157.2019.03.30.23.40.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 23:40:44 -0700 (PDT)
Message-ID: <5ca060ec.1c69fb81.fbdbb.9da4@mx.google.com>
Date:   Sun, 31 Mar 2019 01:40:43 -0500
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v1 1/6] dt-bindings: gpu: mali-utgard: add hisilicon,hi6220-mali compatible
References: <1552937931-23050-1-git-send-email-peter.griffin@linaro.org> <1552937931-23050-2-git-send-email-peter.griffin@linaro.org>
In-Reply-To: <1552937931-23050-2-git-send-email-peter.griffin@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        mark.rutland@arm.com, p.zabel@pengutronix.de, xuwei5@hisilicon.com,
        mturquette@baylibre.com, sboyd@kernel.org
Cc:     john.stultz@linaro.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        yuq825@gmail.com
To:     Peter Griffin <peter.griffin@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Mar 2019 19:38:46 +0000, Peter Griffin wrote:
> The Hisilicon hi6220 uses a Mali-450MP4 with 4 PPs, so add
> a compatible for it.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

