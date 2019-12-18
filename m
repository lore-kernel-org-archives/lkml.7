Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941EEC2D0BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6741B218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576704840;
	bh=qMi4cxsIQysET4oWXLr7YFXG2w/rlgJJcnPgApt1z5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Nx/1SbTodCztkrr+6AsuXZweyoejILt7w8PG5NJLqReWMAvG6oS+NmuW7+03EE5ll
	 ML6sjyyrJESNPOJydpQP8tjdaUeAnvwFmkUZAlNND1cqegpz/wUPNjgt+STnvt/nv3
	 /eKs/6VHpnd6BT6GnRUpmL/bbqSLuy5vwtLlBv78=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfLRVd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 16:33:59 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33290 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfLRVd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:33:59 -0500
Received: by mail-oi1-f194.google.com with SMTP id v140so2001525oie.0;
        Wed, 18 Dec 2019 13:33:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c0tGiynpJxULvbwlFBguiy9u5rn02fPkRpWLO+m4eBo=;
        b=W9MRCR1g8LDSgl48YyB5Fb7EwOQkMp9kYQHUq1lFDsScxo485Wh4O/r/kFOogrgLpz
         n/eG2kNTcA3Y9ezEq+rx35BPu4iyUs07OrP7QHMPTp2b3MZQQ9RhQlfKm90e+AlAc79b
         G7i2p9v2SppxJCqzfQxbdMEk0SgHuTl6SRwZJM5K562r7pYwG0JQ9Qpzeqy96o/dqbo4
         p3uQ97wAYgYvI49eXJySLJumYhHViHnZwSfot9bVVDnMtxtRIvjGP5aH+o5uoCi+y9by
         jNzlnB9eJkmf7ZshtMIC8HuP/mAencqrXsenYf2h9nP7VzOBuJlYAgJ9IfYTWOkFEUXT
         AYLg==
X-Gm-Message-State: APjAAAW6cgf/hmXWVk8EwR8j/JQ32cM0oNnwOkVXhYLt1evZ82r+6qM6
        yqtILMABRM1Pm8agtjXIg/D2y4Fj6A==
X-Google-Smtp-Source: APXvYqxmyvq1VjUYfL1bqfUpq5hpKOG655pjgo7UmbqoYPvSmp241AOklCyO+pXoVFU1SEl7e/iRSg==
X-Received: by 2002:aca:3256:: with SMTP id y83mr1573796oiy.58.1576704838146;
        Wed, 18 Dec 2019 13:33:58 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a65sm1248253otb.68.2019.12.18.13.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 13:33:57 -0800 (PST)
Date:   Wed, 18 Dec 2019 15:33:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     dri-devel@lists.freedesktop.org, thierry.reding@gmail.com,
        sam@ravnborg.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com, maxime@cerno.tech,
        heiko@sntech.de,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: Add vendor prefix for Xinpeng
 Technology
Message-ID: <20191218213357.GA25585@bogus>
References: <20191217222906.19943-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217222906.19943-1-heiko@sntech.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Dec 2019 23:29:04 +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> 
> Shenzhen Xinpeng Technology Co., Ltd produces for example display panels.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
