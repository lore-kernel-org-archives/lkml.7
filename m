Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A5EC10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 06:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8570C21855
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 06:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554530828;
	bh=7OsnDdsa2tqdAHHDH16l+ccwRV2cGkVkMfes1c2rFE4=;
	h=Date:From:Subject:References:In-Reply-To:Cc:CC:To:List-ID:From;
	b=ew2UOZk4o0HlO7tm8nQk9ov1f8MXGuVk+nM6tY1JQE6P51FzqA4p/+g1ro1ml46vt
	 EU7nyfLEhZRDDZewrASiSj59GU7qq/0HMLtABInLGC3rvDox81ex4A4xHmwX/N8k4t
	 OxzkxIL2a0d0U0cGJz+U8e5oOt66QgHdyKAx4LbU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfDFGHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 02:07:06 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42762 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfDFGHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 02:07:05 -0400
Received: by mail-pg1-f195.google.com with SMTP id p6so4190540pgh.9;
        Fri, 05 Apr 2019 23:07:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:cc:to;
        bh=c9p0P+9nydJyt6OGWdToERfalG5+pKDaHfFxQbmZ9ko=;
        b=ocz2GNHkf3ovbRo7TdKmriWiehGUY10A5lTZoO20t2bKeL6e/YiK7VULGf4crU+x8y
         tej7wZqKmhIokZRBmFWlmV0TYZeLKUUhlh1ZJA41ks/WpYpILNok89C6gvRCmqnMNhE3
         1qX6kWhUlSzvROwGyOplV4c1BkUBMZc0+3vNuGpCSIdilTlFIiVvirvWb7UXalbpkt+6
         QfZq6ffiqfcO12spD3v94wvdhf020wrrh9dVDaJ7AaxqWlm2CS4ip36tfzA1oe5KKrJJ
         0uqsia4QcHUcVO8+CzUUgoQc5pavkZStUCQuGUOwo8bg5qsJPNUxBp0QjZnbRR783gi4
         bX3g==
X-Gm-Message-State: APjAAAWXbk9IKN7vJ9wzbbMXkPiNOqgqhaHK+soBE+vq16yVAUuZpjvd
        ivzBs4CTtbxf3lLtM4t7Ew==
X-Google-Smtp-Source: APXvYqzFP/JBTB8umGYnxP1PQ5m34pzBxEFT+WoqtZsQ7l89nmFuu4v19+5wRfiKLBBeOpLvieElGw==
X-Received: by 2002:a63:3281:: with SMTP id y123mr9451577pgy.272.1554530824228;
        Fri, 05 Apr 2019 23:07:04 -0700 (PDT)
Received: from localhost ([210.160.217.71])
        by smtp.gmail.com with ESMTPSA id t82sm67560937pfa.153.2019.04.05.23.07.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 23:07:03 -0700 (PDT)
Message-ID: <5ca84207.1c69fb81.eee15.9249@mx.google.com>
Date:   Sat, 06 Apr 2019 01:07:01 -0500
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: timer: Add binding doc for nxp system  counter timer
References: <1554287101-16189-1-git-send-email-ping.bai@nxp.com>
In-Reply-To: <1554287101-16189-1-git-send-email-ping.bai@nxp.com>
Cc:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
To:     Jacky Bai <ping.bai@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Apr 2019 10:20:25 +0000, Jacky Bai wrote:
> From: Bai Ping <ping.bai@nxp.com>
> 
> Add the binding doc for nxp system counter timer module.
> 
> Signed-off-by: Bai Ping <ping.bai@nxp.com>
> ---
> change v1->v2
>  - remove the blank line at EOF
> change v2->v3
>  - update the binding example based on the driver change
> ---
>  .../devicetree/bindings/timer/nxp,sysctr-timer.txt | 25 ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/nxp,sysctr-timer.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

