Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DBFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B7C52085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbfCYOGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:06:22 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:47184 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbfCYOGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:06:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 11291FB06;
        Mon, 25 Mar 2019 15:06:20 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QCfyDqVIXrt1; Mon, 25 Mar 2019 15:06:18 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 21B4A4027C; Mon, 25 Mar 2019 15:06:18 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v4 1/3] dt-bindings: Add vendor prefix for ROCKTECH DISPLAYS LIMITED
Date:   Mon, 25 Mar 2019 15:06:16 +0100
Message-Id: <13cdeeb62780167836fabdeb496fb19262bc53a5.1553522676.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1553522676.git.agx@sigxcpu.org>
References: <cover.1553522676.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ROCKTECH DISPLAYS LIMITED (https://rocktech.com.hk) LCD panel
supplier.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index fae55f50b2d3..326a4b278186 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -346,6 +346,7 @@ ricoh	Ricoh Co. Ltd.
 rikomagic	Rikomagic Tech Corp. Ltd
 riscv	RISC-V Foundation
 rockchip	Fuzhou Rockchip Electronics Co., Ltd
+rocktech	ROCKTECH DISPLAYS LIMITED
 rohm	ROHM Semiconductor Co., Ltd
 ronbo   Ronbo Electronics
 roofull	Shenzhen Roofull Technology Co, Ltd
-- 
2.20.1

