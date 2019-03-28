Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892E1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BABF21773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553787574;
	bh=W2OK6Z9fDyiUoNoQBEVaOhBlPYOw822K5P+W6sDdzh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pyPOFIkwuQaNp1XsQ8AK/YYgSIEFaexWKdah/Tl0kFxrmKnBC9oyxDTqvBa4Q9Uuu
	 cCWeaXCUCYNm53/RHJpFCzIReKE4dnjU3Z5OPKwNOJ5d8fu6gbW20ZlB8yeWUgh9+I
	 y/4zyxHjD9tdix4IwXjFKzT1roX9TLRBlMKhuYqM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfC1Pjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:39:33 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40342 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfC1Pjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:39:33 -0400
Received: by mail-ot1-f68.google.com with SMTP id t8so13454653otp.7;
        Thu, 28 Mar 2019 08:39:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4kUjWeKG2Qe/X9DGA6Nn149eABC3mnQfdt7tGT6CEU0=;
        b=RaeYa7zu33/rBYv9pQsWu72naqZpz+WNyKCTMrPKvBfWFWT0XbHpKpDVlMwJakqM9R
         qCu4lZIlXaJ6qJxajinOzkC6ROC8Ih/aBlwdLmxqWgoGVUEF4azXUBWcKW8swcZracsJ
         rh+L7SP6MrkwBSQyVQNh9bjc9tc+JV1trnNcx3wdDgZo646OHCwlLXc8sF80jj1dt7aT
         7XD5AXu0phZGFRERzGcKAWk0u3jem4M/onddEgEG7l5kpPYAN5UqUn+sYLpv3fFhCKgP
         FmPmeJG/XWGE5RvklfpHTkYofRTk1ONrAfIErqtYa/Txc0i7qPCzIouY8DCYpfMJYsA6
         Oczw==
X-Gm-Message-State: APjAAAWz5N2Q66NqsjnoMbqFzDSwXf9M9pv4Kef464/BXgah9lLt/Bnl
        IOqiUFx/YRYHKZ1kJcilLQ==
X-Google-Smtp-Source: APXvYqx+v12cjW4TOO/iwP2m6MCzlcTjzxh79MknTQoQAmNztyfaa4ZdIKaB7WYVh6l8OpeW2kH5Rg==
X-Received: by 2002:a9d:6b94:: with SMTP id b20mr32780582otq.289.1553787572285;
        Thu, 28 Mar 2019 08:39:32 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q67sm9756730oif.40.2019.03.28.08.39.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 08:39:31 -0700 (PDT)
Date:   Thu, 28 Mar 2019 10:39:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 1/5] dt-bindings: display: Add Sharp LS020B1DD01D
 panel documentation
Message-ID: <20190328153931.GA20107@bogus>
References: <20190314122622.7597-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190314122622.7597-1-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Mar 2019 13:26:18 +0100, Paul Cercueil wrote:
> The LS020B1DD01D is a 2.0" 240x160 16-bit TFT LCD panel.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>     v2: New patch
> 
>  .../devicetree/bindings/display/panel/sharp,ls020b1dd01d.txt | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/sharp,ls020b1dd01d.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
