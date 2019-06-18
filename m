Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F22EC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E178B206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560884121;
	bh=g0VxTglB6kxOWl3592YYibHlfp4+z0i9+U3LD0qRVPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P3txaCz6erlRRDUbuPqHi8vTAzT04XxlC0yY7xmsr2g3/CfvbBBxtkVUdM5p4+EFZ
	 C3qTdLPAq3UdK8BaW6WwGdI/PXMo9GrGyDrfeSkdIH+JAA+Hm0vW02e+AjEqZmYFMj
	 Im1PQuJ/CopDV0CB6u7OpK6qg9Fu1oUBTdqm1KfA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730500AbfFRSzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 14:55:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52334 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730475AbfFRSzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 14:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TIxkstX3Yz1i1rLmk+0dEqZy9f5lz47x/sbdggQWrYY=; b=VF2H2XFBGFqvqGcaw4YJPUJsvB
        TsNjnM7B1VvavSSPUyv4h1MNCLzPFyA7TcbKU57736JdsUyRSTcjPDEQu0uuEf3NtL1gIFC9RF899
        xj2SP7e+X64E/Vfx6UusRIDziXF9DPmXXcXi08poLDjn7ZaodQ2i0rFKVv8UuKLEHbegSdpSCbBeX
        oO0q5/qvb8Yui1afLAVL3+03KCKLMp/+es1g6ZAFwWO+fmGpspZntnS+jc6dZpfVm2mOOHenriv36
        Za8J4qgdwiFqIak+x9WQvwNkQf3LNzcyArjusoifyv7JgcxfuWge3BHwbTVLPGDW4EkbM9J+uASNk
        Db7REoOA==;
Received: from 177.133.86.196.dynamic.adsl.gvt.net.br ([177.133.86.196] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdJGG-00083K-3Y; Tue, 18 Jun 2019 18:55:16 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hdJGE-0006Z0-1l; Tue, 18 Jun 2019 15:55:14 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 6/6] drivers: base/node.c: fixes a kernel-doc markups
Date:   Tue, 18 Jun 2019 15:55:12 -0300
Message-Id: <bfda4a23dfd4b14d71d9622acd4e81d178f5bca3.1560884037.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <2ff9c819831995ec34a826d44f9fae87ea3bf8c9.1560883872.git.mchehab+samsung@kernel.org>
References: <2ff9c819831995ec34a826d44f9fae87ea3bf8c9.1560883872.git.mchehab+samsung@kernel.org>
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

v2: Add a missing hunk solving the warning reported as line #78.

 drivers/base/node.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 9be88fd05147..beec80649b33 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -66,6 +66,7 @@ static DEVICE_ATTR(cpulist, S_IRUGO, node_read_cpulist, NULL);
  * @dev:	Device for this memory access class
  * @list_node:	List element in the node's access list
  * @access:	The access class rank
+ * @hmem_attrs: Heterogeneous memory performance attributes
  */
 struct node_access_nodes {
 	struct device		dev;
@@ -673,8 +674,8 @@ int register_cpu_under_node(unsigned int cpu, unsigned int nid)
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


