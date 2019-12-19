Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EC3C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 23:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5305206EC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 23:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576796869;
	bh=1UwGQnsKsSVL/Sjr7ExtByNFEaes7NdRMbEJNsn3Jok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VVTisT7wMZqAKgGB5NKeIfkmKX1kz0NJ+PWx84eWtdZ1v5LWm8XRnbTmPWf3A2KMk
	 ns+vjajV1il5wEOVHHINtfAV92jZUXkR1ulEvn1ST4jefG0ns4RLkqOLFs4RLR+htp
	 IDO7eRFd0igSmh7luovuR/5ruEC8+hrgOEpA/5Ak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfLSXHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 18:07:49 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35978 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfLSXHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 18:07:48 -0500
Received: by mail-ot1-f67.google.com with SMTP id w1so9261060otg.3;
        Thu, 19 Dec 2019 15:07:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DgX0NKioz1rOLIBSrzLogpmefAWeE3WIM8ZkXd4rq84=;
        b=WvTmuBodTGIZtY1oFNFfJL0P6LAVRUMz2RXFVwdEzb3k0zNZprzumrcfEJLVlUj8yp
         eJhAOgQANtKA3NE6nlsUmEB+npmJFyCodJNpc/aCoHP5CRqSW5jRiy8+GhR33bhqklxi
         61NCAL6XVIiQqYPKPf2RnEut8DlioGfjSrrmaS+dNLvjjKGlwfz4+gkvhWQ31vlK4y83
         53cDWoztNiU0D0wxq9unRi9FyVVG2u9EaknyiNb3IPBZQlwy5IxtLtScoijx6bilLBLV
         6bVQbr2MsZiwDMCVNnXzPHc8RMGyUgzBa/zyCf39b5q5oKuqZYFC51o5UPQdn5kb8B1D
         ocVQ==
X-Gm-Message-State: APjAAAUHTprp+HyYz1W3FNwXBIrgXuCSt1GQbApXkedTvuLLYbbuo2Or
        rJNMMu6QE0gaCLdcBdK7eg==
X-Google-Smtp-Source: APXvYqwB9T3HzArMlvLUll2SoZeItk08mg/8cUPV/SIjXWZaF7FfZ7O50gyaF8wV0hnYcqYD0TrjJA==
X-Received: by 2002:a9d:7c97:: with SMTP id q23mr11280615otn.253.1576796867866;
        Thu, 19 Dec 2019 15:07:47 -0800 (PST)
Received: from localhost (ip-184-205-174-147.ftwttx.spcsdns.net. [184.205.174.147])
        by smtp.gmail.com with ESMTPSA id n25sm2528516oic.6.2019.12.19.15.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 15:07:47 -0800 (PST)
Date:   Thu, 19 Dec 2019 17:07:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rocky Liao <rjliao@codeaurora.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, marcel@holtmann.org,
        johan.hedberg@gmail.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bgodavar@codeaurora.org, Rocky Liao <rjliao@codeaurora.org>
Subject: Re: [PATCH v1 2/2] dt-bindings: net: bluetooth: Add device tree
 bindings for QCA6390
Message-ID: <20191219230745.GA9366@bogus>
References: <0101016ef8b923cf-ef36a521-9c4b-4360-842d-d641e0eaaf0e-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0101016ef8b923cf-ef36a521-9c4b-4360-842d-d641e0eaaf0e-000000@us-west-2.amazonses.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Dec 2019 06:08:33 +0000, Rocky Liao wrote:
> Add compatible string for the Qualcomm QCA6390 Bluetooth controller
> 
> Signed-off-by: Rocky Liao <rjliao@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
