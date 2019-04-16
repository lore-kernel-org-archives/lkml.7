Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44625C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13FF72075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555383546;
	bh=TVw/dbkEM4qC9iVh79vfpW5LXPXGR3fawv6/LuC8DhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HZGv64jvvd4jOANrVrgtVCXpyUy4+7XYlu3sFoEZePR7k1s5bNim5rVDQ9X4ETY++
	 p2v5YPSyW9PwlgE5JnI/PNQOT5UQqfbh5vWlDNhraTXBF4M/ARIhsAJXmv0OXGsMIE
	 6PUvyZyZRELfDjLVY1bFpR19XWfC2l9cdia0LemM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbfDPC7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 22:59:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44354 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfDPC4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 22:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jXd1MlVWsNEWsNqpR9TI2SnJaz0OJPoUqAjQq3uzC8I=; b=HFuNYCbKPa72Psb3KdqMjQwzAF
        JtKxAA/YSIUFIfjkgo1zXK8aKi+Q0J3Jy9bFDu/81AwzhSDpkAqWlH6txixTKvTLTNCYQwh/DWZ8b
        Ca59h617aZ7GnII6fL7LuhYx5zAzKJIvTQQifaMFRs+f/IYQU4j1BaN5lODQ55Ga+1SF6/IEzYRuB
        n0LGmdI7/clYW5/ZK/OqEgzenYLLHObN+c6LtSHb2NaDTBJsb8hac2THLvWFZsyQdRelc/UZ8l3fK
        kxl/Of7ZeQHTTJndVjlfosZ1HgurceTUiHTLdMm2+Hhsob8TzYL27s5ubRsbCoeXvSD0ttgIwE/fz
        rA+6+7QA==;
Received: from 177.205.118.176.dynamic.adsl.gvt.net.br ([177.205.118.176] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGEGu-0007aq-Ql; Tue, 16 Apr 2019 02:56:32 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hGEGo-0001pY-60; Mon, 15 Apr 2019 23:56:26 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 46/57] docs: cma/debugfs.txt: convert to ReST and move to admin-guide/mm
Date:   Mon, 15 Apr 2019 23:56:11 -0300
Message-Id: <fad74a378f3e988c9519a784bed2a5b4aa471482.1555382110.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1555382110.git.mchehab+samsung@kernel.org>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The debugfs interface for CMA should be there together with other
mm-related documents.

Convert this small file to ReST and move it to its rightful place.

The conversion is actually quite simple: just add a title for the
document. In order to make it to look better for the audience,
also mark the "echo" command as a literal block.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/cma/debugfs.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/cma/debugfs.txt b/Documentation/cma/debugfs.txt
index 6cef20a8cedc..4e06ffabd78a 100644
--- a/Documentation/cma/debugfs.txt
+++ b/Documentation/cma/debugfs.txt
@@ -1,3 +1,7 @@
+=====================
+CMA Debugfs Interface
+=====================
+
 The CMA debugfs interface is useful to retrieve basic information out of the
 different CMA areas and to test allocation/release in each of the areas.
 
@@ -12,7 +16,7 @@ The structure of the files created under that directory is as follows:
  - [RO] count: Amount of memory in the CMA area.
  - [RO] order_per_bit: Order of pages represented by one bit.
  - [RO] bitmap: The bitmap of page states in the zone.
- - [WO] alloc: Allocate N pages from that CMA area. For example:
+ - [WO] alloc: Allocate N pages from that CMA area. For example::
 
 	echo 5 > <debugfs>/cma/cma-2/alloc
 
-- 
2.20.1

