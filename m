Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA34AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 19:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE54218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 19:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551383544;
	bh=OF961FnBEvc5xaC/Ha+sbvVq9dakfXU1kRIGQBYHO/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ixYghGpbwpGHVR9NC5VzgNmUdOWzpkaJNj2odh5DQR4JISTebbu/Tie8ODUmkodF0
	 5EaClvXsuMxjZJLcuYS3bSdwVu6EOm55SYm8U4q7dC2ch5VERAM/PBJFTPpVlVaBkj
	 wrpfUXfhgGjTZY5NPVk9jexle8CTUGEgqpui8buo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733050AbfB1TwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 14:52:23 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44276 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfB1TwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 14:52:22 -0500
Received: by mail-oi1-f193.google.com with SMTP id a81so17487591oii.11;
        Thu, 28 Feb 2019 11:52:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hil03hV0I+aHnfitrTLvjkcXNHA4tENUSQmRBq8VIik=;
        b=WCESRJZouvGV4pyEpcMRd8EKRyUsP9rTiy5hvmp/c5j1vMYfvU4+Z96AB91AQBQOoi
         nuUA43PzdjmQd17W2bWPQN4DOyyHBUJfi2dlfubfkAc55CNAtU8fJOtbsbR2k4qx34Vo
         Xag10JwZ/nmDDz5DQFkJ45thsI5UggwwFO4PF9RgnoGiwGE/gG+USXBJdRyrGQDmovxP
         /hxKki7yHDiefgBhhcD8rEF9tuXPuWqljPhu7MMmvVE5Tf1Y6D6CFgeCy41BJ5WFc9yS
         NlI1Y2bgKIfP5LWUUsvSFfi3i4LhlBfLa9HaHbZTiMx0s9jGwezezt9DtnJ5RRjFHFPc
         Iv0A==
X-Gm-Message-State: AHQUAubxdRvaa890y9awVisoJVeWOS1T/0wNO+45ksqflR+b3IE/zMSc
        1EuzDCDJ258ME6HP4gJq3g==
X-Google-Smtp-Source: AHgI3IZkPGaUxjf5/oFjeH0EqARP/ypphs0Qq+KEpHQPsvrhbL8kmAL40SrN1Wqepmip4DlmIMABSQ==
X-Received: by 2002:aca:adcb:: with SMTP id w194mr880818oie.97.1551383541874;
        Thu, 28 Feb 2019 11:52:21 -0800 (PST)
Received: from localhost ([2607:fb90:20de:307f:59ce:35b2:628:2365])
        by smtp.gmail.com with ESMTPSA id b20sm7864936otl.55.2019.02.28.11.52.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 11:52:21 -0800 (PST)
Date:   Thu, 28 Feb 2019 13:52:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com, robh+dt@kernel.org,
        mark.rutland@arm.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        baolin.wang@linaro.org, broonie@kernel.org, lanqing.liu@unisoc.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/5] dt-bindings: serial: sprd: Add clocks and
 clocks-names properties
Message-ID: <20190228195219.GA12933@bogus>
References: <cover.1550560916.git.baolin.wang@linaro.org>
 <c2b4db380c044bebe9fdf546b8a9f3aa351c6867.1550560916.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2b4db380c044bebe9fdf546b8a9f3aa351c6867.1550560916.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2019 15:31:12 +0800, Baolin Wang wrote:
> From: Lanqing Liu <lanqing.liu@unisoc.com>
> 
> This patch adds clocks and clocks-names properties, which are used to do
> power management for our UART driver.
> 
> Signed-off-by: Lanqing Liu <lanqing.liu@unisoc.com>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  .../devicetree/bindings/serial/sprd-uart.txt       |   11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
