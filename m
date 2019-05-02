Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEADC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 807D02081C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556810850;
	bh=MjABCqfS1k0O8GsSNRdgRMIOkFguu2lYHJe3/fEpjUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ITWjinwEUqSs6NQsc+Bf1tdlBg8C4g7Zs6uW5ATk53rhiw6zFbeCI9h8u+Bmx6X65
	 rnW1Yv9jauIlW3CsJ6Y6bO2KQZJWOtgIRDcVVczJS1f0ZWkz28GVI7lJeD5c4x19Lu
	 NStaqJNeZ4TmMLnwJ02gtFvDLtw7+0+VTCtkEpx8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbfEBP13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:27:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:44268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727970AbfEBP11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:27:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62D12214DA;
        Thu,  2 May 2019 15:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556810846;
        bh=MjABCqfS1k0O8GsSNRdgRMIOkFguu2lYHJe3/fEpjUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P/q89/jsZei2DZ7FxrJPeaEkhe193nPY8Lq/CpDkg38g3FI2IY92Flew/5fhTarwN
         ROdqoed3MN1kRyfY46o1tEkOnjIBWo7ejXzO4Ae7aKu7M1NpW7CQR17fITR+/Wqg3+
         R9r8PbWK/I3Du6CWYVA+5MkVlOdJgWwLG+URykAY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maxim Zhukov <mussitantesmortem@gmail.com>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 4.19 15/72] staging, mt7621-pci: fix build without pci support
Date:   Thu,  2 May 2019 17:20:37 +0200
Message-Id: <20190502143334.548435560@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502143333.437607839@linuxfoundation.org>
References: <20190502143333.437607839@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 90cd9bed5adb3e3bd4d3ac4cbcecbc4a8028bbaf ]

Add depends on PCI for PCI_MT7621

Signed-off-by: Maxim Zhukov <mussitantesmortem@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/staging/mt7621-pci/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/mt7621-pci/Kconfig b/drivers/staging/mt7621-pci/Kconfig
index d33533872a16..c8fa17cfa807 100644
--- a/drivers/staging/mt7621-pci/Kconfig
+++ b/drivers/staging/mt7621-pci/Kconfig
@@ -1,6 +1,7 @@
 config PCI_MT7621
 	tristate "MediaTek MT7621 PCI Controller"
 	depends on RALINK
+	depends on PCI
 	select PCI_DRIVERS_GENERIC
 	help
 	  This selects a driver for the MediaTek MT7621 PCI Controller.
-- 
2.19.1



