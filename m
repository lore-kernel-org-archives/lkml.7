Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634D3C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 314BA20882
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554014563;
	bh=PSs4d4RaMNbOXANPVnhjl99H+d33KG15rcs0gdsYJCU=;
	h=Date:From:Subject:References:In-Reply-To:Cc:Cc:To:List-ID:From;
	b=FgYyA1xeu3qn+QePih0wnoZRVahhn3N91FhOQqh/dgneiWzx8w0612aQ+deWMfzYD
	 qZpwQ9980SJdiWhr81bV4iPx8s8jX9qIlXLIhQ/UDXllKDKC7N1kc4QeJlIw8HX2Ug
	 Ta/sx7rjAx5v1d5r6HF7HMG+u18CiTtWZDD4CxcY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731555AbfCaGmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 02:42:42 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38226 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731500AbfCaGmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 02:42:39 -0400
Received: by mail-pg1-f196.google.com with SMTP id j26so3162795pgl.5;
        Sat, 30 Mar 2019 23:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:cc:to;
        bh=T99fg7hIA02EvGKo9Wat0eXhYCvR45zHh4Mkme07iag=;
        b=P4BKzAWYqSMKd9bWiv35iNqzs+MWMbh+IsOBf2oGAQQtJal8OL/0n1gqRJFlbtlF3p
         kcN9QtIrm2YyOMcDjwy2VK/l3xL8LevYPsZQwQiRwBO0aInYLawgFRfT+GjvLBoshVPN
         q/lreoEC1yMf8K73bxzhUrUAirrHR/dHurLJNMqe85urqazPzNj6aI214KkpBxabIhF6
         epO8Si1rWtx3KUzi8SH7XmXGMpNpI1Wu7MeEyNne8lt3Cx+tlOqNKBD1XtN+GEZFhjvK
         KXoBCW6JOsq5VVT4bBUFcy/94AyKhiyHydGSpDI0FVkDEXjr/6veqSf10S4DnUVi3Ac/
         i5kw==
X-Gm-Message-State: APjAAAXSYqPsoCCpATjaiWHcUmhn4Uk7SdaJFun04CTfDG2ze7hMAKEF
        BuyEmq4ICcq8bQ4D5El/nA==
X-Google-Smtp-Source: APXvYqxTgjjqz7xInefH6M1TaQ2+nlWkssNwbTWc9fBMZeYTs6YV3AC1OIS2pXDTYEUIQ4OmoXkfsw==
X-Received: by 2002:a63:2158:: with SMTP id s24mr45677421pgm.156.1554014558741;
        Sat, 30 Mar 2019 23:42:38 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with ESMTPSA id e184sm10391210pfc.143.2019.03.30.23.42.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 23:42:38 -0700 (PDT)
Message-ID: <5ca0615e.1c69fb81.5f157.ab16@mx.google.com>
Date:   Sun, 31 Mar 2019 01:42:35 -0500
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH RFC 4/6] dt-bindings: arm: amlogic: add G12B bindings
References: <20190327103308.25058-1-narmstrong@baylibre.com> <20190327103308.25058-5-narmstrong@baylibre.com>
In-Reply-To: <20190327103308.25058-5-narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Neil Armstrong <narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2019 11:33:06 +0100, Neil Armstrong wrote:
> Add compatible for the Amlogic G12B SoC, sharing most of the
> features and architecture with the G12A SoC.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

