Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8E4CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 587B3205C9
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572210770;
	bh=qhJM50bxO+MG7WrkXdo6i8sZ/JZEPykOMKFr88gZ6t8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=StOTHlRh+1LFOv/fJfbj6ZJkNJgadIr4wyG/nMo81U0NS8XD49ttoXAnG0jWvypwM
	 a6k15E1q7RuYFFpTFhSGWPws/Dkxzh32F30k6l8IR9mb13wVBuB60pwfHd2uHYDwJ2
	 43F2sEi4ViZ33n0jsrSDOu+cCghwznPgZ2jWfBkY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbfJ0VMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:12:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:59684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728695AbfJ0VMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:12:46 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96339208C0;
        Sun, 27 Oct 2019 21:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210766;
        bh=qhJM50bxO+MG7WrkXdo6i8sZ/JZEPykOMKFr88gZ6t8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rNHzLkFCoifjGz4WHdK0Nqx9FZWTDGK6sil2IbLjyQnyhP3HdczuwO3KhmJika3je
         g/6q2gKKR6F91RCq/a4xuSySJQaB7oWa9F1JQIXfgjz/ZpS3eykvtLxxqO/lSCDdIj
         E5W4gxVpXRJWfQS0mlw+MTja3H7R3XC9nvbgR/Og=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
        Paul Burton <paul.burton@mips.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 10/93] MIPS: dts: ar9331: fix interrupt-controller size
Date:   Sun, 27 Oct 2019 22:00:22 +0100
Message-Id: <20191027203254.069647999@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203251.029297948@linuxfoundation.org>
References: <20191027203251.029297948@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksij Rempel <o.rempel@pengutronix.de>

[ Upstream commit 0889d07f3e4b171c453b2aaf2b257f9074cdf624 ]

It is two registers each of 4 byte.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/boot/dts/qca/ar9331.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/qca/ar9331.dtsi b/arch/mips/boot/dts/qca/ar9331.dtsi
index 2bae201aa3651..1c7bf11f8450b 100644
--- a/arch/mips/boot/dts/qca/ar9331.dtsi
+++ b/arch/mips/boot/dts/qca/ar9331.dtsi
@@ -99,7 +99,7 @@
 
 			miscintc: interrupt-controller@18060010 {
 				compatible = "qca,ar7240-misc-intc";
-				reg = <0x18060010 0x4>;
+				reg = <0x18060010 0x8>;
 
 				interrupt-parent = <&cpuintc>;
 				interrupts = <6>;
-- 
2.20.1



