Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B5BC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2A621479
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560883891;
	bh=YTvpoGmAuHuUqZdPRsIBhQ+I0txss2TLjj9V4BEiJc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LVIY7ST1AH7wuB50puZlCOC1IMS4qmOSq8osLA0KFdCa4HrsFZR8gPSzHCWFaxZO1
	 utdtOPs65TM0qE5HAOPclXsiNU3alYhjUcT9cFtIS+5/A5CW99E4arfa632iD5Mfqi
	 BUOjRkT3x6oNNGDbRhJ0lNn83xBxpZB5W6zbGWhM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbfFRSv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 14:51:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51846 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729642AbfFRSv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 14:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sS7XzFTywdPX1bp97jfirEs5HqvLLi6VQUFoiGF+v9Y=; b=XNNAmsfVfNviGN6Q0U7U4Ct+e5
        Hq1EgLsUPtjCiM6nNVOvWZkpqFijMrvfqqPu/yCCRSKMGMF0vc9RzaAVcHMnqlIAAPoJ94na3Kikk
        VfO8rcRLs70Ef4Xi4s3Yndd0k0766CR40gtQe0jpazAEliFhJaT3w3/TtNjkToc3BrKSx1aVNLtEf
        fm7ylWZOOU3wiwudS+6mqYLv+pGYJ9hrHWtx0E14j7mFsZ1EEW4z6c10xHmqvup/eQ4ZBYxFFqrJO
        nVPcPa1Y67iV0QHn3g4N1YKAKuTA9/L4f1UUh3Liksig8kyTgGnBu0wxpXpC0XNmF2QBFLgeWbUES
        LiYYIzKg==;
Received: from 177.133.86.196.dynamic.adsl.gvt.net.br ([177.133.86.196] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdJCa-0006RJ-1U; Tue, 18 Jun 2019 18:51:28 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hdJCW-0006UR-EM; Tue, 18 Jun 2019 15:51:24 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 6/6] drivers: base/node.c: fixes a kernel-doc markups
Date:   Tue, 18 Jun 2019 15:51:22 -0300
Message-Id: <2ff9c819831995ec34a826d44f9fae87ea3bf8c9.1560883872.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <a83ea390bc28784518fce772b4c961ea1c976f14.1560883872.git.mchehab+samsung@kernel.org>
References: <a83ea390bc28784518fce772b4c961ea1c976f14.1560883872.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There was a typo at the name of the vars inside the kernel-doc
comment, causing those warnings:

	./drivers/base/node.c:690: warning: Function parameter or member 'mem_nid' not described in 'register_memory_node_under_compute_node'
	./drivers/base/node.c:690: warning: Function parameter or member 'cpu_nid' not described in 'register_memory_node_under_compute_node'
	./drivers/base/node.c:690: warning: Excess function parameter 'mem_node' description in 'register_memory_node_under_compute_node'
	./drivers/base/node.c:690: warning: Excess function parameter 'cpu_node' description in 'register_memory_node_under_compute_node'

There's also a description missing here:
	./drivers/base/node.c:78: warning: Function parameter or member 'hmem_attrs' not described in 'node_access_nodes'

Copy an existing description from another function call.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/base/node.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 9be88fd05147..4ee32db9d61d 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -673,8 +673,8 @@ int register_cpu_under_node(unsigned int cpu, unsigned int nid)
 /**
  * register_memory_node_under_compute_node - link memory node to its compute
  *					     node for a given access class.
- * @mem_node:	Memory node number
- * @cpu_node:	Cpu  node number
+ * @mem_nid:	Memory node number
+ * @cpu_nid:	Cpu  node number
  * @access:	Access class to register
  *
  * Description:
-- 
2.21.0

