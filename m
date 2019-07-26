Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63809C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 23:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 357AD22BE8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 23:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564182098;
	bh=NSv3imrSJ6kq6J9JSZL3L2SHfM3BjhB8tKcL05Q608U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D65yWXqJ2uuZxCaYUW84zhlTRCelVqVje1di2xWZBSkGuGNOx9yyaOIGfGHe3DwG6
	 lV9ZeS6+HFmaDvOVgTSGWWqTpeIWQ76ZxfkmvZ1t3OcQjHxpDCC+My9bNYSAmQuKip
	 mkCSDcXzsrWRF/gyfpJSsp380VGtKO2yFshsj/Gw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbfGZXBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 19:01:36 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36736 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfGZXBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 19:01:36 -0400
Received: by mail-io1-f65.google.com with SMTP id o9so4452114iom.3;
        Fri, 26 Jul 2019 16:01:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W9aJHw1S9UNrc+mERSpNWt7mOmycq6fdw0EF/39Vags=;
        b=GxQ8fIY7tEl9P4fqes6jdL0dBBaAKe2ArTOWkU3exgaZjcoiaw9bH0VHZ+EqDvkri5
         7E6Q6Ce5WLkRToYgSm4yqdg2TFJkPsO8BS0ANjwrqyRKdB1z99GU6Y5PMawJ0e6xCRzj
         m0cufhEKInVgwe94917cR6Qns8dX1jwCLvLuUbnXWlXzjEJhnjy9h2Apn5/2LSJCRXNY
         5j9IlyfZ4qQfyKPX+TKlewoVBw+2VSCvq2I+iCs1k3FX/WONxpPnCutTsu7TTCHJhFAq
         Y/5DhyBW+77tMygdHivTQEVfYcwvhX0Mulp6F6hfRZJ+5OnXIbgMuwrQw24YLIPmFBl8
         c4rg==
X-Gm-Message-State: APjAAAXuJiHv4x5/Ddl+ivFCWicjxWbU5rLDszHM1E1nIuUkfoJ0sXQk
        jg7+nxVuEbEQ7ATLVT2m+A==
X-Google-Smtp-Source: APXvYqxPyJPHExO+MTu/7+6H+tPoiDVGmxEamiEz/kzHRo5pS/oMtad7oaypn7kmMQMsm2/VQdnY3A==
X-Received: by 2002:a5e:de4d:: with SMTP id e13mr67504232ioq.272.1564182095539;
        Fri, 26 Jul 2019 16:01:35 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id k2sm47708711iom.50.2019.07.26.16.01.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 16:01:35 -0700 (PDT)
Date:   Fri, 26 Jul 2019 17:01:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: Fix typo in kerneldoc
Message-ID: <20190726230134.GA30632@bogus>
References: <20190726101744.27118-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726101744.27118-1-thierry.reding@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2019 12:17:44 +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> "Findfrom" is not a word. Replace the function synopsis by something
> that makes sense.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  include/linux/of.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks.

Rob
