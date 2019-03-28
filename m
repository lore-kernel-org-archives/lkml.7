Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDEFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4736121773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553787604;
	bh=NsihYf+yMz8SpRXApB0dPN4lowkmOaDaTCieioeq5lQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dNJw13djWpxqEGY73e/4kn7INz6it+HR5VvS6s0e8PvQkXD5WfRJ3i5Tz7JU0xb7C
	 RqZAlzHEGGc7FL6nkMoK1bTQsWdhl2Z98qsgpTC5qeeN5VF5Sb/rFMUg3KWupm8w4C
	 JKKjGfR2C/L7GQ9bQh9zf6oCVyZAVgtBx5fETI6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbfC1PkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:40:02 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33922 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727500AbfC1Pj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:39:59 -0400
Received: by mail-oi1-f194.google.com with SMTP id v10so11772059oib.1;
        Thu, 28 Mar 2019 08:39:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ri9Pm5BJRuOYq/6NE1xkJMaLmBJuhc7suU9HKn1iKDE=;
        b=pbazpH3t5n6hEydjs+HONgQO5i+rI5P0jMKu61ViwBPJ3VG/fGSbO9qZNJS5h8WFYF
         B9WEzpY9I1CUwd9X+gXGvRDJrdGnDk120BqPWe1WGQS/QH6+hygK2cBKKpV0UKwQqDnQ
         XYyemMEQe8KrKnkRG1UW8xLg6uBGaPnA5ywLo8zKg9WeHe3BL9JMmZNwNPLW7WVfoiz0
         /bPVBs0BGyWdgg0x1eSUbT/ViQ4HYu2cUyRCm7M/z1ivvhQvnbrtP8FxG3kCsZBAw1FK
         QRos7mw0ytbiI/FpcV3ofo9Z2bsNNv211bYPBoADib+1iU3zVLGfhJXMeNQjsBnWIxiy
         YluA==
X-Gm-Message-State: APjAAAU5uhTB/e2jxY8Qboo7twZy9XGE8nyGFDF88rI058lEyccdfriV
        SRO9jDn+xyIGFrw9T4tYBuAcne8=
X-Google-Smtp-Source: APXvYqz5QhojS13/NgeJTzlyn8YHb6gwfUVws2OW4Djqfql+9C+DsqnLuJn9IgoJyVHFDPJ9iKT5oQ==
X-Received: by 2002:aca:e74d:: with SMTP id e74mr475155oih.36.1553787598283;
        Thu, 28 Mar 2019 08:39:58 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k73sm11823236otk.14.2019.03.28.08.39.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 08:39:57 -0700 (PDT)
Date:   Thu, 28 Mar 2019 10:39:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 2/5] dt-bindings: display: Add GiantPlus GPM940B0
 panel documentation
Message-ID: <20190328153957.GA20720@bogus>
References: <20190314122622.7597-1-paul@crapouillou.net>
 <20190314122622.7597-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190314122622.7597-2-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Mar 2019 13:26:19 +0100, Paul Cercueil wrote:
> The GPM940B0 is a 3.0" 320x240 24-bit TFT LCD panel.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>     v2: New patch
> 
>  .../devicetree/bindings/display/panel/giantplus,gpm940b0.txt | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/giantplus,gpm940b0.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
