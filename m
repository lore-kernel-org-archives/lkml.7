Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3429C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 17:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B251B21783
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 17:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408080AbfIYRFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 13:05:20 -0400
Received: from verein.lst.de ([213.95.11.211]:59367 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407542AbfIYRFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 13:05:20 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D96AB68B02; Wed, 25 Sep 2019 19:05:16 +0200 (CEST)
Date:   Wed, 25 Sep 2019 19:05:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keerthy <j-keerthy@ti.com>
Cc:     arnd@arndb.de, nsekhar@ti.com, olof@lixom.net, t-kristo@ti.com,
        catalin.marinas@arm.com, will@kernel.org, tony@atomide.com,
        s-anna@ti.com, hch@lst.de, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 linux-next 0/4] arm/arm64: configs: Convert all
 CONFIG_REMOTEPROC instances to y
Message-ID: <20190925170516.GA16678@lst.de>
References: <20190920075946.13282-1-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920075946.13282-1-j-keerthy@ti.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Keerthy,

the patches look good to me:

Acked-by: Christoph Hellwig <hch@lst.de>
