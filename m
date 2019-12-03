Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05722C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA36D20684
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575414634;
	bh=qm5/sHBfu8SWriiyMEBV4y7WHmX7oPbse1mtJOkC930=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EF7tRWjU/1ZZlwJpkgv4A09NWafBUb3N3H1/oMO6RbNnKY3DGhJOa0Ac15LCPPVly
	 Rjl38rWtdaDxlgahK61XP/AbIN472wTLzw8CqQoev4xenudVNIPuEb3nSzQhcUKg1a
	 voyHHDthJ4oTGtSJ4rrdDX8mBHfTZi/0rF9WTxf8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbfLCXKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 18:10:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:57540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728327AbfLCWmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:42:33 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C291206EC;
        Tue,  3 Dec 2019 22:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575412952;
        bh=qm5/sHBfu8SWriiyMEBV4y7WHmX7oPbse1mtJOkC930=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dj9YFIUnh/5fCIkTyerhuB4+GEsHI+Vd+FyWEuHl7Tdo4pK2E8J2jT389YKr86KEL
         8BX16zaLE9M7Gu/gqZ3QBuqAaXguZ2/BRlSkRs/7wQRcr8FTF6MOF7rJLOtByulbiP
         N0Q9RkKklsrvfqt1xq8SbdpXz+MvwpIVU/90Xqw4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roi Dayan <roid@mellanox.com>,
        Eli Britstein <elibr@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 078/135] net/mlx5e: Fix eswitch debug print of max fdb flow
Date:   Tue,  3 Dec 2019 23:35:18 +0100
Message-Id: <20191203213029.374329807@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203213005.828543156@linuxfoundation.org>
References: <20191203213005.828543156@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roi Dayan <roid@mellanox.com>

[ Upstream commit f382b0df6946d48fae80a2201ccff43b41382099 ]

The value is already the calculation so remove the log prefix.

Fixes: e52c28024008 ("net/mlx5: E-Switch, Add chains and priorities")
Signed-off-by: Roi Dayan <roid@mellanox.com>
Reviewed-by: Eli Britstein <elibr@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 35945cdd0a618..3ac6104e9924c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -1085,7 +1085,7 @@ static int esw_create_offloads_fdb_tables(struct mlx5_eswitch *esw, int nvports)
 			    MLX5_CAP_GEN(dev, max_flow_counter_15_0);
 	fdb_max = 1 << MLX5_CAP_ESW_FLOWTABLE_FDB(dev, log_max_ft_size);
 
-	esw_debug(dev, "Create offloads FDB table, min (max esw size(2^%d), max counters(%d), groups(%d), max flow table size(2^%d))\n",
+	esw_debug(dev, "Create offloads FDB table, min (max esw size(2^%d), max counters(%d), groups(%d), max flow table size(%d))\n",
 		  MLX5_CAP_ESW_FLOWTABLE_FDB(dev, log_max_ft_size),
 		  max_flow_counter, ESW_OFFLOADS_NUM_GROUPS,
 		  fdb_max);
-- 
2.20.1



