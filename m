Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29513C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 00:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0633F208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 00:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfF1A2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 20:28:25 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40440 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfF1A2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 20:28:25 -0400
Received: by mail-pl1-f195.google.com with SMTP id a93so2184952pla.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 17:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=BomPkIzRMHtNhgTt9YOOvsPTPOOao9rvEJbBjPIy2x0=;
        b=BwJL/mH9rFXI0vvPqqO2dl/Wa955j/NWsx3M4DC/bWD8GRQivuWjI8IMxL+4mnk3Tk
         XYprBpm3q+VW9x8uejk4z2ovKQQXKFTo8YigY7xM47wYCQ1N1qLO7tpFaYN3QttB6sFV
         NMWXaLaes8OidrKksfq/RbDZRSaFTS/VrqkN+fTRKoKQGLVEmaTngMuhJsxpCgJwP0tf
         vBin2QlsYjd071JRHKgcLQDftzL1pFnLEUDQan6uZyWmZjUVS1xS5zOSz/+8P/TXBxhb
         ZuUIBeJ0ZW38FDZIV/OCxHs1/TRjDm6AeV6JIESP8/eWvDo+qB1NqfFjJdNcWTH88WJI
         ofGQ==
X-Gm-Message-State: APjAAAUAQ3mtbNdpahrzl2eX6169QwfGhmb82ukHjwZS97ypMxsNI5ZU
        JbQNQ+WNb40gFW/qq1NScgsZi69QvhYJgw==
X-Google-Smtp-Source: APXvYqy5kZQtvpH0HuDeBDxfScn8wHazkdQ2pzR/buG34ccvL+ag+VVh/am35IllTvVGB4L622d+Tw==
X-Received: by 2002:a17:902:20ec:: with SMTP id v41mr7541626plg.142.1561681703695;
        Thu, 27 Jun 2019 17:28:23 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id i36sm238048pgl.70.2019.06.27.17.28.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 17:28:23 -0700 (PDT)
Subject: [PATCH] MAINTAINERS: Add Paul as a RISC-V maintainer
Date:   Thu, 27 Jun 2019 17:27:53 -0700
Message-Id: <20190628002753.5573-1-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>
From:   Palmer Dabbelt <palmer@sifive.com>
To:      linux-riscv@lists.infradead.org,
         Paul Walmsley <paul.walmsley@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RISC-V port has grown significantly over the past year.  Paul's been
helping out for a while ago.  We agreed in person that he'd take over
collecting the patches and submitting the PRs, but it looks like I
forgot to make it official.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d0ed735994a5..b54b23261cf5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13472,6 +13472,7 @@ F:	drivers/mtd/nand/raw/r852.c
 F:	drivers/mtd/nand/raw/r852.h
 
 RISC-V ARCHITECTURE
+M:	Paul Walmsley <paul.walmsley@sifive.com>
 M:	Palmer Dabbelt <palmer@sifive.com>
 M:	Albert Ou <aou@eecs.berkeley.edu>
 L:	linux-riscv@lists.infradead.org
-- 
2.21.0

