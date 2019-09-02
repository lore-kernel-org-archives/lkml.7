Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B4BC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 14:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA7621744
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 14:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567436121;
	bh=43o8eXnmLsvY775aO6i1KFugDuONJFiLug8mDOgoEb0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Cil1PDpi7ZQuQJ0k1O0NJqGOPRTrYhflQjqGhX5OXVqwma9y4hQthRqhwxKs6Q6ic
	 9JOFU7RprwuMqcC6x7Op0Sxw4MMlciwdRYddftPaJWF4VZKrbH6kLvA0M9HMI3dgBo
	 6T0Qc77Pjhhjw6z0Kp875RO4h9Xfx71S2JE6tDEg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731698AbfIBOzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 10:55:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42947 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730559AbfIBOzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 10:55:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id b16so14305870wrq.9;
        Mon, 02 Sep 2019 07:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=05naA+tRFr1oVP7UyroxrvoG5G6/VszoOUPqo59hvhc=;
        b=H0U6QMs0axwnl5sxwRXiPWipAAarGf4uyOts/CANRQwnqw1F/ivTZtH71lYY7hJNAN
         XFkMNRTF1vjJlOV/uOpe5BZ5B3uHp676SMYpjkis4hlGPjH2Gp+W4Aa6OgXkE07BrmUt
         5xaOSxsfXHsiltHNiov8NCfH3AYjIx51z+ZJ3wTh8ZBEHW7PeJ7BTm5kofdk0RKDdqB4
         Kzi+AsT+mcWSrM38U7oZzPEDewdxCRQFZbbif/3gz3hK8/4cWHaubf5EuaB8XAbhsxmY
         fC5OJutlEWd7ICbhdFK4K4xqVVXwNQ3HJEPSsZPSl7GiuJ7yT1w0zNkmzTDBxto/s1AA
         PBCA==
X-Gm-Message-State: APjAAAVfBVeoMO28QoREuweqRtoslP2ULm74CC6121keGhgjOlYE046g
        RtPnOFhZGH3IdZ6RA6wn+A==
X-Google-Smtp-Source: APXvYqyIDvYfiwAUsbogEBML9p8lY5maoaCIAtBAckCgpS3h5i2lNutbJF7IUlph/pRFUQtWBPP5xg==
X-Received: by 2002:adf:e947:: with SMTP id m7mr22629133wrn.178.1567436118161;
        Mon, 02 Sep 2019 07:55:18 -0700 (PDT)
Received: from localhost ([212.187.182.166])
        by smtp.gmail.com with ESMTPSA id a17sm16865787wmm.47.2019.09.02.07.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 07:55:17 -0700 (PDT)
Date:   Mon, 2 Sep 2019 15:55:17 +0100
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Nicolas Pitre <nico@linaro.org>,
        Sebastian Capella <sebcape@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 5/5] dt-bindings: arm: idle-states: Move exit-latency-us
 explanation
Message-ID: <20190902145517.GA18377@bogus>
References: <20190830150302.20551-1-geert+renesas@glider.be>
 <20190830150302.20551-6-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830150302.20551-6-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Aug 2019 17:03:02 +0200, Geert Uytterhoeven wrote:
> Move exit-latency-us explanation to exit-latency-us section.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/arm/idle-states.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks.

Rob
