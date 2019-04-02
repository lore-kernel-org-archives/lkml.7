Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF60C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27BFE20883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730890AbfDBM1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 08:27:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:47054 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730099AbfDBM1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 08:27:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id t17so3356979wrw.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 05:27:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=84XKEaT4CcALlJdLU6TbLSH4wKSJNLbfVyM0oAsVIbM=;
        b=ef88Vk5m6CZWHG8ffTteq6XPZKVLxAnKOLTNFp81hPiLkAP9l/uJBa356lGM8rOjST
         AFaCwx7JVwEP9ctW0rS8wwnthtBBYAqFu8vuLFesW2PoM2G97Mwcmh5T/bTA40XTdojy
         Hm7B/hPk3D10RCAeJnTlkR0a068UyWnhJYw8p3TKCgZwKj70WrVrCKtaJNTx0ftNvcTQ
         5lYpQ1alwhEHNFjSCd633Sw5MbuueFXkVQftj/ySx2J7s+HueWo8b+pMz/tgKoo0+P8w
         8130v2zX87jyrCo3v87Imm1PU6YHYDYr3/arcfpx+1UhOtCnqCO970PsaKerAVkdzs/R
         7k3A==
X-Gm-Message-State: APjAAAU+ktTVUWipWgIYCPjDltlzg4cOYakiev6kFpJsTSUnGNriVOgE
        z8RMpMqaBv6pPdmHR9o1THU=
X-Google-Smtp-Source: APXvYqyulZw4PiBhwJS2jxhnqVEmKfrZRz5Wj2gcyzB7AAsrL3w02x+QciHY233jL4md9bAn7L4i1w==
X-Received: by 2002:adf:f1ce:: with SMTP id z14mr28484866wro.152.1554208035305;
        Tue, 02 Apr 2019 05:27:15 -0700 (PDT)
Received: from localhost ([90.85.130.193])
        by smtp.gmail.com with ESMTPSA id u2sm13607441wmc.45.2019.04.02.05.27.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 05:27:14 -0700 (PDT)
From:   Christina Quast <cquast@hanoverdisplays.com>
Cc:     trivial@kernel.org, Christina Quast <cquast@hanoverdisplays.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] fs: kernfs: Corrected spelling mistake
Date:   Tue,  2 Apr 2019 14:27:06 +0200
Message-Id: <20190402122706.27548-1-cquast@hanoverdisplays.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190402120059.GA24119@kroah.com>
References: <20190402120059.GA24119@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

flies => files

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

