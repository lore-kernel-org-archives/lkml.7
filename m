Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA75FC76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A43A206DD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564076774;
	bh=5diVvmNkyc6zSgOzgI4GuPDw7o87U7rtPXBELLFBjOY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=AZNJiWukMz2a6pEHV8QWzo9o+GRaJxmXU2kk3hENAUTM2KTsHGMAfYZ7HraYPTiXl
	 PBbQHJmz9Ijun2w8NItN90G1ZB8CHTnWnOQLJTj2lz0f+2nPIqNuzHufx5RF8DFII8
	 LrpJCzN4Fwmn3ByTC9+liHgn1vKsGpKxUJXVXZgI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403767AbfGYRqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 13:46:13 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35217 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbfGYRqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 13:46:13 -0400
Received: by mail-pf1-f194.google.com with SMTP id u14so23138279pfn.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 10:46:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KIEUujZBBpPF2FsXK/3C/Ifc337XmCaBCcdUOmfolVM=;
        b=lAhWb3i3Y4usQSkq4mmBtnzbbrP2F4WFmU1kMV4F9bgGpDsfj0YxOJMQxuTmkubjr7
         7ceoR6UgAeimSxQ0s+0DvfMN66fPiH6aLiGY5Ey0BNqQVgdCISrpdPGN1IK0lx6Qs1/4
         BhvHcySSDQ4BeaB8axJDmZL/KIL34k5+eaCkOpX9inbzHapHESr2Bl5Z8Z8UN/FYs993
         rQYa+H51+FTKuak39+qJ5N+EGMxayigoopNHqGAPNVT0kR0NZmnmFrQddxBMun7nNBV1
         PGJej/kQtxLTMdI/lvMNqVAC6pcHslLD/qpsC5Nig2pnHl5TTQqyrt/KL8eam6ExjJfW
         eB6g==
X-Gm-Message-State: APjAAAVVk60yKdw7JQ+e94APqDgQbYk+Nu8EeRyAhzkWkCDae+DU+6o/
        hi5DCJYS0nsTaPET4jD1mltp/E6PDds=
X-Google-Smtp-Source: APXvYqwSgDnD1dC3KbPIQcEuvMPLs/vPwaApQYOvM2klOHt+mpbLAUeYmQKwYs6mjiWOn6eosqC/ZA==
X-Received: by 2002:a17:90a:380d:: with SMTP id w13mr92156981pjb.138.1564076771845;
        Thu, 25 Jul 2019 10:46:11 -0700 (PDT)
Received: from localhost ([2601:647:5b80:29f7:1bdd:d748:9a4e:8083])
        by smtp.gmail.com with ESMTPSA id 67sm9996001pfd.177.2019.07.25.10.46.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 10:46:10 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fpga@vger.kernel.org, gregkh@linuxfoundation.org,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH] MAINTAINERS: Move linux-fpga tree to new location
Date:   Thu, 25 Jul 2019 10:45:17 -0700
Message-Id: <20190725174517.10516-1-mdf@kernel.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the linux-fpga tree to new location at:
 git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git

Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 783569e3c4b4..c3b5e3dbc74e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6339,7 +6339,7 @@ FPGA MANAGER FRAMEWORK
 M:	Moritz Fischer <mdf@kernel.org>
 L:	linux-fpga@vger.kernel.org
 S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/atull/linux-fpga.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git
 Q:	http://patchwork.kernel.org/project/linux-fpga/list/
 F:	Documentation/fpga/
 F:	Documentation/driver-api/fpga/
-- 
2.22.0

