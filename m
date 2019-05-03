Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35D9C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 10:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A00DB2075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 10:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=crashcourse.ca header.i=@crashcourse.ca header.b="UPdLSeju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfECKNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 06:13:02 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:34004 "EHLO
        somersetfoodbank.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfECKNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 06:13:02 -0400
X-Greylist: delayed 1515 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 May 2019 06:13:01 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=alUy8Jq4vitcVcXsUaRK97EQ2xv6e/+wFnS0LwHJgDM=; b=UPdLSejucmigWYuYGE/iKHFiAD
        /y1lWeGuEROSJ9ownVais5uWdB1pMD+Ixp1CPg/CtsYTle2+wUBvLhP/PKTRQYUc3md86i0S4AYUz
        YzoeBBJqaYwVVEPeWC+lAs5hIUOXziOlgLiGK43ITNZre5zJQrrqv037mnSgiClqEwEzSJV1Q5FA4
        N7RYAmwKf8TffVHO1vz6Q1UjHa1OT05pVYAmJRx3SEfUI5ewJ2QVPs7NsI/PxRFn0RejQNj/oxHQx
        P5RVVdvsnZiGPhUF/j/bSkKzTcXLVZUdbQtWiP6AM4qEtjJ8PyWXXgl1SEg4VWHjN5sCdCgD1EU1n
        e/kkZWAQ==;
Received: from [72.142.126.219] (port=58096 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1hMUn9-0001C2-5w; Fri, 03 May 2019 05:47:44 -0400
Date:   Fri, 3 May 2019 05:47:42 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc:     mporter@kernel.crashing.org, alex.bou9@gmail.com
Subject: [PATCH] MAINTAINERS: RAPIDIO: include more rapidio-related content
Message-ID: <alpine.LFD.2.21.1905030545110.5476@localhost.localdomain>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Add missing RAPIDIO-related files and directories to MAINTAINERS
entry.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/MAINTAINERS b/MAINTAINERS
index 5c38f21aee78..1bd2f95c0df6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13020,6 +13020,16 @@ M:	Matt Porter <mporter@kernel.crashing.org>
 M:	Alexandre Bounine <alex.bou9@gmail.com>
 S:	Maintained
 F:	drivers/rapidio/
+F:	include/linux/rio.h
+F:	include/linux/rio_drv.h
+F:	include/linux/rio_ids.h
+F:	include/linux/rio_regs.h
+F:	include/uapi/linux/rio_cm_cdev.h
+F:	include/uapi/linux/rio_mport_cdev.h
+F:	Documentation/rapidio/
+F:	Documentation/ABI/testing/sysfs-bus-rapidio
+F:	Documentation/ABI/testing/sysfs-class-rapidio
+F:	Documentation/driver-api/rapidio.rst

 RAS INFRASTRUCTURE
 M:	Tony Luck <tony.luck@intel.com>

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                         http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
