Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA672C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 22:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE454206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 22:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560465716;
	bh=w0/OSWvI2qn+JSy2YoLSNy6vitU/yELlhLrNJyi+bZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Jqe9zJyFWplXX7GLVWoiqX02kxzBGAd89zmvo6sdM86uv1SUOomwGM4nt3ijdCv8Q
	 r4Pqxsbz17xngxnsWyjXm7Zd09vGcoEIN39uPSHWkVrykT2hGbmExuO1TlOgi+Eiw6
	 Mu8kz9u0uQzQmYRaGvwPrJaBrMk5ZGQQqUueNXG0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfFMWlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 18:41:55 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36678 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfFMWly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 18:41:54 -0400
Received: by mail-qk1-f194.google.com with SMTP id g18so492006qkl.3;
        Thu, 13 Jun 2019 15:41:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=555W8SlOEWdbOmtVeCHjPCQVdc/MKI4w8OP/WDqt3z8=;
        b=qx//8Yf0gVSHXYZL+432RNJe2E6hPhn2fNe/bp/R4w+6I56gEyz/4/FujBKesnffL9
         MiQaXshokMBco6iPV2/yLvbX9f4RmOmaySlALpTvKvkK43wcwNTHei/bHCw/S+9mmALd
         DKs4HGy8CTL8ZS4lVW0wTr1esboEk8KFjKIzjAUb+qHjfmc9mKCKU6iGurxQRMSVylVH
         SGAd7EWUZfIEWJ74zaHgPEMKx2yJ4T5Mej26TcpM3ZBBOfIBy75q0evTichmAWZrOB9Q
         JHCTz25K93S5VVnVpvsD/bwnH88BNx+ogW4ghz6PJlr1f5r1wU5KyGjLijgm/sIw9AqJ
         mZ1Q==
X-Gm-Message-State: APjAAAU6eouH9TUTPjOVFUvjyEGjLOm2QkcAlHuC9tBdF8innhZFT2U+
        WuOO8yyPBbB9YXxEmHaniw==
X-Google-Smtp-Source: APXvYqzBvDkee2tbRQ7LDu7J0RLvPSx9PFA+ewlhL0hdgzb8u7tmMhGmcaUxchrxz5GjWKXYafhucw==
X-Received: by 2002:a37:b044:: with SMTP id z65mr72541781qke.294.1560465713376;
        Thu, 13 Jun 2019 15:41:53 -0700 (PDT)
Received: from localhost ([64.188.179.243])
        by smtp.gmail.com with ESMTPSA id o54sm706848qtb.63.2019.06.13.15.41.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 15:41:52 -0700 (PDT)
Date:   Thu, 13 Jun 2019 16:41:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH v3] dt-bindings: clock: Add silabs,si5341
Message-ID: <20190613224151.GA32304@bogus>
References: <20190424090216.18417-1-mike.looijmans@topic.nl>
 <155623344648.15276.18213024444708122458@swboyd.mtv.corp.google.com>
 <3ea2d720-f49b-586c-e402-07db289b39a8@topic.nl>
 <155632584222.168659.9675557812377718927@swboyd.mtv.corp.google.com>
 <cd52a35b-d289-24e1-70db-9d63fd9f6448@topic.nl>
 <20190507140413.28335-1-mike.looijmans@topic.nl>
 <20190513203146.GA24085@bogus>
 <20190517132020.31081-1-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517132020.31081-1-mike.looijmans@topic.nl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 May 2019 15:20:20 +0200, Mike Looijmans wrote:
> Adds the devicetree bindings for the Si5341 and Si5340 chips from
> Silicon Labs. These are multiple-input multiple-output clock
> synthesizers.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> 
> ---
> v3: Remove synthesizers child nodes
>     Fix typo
> v2: Add data sheet reference.
>     Restructured to enable use of "assigned-clock*" properties to set
>     up both outputs and internal synthesizers.
>     Nicer indentation.
>     Updated subject line and body of commit message.
> 
>  .../bindings/clock/silabs,si5341.txt          | 162 ++++++++++++++++++
>  1 file changed, 162 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/silabs,si5341.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
