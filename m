Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB249C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 23:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B891B218A4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 23:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551311071;
	bh=CJ3Hkk15t5yYzO1/hRWFStBZ3RekcxSGOabOa998A+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1YFWY0qbhaKuzXJhIsdIF31IuRATruos6WljphQW7fDAUKHeOicivgTCGvKr2LsZh
	 O4PXF2vqaCD3IDOx2S6+IbiEVsEb9oQklQIAlpw9SzCzZaqAtZi+s0u4qjDfuUcv8u
	 mb+lvd9pEDYgBItkIew955DqmI+ThnSj+Ll8siZg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730446AbfB0Xoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 18:44:30 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38547 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728397AbfB0Xoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 18:44:30 -0500
Received: by mail-oi1-f194.google.com with SMTP id q81so15018868oic.5;
        Wed, 27 Feb 2019 15:44:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HwZbWvn0qoAbQbJofGBdR3E5M84CPEw/RuViiu5mbME=;
        b=P0WZUZC/4WZLjYSe0uw0m2MMfE+i8bFePnzw+7wKWuKrFleUg60Bbrrf08Sa1N+o7s
         iCbtbcs8hUz8S/X7q59zLMPxrplsXoXDCxB95YtlLBS6OTHW07NHv8ebEJoSVXoOOH6Z
         W5O2gYEyEomO+GrgMnz0tPAidZ5Thtf5Oeg4WQ3JtOXlTdmJlZkobqdNl+UpwI35MTkP
         EPIrKOpqZWJFZFQd2fk3o5k3ZIKEwa0EXXjHD7sf2yl7wrr8Sp1hlFreefk2OGbfH05O
         n5F0HFMHO2WYynHDOQ7xu8C89ZO3eZqYoTRLKejwSGae1xzrUzNaNmrhbliVdWt47riJ
         vetw==
X-Gm-Message-State: AHQUAuamY7s3GIaLHLd5Ogfpf65MImlYmdECVo+AAgw7haODNJwlzDrG
        M3Ng1Fi1ZZVoKiw5l1BxdA==
X-Google-Smtp-Source: AHgI3IaresjsyWzlcevE//zGUd4AePMCUOg4p7VaGzW/+FNSLqCGgsLJ1GcggzJ/Hv6IGltCOdIftg==
X-Received: by 2002:aca:33d5:: with SMTP id z204mr1132988oiz.61.1551311069194;
        Wed, 27 Feb 2019 15:44:29 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d3sm7305812otb.54.2019.02.27.15.44.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 15:44:28 -0800 (PST)
Date:   Wed, 27 Feb 2019 17:44:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
Cc:     Mark Brown <broonie@kernel.org>, J Keerthy <j-keerthy@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: regulator: add LS2 load switch
 documentation
Message-ID: <20190227234428.GA2855@bogus>
References: <1550650552-26013-1-git-send-email-Christian.Hohnstaedt@wago.com>
 <1551076866-12578-1-git-send-email-Christian.Hohnstaedt@wago.com>
 <1551076866-12578-2-git-send-email-Christian.Hohnstaedt@wago.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551076866-12578-2-git-send-email-Christian.Hohnstaedt@wago.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2019 07:41:05 +0100, Christian Hohnstaedt wrote:
> Document device-tree settings of the load-switch LS2
> in the tps65218 device.
> 
> Signed-off-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
> ---
>  Documentation/devicetree/bindings/regulator/tps65218.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
