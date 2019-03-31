Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A63C3E8A3
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8908D20882
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554014439;
	bh=7Q1sIJ+HSD/avwXU7gkws799CtUK6hNq66H/2G2NPD8=;
	h=Date:From:Subject:References:In-Reply-To:Cc:Cc:To:List-ID:From;
	b=xeQct1N+RPHAvYBODbm0ptQ0sFuTzRTnlN8/YZlpI3MraZD2gTfS9zzUIcwxhWq39
	 zS9caneUd7Ou3CghImXcRbr1fNbdcNtZcW/1LeIs31hK38xet4pRuA0vRFaAeSjbwk
	 KriQOcCtYnW1HzoQUgcDxwLdpxbkO1j5Bgjz5Q9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfCaGki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 02:40:38 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45352 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbfCaGke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 02:40:34 -0400
Received: by mail-pl1-f193.google.com with SMTP id bf11so2918674plb.12;
        Sat, 30 Mar 2019 23:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:cc:to;
        bh=fhurChVOjxYm5GpP7Zr9zAYKclR5rDuewkb+9pAweUM=;
        b=s/u3kvh/GBjKMqfKRpGz3XIQ24fD5rX1iXpcqPBjIQJaWZVZIhIvprFIMV2h+1Hv0c
         o7FxP/VY4z5Mk6XWjiY7xCnXZOB5xDdGV3jojCqsYXpF017sijwQoEJ2WijjZanB5TZc
         tlDxftA68bTa0Qrcfnxwdi4X9OBj/4XyPTp5wC5qruhhXNH+tWoUwU/pFzhTgL0wpp5Q
         s3nMOAqlxjJDoP5STiCEhgsKaXpaDvL6gcjTUbxyBFDcOVE7c2Ka24q4wZoawiNee57L
         Nq+DAfsz5MkmSj+OpFsjIQKVNPsfbWvvWCx68yb/pwBXRAFWhJI6vPvYT6Mbgx1uvkWq
         78RQ==
X-Gm-Message-State: APjAAAWzdSbabfLof/R5fb4VaZf6AIq3jun80Og3OTv5v19/E9UEFPrC
        VXqD6uDbOgqmb9b+80FENGGCeQYOvQ==
X-Google-Smtp-Source: APXvYqw9iljcI8/Bu79YiOeRNIMziMvlbWP7l9y/+8+gxK1ZrB4EO3xFJst6LtssQySP3LRgzS1gmQ==
X-Received: by 2002:a17:902:6aca:: with SMTP id i10mr57222982plt.43.1554014433710;
        Sat, 30 Mar 2019 23:40:33 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with ESMTPSA id 4sm7886615pgx.68.2019.03.30.23.40.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 23:40:33 -0700 (PDT)
Message-ID: <5ca060e1.1c69fb81.ce85d.55f2@mx.google.com>
Date:   Sun, 31 Mar 2019 01:40:31 -0500
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: gpu: mali-midgard: Add resets property
References: <20190315135655.28359-1-narmstrong@baylibre.com> <20190315135655.28359-2-narmstrong@baylibre.com>
In-Reply-To: <20190315135655.28359-2-narmstrong@baylibre.com>
Cc:     devicetree@vger.kernel.org, khilman@baylibre.com, icenowy@aosc.io
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Neil Armstrong <narmstrong@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2019 14:56:54 +0100, Neil Armstrong wrote:
> The Amlogic ARM Mali Midgard requires reset controls to power on and
> software reset the GPU, adds these as optional in the bindings.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../devicetree/bindings/gpu/arm,mali-midgard.txt   | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

