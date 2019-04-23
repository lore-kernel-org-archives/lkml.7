Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33FBC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F6F4208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbfDWRyh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:54:37 -0400
Received: from gloria.sntech.de ([185.11.138.130]:35482 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726655AbfDWRyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 13:54:36 -0400
Received: from p57b772a1.dip0.t-ipconnect.de ([87.183.114.161] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hIzco-0003ub-LG; Tue, 23 Apr 2019 19:54:34 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     linux-kernel@vger.kernel.org, wang.yi59@zte.com.cn,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 3/4] ARM: rockchip: fix a leaked reference by adding missing of_node_put
Date:   Tue, 23 Apr 2019 19:54:34 +0200
Message-ID: <2700593.YbihCcEB6N@phil>
In-Reply-To: <1551785577-45896-3-git-send-email-wen.yang99@zte.com.cn>
References: <1551785577-45896-1-git-send-email-wen.yang99@zte.com.cn> <1551785577-45896-3-git-send-email-wen.yang99@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 5. März 2019, 12:32:56 CEST schrieb Wen Yang:
> The call to of_get_next_child returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
> 
> Detected by coccinelle with the following warnings:
> ./arch/arm/mach-rockchip/platsmp.c:250:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 241, but without a corresponding object release within this function.
> ./arch/arm/mach-rockchip/platsmp.c:260:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 241, but without a corresponding object release within this function.
> ./arch/arm/mach-rockchip/platsmp.c:263:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 241, but without a corresponding object release within this function.
> 
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-rockchip@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org

applied for 5.2 after adapting the patch subject a little bit

Thanks
Heiko


