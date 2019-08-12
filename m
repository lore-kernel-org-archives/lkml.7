Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFD8C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 22:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FB162054F
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 22:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565649996;
	bh=hLHV9fVasK4l+S4cL82UdIjZ+ye00hR11YOmWfhylXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=c22Movv7O6/3N4jgdI40b/9hdVwGF3kpdGH4l/WYPN2aNompdJG80mPhPKWerH3RJ
	 OMuZ/auT0AJOiZl3pXuHtHSBJhFHQaNJCcbkXe2vbOOtDFTD0jycT/YnGNXRr+LQaS
	 qwd/mLfbvTKfvvTteBbjzM/wq260FGPVBZY7QkzI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfHLWqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 18:46:35 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37184 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbfHLWqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 18:46:34 -0400
Received: by mail-ot1-f65.google.com with SMTP id f17so29896720otq.4;
        Mon, 12 Aug 2019 15:46:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KS0Ggk8/WnDOHf4y0WafUwtXAfrRj3bnVPQpHZODwE4=;
        b=QHoSayy4NpFioKOE8MZpp4eC2XYT0sDp52QUEDqsXkgBmQI8IGKxGRmJcTMxIrPg40
         tTQne/6wy033BsKgNqU6nQELNsl8wmmlc58EmOi2TpdiSu6HQOQylPR6MO7WceBIfJvB
         EwMS93uxLJgwbwpE0NvOT3F9jbsvrCrAd0y+zdIEYaFd2GtUnckyu18vuOM5bNPo2vZV
         LOsMqp3rHKXiUMaX5zTKnfHbACrSIfMVIW/EqozIYw1fNfjVpWohf5Gu+CNaSt39R/VG
         TfTzRSYUTSUm0mfj+12y1B1isvkfiPUbpTEcUCkZhtRJWrfugTqs2UpgvRyvWRndkwTq
         Rarg==
X-Gm-Message-State: APjAAAVp0K8nHtdaNetJ82CeWm6/Ytd9GcJe35dPWjaYZjJUR6VMztzO
        F8hWhnPS7Z1CT4NJDw3MtA==
X-Google-Smtp-Source: APXvYqw0DHsEGO4r5uXAMeKV/9aPKTqdrrYppFG758qnraHchXhK+sOX7jXcXCutn/8jBoF6ZW+NBg==
X-Received: by 2002:a6b:6012:: with SMTP id r18mr37836641iog.241.1565649993800;
        Mon, 12 Aug 2019 15:46:33 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id f1sm11650956ioh.73.2019.08.12.15.46.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 15:46:33 -0700 (PDT)
Date:   Mon, 12 Aug 2019 16:46:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, jic23@kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        baylibre-upstreaming@groups.io, dmitry.torokhov@gmail.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: Add pixart vendor
Message-ID: <20190812224632.GA12010@bogus>
References: <20190713080455.17513-1-amergnat@baylibre.com>
 <20190713080455.17513-2-amergnat@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190713080455.17513-2-amergnat@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Jul 2019 10:04:53 +0200, Alexandre Mergnat wrote:
> PixArt Imaging Inc. is expertized in CMOS image sensors (CIS),
> capacitive touch controllers and related imaging application development.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
