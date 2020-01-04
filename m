Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396BCC2D0C2
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 15:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 121062465A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 15:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578151376;
	bh=6sqbGcn0je4wFW/TxlyESiINV9NRJSSETNDpI9HWKVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GZubCzIg8K/Lj14PtG+AQnyfCW1xEjuEQ/MxUTS4qF7fVn6YMDIRFOfGEleOkbXz1
	 W4+dFNuPFEVUJyAR5RgKh8+OJVknhHcUhNiioHgHt6ZduAfhET9cpzoimWgNy4fs/G
	 bcbDSWsUHvMoLwt/K/tM6MyjCDwSQCh0cZUyz6pA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbgADPWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 10:22:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:32770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbgADPWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 10:22:51 -0500
Received: from localhost.localdomain (unknown [194.230.155.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00F5C24655;
        Sat,  4 Jan 2020 15:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578151371;
        bh=6sqbGcn0je4wFW/TxlyESiINV9NRJSSETNDpI9HWKVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j3sZOZxEofj9aespnr3Ejre+YYYSg6WLkB1V/+4y9hm1BBcZ8TNTLGB+PkLAE6wY7
         j71JTofOPbimlnyMYz6MbVSMa32nTwxR3jCWswJ/qeSOAVMc6v6bPdxdbbS2ZkT9Y/
         YBeaaVItL+kJn8hD4nnAALKT00ofOOytahCcIMOA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v2 15/20] video: exynos: Rename Exynos to lowercase
Date:   Sat,  4 Jan 2020 16:21:02 +0100
Message-Id: <20200104152107.11407-16-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200104152107.11407-1-krzk@kernel.org>
References: <20200104152107.11407-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up inconsistent usage of upper and lowercase letters in "Exynos"
name.

"EXYNOS" is not an abbreviation but a regular trademarked name.
Therefore it should be written with lowercase letters starting with
capital letter.

The lowercase "Exynos" name is promoted by its manufacturer Samsung
Electronics Co., Ltd., in advertisement materials and on website.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 include/video/samsung_fimd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/video/samsung_fimd.h b/include/video/samsung_fimd.h
index b6571c3cfa31..c4a93ce1de48 100644
--- a/include/video/samsung_fimd.h
+++ b/include/video/samsung_fimd.h
@@ -10,7 +10,7 @@
  *
  * This is the register set for the fimd and new style framebuffer interface
  * found from the S3C2443 onwards into the S3C2416, S3C2450, the
- * S3C64XX series such as the S3C6400 and S3C6410, and EXYNOS series.
+ * S3C64XX series such as the S3C6400 and S3C6410, and Exynos series.
 */
 
 /* VIDCON0 */
-- 
2.17.1

