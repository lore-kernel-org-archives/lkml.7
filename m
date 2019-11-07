Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20691FC6194
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 01:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B982166E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 01:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573089078;
	bh=rIU6EyvBYO9j9IVhetnly4HBKdPEzu5PrktOv5FywjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pGVuGCG1XO2xI9kcWTnMj8eNs2YERMZ218JylNxeojFzpV58jHm8mq7UxQBFW+GXi
	 lqOa5U5LyeNnuwGvUt/ZwJkfWLCgxteCiaUmKEVrtDBn7mRJVTaRSbWz+fGvYKUG9A
	 vian9e1fndd1xLPF2urwo/8gqFlOUvAbf3g8Zofs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732897AbfKGBLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 20:11:16 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43022 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfKGBLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 20:11:16 -0500
Received: by mail-oi1-f194.google.com with SMTP id l20so459722oie.10;
        Wed, 06 Nov 2019 17:11:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=icw6S2OVXRtdcU89hq1ruG6UsmLeUp//TCbYMm2btBk=;
        b=LBnx0RY7ec1S3kbRk3qvTH4Pa1dt8KKBvTZsmY9Vy+pwy5Se0WsjFIu8mqYIgtm/I6
         mUyiBNlzRdRu5xH2QfJeDf7Sgui3Vyh5SdDI6oXDURQu1sfzBAjZ6xw+zhLtuodUycLV
         feur7j5x5AltPb5oVElqudphYC+WDLo8g20Z8/zrNNBXQiPF1A5UQFXsFZVvgzQ129j/
         LUMAJpKAn5p53z6pY+9MnHrui/q6PbRbBcWZZMVUUdpHBrsb4EobcgCLId3MJtbXSDzz
         TyAYVCna45ihhVVVxFR84iHBivrNSybLf47BSWtLbGVyvelfPHIvTZ3sc90StelOx8j6
         hnPQ==
X-Gm-Message-State: APjAAAVkj2Jj8Ef0qcA1zEiV+OHnbu86XILsKrC6OgeDs2sZ0yI/ak/I
        b6R+Y7Qd2gJfeHu+7fYS7g==
X-Google-Smtp-Source: APXvYqxWuabs3rv1PDOsLYIr4ybg0LIvCamfpGN0rR9RPj39X3hmAT+aHnyaQu14PBYsExoD+RRE3Q==
X-Received: by 2002:a05:6808:2d8:: with SMTP id a24mr824426oid.127.1573089075340;
        Wed, 06 Nov 2019 17:11:15 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m25sm233558otj.62.2019.11.06.17.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 17:11:14 -0800 (PST)
Date:   Wed, 6 Nov 2019 19:11:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     p.zabel@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com,
        yuenn@google.com, venture@google.com, benjaminfair@google.com,
        avifishman70@gmail.com, joel@jms.id.au, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: Re: [PATCH v5 2/3] dt-bindings: reset: Add binding constants for
 NPCM7xx reset controller
Message-ID: <20191107011114.GA19324@bogus>
References: <20191106145331.25740-1-tmaimon77@gmail.com>
 <20191106145331.25740-3-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106145331.25740-3-tmaimon77@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 Nov 2019 16:53:30 +0200, Tomer Maimon wrote:
> Add device tree binding constants for Nuvoton BMC NPCM7xx
> reset controller.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  .../dt-bindings/reset/nuvoton,npcm7xx-reset.h | 91 +++++++++++++++++++
>  1 file changed, 91 insertions(+)
>  create mode 100644 include/dt-bindings/reset/nuvoton,npcm7xx-reset.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
