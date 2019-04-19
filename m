Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D3CC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D222F222CC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="v8+q2DrJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfDSSX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:23:58 -0400
Received: from condef-10.nifty.com ([202.248.20.75]:46213 "EHLO
        condef-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbfDSSXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:23:54 -0400
X-Greylist: delayed 408 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Apr 2019 14:23:53 EDT
Received: from conuserg-12.nifty.com ([10.126.8.75])by condef-10.nifty.com with ESMTP id x3J5IK41026097;
        Fri, 19 Apr 2019 14:18:20 +0900
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x3J5HXEU018278;
        Fri, 19 Apr 2019 14:17:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x3J5HXEU018278
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1555651054;
        bh=hjC8BvtT+4tqs15iB8UW6C5JqDkO9HtBOxFweQyd4Y0=;
        h=From:To:Cc:Subject:Date:From;
        b=v8+q2DrJ7yWiFFyqsE/DeebgJ1OvhyFakopqaSK2tarojcglHM90VaF0OE33scsNu
         HHLnH48yRS9/U/MDAGJ6xvMDMPoCCR0FGEgGkfs8l5XUWIVAJMnRnU5plimjOpofhG
         tBxG+4pQUK/jZm4Xi2NOjbyOF0IHBib2aD+fK9WgLq7XIDz8f2Nwc6oGD1/p+vPFSr
         icU8rYvambdK4oHzTfolR7Qekq32YwsHvJPSPkj/ufpOAZozFuReZrEucNxccSrKKp
         2TcLKr8irKpGxKiUKNefPvtuAy7y/J7neclAK2uaE+pvl1a6giZGtyn7xeC9p46y/w
         n3zi/0LckjjGw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Saeed Mahameed <saeedm@mellanox.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Leon Romanovsky <leon@kernel.org>
Subject: [PATCH] net/mlx5e: remove meaningless CFLAGS_tracepoint.o
Date:   Fri, 19 Apr 2019 14:17:31 +0900
Message-Id: <20190419051731.15111-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CFLAGS_tracepoint.o specifies CFLAGS for compiling tracepoint.c but
it does not exist under drivers/net/ethernet/mellanox/mlx5/core/.

CFLAGS_tracepoint.o is unused.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/net/ethernet/mellanox/mlx5/core/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index 1a16f6d73cbc..fa12c2ca9fc5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -57,5 +57,3 @@ mlx5_core-$(CONFIG_MLX5_EN_IPSEC) += en_accel/ipsec.o en_accel/ipsec_rxtx.o \
 				     en_accel/ipsec_stats.o
 
 mlx5_core-$(CONFIG_MLX5_EN_TLS) += en_accel/tls.o en_accel/tls_rxtx.o en_accel/tls_stats.o
-
-CFLAGS_tracepoint.o := -I$(src)
-- 
2.17.1

