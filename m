Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424B2C2D0D1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081C9222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576782454;
	bh=BTAqUAWQAmyPZQBX1BsGJul8pE5B7AMyGZlkjMmd0VI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o42sBMXr88N/eGo3bCqKlQaXQzK96/px5LrbqQHZUA/voTR5lSCuRN4LlGmiWpDbU
	 +e4ucAcsd99IodbmH9VWJEsImY8ZE0rynA4qBsOmdoKEfOf45r1v7khZSLjRWGu3/J
	 KP3SCNKQ3xULwXtEAVc0KYTANAcTColD7dgcjkzE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfLSSnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:43:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:34474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728779AbfLSSnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:43:00 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D20C206D7;
        Thu, 19 Dec 2019 18:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576780980;
        bh=BTAqUAWQAmyPZQBX1BsGJul8pE5B7AMyGZlkjMmd0VI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RPBydbtKvciW4xgvhjXd+s0X6Ho57XYsBe/CAUcgLFjBmwITx2MLyM35i7KkOXezd
         hZGq3iSYjRzeYAdYBsb87jcHaJ5Em28FHtRpMzXxKj2TFmY20zNFon6o0Rr6qpb0LT
         FST9v9b4wfz9EcCgi8b6FUQCeiKTwqY8zC+8zg8o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 032/199] MIPS: OCTEON: octeon-platform: fix typing
Date:   Thu, 19 Dec 2019 19:31:54 +0100
Message-Id: <20191219183216.666858316@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183214.629503389@linuxfoundation.org>
References: <20191219183214.629503389@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaro Koskinen <aaro.koskinen@iki.fi>

[ Upstream commit 2cf1c8933dd93088cfb5f8f58b3bb9bbdf1781b9 ]

Use correct type for fdt_property nameoff field.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/21204/
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/cavium-octeon/octeon-platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index 1ba6bcf985702..2ecc8d1b05395 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -502,7 +502,7 @@ static void __init octeon_fdt_set_phy(int eth, int phy_addr)
 	if (phy_addr >= 256 && alt_phy > 0) {
 		const struct fdt_property *phy_prop;
 		struct fdt_property *alt_prop;
-		u32 phy_handle_name;
+		fdt32_t phy_handle_name;
 
 		/* Use the alt phy node instead.*/
 		phy_prop = fdt_get_property(initial_boot_params, eth, "phy-handle", NULL);
-- 
2.20.1



