Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE1CC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA2742133D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731840AbfDBOC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:02:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42182 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbfDBOC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 10:02:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id g3so16804952wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 07:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=93gbuDVPoZdQWR86uJnRHRVlnXZgLa67h52WGB1FG/A=;
        b=df0b4QgxkNGsPD9cS2GJwtr1gxAoy+ZgMiQgBhBoHhB/VJqnmDYAnV99PK6n1RnUjk
         HCJye83d/cxELBp/9UsaeqkRODTe8FWpmbyY1nBYavalVRrxp9Yytwqgy1gkkrjQw0lC
         vPmTmZCZg5I+biBNB0r6+ayZZlU/A+PG8x11Vjo5E/aTIbEXcc/HHvEGlnwqTEuGL73h
         7jP3t7Qd9KUfl0MmB42apFqvOGkcMxEWsPMbXCaircTuMTAvdCDcr1C19ovyyXz/2Ld+
         O7cxZiQMllkxOpFVyAuSbjiWfdZBhpReK9jSyr5A6z/+kbgZsRdLoVL1IImhOAEU7HFW
         /xlw==
X-Gm-Message-State: APjAAAXL/WcEQFKfOnmOrHIx+45u4trRlhwemGpBcLxpRFmtedFLjsH7
        dQpNQowHJSXPPbXyWI/FcRU=
X-Google-Smtp-Source: APXvYqzitGNzpxqUzHQ07JU0WxEk3WRim4Br0xyuYTVzhJiuJGEUVI3q0cBYR5qEihdV+6NW0esTOQ==
X-Received: by 2002:a5d:4f8b:: with SMTP id d11mr43776271wru.150.1554213744962;
        Tue, 02 Apr 2019 07:02:24 -0700 (PDT)
Received: from localhost ([90.85.130.193])
        by smtp.gmail.com with ESMTPSA id x18sm13869827wmi.6.2019.04.02.07.02.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 07:02:23 -0700 (PDT)
From:   Christina Quast <cquast@hanoverdisplays.com>
To:     gregkh@linuxfoundation.org
Cc:     trivial@kernel.org, Christina Quast <cquast@hanoverdisplays.com>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] fs: kernfs: Corrected spelling mistake
Date:   Tue,  2 Apr 2019 16:01:46 +0200
Message-Id: <20190402140146.3429-1-cquast@hanoverdisplays.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190402130827.GA32338@kroah.com>
References: <20190402130827.GA32338@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

flies => files

Signed-off-by: Christina Quast <cquast@hanoverdisplays.com>
---

Changes since v1:
	* Added changelog text

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

