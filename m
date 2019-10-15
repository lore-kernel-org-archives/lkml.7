Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8166ECE58F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B85D72084B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571159451;
	bh=mDEtXLSoQfNWU7CmHmgTRDGBYS6McxGZnZilTrAP4ls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ire/mW1JE5C3phI01nRkRoN7t57t3lfZ7ttFhJaRPHachJaGUpGi1wLnlHhcsNsf8
	 HpGAqUzBd07iMlu41t30eqMcjBAjY7JMiUCo7sdS7E6T2OK4DRrxsWUmCyHToP866E
	 34NQT8FUhEvi7Gieyic5ANwCmic4UPywru76WKk0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbfJORKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 13:10:50 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45820 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbfJORKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 13:10:50 -0400
Received: by mail-oi1-f195.google.com with SMTP id o205so17462108oib.12;
        Tue, 15 Oct 2019 10:10:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MuM5OXPQEf/qQaZDX6U88QiRRUcUu9cQvoANannVLLg=;
        b=f9dFBLTg/nyxklKIG/IbWsoWkAZnfBJzBWpdXdavLSfGmiyLiia8m6EVTqCnWpie8b
         MAUTLwRzRrSLoad0hSCyJDIUp3qcA6cMlAs8Xe9t7WW217/jYqRS9mOyD9hNg65/cmjs
         y+wnuc1fyUFJmm6gb4cFM8hwdMKQ3n0Zx8WMQBDsWp0PsSaOIqbuir8SzHFQa5twZ76E
         GYbf9oheO8ogbARb4KgKkdLz4WRli/jlgz/QIdP2UkEcaOBAW4HPX8xyZumhFrExowpY
         C+WVWyjcEYlbHS6MUhrzIzkiXgSH4mRnQiR/cnO6y4Q2354Yv5PLidu9rq1eJ1h+JzJg
         rjLg==
X-Gm-Message-State: APjAAAUm9UUEUCOBO9w0kA/ZHK4nkNemuvaDXHO81GPyiLbvPIDZYrOv
        CVkSFYDEt4pPVTm1O3GiCHXuB9g=
X-Google-Smtp-Source: APXvYqzaGxPe8TwkXiP2OfuHpB4m420Ks0jDce+UGmdVQ7BdQQbg5qasG/3Db5bbjpGHHy65AoHC5g==
X-Received: by 2002:a05:6808:9:: with SMTP id u9mr30411976oic.98.1571159449283;
        Tue, 15 Oct 2019 10:10:49 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n27sm6583417otr.32.2019.10.15.10.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 10:10:48 -0700 (PDT)
Date:   Tue, 15 Oct 2019 12:10:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: samsung: Indent examples with four
 spaces
Message-ID: <20191015171048.GA10675@bogus>
References: <20191002160744.11307-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002160744.11307-1-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  2 Oct 2019 18:07:41 +0200, Krzysztof Kozlowski wrote:
> Change the indentation of examples used in json-schema bindings from two
> to four spaces as this makes the code easier to read and seems to be
> preferred in other files.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../bindings/arm/samsung/exynos-chipid.yaml   |  4 +-
>  .../bindings/iio/adc/samsung,exynos-adc.yaml  | 64 +++++++++----------
>  .../bindings/power/reset/syscon-poweroff.yaml |  8 +--
>  .../bindings/power/reset/syscon-reboot.yaml   |  8 +--
>  .../devicetree/bindings/rtc/s3c-rtc.yaml      | 12 ++--
>  5 files changed, 48 insertions(+), 48 deletions(-)
> 

Applied, thanks.

Rob
