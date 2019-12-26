Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A559C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 23:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 207012080D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 23:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577402847;
	bh=y00MAt6knTJmkoy7Oh7bwITIr6QQMSRufQ3fPLuAo0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uxG4cYxposvit7kUmNSuKge4LMVTtJsRnq0GLdDm5WhEX/faabvsYIXbh30a3pG4n
	 QjexsOYqQwt8CFCWCpTC8lqo+b4QAkLgg4g1xRFWx6nSERHkKq0uWJDuoAFwoUj4T1
	 TdFkngt2iePSCYSXCA6bvHlKwCaQTPajBpa0fi04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfLZX10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 18:27:26 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:35609 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfLZX1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 18:27:25 -0500
Received: by mail-il1-f193.google.com with SMTP id g12so21214402ild.2;
        Thu, 26 Dec 2019 15:27:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=079ePGuH4LFeB4eTg/R3HlprnewzRRTDmlXGUNyMiYE=;
        b=T+q9l17eUO6ai62WWcye9PHefQRJbBPkGEUSvon7oPvqDH9UltkXjgnmjv6MK9H0Yn
         9fx5vZyP1XUCPvswBJPH8OnK3EMq1XIjlR+ctjdy4hHmUTik081soKT5eIvMOO38nuWX
         k1CZjBTsBH7tHhhHYg2YLAafnLz/hu3SbmTfaXvAQJcRiWWriOsbHKfnzKasezIZFYRe
         nqi+jPqjy6H8fNL9hSOE8quA7rX6a+OHToXxwrPdilQkbB6i9SwJn2miyWWMeGYZFgEF
         J17jvHcJzxXQPYriEyyqMucCH2Pn2J7mixirrQJJZE2yD7Fo7jWNsgj6BVygXypUN9f3
         nBKg==
X-Gm-Message-State: APjAAAWd3Ky4h5Xq40LGd129kGnWftl/ioCAuciEDf2DGKFWLy0wOLPU
        hHhXClJF5ebaxBaUYx9rOg==
X-Google-Smtp-Source: APXvYqy+c0rmXNLffc3Rk6rkLD6TvFeAK3D5lvZQZ6C/dxSMer9A1oMxAvU0bFVT+udEDZaLDenKEw==
X-Received: by 2002:a92:4717:: with SMTP id u23mr39096860ila.190.1577402845221;
        Thu, 26 Dec 2019 15:27:25 -0800 (PST)
Received: from localhost ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id 81sm12626716ilx.40.2019.12.26.15.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 15:27:24 -0800 (PST)
Date:   Thu, 26 Dec 2019 16:27:23 -0700
From:   Rob Herring <robh@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     dri-devel@lists.freedesktop.org, thierry.reding@gmail.com,
        sam@ravnborg.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com, heiko@sntech.de,
        maxime@cerno.tech,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: Add vendor prefix for Leadtek
 Technology
Message-ID: <20191226232723.GA5257@bogus>
References: <20191224112641.30647-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191224112641.30647-1-heiko@sntech.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Dec 2019 12:26:39 +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> 
> Shenzhen Leadtek Technology Co., Ltd. produces for example display
> and touch panels.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
