Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3F4C282DC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D61020989
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nDQFCz5B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731620AbfDER3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:29:01 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:39400 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731133AbfDER3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:29:00 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x35HSteT084498;
        Fri, 5 Apr 2019 12:28:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554485335;
        bh=+idwsba+yzNmD3qxEOQ0G2WSZUsgRL8DZ6Zzn8TZQC0=;
        h=From:To:Subject:Date;
        b=nDQFCz5BpjKzDbyNp+WgM32Z18YaVu7bdyQxJAr0mApvIPyKLfXTa6shMJjrWHe5/
         y+ZXnZPOo7sfh4hHhokW08ntrSzE0WqRVc6ECaNmYszcA+N5loXKxnXz9q5dUgcfd5
         3JSkuGSPR+rXXVaF1ozd8qQQierNij1QwhUaQbAo=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x35HStHo095529
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Apr 2019 12:28:55 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 5 Apr
 2019 12:28:55 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 5 Apr 2019 12:28:55 -0500
Received: from uda0868495.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x35HSsuN095744;
        Fri, 5 Apr 2019 12:28:54 -0500
From:   Murali Karicheri <m-karicheri2@ti.com>
To:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <arvid.brodin@alten.se>,
        <a-kramer@ti.com>
Subject: [PATCH net 00/14] net: hsr: improvements and bug fixes
Date:   Fri, 5 Apr 2019 13:31:22 -0400
Message-ID: <20190405173136.18050-1-m-karicheri2@ti.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series has some coding style fixes and other bug fixes.
Patch 12/14, I have also done SPDX conversion. Not sure if
that is the only thing needed and is correct. So please pay
close attention to this patch before merge as I would like to
avoid any issue related to licensing applicable for this code.

Thanks

Murali Karicheri

Aaron Kramer (1):
  net: hsr: Fix node prune function for forget time expiry

Murali Karicheri (13):
  net: hsr: fix lines exceeding 80 characters
  net: hsr: fix multiple blank lines in the code
  net: hsr: remove unnecessary paranthesis from the code
  net: hsr: fix alignment issues in the code for functions
  net: hsr: fix lines that ends with a '('
  net: hsr: fix NULL checks in the code
  net: hsr: remove unnecessary space after a cast
  net: hsr: fix placement of logical operator in a multi-line statement
  net: hsr: add missing space around operator in code
  net: hsr: remove camel case usage in the code
  net: hsr: add blank line after function declaration
  net: hsr: convert to SPDX identifier
  net: hsr: add debugfs support for display node list

 net/hsr/Makefile          |   1 +
 net/hsr/hsr_device.c      |  66 +++++++++-----------
 net/hsr/hsr_device.h      |   6 +-
 net/hsr/hsr_forward.c     |  90 ++++++++++++---------------
 net/hsr/hsr_forward.h     |   6 +-
 net/hsr/hsr_framereg.c    | 127 ++++++++++++++++----------------------
 net/hsr/hsr_framereg.h    |  18 ++++--
 net/hsr/hsr_main.c        |  16 ++---
 net/hsr/hsr_main.h        |  63 ++++++++++---------
 net/hsr/hsr_netlink.c     |  59 +++++++-----------
 net/hsr/hsr_netlink.h     |   6 +-
 net/hsr/hsr_prp_debugfs.c | 120 +++++++++++++++++++++++++++++++++++
 net/hsr/hsr_slave.c       |  19 ++----
 net/hsr/hsr_slave.h       |   7 +--
 14 files changed, 327 insertions(+), 277 deletions(-)
 create mode 100644 net/hsr/hsr_prp_debugfs.c

-- 
2.17.0

