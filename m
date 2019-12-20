Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10C7C4741C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6B124695
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576852254;
	bh=dANxbATojZDgt93uvjH1G9EcIEZvg1xeO8+gLAkF7ME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iJCZfENfWpXngkpQZnhSm7VrO2vKLrfzn4t5LGVvV9H2/ydvkKTCeIxmf7u7BYc6J
	 Q+hAp3DQa5EEk4yklQHp7wXWGwgc+v9mZppIPd0G28MFudcH1EDG9NCJjhUjhsUhE/
	 H46QzODY217Nh8yXYpMRRFD9rfV3DoOGtRqh4GUw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbfLTOax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 09:30:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:34494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727840AbfLTOan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 09:30:43 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C384B21D7D;
        Fri, 20 Dec 2019 14:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576852242;
        bh=dANxbATojZDgt93uvjH1G9EcIEZvg1xeO8+gLAkF7ME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X9fCcZ/TlVx7EEciBuJEhCk8WkwMgIvup6HDpBv/uG/+63qigCziT7SSFAX1afTFd
         Zp/AZ3yZ2qDEqoZus9dl06l84Gbo5m3DH2W6x9K7dQ+Gj7FjzKrboIV/s8qXCXhklB
         CuWmNTKbvPa7rpD29BaZZfG+EUP6hD9R2/wqNmV4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kay Friedrich <kay.friedrich@fau.de>,
        Michael Kupfer <michael.kupfer@fau.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 5.4 35/52] staging/wlan-ng: add CRC32 dependency in Kconfig
Date:   Fri, 20 Dec 2019 09:29:37 -0500
Message-Id: <20191220142954.9500-35-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220142954.9500-1-sashal@kernel.org>
References: <20191220142954.9500-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kay Friedrich <kay.friedrich@fau.de>

[ Upstream commit 2740bd3351cd5a4351f458aabaa1c9b77de3867b ]

wlan-ng uses the function crc32_le,
but CRC32 wasn't a dependency of wlan-ng

Co-developed-by: Michael Kupfer <michael.kupfer@fau.de>
Signed-off-by: Michael Kupfer <michael.kupfer@fau.de>
Signed-off-by: Kay Friedrich <kay.friedrich@fau.de>
Link: https://lore.kernel.org/r/20191127112457.2301-1-kay.friedrich@fau.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/wlan-ng/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/wlan-ng/Kconfig b/drivers/staging/wlan-ng/Kconfig
index ac136663fa8e5..082c16a31616e 100644
--- a/drivers/staging/wlan-ng/Kconfig
+++ b/drivers/staging/wlan-ng/Kconfig
@@ -4,6 +4,7 @@ config PRISM2_USB
 	depends on WLAN && USB && CFG80211
 	select WIRELESS_EXT
 	select WEXT_PRIV
+	select CRC32
 	help
 	  This is the wlan-ng prism 2.5/3 USB driver for a wide range of
 	  old USB wireless devices.
-- 
2.20.1

