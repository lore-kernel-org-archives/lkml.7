Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178E9C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 20:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D39FB20850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 20:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lJHD1f60"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfDLULN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 16:11:13 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:40096 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfDLUKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 16:10:54 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3CKAnPu037530;
        Fri, 12 Apr 2019 15:10:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555099849;
        bh=R4DEYj4XdTtmQLE+YgSCUkUYLQc3oW2RIbaKgF6qBWg=;
        h=From:To:Subject:Date;
        b=lJHD1f60snQAvQeKXGxxWhd+FifL07qDpEBV0FmMd1tNWZ1i5mJtZvpTfpt41dG0R
         +gKpBsMSQyENaFDdPmdHeFAsQI+xUFnqtvUyZNujml/zg0qirnUJiFcak2J/rIx35l
         FFSDYeVjZgzy2qPkxIiJxhlHZQE6SkZALyeHjK4g=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3CKAnug120830
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Apr 2019 15:10:49 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 12
 Apr 2019 15:10:49 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 12 Apr 2019 15:10:49 -0500
Received: from uda0868495.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3CKAnc6059487;
        Fri, 12 Apr 2019 15:10:49 -0500
From:   Murali Karicheri <m-karicheri2@ti.com>
To:     <davem@davemloft.net>, <arvid.brodin@alten.se>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [net-next PATCH 0/3] net: hsr: updates from internal tree
Date:   Fri, 12 Apr 2019 16:13:22 -0400
Message-ID: <20190412201325.29001-1-m-karicheri2@ti.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series picks commit from internal kernel tree.
Patch 1/3 fixes a file name issue introduced in my previous
series.


Murali Karicheri (3):
  net: hsr: fix naming of file and functions
  net: hsr: fix debugfs path to support multiple interfaces
  net: hsr: add tx stats for master interface

 net/hsr/Makefile                             |  2 +-
 net/hsr/{hsr_prp_debugfs.c => hsr_debugfs.c} | 43 ++++++++++----------
 net/hsr/hsr_device.c                         |  6 ++-
 net/hsr/hsr_main.h                           |  9 ++--
 4 files changed, 31 insertions(+), 29 deletions(-)
 rename net/hsr/{hsr_prp_debugfs.c => hsr_debugfs.c} (69%)

-- 
2.17.0

