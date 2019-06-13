Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A91C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 20:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE4D321537
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 20:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560457722;
	bh=6LG9in7pja8a5w1GN/a+95PAyWjDutHkN561WT7tMjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qIKmB9AHXNECH6MPBYRszJDZQwYv+sKTvMfj4rfWLcxPjRrecnvFHFZ/kPDL3a147
	 Y5Q13B7nkEliOrYF1MLIKxuaEqT0k1a3FCwzQZq66AYHUCV5KEcfGb2AysVJOZ5VLh
	 CrpQV2el0DsYM6GBDdS9GOOJ+qzJn/GDe3TzrZcs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729885AbfFMU2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 16:28:42 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34799 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfFMU2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 16:28:41 -0400
Received: by mail-qt1-f193.google.com with SMTP id m29so24176030qtu.1;
        Thu, 13 Jun 2019 13:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aEXZ9ovG0nQIpd8Z74pAm7FU5KWUqGz2YDsBOtBFjmI=;
        b=nqolfzDb7nBOEec3gi2fqxt9lTBXK72M8yfwqaLze7r4xDZXFNJaL5RlWQYnsBrqEw
         UVUYA9gJfo2TIjI4szTcw8boETANuUMKuvVh5S4Vn3BNxhAY8xulFGvdt/d6pwO9VMme
         3zm6hMeoEb25kEzJXcKwgIdJCKAq6rI7xyDZyt4tcXt6f5mWyxhG1BOBMTMcdrVgVK8b
         JJDvg0g7IkNdhYtr7SQ9clWB3pwUUDoUwtJx1YqgTRVTZSI+QMiJVorXls+ecpcHaQTE
         zml0qlrv94UCjWX4ES885xn0gpxlvaDBLNReXzR+AdcTdQn7SeFbJelYpJOdqm5SJVQ7
         bLQg==
X-Gm-Message-State: APjAAAWhuMQHn1rZhp19KP5ic4DC+w2xPLza9SPtkZyDF7g6e59TV7FC
        Ny7Ukcg+sD/Ar48kGPGQ5w==
X-Google-Smtp-Source: APXvYqx/GGQsQaZAE82OHRCzaZxHMgbVOY4Azf/9Ea8dY74XXg53tRU0GwGVV778oTBgcmL/ZE+rbQ==
X-Received: by 2002:ac8:689a:: with SMTP id m26mr34806510qtq.192.1560457720530;
        Thu, 13 Jun 2019 13:28:40 -0700 (PDT)
Received: from localhost ([64.188.179.243])
        by smtp.gmail.com with ESMTPSA id o38sm453562qto.96.2019.06.13.13.28.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 13:28:39 -0700 (PDT)
Date:   Thu, 13 Jun 2019 14:28:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, matthias.bgg@gmail.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: Re: [PATCH 1/2] dt-bindings: input: mtk-pmic-keys: add MT6392
 binding definition
Message-ID: <20190613202838.GA20410@bogus>
References: <20190513142120.6527-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513142120.6527-1-fparent@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 May 2019 16:21:19 +0200, Fabien Parent wrote:
> Add the binding documentation of the mtk-pmic-keys for the MT6392 PMICs.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  .../devicetree/bindings/input/mtk-pmic-keys.txt       | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
