Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF73C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 20:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 376E62171F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 20:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568750899;
	bh=0gnn8xS+QQzHPckFH1l+WH7Q6WWdI1641INxLNjxbsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OKL6H/Eqbs8E92NeNY0jm5nUJjNZt6b70KKIG63i+2v9fBodoZyEa9r5Jykq/ASr6
	 n17JnEscbf/uKZUPNASWApu6mWfaS7PeBvat7LAHA+OeBnA+q2OCXb136paErsxvBq
	 8rsT3M+sLXkXEBW87y27UEpIRbmejemUXEZcOx0M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbfIQUIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 16:08:18 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38095 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbfIQUIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 16:08:18 -0400
Received: by mail-oi1-f195.google.com with SMTP id 7so4014345oip.5;
        Tue, 17 Sep 2019 13:08:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hogc/92S8/u/DUogFIB6MZH6mO5Gji1BbREYssF21ZI=;
        b=f8FjVTlDwxI4rxUpP/iT+21WbETKApCKdqaRiR+jSY+phmxh0MXtaYQwEMayynCtMa
         M3jme15ApErHzXQAwyb0x66jyOmYOm3dCBN/s4EFatgeHGYy/CJ0jymfqBXlUj1Pb8gL
         XQrgxDhCeO4vaD0P5KJMVMUSBYuZQemrr6IVf+sHW5aPBLaX6YHzN4BbkcPDejWvCKWe
         GYUSV/cZ23Fe6+f4p9eUFFyeKOJahnCO2i50qSc5an5bNM9WjTQlxKHj/t693RE1fQld
         BXn4p6rbVrnHBF7yQFeuSzMrsjuX/4A+uRDpbNT09M9oNOemHJ9BVsMpnQubcR09vthO
         RSRQ==
X-Gm-Message-State: APjAAAVePGEFZKVXK94lVVXENUuK/O7zfMmA+GvXBIt1RAVthXHawuoE
        MtSosYM2JuX4dmfCtih6xg==
X-Google-Smtp-Source: APXvYqzFGTenJyiV9FyX5Dm5tzOndO9FlAzGE1mpSP3LOGeYCu62xyqYJaDeLNgqxRiN0ELUJbqGsQ==
X-Received: by 2002:a05:6808:302:: with SMTP id i2mr3244340oie.176.1568750897306;
        Tue, 17 Sep 2019 13:08:17 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i17sm994400oii.3.2019.09.17.13.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 13:08:16 -0700 (PDT)
Date:   Tue, 17 Sep 2019 15:08:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Maciej Falkowski <m.falkowski@samsung.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        mark.rutland@arm.com, krzk@kernel.org, a.hajda@samsung.com,
        m.szyprowski@samsung.com, m.falkowski@samsung.com
Subject: Re: [PATCH v3] dt-bindings: gpu: Convert Samsung Image Rotator to
  dt-schema
Message-ID: <20190917200816.GA10224@bogus>
References: <20190913062945.GA10283@pi3>
 <CGME20190917103758eucas1p10793e499209137630681186a10a4b7bd@eucas1p1.samsung.com>
 <20190917103727.14997-1-m.falkowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917103727.14997-1-m.falkowski@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Sep 2019 12:37:27 +0200, Maciej Falkowski wrote:
> Convert Samsung Image Rotator to newer dt-schema format.
> 
> Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> v3:
> - remove unneded comments and descriptions
> - remove unneded maxItems field from clock-names property
> ---
>  .../bindings/gpu/samsung-rotator.txt          | 28 -----------
>  .../bindings/gpu/samsung-rotator.yaml         | 48 +++++++++++++++++++
>  2 files changed, 48 insertions(+), 28 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/gpu/samsung-rotator.txt
>  create mode 100644 Documentation/devicetree/bindings/gpu/samsung-rotator.yaml
> 

Applied, thanks.

Rob
