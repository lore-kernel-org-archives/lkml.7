Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AA5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AAA121741
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411061;
	bh=CMelUpm/SFz2/UxL4sw3BY9Qn7JV1dOO4dFH+2PtoI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tEnSs2vmdAw8ibUj0NOOppmutWlqVLTyQAkMrJcGjP+S9ZlcJ6SzuA/Or3O5xdjGp
	 l2ls2JKgwzTguWL9KWaTK7SHhbag8hFOxkHCXjgcal8ysE0wM06OqiBcOLPzOZEb08
	 73yHPDy1cdfSQVr00/LuEbS7rdGXuQfjxU5CcFYA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfCLRRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:17:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:58668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729162AbfCLRQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:16:30 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FDAF21871;
        Tue, 12 Mar 2019 17:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410990;
        bh=CMelUpm/SFz2/UxL4sw3BY9Qn7JV1dOO4dFH+2PtoI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xm2yF8n+VcUSM4f8eq8QcDJp4y19u0ncgwFBN1jnCkhc6s7+whWYH4uf/+lSpL3nq
         Q/tVQsbvsN5tV/qG00EPcxH1Dfu79jWdZAet9nmOY5umH8N1e68W8NySaKui8Asttg
         7Pk2IToqG4ecvJm529fI06F9HZ7cGkON2uotxstI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 087/135] ARM: dts: omap4-droid4: Fix typo in cpcap IRQ flags
Date:   Tue, 12 Mar 2019 10:08:54 -0700
Message-Id: <20190312170349.196616633@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
References: <20190312170341.127810985@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index 4d61e5b1334a..bcced922b280 100644
--- a/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
+++ b/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
@@ -92,7 +92,7 @@
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



