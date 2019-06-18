Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB8CC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B30121479
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560884072;
	bh=M8Z6MKvDJFtGbY9f6b0OGdPP9p+SXSF+G/rAYyafZ2I=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=s+24mOWIHcIMXI0uWLR7xXdNHIWno2kWSckiS3HMdu6hP2PbPcu8A/acceA1LCBTB
	 kG7BsLV3IP/I2PxmK5KSaCCAlp8bvMEcopLWXkAkHpXfqOZz87b35LF/nXL3Z1EkIq
	 /VTRM4qb/U3JWFaw6gyQiObOvkmPjquXZliQ6+v0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730420AbfFRSya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 14:54:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:36398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730162AbfFRSya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 14:54:30 -0400
Received: from localhost.localdomain (unknown [194.230.155.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C1F2206BA;
        Tue, 18 Jun 2019 18:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560884069;
        bh=M8Z6MKvDJFtGbY9f6b0OGdPP9p+SXSF+G/rAYyafZ2I=;
        h=From:To:Cc:Subject:Date:From;
        b=FwwdkRijMUE3FzSIX8cOP68Gv71Gy8TC8ni2fBHlv4Z+1+WwcgGxSAR6QPIzSgiH2
         FQXA0Y6Q+Dn3wsQYugWtouvYvm1nNH0ed8qAlKUHw9N/jmwlUTY9MT7FuuoekvgFb8
         I2tIv/YgHYY8Vg19rK2DZxHnUHWc/Bwo+j/DNetg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] net: hns3: Fix inconsistent indenting
Date:   Tue, 18 Jun 2019 20:54:22 +0200
Message-Id: <20190618185422.3726-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix wrong indentation of goto return.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 58633cdcdcfd..c3c79e92b1f7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3864,7 +3864,7 @@ static int hns3_client_init(struct hnae3_handle *handle)
 	ret = hns3_client_start(handle);
 	if (ret) {
 		dev_err(priv->dev, "hns3_client_start fail! ret=%d\n", ret);
-			goto out_client_start;
+		goto out_client_start;
 	}
 
 	hns3_dcbnl_setup(handle);
-- 
2.17.1

