Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1342EC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7CF620830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554890204;
	bh=gEVs0luHgaKgDIB6rGGrV4eeCFe+sJCoOyIWVOVfJ+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JdlPK0MYtevlu7ap81U7fn/JKhRxZnAEQUkADcrdMSzUldIq0CBiww3inHSs/muby
	 TyhzlOMXwfN+UUAZ8wM7LFNBN85+1CQe0SPIoiCZCYMUxI0SmqyG1JA60y3wbxLWaK
	 wR0VdbHQxG/doq5u7qVoERcMQFm32lklkMpJZ0hg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730368AbfDJJ4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 05:56:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60566 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730335AbfDJJ4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 05:56:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LjqWFQd9f4udM9lpSAPOlXKEaiWBGg47uilrc82cBF4=; b=TSIfJeKgzFVi5wrZEIhCbEyaAx
        OHDQyIG2OOffR0siWt2TJftO7LYL+YFnsXUVuYM89iFPjC7CZx50z5m9xVfzpX1bNYTGSc2/b5oos
        rqI3L4qLDLcOTUpceWtJESTE6ta91YizIVKUtQIgzNfoRl714E3UV5WDcy7VWv7xU/0Jh/CrEden+
        cOaPD3eurEAV+Q6U9NcYMoZtM+uCtb4WtEvehHUow0cut66Us4PBjhkNh2EXQh9/0zWrxYRaRUsSF
        JZCpwqRQLcxDGRhviGoOYrFhcm/syGKd224VuZRzl/f29lJZhH9rlAIhg/Vjb65bOob5VDcgGyTgC
        z4gkpofw==;
Received: from 177.41.129.23.dynamic.adsl.gvt.net.br ([177.41.129.23] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hE9yA-0003D3-Vd; Wed, 10 Apr 2019 09:56:38 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hE9y3-0000o9-Pp; Wed, 10 Apr 2019 06:56:31 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 4/8] docs: ntb.txt: use Sphinx notation for the two ascii figures
Date:   Wed, 10 Apr 2019 06:56:23 -0300
Message-Id: <a4e40245a483aafeb3d820a05b44166cea11f189.1554889999.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1554889999.git.mchehab+samsung@kernel.org>
References: <cover.1554889999.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to make it to build with Sphinx, we need to fix the
notation for two ascii artwork.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/ntb.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/ntb.txt b/Documentation/ntb.txt
index a043854d28df..344a075f81f5 100644
--- a/Documentation/ntb.txt
+++ b/Documentation/ntb.txt
@@ -41,9 +41,10 @@ mainly used to perform the proper memory window initialization. Typically
 there are two types of memory window interfaces supported by the NTB API:
 inbound translation configured on the local ntb port and outbound translation
 configured by the peer, on the peer ntb port. The first type is
-depicted on the next figure
+depicted on the next figure::
+
+ Inbound translation:
 
-Inbound translation:
  Memory:              Local NTB Port:      Peer NTB Port:      Peer MMIO:
   ____________
  | dma-mapped |-ntb_mw_set_trans(addr)  |
@@ -58,9 +59,10 @@ maps corresponding outbound memory window so to have access to the shared
 memory region.
 
 The second type of interface, that implies the shared windows being
-initialized by a peer device, is depicted on the figure:
+initialized by a peer device, is depicted on the figure::
+
+ Outbound translation:
 
-Outbound translation:
  Memory:        Local NTB Port:    Peer NTB Port:      Peer MMIO:
   ____________                      ______________
  | dma-mapped |                |   | MW base addr |<== memory-mapped IO
-- 
2.20.1

