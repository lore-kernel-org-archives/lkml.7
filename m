Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60440C468BC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 11:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43BC920B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 11:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbfFGLZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 07:25:30 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:35370 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727754AbfFGLZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 07:25:29 -0400
Received: from ramsan ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id MnRT200053XaVaC01nRTyW; Fri, 07 Jun 2019 13:25:27 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hZCzv-0004Ej-1S; Fri, 07 Jun 2019 13:25:27 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hZCzu-0003Zz-Vp; Fri, 07 Jun 2019 13:25:26 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Ariel Elior <aelior@marvell.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jiri Kosina <trivial@kernel.org>
Cc:     GR-everest-linux-l2@marvell.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] qed: Spelling s/configuraion/configuration/
Date:   Fri,  7 Jun 2019 13:25:16 +0200
Message-Id: <20190607112516.13717-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/net/ethernet/qlogic/qed/qed_sriov.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_sriov.h b/drivers/net/ethernet/qlogic/qed/qed_sriov.h
index 9a8fd79611f24909..368e88565783bb50 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_sriov.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_sriov.h
@@ -305,7 +305,7 @@ void qed_iov_bulletin_set_udp_ports(struct qed_hwfn *p_hwfn,
 
 /**
  * @brief Read sriov related information and allocated resources
- *  reads from configuraiton space, shmem, etc.
+ *  reads from configuration space, shmem, etc.
  *
  * @param p_hwfn
  *
-- 
2.17.1

