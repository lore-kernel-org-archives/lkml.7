Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2D3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFDB12064A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553798449;
	bh=2IkJg0kWGNgHzfj0+QgIISPgrmjWH5LdtXMzVRkjfOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kow/OmTWocJ7uZVSw8TWQ1XHKfLfRXVdVFxXxGUIFxHXibNstm3iU32T2knW6WLmQ
	 9F8ZvWt4O1dOeu18roZ8AQjyPSqcM0FMBHzoaXXHxPZyi30nUF0o0DdnlZs5TKG636
	 gsBiCIX8jRmnPTP948axOsbFv/thpIWvfz+pklBQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfC1Sks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 14:40:48 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43621 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbfC1Skq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 14:40:46 -0400
Received: by mail-ot1-f66.google.com with SMTP id u15so19290308otq.10;
        Thu, 28 Mar 2019 11:40:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xm2TOGI+qBS0WxF1/CMLhv3mKSq3N5K4JOgdIMZqk7s=;
        b=LarUq5pzE2MOBhPd8iYEqllBFld3y1hsoZruoKgPFkaBSnTDgD4m4LfR95/iBhn8Ls
         aWnULvHoJ7EZzkmkhVf8QIYPAaCyvge61PK99WfpQFbuatjF0LEzeoHDNUW3iNCoo+jY
         2+nWD2LjApvpSLxUXrYZszSvFrfDk8vjBnLfs+kan6O9JZNAE8fwy+HnbClpU4DqiEIz
         cQpF1BvxPg/6cWakFK5/1kXt/a7BSA/ULT62OHhbmN57OpEOdhHXulIosf9D1eeqnGJR
         AZQqNJxYQxUHwc7AC5z8Ibq0n6e9Oa3TwgdnFUGy/RA9pjkGxveMwTbu9PVsadDd/CKA
         OMAA==
X-Gm-Message-State: APjAAAXZrsAFn0ANWnaayQQE19ycEXFFYoDToEVOntlMWZivVc5uarUy
        S22mAwOYS7kJ+f4LpMQleQ==
X-Google-Smtp-Source: APXvYqz5dgJQ1zr6CjMce8Ki1CvAVEnAxLdK9GPVwvcieTovS6wITuAZkIoYOMt4SlGFGHKMiTImig==
X-Received: by 2002:a9d:6a88:: with SMTP id l8mr5175184otq.260.1553798445998;
        Thu, 28 Mar 2019 11:40:45 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 33sm10743923ott.44.2019.03.28.11.40.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 11:40:45 -0700 (PDT)
Date:   Thu, 28 Mar 2019 13:40:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        andy.gross@linaro.org, rnayak@codeaurora.org,
        david.brown@linaro.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        devicetree@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>
Subject: Re: [PATCH v3 7/9] dt-bindings: power: Add rpm power domain bindings
 for msm8998
Message-ID: <20190328184044.GA20740@bogus>
References: <20190327123832.11566-1-sibis@codeaurora.org>
 <20190327123832.11566-8-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327123832.11566-8-sibis@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2019 18:08:30 +0530, Sibi Sankar wrote:
> Add RPM power domain bindings for the msm8998 family of SoC
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  .../devicetree/bindings/power/qcom,rpmpd.txt         |  1 +
>  include/dt-bindings/power/qcom-rpmpd.h               | 12 ++++++++++++
>  2 files changed, 13 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
