Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF44EC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB2BC20652
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556120381;
	bh=Gx6D8oVIngXZQhCE73Ll4RIrliO5zdIxd1ORVaeWTMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ibc0ZsKAEtyuoFFQvKWNE4DyJDeN/xM861shibMkQ/zhMU1uV5L0c9ciL5j2LB8rW
	 JOJ4Ur+gDFXthM+oUrYz5ESDqbXYYhvQjkwU+P4OAdKBrlZlSyBaQKv5Zj1G9p9hFu
	 3hlA23gW/RfBFdwHeHnul+3rJo7rsVns/aaqUvxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731622AbfDXPjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:39:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:51644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730953AbfDXPjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:39:37 -0400
Received: from localhost.localdomain (user-0ccsrjt.cable.mindspring.com [24.206.110.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B075F218FE;
        Wed, 24 Apr 2019 15:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556120377;
        bh=Gx6D8oVIngXZQhCE73Ll4RIrliO5zdIxd1ORVaeWTMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uw9HpTUz0bc4MRciBhR3fIR8MogAteU9Q6H8uV1JDn6MG1pOJi5fhpaYAGkyVkgmz
         ttGmW5cqlxDPl7G9mC9O0CU7QIkhtlmGyzpqpJoyGW5s+tRbsqT+Pl5q8+42hUzuYE
         Wu/0mKN46gdZvqwgxsMsc4Y/9ya5+uIfsWFM9WIE=
From:   Alan Tull <atull@kernel.org>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        delicious.quinoa@gmail.com, Alan Tull <atull@kernel.org>
Subject: [PATCH 2/2] ARM: socfpga_defconfig: enable LTC2497
Date:   Wed, 24 Apr 2019 10:39:16 -0500
Message-Id: <20190424153916.30115-2-atull@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424153916.30115-1-atull@kernel.org>
References: <20190424153916.30115-1-atull@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the LTC2497 driver to support the two LTC2497's that are on
the SoCFPGA Arria10 Devkit.

Signed-off-by: Alan Tull <atull@kernel.org>
---
 arch/arm/configs/socfpga_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index 08d1b3e11d68..cfc447161c09 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -127,6 +127,8 @@ CONFIG_RTC_DRV_DS1307=y
 CONFIG_DMADEVICES=y
 CONFIG_PL330_DMA=y
 CONFIG_DMATEST=m
+CONFIG_IIO=y
+CONFIG_LTC2497=y
 CONFIG_FPGA=y
 CONFIG_FPGA_MGR_SOCFPGA=y
 CONFIG_FPGA_MGR_SOCFPGA_A10=y
-- 
2.21.0

