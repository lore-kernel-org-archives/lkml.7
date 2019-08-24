Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E605EC3A5A4
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 11:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC6162173E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 11:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566647856;
	bh=2gPSnsiLTiZzM3VtEOlTe2NDmgUZRMbJJi3dmdROM2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GVYTWNs0+ZwR8PfNM4yTZ2qlXALFKG9DbLA0FRFbxxi6IbQv25GQd3fWiXXSMP8ji
	 bAGk/SZxgn4U3igqY1utGnAmD/3sqkuNotGu5z5OIoxZvRFm5wj2JcpzRsTHwQBELo
	 MrpSlqQBgyUPs6CZ1i626db+QnwIsc4zQFOLL6Fg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbfHXL5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 07:57:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727779AbfHXL5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 07:57:35 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4A5721670;
        Sat, 24 Aug 2019 11:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566647854;
        bh=2gPSnsiLTiZzM3VtEOlTe2NDmgUZRMbJJi3dmdROM2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oYouPo1TechO7rUXVnYc/d5QQKmx8wd/2lrTjEC73P3PGYatRMoM38205X6ie4daK
         p2SzQtUHn+KtAP9Odb4S7o/WiTSMgXZi3g//oXrgiOt57B1wdHhQilDoxRSI6EBSQd
         kjllxlKtG+xB1eupYlk2xisYyma3Rbw/ijawoDp8=
Date:   Sat, 24 Aug 2019 12:57:28 +0100
From:   Will Deacon <will@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>, youlin.pei@mediatek.com,
        devicetree@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        cui.zhang@mediatek.com, srv_heupstream@mediatek.com,
        chao.hao@mediatek.com, linux-kernel@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org, ming-fan.chen@mediatek.com,
        anan.sun@mediatek.com, Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v11 00/23] MT8183 IOMMU SUPPORT
Message-ID: <20190824115728.hsdsp3ut5mywplaw@willie-the-truck>
References: <1566615728-26388-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566615728-26388-1-git-send-email-yong.wu@mediatek.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 24, 2019 at 11:01:45AM +0800, Yong Wu wrote:
> This patchset mainly adds support for mt8183 IOMMU and SMI.

Thanks for persevering with this, and sorry it took me so long to get
to grips with the io-pgtable changes.

Joerg -- this is good for you to pick up from my side now, but if you run
into any fiddly conflicts with any of my other changes then I'm happy to
resolve them on a separate branch for you to pull.

Just let me know.

Cheers,

Will
