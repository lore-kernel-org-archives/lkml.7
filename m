Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84DFC35280
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 22:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB01621855
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 22:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569884324;
	bh=oFOHpsIegBDie0JmpNKIAb9m+QmN2MQ8QREREQVUaSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1T//kT2LkJxl3I2vxWWbcrNvjlyumKSJYi7ItKUJJyqqVGmoT5xHE9CSDwr5mwike
	 eTrtHovjA5jDtAJDJ/gWwpr84W65A7FokTHcvjAdPhxGQyxlCAAS8w9YXnGdDb8A64
	 G5x0cGI4qNwMXMMiyVFkQfO5Bg7N1CqYC+x1zgP4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731889AbfI3W6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 18:58:44 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40524 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731685AbfI3W6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 18:58:42 -0400
Received: by mail-ot1-f67.google.com with SMTP id y39so9865602ota.7;
        Mon, 30 Sep 2019 15:58:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zsh+LJZZ1bYwJ2NNK3krE03pjGa9uFNYkpSwzo6s75E=;
        b=cF3SuEP6UVgmLoVbAww7p98JUkzMwHp1DEDMgGI3sQcZuyAldX6pp1xwW4uBwGVpzA
         gpLjpGJrJ490EgeLAT728uHaTrjaIfZkEfdr02Dlo7Hv46RJO0rqmfQFUXQZ4ReaGWb9
         KjIDP3fgQyZCUXjtEwbtRJ/RPSTFNBF3VXYkNeeVNksJHnhvQ6Z/TrFuuPcH7NTZmsl3
         V6f4iEFd1lhh2Lav213Ss2/mqxT7CHQcary9ygzHhjX56g5McM5/XTkmNV7Ma2yTp//F
         7E2tSgBTlgGI2SoYiSA4GJaJwwbGz6mHJRPjOsjt1jnhDR/peYL3s90YMyS8w6Z2uHNR
         4LBQ==
X-Gm-Message-State: APjAAAUB91R2jikZ49L58S4AymLios4FUn/9Bps/Q8eTdMDaaDo2RgWT
        GiFVd6BLO6Sjr3myv420fg==
X-Google-Smtp-Source: APXvYqwWkT9GDFmYgFBWEu1p/Bs3nmD8s9rnVMBqjB0aVwy3EoB5SB513rfznMUpF2BgtyGrnCCJBg==
X-Received: by 2002:a9d:67c3:: with SMTP id c3mr14456067otn.254.1569884321904;
        Mon, 30 Sep 2019 15:58:41 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 38sm4493219otw.28.2019.09.30.15.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 15:58:41 -0700 (PDT)
Date:   Mon, 30 Sep 2019 17:58:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-rockchip@lists.infradead.org,
        christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH 11/13] dt-bindings: document PX30 usb2phy General
 Register Files
Message-ID: <20190930225840.GA14866@bogus>
References: <20190917082659.25549-1-heiko@sntech.de>
 <20190917082659.25549-11-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917082659.25549-11-heiko@sntech.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Sep 2019 10:26:57 +0200, Heiko Stuebner wrote:
> One of the separate General Register Files contains the registers for
> controlling the usb2phy, so add the necessary binding compatible for it.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  Documentation/devicetree/bindings/soc/rockchip/grf.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
