Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BD7C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 22:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7D372086A
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 22:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569884295;
	bh=vFie4eF0rb7YFt1obVT+0KlLF3kuJQ43blYW0sK+iNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=w3uEctRKUKyK0FrgVHKiYshHyFYlIjSJXXmQUblczwECpZlapf2McI41sIbTU9EVj
	 KgKmKET7TQAQYgnq0RERASXZtprjixZwt7OILo0TrtNERZPu22UU5QUsUA7+0rHLkf
	 ZhxP1KGHrqjCq3t+8dARIaznsrYgeIfFQpMNOGms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbfI3W6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 18:58:14 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39024 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfI3W6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 18:58:13 -0400
Received: by mail-ot1-f66.google.com with SMTP id s22so9859372otr.6;
        Mon, 30 Sep 2019 15:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yMD9pmuStBSmV7/f6WmG6NS1chDF+Ciauz815CKJvxk=;
        b=hy5Alx4wVYQh8+zwDXtQd/uAHU+rW4yWHk3FKAyDP1iz30W7eXN8HAp+iRSLXBrCEt
         A7G6akFvoOonT1IMcGphPp5Wux9xgZzWRtECIDYwBfBLl8fz8whcCgwErwUuNZLo3hfu
         D35PkGfmNJFC3eFRhmFW87OMUa4AVrciRqdfwkZbBpu6slgbJT7c+YwMFXerue3NqDJ4
         +rHD71bTA/q65GIbVPp4djQjYsUPHT/Yg/q20QAjt6a16QEq7pSvX043g+Zhr2eJxzNX
         IUUFV02ck0met1EHvJjKMK442WuViUoSrMjWOd6I342EKTKdW26J9QZikpFCFfCA0Clm
         QQ3Q==
X-Gm-Message-State: APjAAAWqrq+7wo6oGNSY2ReY1zFtdq87B0pQdI+WB59lueA3ePZ2g/uu
        PtzHWlaRDQdZUX/8YjkwRg==
X-Google-Smtp-Source: APXvYqywsx7UD2SV0vlleU8U80VUN6PE7GBO/x4hSrEd/v4xkSmgFSt6RjJIUygixJXrVFXJWQV6pQ==
X-Received: by 2002:a9d:a06:: with SMTP id 6mr15686295otg.69.1569884292929;
        Mon, 30 Sep 2019 15:58:12 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a9sm4409375otc.75.2019.09.30.15.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 15:58:12 -0700 (PDT)
Date:   Mon, 30 Sep 2019 17:58:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-rockchip@lists.infradead.org,
        christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH 09/13] arm64: dts: rockchip: document explicit px30 cru
 dependencies
Message-ID: <20190930225811.GA14016@bogus>
References: <20190917082659.25549-1-heiko@sntech.de>
 <20190917082659.25549-9-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917082659.25549-9-heiko@sntech.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Sep 2019 10:26:55 +0200, Heiko Stuebner wrote:
> The px30 contains 2 separate clock controllers the regular cru creating
> most clocks as well as the pmucru managing the GPLL and some other clocks.
> 
> The gpll of course also is needed by the cru, so while we normally do rely
> on clock names to associate clocks getting probed later on (for example
> xin32k coming from an i2c device in most cases) it is safer to declare the
> explicit dependency between the two crus. This makes sure that for example
> the clock-framework probes them in the correct order from the start.
> 
> The assigned-clocks properties were simply working by chance in the past
> so split them accordingly to the 2 crus to honor the loading direction.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  .../bindings/clock/rockchip,px30-cru.txt      |  5 ++++
>  arch/arm64/boot/dts/rockchip/px30.dtsi        | 25 +++++++++++--------
>  2 files changed, 20 insertions(+), 10 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
