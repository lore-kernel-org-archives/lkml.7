Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E05C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 00:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D352085A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 00:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556757200;
	bh=IJg2wPKijmjyQvPo/XX26gTY68c/vvnec7CmorgqKgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jzXLAhKIGW+IwamgoIJY1ZCzu2lsbd5BJd2VJyOsXpss6okPeBs497YFM1h6KnUwA
	 20skTN6KsfI5GEr5rdh98iy4Ja+4uSxKTlyXvhkRCouEineFMq1bRORL91rjG48ZyE
	 YONrimwZCkhQ8qfxYM71TpH+ejc3K+gzceLjmHNQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfEBAdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 20:33:19 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41256 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfEBAdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 20:33:18 -0400
Received: by mail-oi1-f195.google.com with SMTP id v23so377319oif.8;
        Wed, 01 May 2019 17:33:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Bxx61/5tMqffUxYSXPspJfDFkI/HyVDd0hSMIepjoOA=;
        b=b9QG19We1AD8anvQ5BhnDG65pXRN4uTI7ciMtBwOXzKH7pBK1BNFZ200jQy9R+K3wL
         ggQeO8Fm6yFuaMPpJutCOZgqUttxLncG01sIvL3x/uoSIIPePmSOrFUdgphB9KaVVd3U
         wuiwwgwWXq/4weosdbKwDN+MDeMTIVcZ0GNLd/B3S00UR5cqkqeKAR2M8K6pWk7vu12L
         JtI5Nl17ORCc1YbT2c8aYnVeEh320YxT8BqSgT9MLtBJW0vFvGgT7Yj3UFEvufcgtDzZ
         HBOTNUtTqBxTC6I35BMfBYXJIZGT+sWC5OXn6tpFmmVSIQie0j9xWMDiZXjn4nXwPuYC
         mYCw==
X-Gm-Message-State: APjAAAVVHQW/XyXISAICAIum3+HgXXqRbMH7B1EN+2SJmQHgC6FQRxVs
        at9wFpjFaIoPYeiXvxEQDTwevpM=
X-Google-Smtp-Source: APXvYqwG4sgkcB8hW9YmcTmsW+CtvtTwnV1EVJN8lSy89I0iBHiV6qS0oSaWBgQ245GTGJJYK6QUYA==
X-Received: by 2002:aca:7544:: with SMTP id q65mr702705oic.5.1556757198277;
        Wed, 01 May 2019 17:33:18 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u11sm17000548otb.66.2019.05.01.17.33.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 17:33:17 -0700 (PDT)
Date:   Wed, 1 May 2019 19:33:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     jojo_zeng@126.com
Cc:     frowand.list@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  of/device.c: fix the wrong comments
Message-ID: <20190502003317.GA19775@bogus>
References: <1556156754-18993-1-git-send-email-jojo_zeng@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556156754-18993-1-git-send-email-jojo_zeng@126.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 09:45:54AM +0800, jojo_zeng@126.com wrote:
> From: Jojo Zeng <jojo_zeng@126.com>
> 
> the comments which discribed the input parameters of of_match_device(). 
> the name is changed, so fix it.
> 
> Signed-off-by: Jojo Zeng <jojo_zeng@126.com>
> ---
>  drivers/of/device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied.

Rob

