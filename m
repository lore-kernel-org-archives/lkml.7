Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB531C2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 15:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A04D7224F8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 15:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575559087;
	bh=9YSgBEX3Of0BZkNkYZ9oZDnRtUuyam2FLRsMmfXpbJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lkJnH0SzcH1wsVYp6TUk3t0qS9EWXLoPH1TE65uCNYI17BA6prLwYORiDmSC9fu4O
	 Ylx5tHb6iTM38lQaXnIUiP/HABeiDFik9z8qXPm0Wt6uB7DyEBp8DrOda5/sKtynzB
	 DvN9Jr8von5PPHBtGWhsgyZ+qxjeZyX3JIdW2lmk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbfLEPSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 10:18:06 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46104 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfLEPSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 10:18:06 -0500
Received: by mail-oi1-f196.google.com with SMTP id a124so2996281oii.13;
        Thu, 05 Dec 2019 07:18:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zqhZAZGkDdkxiUbtVKwjzLYnsHkdCRqaPtvFRBEAazc=;
        b=sLvQfwf2NC6CGqDQ0wArCc83WxeKuWhK8PQSRwULXJN3kkc03KihhWgyC+ZktTqq37
         gDk6L7VqBRXKj9W4aaAbq5wOXsueTAh78WkiMG+E1476hYD17v1sQIulS0PXyCXDHmJf
         Ow8W7hbsYytA43YOylOUWL9A7b/NkMJP5HDOGZHvTHKC3xa+XWO4iXHLcAY1HnF/wOUI
         l8ZsIO9JtYXmJyFL6M82g9gydDkxjGhYgV6XJcLBcNQv/BgZAG4ysTMn9ZbfK5ltK5+L
         nQc99FQLqDvXoeHnyBctWSpocpJBsHKCoL8/ThHORB4xYAWxJe47fe249wm633eH7cgR
         y00A==
X-Gm-Message-State: APjAAAWkASmhfhDB7wwAKraLnVo66qJpa1NkbgiMWjk6fVxlHP130L5N
        hokoyWk56YM/0HUwYg9GGQ==
X-Google-Smtp-Source: APXvYqx7NjjdIbgArEWQaF8DmmYAXEnb3idpC0UtmO9ygdIx+x5XydOKAeoS9ZQZJ5Njo9l3MyPGNw==
X-Received: by 2002:aca:3442:: with SMTP id b63mr7804158oia.36.1575559085415;
        Thu, 05 Dec 2019 07:18:05 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i20sm3442756otp.14.2019.12.05.07.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 07:18:04 -0800 (PST)
Date:   Thu, 5 Dec 2019 09:18:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     linux-realtek-soc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 6/8] dt-bindings: arm: realtek: Add Realtek
 Horseradish EVB
Message-ID: <20191205151804.GA13693@bogus>
References: <20191123203759.20708-1-afaerber@suse.de>
 <20191123203759.20708-7-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191123203759.20708-7-afaerber@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Nov 2019 21:37:57 +0100, =?UTF-8?q?Andreas=20F=C3=A4rber?= wrote:
> Define a compatible string for Realtek Horseradish EVB for RTD1195 SoC.
> 
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>  v4: New
>  
>  Documentation/devicetree/bindings/arm/realtek.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
