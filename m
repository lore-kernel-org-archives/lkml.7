Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95301C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 21:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 777BC21835
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 21:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbfI2VkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 17:40:02 -0400
Received: from gloria.sntech.de ([185.11.138.130]:46008 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbfI2VkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 17:40:02 -0400
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iEgv8-0001fh-UF; Sun, 29 Sep 2019 23:39:58 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        christoph.muellner@theobroma-systems.com
Subject: Re: [PATCH] dt-bindings: arm: rockchip: fix Theobroma-System board bindings
Date:   Sun, 29 Sep 2019 23:39:58 +0200
Message-ID: <2067842.OmCvtMiqeS@phil>
In-Reply-To: <20190917083453.25744-1-heiko@sntech.de>
References: <20190917083453.25744-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 17. September 2019, 10:34:53 CEST schrieb Heiko Stuebner:
> The naming convention for the existing Theobroma boards is
> soc-q7module-baseboard, so rk3399-puma-haikou and the in-kernel
> devicetrees also follow that scheme.
> 
> For some reason in the binding a wrong or outdated naming slipped
> in which does not match the used devicetrees and makes the dt-schema
> complain now.
> 
> Fix this by using the names used in the wild by actual boards.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

added a Fixes tag and applies as fix for 5.4


