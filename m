Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB908C282DA
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 06:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F98F21855
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 06:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554530812;
	bh=3HgEj3Ujv7ZcHHeyG0mqcpx3M5niOEcpcy28loowDtk=;
	h=Date:From:Subject:References:In-Reply-To:Cc:Cc:To:List-ID:From;
	b=cehFaxajgrdbPDp8WIHSHLcse+xtPogC1YSa1W9alD88prn+MUv6LfawCo6g7VxWD
	 Y1y9xXWD8yJ6jNCNSFMiT/Qq63/EfH9Fo2znWxQz9D2m9wJhx4c9XbKnILY4qpjaKV
	 mHaOjh48+Uiy2TODt1jaO7orfpdzJzK8k0cPvEJQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfDFGGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 02:06:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33559 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfDFGGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 02:06:50 -0400
Received: by mail-pf1-f193.google.com with SMTP id i19so4467698pfd.0;
        Fri, 05 Apr 2019 23:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:cc:to;
        bh=sA/AuC+EvgS8q1EmEqG5/iUfmidgbX/r7KPJNDbEing=;
        b=CoIlRoeGSXAQsVgMzHVrPPKVSiRWnMDcVxQPfpUp4RtP7fj0DG14F+ltg2UxCXCqqT
         imQOpQinXBrLG2nmjytdIywslU7oz/4m2p9JzNmENHBYWH1cY7Vb5eW0i+VjLddsrv6G
         QRbrND/Hy5yfBTjHB+1Ynvs0nTk0YshkqQDCtK3aV0HHX4rq55b22VdN71t3B9WxVdG0
         z3SGNTSkRRrYAt4sAgqNn2tnVtC2X8h4xAhGn0pHrxWTjkMZyqv7MDIwiVZHjo7A23d8
         WLOO0/8YirEA1M3FK4YwzUt9wsIGUukBRGQTE0U9cJnGaMIxSr75OPQavvV96bnga7R/
         rHRA==
X-Gm-Message-State: APjAAAVAikOt2PLYuStTip8Y0TvNYItpGmxznM7Msd1kFPItEi/Y5rsA
        0+rJZtA15Qj50x3sHjIz+G1e9+N0Dg==
X-Google-Smtp-Source: APXvYqyWYaAMQp2FrgYSuzfThzpTe2wfAO5ZLYGHTyv8ZmnDhST80NjB2d8uLF7sijdtB3ZXbYJZJQ==
X-Received: by 2002:a62:12c9:: with SMTP id 70mr17225504pfs.156.1554530809765;
        Fri, 05 Apr 2019 23:06:49 -0700 (PDT)
Received: from localhost ([210.160.217.71])
        by smtp.gmail.com with ESMTPSA id c189sm36545451pfg.24.2019.04.05.23.06.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 23:06:49 -0700 (PDT)
Message-ID: <5ca841f9.1c69fb81.70acb.c159@mx.google.com>
Date:   Sat, 06 Apr 2019 01:06:46 -0500
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 3/5] media: dt-bindings: aspeed-video: Add missing memory-region property
References: <1554229504-5661-1-git-send-email-eajames@linux.ibm.com> <1554229504-5661-4-git-send-email-eajames@linux.ibm.com>
In-Reply-To: <1554229504-5661-4-git-send-email-eajames@linux.ibm.com>
Cc:     linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        joel@jms.id.au, andrew@aj.id.au, mchehab@kernel.org,
        linux-clk@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, devicetree@vger.kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org
To:     Eddie James <eajames@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  2 Apr 2019 18:25:02 +0000, Eddie James wrote:
> Missed documenting this property in the initial commit.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  Documentation/devicetree/bindings/media/aspeed-video.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

