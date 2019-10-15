Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066C6C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D30602084B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571159472;
	bh=8jsDRkp6lSUOWbkuvM1aMxvvnkL5/4ulgxl4THwZ5Jo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IQjhaZDP/MvI4gcO0yHAsNq4AWeM9R1RbWDm5ka/gkJsxFjuqDYXJhouOYx2oG8Dq
	 OSowzZca/tl+dBxNwhcZHca9ivqsEolidX/rX13mLRMobPMUEpOB+y9yxd/z7xlRrj
	 PUu02+fP9UG5FsxZ+Hew8havZjHAQbHoYlSeCtYQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730057AbfJORLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 13:11:11 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38085 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbfJORLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 13:11:11 -0400
Received: by mail-ot1-f67.google.com with SMTP id e11so17589529otl.5;
        Tue, 15 Oct 2019 10:11:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PqlcVUu7LJBkQ3UfMyNreWglkJZmOU4KXfvEBcyGtFo=;
        b=aDUZEYZCL6kZw0Uz+c+udAFsi+WTJwTzSUKlhza03cDHsuaogIAX/S9rUxiS8iSeRZ
         Bts23KN+wz1WaVR426kJZND0nsXABQ4qxkl07r2zRkm18TtCEVQ9Yukp4i+eD0Vi8Wba
         neuo4TfWuEyYV4579ELFqmssJrndDI5DOMxe5vd7UjV6qh6OiAfVZf6Athc+v+j2N3I8
         FvaCBlQKWadgDzWZQuf8j4wq5TepbMNM8xxL/BlpfPvOihT9pOparmGhlS+PAdElG4vr
         qfzepFeTraCCJi5f26Hkp2f4fToVb5WWCL6OQ68D7I9URp6hMSeBAMyqiEeCC/IfG5Jy
         UB4Q==
X-Gm-Message-State: APjAAAUDlIZLjE890Dv2MDUCWFAAPH9zlnwPrYN+w2H+oD+roZd/EGOv
        xnwTlZH3wUOMY+pM/BXNFtdDnDU=
X-Google-Smtp-Source: APXvYqzbeF6N5qHLFyJv7c4cHAq77g41o3t5xO1edKQAiRHLUy71hTkZO6D7NjbQNBuIv3dkEN+9tw==
X-Received: by 2002:a05:6830:10cc:: with SMTP id z12mr28407257oto.1.1571159470221;
        Tue, 15 Oct 2019 10:11:10 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r7sm6534251oih.41.2019.10.15.10.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 10:11:09 -0700 (PDT)
Date:   Tue, 15 Oct 2019 12:11:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: rtc: s3c: Include generic dt-schema
 bindings
Message-ID: <20191015171109.GA11552@bogus>
References: <20191002160744.11307-1-krzk@kernel.org>
 <20191002160744.11307-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002160744.11307-3-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  2 Oct 2019 18:07:43 +0200, Krzysztof Kozlowski wrote:
> Include the generic rtc.yaml bindings in Samsung S3C RTC bindings.  This
> brings the requirement of proper node names and adds parsing of
> additional properties.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/rtc/s3c-rtc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks.

Rob
