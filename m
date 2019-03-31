Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1F2C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 15:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5655620882
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 15:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731306AbfCaPgQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 11:36:16 -0400
Received: from gloria.sntech.de ([185.11.138.130]:51812 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731162AbfCaPgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 11:36:15 -0400
Received: from p5b1271a2.dip0.t-ipconnect.de ([91.18.113.162] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hAcV9-0000lR-HH; Sun, 31 Mar 2019 17:36:03 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     hjc@rock-chips.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/4] ARM: dts: rockchip: add rk3066 hdmi nodes
Date:   Sun, 31 Mar 2019 17:36:02 +0200
Message-ID: <129514949.lNtq4q1g8b@phil>
In-Reply-To: <20190330095639.14626-3-jbx6244@gmail.com>
References: <20190330095639.14626-1-jbx6244@gmail.com> <20190330095639.14626-3-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 30. März 2019, 10:56:37 CEST schrieb Johan Jonker:
> From: Zheng Yang <zhengyang@rock-chips.com>
> 
> This patch adds the hdmi nodes to rk3066.
> 
> Signed-off-by: Zheng Yang <zhengyang@rock-chips.com>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

applied for 5.2 after correcting the alphabetical sorting of some
properties.

Thanks
Heiko


