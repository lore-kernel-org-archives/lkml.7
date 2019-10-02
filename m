Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C41C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEBFC21920
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570025968;
	bh=0zemGO/KuKaR5LumFGfvN7HxDXwToRTuIKQudn82vQ0=;
	h=Date:From:Subject:References:In-Reply-To:Cc:Cc:To:List-ID:From;
	b=WU1BvDIKsRqama9JcZ6mM9btErQ0rFr6ntg3aWEEOkA6OHeEl8GtpvEVQPmLDFOsL
	 jEuw50j7mYCHEaBL/KPMENvI76L8WGX8RZeVLEPluBrPRQOYoRfPc/PKyHMJZBS988
	 oi2wsSJk742WBHrPxZxnZZ+qqBTbBqSi/LYmPyG8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbfJBOT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 10:19:27 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36414 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbfJBOTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 10:19:18 -0400
Received: by mail-qk1-f193.google.com with SMTP id y189so15163247qkc.3;
        Wed, 02 Oct 2019 07:19:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:mime-version:content-transfer-encoding:cc:cc:to;
        bh=z8Shi7iPsdT4yk/0Roav1rVtwwblOxfkO9UncLfj12Q=;
        b=juoLBXr//RDsh5SpH+ki+XxcsqFx5ot3d4EMhdNGBsAdEPOnNl14x+mIeX3xMU8FIe
         I7dP03ewxhvfEsDxvFpGhTnD7YdP2J/gZUYui499Z+VWEPANcDVGMEoOOSgCBx/Mj+HT
         6JSsWTgQZnUi+SLOQRJyoec6e43OBAokZ3uVadHQf1sW/4Se3Jg6wjN6pMh/Eup7jn75
         IgQHNgZlwaB71ID1LUGBIaJRrYLv2x2/uTv0IKhaBDAhzFl0BBuDVKityS5qcWal76Kx
         SUCpSXWgab2cV8ZBzwvvBbdXEiVx24+ldlj+SgOYOFnFWPm9Ywc1FEb4dP9i5+aC45wy
         tUzQ==
X-Gm-Message-State: APjAAAXCMa+T6X8/1wG2ca8kQJZXu2Eu6kFdvJ/iH5Zdupm0mPSbxun7
        TGj8Vst1Pofi65tlUyyCVQ==
X-Google-Smtp-Source: APXvYqwX9sEGOCjd772Os8B5bxoO/qnVpokJm1RsuGpcikqc9bd2tVQI/70fY7iwbTBKnGQ7rUo9qg==
X-Received: by 2002:a37:68d3:: with SMTP id d202mr4045244qkc.62.1570025957013;
        Wed, 02 Oct 2019 07:19:17 -0700 (PDT)
Received: from localhost ([132.205.230.8])
        by smtp.gmail.com with ESMTPSA id x33sm10486592qtd.79.2019.10.02.07.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 07:19:16 -0700 (PDT)
Message-ID: <5d94b1e4.1c69fb81.63a32.683c@mx.google.com>
Date:   Wed, 02 Oct 2019 09:19:13 -0500
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 4/4] dt-bindings: pwm: mxs-pwm: Increase #pwm-cells
References: <20190923081348.6843-1-linux@rasmusvillemoes.dk> <20190923081348.6843-5-linux@rasmusvillemoes.dk>
In-Reply-To: <20190923081348.6843-5-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     devicetree@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Sep 2019 10:13:48 +0200, Rasmus Villemoes wrote:
> We need to increase the pwm-cells for the optional flags parameter, in
> order to implement support for polarity setting via DT.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  Documentation/devicetree/bindings/pwm/mxs-pwm.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

