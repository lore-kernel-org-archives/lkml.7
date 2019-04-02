Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5577C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C185820856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730771AbfDBLry convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 07:47:54 -0400
Received: from gloria.sntech.de ([185.11.138.130]:39696 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729568AbfDBLry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 07:47:54 -0400
Received: from we0289.dip.tu-dresden.de ([141.76.177.33] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hBHtL-0002Vj-Ee; Tue, 02 Apr 2019 13:47:47 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     hjc@rock-chips.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: rockchip: add shutdown function to poweroff VOP and HDMI TX
Date:   Tue, 02 Apr 2019 13:47:46 +0200
Message-ID: <81811367.CzZtJVt0pY@phil>
In-Reply-To: <CA+z=w3W+OYgxwejgfbNLJzFP28seh5ij62imuCDAY9XP_V39fQ@mail.gmail.com>
References: <20190308183718.21409-1-jbx6244@gmail.com> <CA+z=w3W+OYgxwejgfbNLJzFP28seh5ij62imuCDAY9XP_V39fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

Am Montag, 11. März 2019, 19:14:27 CEST schrieb Johan Jonker:
> Hi,
> 
> Just found out that this was patched and reverted before.(lol)
> The revert was 3 months ago for RK3399 boards, but other processors
> like RK3066 are left without shutdown now.
> 
> What's the status for a fix?
> Keep using the old patch for now?

I've just resurrected the patch from Vicente, calling the atomic_shutdown
helper. Sadly I forgot to Cc you there, but you can for example find it at

https://patchwork.freedesktop.org/patch/295946/


Heiko


