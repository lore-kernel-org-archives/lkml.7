Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD09C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8243020856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730727AbfDBLoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 07:44:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38148 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfDBLog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 07:44:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id k11so16249598wro.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 04:44:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pUC3T+KFPMqkSdft5y94SHojq5KTehiWMuFREzb863E=;
        b=fx2wCWKNnv9jaMlxhc3uRvm7BVLUoFMIcbYTNyKwfBlwirIhca5WCldQ9f73ZYD57a
         oSneETNQ75UL5ww4ldxxFhJOQ096h7gWaUrgxVJ/4WaFgoQfqvc7SFBqOzVR9roSRKyy
         1Iciz4By3mV8JMMv0AGA58e/3tVlEuiBK4AXmcQojP7RHS2sHXtRezDYhpA4aImPuDrS
         qltcAr3xMtBqGYsZsJIRlzzx9TNkfosMhBphq5CmWsveBXTDe+H3nfzP4Le7AkGCNcxt
         VaLnlJ1BxjTL0Dt37egd090kubbZW+VENAhSb+drPJ6zsddA5kPbzBKJriDPU3IKG0ae
         eBjA==
X-Gm-Message-State: APjAAAXwAS0B+/mPqZUHfShsU1d5jIiKQnyrXCRwPwgoIwa5uSKYurX5
        8JOmn5tOngn0yBcg7vU9g8I8V4i4iYY=
X-Google-Smtp-Source: APXvYqxd0YrqNUY/2DULHTbYH/PuGLPIAFBOtopJ3d3uqSSOOVLTpKJSt+gz7S0RNRpt6znmEGbUUw==
X-Received: by 2002:adf:e547:: with SMTP id z7mr43200375wrm.295.1554205474562;
        Tue, 02 Apr 2019 04:44:34 -0700 (PDT)
Received: from localhost ([90.85.130.193])
        by smtp.gmail.com with ESMTPSA id m13sm13327531wmg.42.2019.04.02.04.44.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 04:44:33 -0700 (PDT)
From:   Christina Quast <cquast@hanoverdisplays.com>
Cc:     trivial@kernel.org, Christina Quast <cquast@hanoverdisplays.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] fs: kernfs: Corrected spelling mistake
Date:   Tue,  2 Apr 2019 13:44:14 +0200
Message-Id: <20190402114414.23767-1-cquast@hanoverdisplays.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christina Quast <cquast@hanoverdisplays.com>
---
 include/linux/kernfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index c8893f663470..e446ab97ee0c 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -64,7 +64,7 @@ enum kernfs_root_flag {
 	KERNFS_ROOT_CREATE_DEACTIVATED		= 0x0001,
 
 	/*
-	 * For regular flies, if the opener has CAP_DAC_OVERRIDE, open(2)
+	 * For regular files, if the opener has CAP_DAC_OVERRIDE, open(2)
 	 * succeeds regardless of the RW permissions.  sysfs had an extra
 	 * layer of enforcement where open(2) fails with -EACCES regardless
 	 * of CAP_DAC_OVERRIDE if the permission doesn't have the
-- 
2.20.1

