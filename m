Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC97C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C012087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412742;
	bh=40VmgVoOwj6/KtY5f7M+Q+moJaVcKh7HDzqV7JX+wR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mD6gAlMvDtqIytkrY+adAuZI4GtLokCB7EmBA5XD3D7I+P1b8UZhTUT8yiaIOYhJ4
	 oPqFhzzjwXfUft8xVV5Up0P8fn1PLGVSKy8W1kOgtcI8B7mWlVb6lmexkqEHNkhVcj
	 sR19ICWXzvZCO1RD5NiQIlA2AFH2kKkVwziGhCFc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbfCLRP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:15:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:53656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728432AbfCLROi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:14:38 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 782C2206DF;
        Tue, 12 Mar 2019 17:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410877;
        bh=40VmgVoOwj6/KtY5f7M+Q+moJaVcKh7HDzqV7JX+wR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PSk51YqTS9QZqZJkgSJcExtZdsAXuPNm97fWBW9T9tGpq6rRKqor+wzB+SY4Fl0k9
         MRC6kJnLr0Mpw9a3u8/RNpdjsHfWoHJelsqiblihbJLo8oAiZdX7U23gR3yqjnblSP
         r/E//ht26BAkbU6+Owvk7RvAfcbya4Cp9m6VzMsM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 063/149] ARM: dts: omap4-droid4: Fix typo in cpcap IRQ flags
Date:   Tue, 12 Mar 2019 10:08:01 -0700
Message-Id: <20190312170354.990245485@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit ef4a55b9197a8f844ea0663138e902dcce3e2f36 ]

We're now getting the following error:

genirq: Setting trigger mode 1 for irq 230 failed
(regmap_irq_set_type+0x0/0x15c)
cpcap-usb-phy cpcap-usb-phy.0: could not get irq dp: -524

Cc: Sebastian Reichel <sre@kernel.org>
Reported-by: Pavel Machek <pavel@ucw.cz>
Tested-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi b/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
index ddc7a7bb33c0..f57acf8f66b9 100644
--- a/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
+++ b/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
@@ -105,7 +105,7 @@
 			interrupts-extended = <
 				&cpcap 15 0 &cpcap 14 0 &cpcap 28 0 &cpcap 19 0
 				&cpcap 18 0 &cpcap 17 0 &cpcap 16 0 &cpcap 49 0
-				&cpcap 48 1
+				&cpcap 48 0
 			>;
 			interrupt-names =
 				"id_ground", "id_float", "se0conn", "vbusvld",
-- 
2.19.1



