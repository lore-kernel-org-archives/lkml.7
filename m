Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53B1C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 21:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC220208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 21:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfJJVbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 17:31:07 -0400
Received: from gloria.sntech.de ([185.11.138.130]:33860 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbfJJVbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 17:31:07 -0400
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iIg1S-0007Bv-HL; Thu, 10 Oct 2019 23:30:58 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Vivek Unune <npcomplete13@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, ezequiel@collabora.com,
        vicencb@gmail.com, akash@openedev.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Fix usb-c on Hugsun X99 TV Box
Date:   Thu, 10 Oct 2019 23:30:57 +0200
Message-ID: <1594003.l3tWjkc0Ga@phil>
In-Reply-To: <20190929032230.24628-1-npcomplete13@gmail.com>
References: <20190929032230.24628-1-npcomplete13@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 29. September 2019, 05:22:30 CEST schrieb Vivek Unune:
> Fix usb-c on X99 TV Box. Tested with armbian w/ kernel 5.3
> 
> Signed-off-by: Vivek Unune <npcomplete13@gmail.com>

applied as fix for 5.4

Thanks
Heiko


