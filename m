Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEC7C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 00:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA2721655
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 00:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556584934;
	bh=owZyzpAguImbAOdIq7oeXiroEJvoh+RodwFAG33Gow0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZXCzPB/MHhNQ/d+WzJZycT8kV1CsQYUk4elZhGwzdD1AE2BWhSLo1Xu3izhQqz0Ft
	 MtwnvsopCp/6ym35w2RiCbLDdx7WAKgxJT+ywNvGpP9xtPGbKUs9UTXFd/YigxVTrR
	 zBox963X2eRGmgfx83OyeJ+1VfZ0cQr03lxiK4U4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbfD3AmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 20:42:13 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37216 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729319AbfD3AmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 20:42:13 -0400
Received: by mail-oi1-f196.google.com with SMTP id k6so9910241oic.4;
        Mon, 29 Apr 2019 17:42:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=auyXfN0CXYNpqTE/OCAwvp4ETY+MdytwD2bzjUyTbyc=;
        b=QBdFttCYTaBpg1bfZO/u265EMJPdHAc2wiZ8gElLkjjfRKdH5AYaZJllmTkn7B8pRY
         DdJsyJWWOVEk+pkJIaHPS4bxVe4gk+0phA9SSu67p+YWKpWg3llgFSeI7+vZdeb5hyYo
         RDZ1+2OIWF+db1hMFOUw8TBGfHUJn/Aoee0WBELWuOMy652YLPkzbbClnY4O8U8glCbh
         RWIZ1fr2K7DMOPafiJeLHyz3y5qXLXiXJc4gQEHarlkEO+4y93kFlL8Ve+ymsOKrSw7o
         YD1Jz0hSyNrWL3dGIbkmeuuKcGvFow/ov3Wd+t9aboq4pNNwtZ6Ed78B0vciwPCV6VJS
         d9vA==
X-Gm-Message-State: APjAAAUgDOWdUZz8PzsBiZjTmh1JRirEZldO0bxfw5JLwkez+DUkdHrY
        KY5BhFcPnqe/KT/UxJTtmA==
X-Google-Smtp-Source: APXvYqzkpm9cXvEPXUgeeY1+qTpNl2Yb4BMCNCJwET/5JhCl4/H2AyLjvRR1YX3ehNMkoA7s3GrD5Q==
X-Received: by 2002:aca:6c96:: with SMTP id h144mr1169022oic.167.1556584932775;
        Mon, 29 Apr 2019 17:42:12 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 33sm2822612ott.23.2019.04.29.17.42.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 17:42:11 -0700 (PDT)
Date:   Mon, 29 Apr 2019 19:42:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Patrick Venture <venture@google.com>
Cc:     mark.rutland@arm.com, trivial@kernel.org, linux@roeck-us.net,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: Add ir38064 as a trivial device
Message-ID: <20190430004211.GA28272@bogus>
References: <20190416154138.124734-1-venture@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416154138.124734-1-venture@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 08:41:38AM -0700, Patrick Venture wrote:
> The ir38064 is a voltage regulator from Infineon.
> 
> Signed-off-by: Patrick Venture <venture@google.com>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Patch 1 and 2 applied.

Rob
