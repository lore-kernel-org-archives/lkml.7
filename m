Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B20C742BB
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A622C2166E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562934957;
	bh=C2kVbOxnYchY6oyzR+KFZl/MXbCAOU6/w+nsh/3S6nk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p3Zh6ABl6qPFr6qx7F8h54IkU/fnZQUi81vNNI+l37od0RTPOzVHyiB7sG+JtiLDU
	 gc6wdAyKtO86upqRtQ1hmf+DjtjUqIRGEnnk66IsD47B5G/9d4qJCYIBuIwUZyr1LH
	 wtH5NcUhJzntBpo4E+MBzmX1HAioxc9JBBEeV+Zw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbfGLMdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:33:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729631AbfGLMdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:33:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C398C21019;
        Fri, 12 Jul 2019 12:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934817;
        bh=C2kVbOxnYchY6oyzR+KFZl/MXbCAOU6/w+nsh/3S6nk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sybXLUtwo+hgcy21iHSb0oaSk2UDJF/oN8u6qZGQEcqdlGXeD0mtwtqx1hmuPH4VW
         sSoMuQjiqTC1PkUib7blE/rDZ1n6OjKSe1mZe7sf5HdbNnrakFBJVUua2jG73/IVEO
         KDoLI5Cc2DB5aP7Hf4xpY8Vm7AByUTueA2zWjR/w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>
Subject: [PATCH 5.2 39/61] staging: mt7621-pci: fix PCIE_FTS_NUM_LO macro
Date:   Fri, 12 Jul 2019 14:19:52 +0200
Message-Id: <20190712121622.735692956@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712121620.632595223@linuxfoundation.org>
References: <20190712121620.632595223@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergio Paracuellos <sergio.paracuellos@gmail.com>

commit 0ae0cf509d28d8539b88b5f7f24558f5bfe57cdf upstream.

Add missing parenthesis to PCIE_FTS_NUM_LO macro to do the
same it was being done in original code.

Fixes: a4b2eb912bb1 ("staging: mt7621-pci: rewrite RC FTS configuration")
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/mt7621-pci/pci-mt7621.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/mt7621-pci/pci-mt7621.c
+++ b/drivers/staging/mt7621-pci/pci-mt7621.c
@@ -40,7 +40,7 @@
 /* MediaTek specific configuration registers */
 #define PCIE_FTS_NUM			0x70c
 #define PCIE_FTS_NUM_MASK		GENMASK(15, 8)
-#define PCIE_FTS_NUM_L0(x)		((x) & 0xff << 8)
+#define PCIE_FTS_NUM_L0(x)		(((x) & 0xff) << 8)
 
 /* rt_sysc_membase relative registers */
 #define RALINK_PCIE_CLK_GEN		0x7c


