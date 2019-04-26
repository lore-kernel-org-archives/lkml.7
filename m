Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,URIBL_CSS,URIBL_CSS_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48364C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1391420693
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556306552;
	bh=McGllE8AW9t2VPZpky6bg+ZSTpAekrZDI5sWVZfLT3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MI3ECGfFWVgUWx0HJcvFC1loBi/NA+M7ok1ttjbdEhJmOzp7RP6rjv1aVMfMuRgnx
	 r/z7cx9H/1q/zF0sfjgUiDFil6AYKfkaB+L7F80cv7h0q63F8tKfQvpTSJkgsC/dxX
	 8pq3WfsVP9bxO2uCagNjckpiyX4V6mYJfOmfldqM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfDZTWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 15:22:31 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44875 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfDZTWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 15:22:30 -0400
Received: by mail-ot1-f66.google.com with SMTP id d24so3564791otl.11;
        Fri, 26 Apr 2019 12:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ptyXeC1nojiYvyGJqSX3Humg6vjBjXgpDxu+/WBGpus=;
        b=pkBcOPlF4HkDP5CbyDytBH54atk2A6NCjvFvipdVX+bjmLhxAGnc9CkXF7YiFqh+Iv
         LL3mTnu0CL+WJZ/UhseRyp6hkH9ED9DjI1xgiklNSHK/8dWx44W2RJaqUbHzDgzob/Ek
         uqjheDppCz3v4+uYH5Jpo9OSgCoRO9kJBxVH2NJCOekkBEuhSpimPu+yCjRYn3Qi5C8B
         JLv5GF820MZELFQ8y1wJ8feuuQEwCCBP1tNR+jB6WRLeZ/1VgaajoE/5SdnaXHktZySk
         Hq0rGxw/+0sfe57fwU6e9ahySfM9BinYm50sRhMYWtwENniBzztxH5Oylup1EjXpK8A8
         klig==
X-Gm-Message-State: APjAAAUxTkYZjRN62QcCoC9VqXGDP+oFCRZ9p1+AEA5xj6Yeu2NZqTXb
        iOCSRdookP3gMdgL8q4DMA==
X-Google-Smtp-Source: APXvYqx2b8BQ/rh9Pz5vsW3GeORduQwL85ETHdB0Db1S5j2QBsyDHkZPOp6hZzfBysvZ14rkQ67hvw==
X-Received: by 2002:a9d:5a14:: with SMTP id v20mr2240094oth.342.1556306549767;
        Fri, 26 Apr 2019 12:22:29 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 3sm5417740oti.45.2019.04.26.12.22.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 12:22:29 -0700 (PDT)
Date:   Fri, 26 Apr 2019 14:22:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, pavel@ucw.cz, robh@kernel.org,
        dtor@google.com, linux@roeck-us.net, jacek.anaszewski@gmail.com,
        Oleh Kravchenko <oleg@kaa.org.ua>
Subject: Re: [PATCH v4 17/26] dt-bindings: cr0014114: Add function and color
 properties
Message-ID: <20190426192228.GA6081@bogus>
References: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
 <20190417205439.17685-18-jacek.anaszewski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417205439.17685-18-jacek.anaszewski@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2019 22:54:30 +0200, Jacek Anaszewski wrote:
> Refer to new "function" and "color" properties and mark "label"
> as deprecated.
> 
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Oleh Kravchenko <oleg@kaa.org.ua>
> ---
>  .../devicetree/bindings/leds/leds-cr0014114.txt    | 26 ++++++++++++++++------
>  1 file changed, 19 insertions(+), 7 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
