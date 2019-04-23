Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B96C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E716C2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfDWKKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:10:06 -0400
Received: from www3345.sakura.ne.jp ([49.212.235.55]:12582 "EHLO
        www3345.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfDWKKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 06:10:06 -0400
Received: from fsav102.sakura.ne.jp (fsav102.sakura.ne.jp [27.133.134.229])
        by www3345.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x3NAA4Ma096115;
        Tue, 23 Apr 2019 19:10:04 +0900 (JST)
        (envelope-from na-hoan@jinso.co.jp)
Received: from www3345.sakura.ne.jp (49.212.235.55)
 by fsav102.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp);
 Tue, 23 Apr 2019 19:10:04 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp)
Received: from localhost (p14010-ipadfx41marunouchi.tokyo.ocn.ne.jp [61.118.107.10])
        (authenticated bits=0)
        by www3345.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x3NA9xCK096063
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 23 Apr 2019 19:10:04 +0900 (JST)
        (envelope-from na-hoan@jinso.co.jp)
From:   Nguyen An Hoan <na-hoan@jinso.co.jp>
To:     linux-renesas-soc@vger.kernel.org,
        ramesh.shanmugasundaram@bp.renesas.com, horms@verge.net.au
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kuninori.morimoto.gx@renesas.com, magnus.damm@gmail.com,
        yoshihiro.shimoda.uh@renesas.com, h-inayoshi@jinso.co.jp,
        na-hoan@jinso.co.jp, cv-dong@jinso.co.jp
Subject: [PATCH 1/2] media: dt-bindings: media: Add r8a77965 DRIF bindings
Date:   Tue, 23 Apr 2019 19:09:58 +0900
Message-Id: <1556014199-12698-1-git-send-email-na-hoan@jinso.co.jp>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hoan Nguyen An <na-hoan@jinso.co.jp>

Add r8a77965 DRIF bindings.

Signed-off-by: Hoan Nguyen An <na-hoan@jinso.co.jp>
---
 Documentation/devicetree/bindings/media/renesas,drif.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/renesas,drif.txt b/Documentation/devicetree/bindings/media/renesas,drif.txt
index 0d8974a..16cdee3 100644
--- a/Documentation/devicetree/bindings/media/renesas,drif.txt
+++ b/Documentation/devicetree/bindings/media/renesas,drif.txt
@@ -41,6 +41,7 @@ Required properties of an internal channel:
 -------------------------------------------
 - compatible:	"renesas,r8a7795-drif" if DRIF controller is a part of R8A7795 SoC.
 		"renesas,r8a7796-drif" if DRIF controller is a part of R8A7796 SoC.
+		"renesas,r8a77965-drif" if DRIF controller is a part of R8A77965 SoC.
 		"renesas,rcar-gen3-drif" for a generic R-Car Gen3 compatible device.
 
 		When compatible with the generic version, nodes must list the
-- 
2.7.4

