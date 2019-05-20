Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F37C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40DB8208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558354707;
	bh=3zQ04bEawYHYY0E2jeNugRpJEMpBLaEKZZr/xCFaa1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y0f/OG872YCkMP5loWazOYoHUlkedQGbhT4B7w2w4RcUGqA6SfeIrncHx+XgdCcxO
	 38z5MqKY56jikNhJgTOuT59tE+7Ff5RZs++BNIpf489NG0ezdKNGFwalAzxzoBnX5y
	 kmVUhtopVuWyxbZDVparopEoVnlkjHoo3Z5T2Jg8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733203AbfETMSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:18:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:59424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733208AbfETMSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:18:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DCA920656;
        Mon, 20 May 2019 12:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558354700;
        bh=3zQ04bEawYHYY0E2jeNugRpJEMpBLaEKZZr/xCFaa1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HZovlBnvu4AfCirL3JaDKqlPQbuPI4nfAliTXHe9lL7LNXQWoj456ocm6gvWicBoh
         bSE+gsUYnSqlGqxdEkXzVjTchTo2xOxUO42Ls2iCZoKEGY/5TJZCZ2HYQrtufT7yfh
         9kLNre4qjn9sN/3pBSiF4a4MG65SOr3OmvTL390c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 4.14 10/63] ARM: dts: exynos: Fix audio (microphone) routing on Odroid XU3
Date:   Mon, 20 May 2019 14:13:49 +0200
Message-Id: <20190520115232.357472281@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520115231.137981521@linuxfoundation.org>
References: <20190520115231.137981521@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sylwester Nawrocki <s.nawrocki@samsung.com>

commit 9b23e1a3e8fde76e8cc0e366ab1ed4ffb4440feb upstream.

The name of CODEC input widget to which microphone is connected through
the "Headphone" jack is "IN12" not "IN1". This fixes microphone support
on Odroid XU3.

Cc: <stable@vger.kernel.org> # v4.14+
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi
@@ -23,7 +23,7 @@
 			"Headphone Jack", "HPL",
 			"Headphone Jack", "HPR",
 			"Headphone Jack", "MICBIAS",
-			"IN1", "Headphone Jack",
+			"IN12", "Headphone Jack",
 			"Speakers", "SPKL",
 			"Speakers", "SPKR";
 


