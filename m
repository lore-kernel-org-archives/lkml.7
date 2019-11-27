Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C67C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D997A20637
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574888664;
	bh=tbrUviMnNBQSpfe313dBOETUABwOxt7qbL94XpnV9Dc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=plbtNgSBXXSKqC4Ta3TIQ+QqnJDXgrq7k1ukWooT2dvS+sgCPL3PTTm5fLXMy++z6
	 zJJZPtPE9XxKADSF/MuhkYoAVvnSsB+FB9+CPjqiF5EDYyp+MrxVUZSSEmuIMyeBjz
	 kPOobZnKMDVHPy/0Gc7dCSRX04E6fSDvHABm+HEY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732138AbfK0VEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:04:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:57812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732135AbfK0VEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:04:20 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61C17215F1;
        Wed, 27 Nov 2019 21:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888659;
        bh=tbrUviMnNBQSpfe313dBOETUABwOxt7qbL94XpnV9Dc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1/BOcSYZ9+gyxhH4gjbtE4+QHNHeeC+IHGS+Cnb0ui7MQRRQfwnj+SX75Tt2N8LGy
         62XtEOqhiQfKxlz+OjqDC3diDGv4Kfb0YxLB6RDMgAbHwymqP79qWwGAzi+jGVFglf
         Sy9YCfQZ2CnMwW0dxwKwvPH6luQ7RW10Rff0tZsY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 219/306] rtl8xxxu: Fix missing break in switch
Date:   Wed, 27 Nov 2019 21:31:09 +0100
Message-Id: <20191127203131.058848545@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

[ Upstream commit 307b00c5e695857ca92fc6a4b8ab6c48f988a1b1 ]

Add missing break statement in order to prevent the code from falling
through to the default case.

Fixes: 26f1fad29ad9 ("New driver: rtl8xxxu (mac80211)")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 505ab1b055ff4..2b4fcdf4ec5bb 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -5691,6 +5691,7 @@ static int rtl8xxxu_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		break;
 	case WLAN_CIPHER_SUITE_TKIP:
 		key->flags |= IEEE80211_KEY_FLAG_GENERATE_MMIC;
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
-- 
2.20.1



