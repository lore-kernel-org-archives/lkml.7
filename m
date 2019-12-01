Return-Path: <SRS0=SILN=ZX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE1AC43215
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 12:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E01A2073C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 12:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="KhL7ekVk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfLAMTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 07:19:48 -0500
Received: from mx.kolabnow.com ([95.128.36.42]:44368 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbfLAMTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 07:19:48 -0500
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id E903CA6D;
        Sun,  1 Dec 2019 13:19:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:mime-version:message-id:date:date
        :subject:subject:from:from:received:received:received; s=
        dkim20160331; t=1575202784; x=1577017185; bh=R+UEMDyeLPsDRtuZjih
        kaFYJiJojTuJXmRqmn0YqSno=; b=KhL7ekVku6uVHrz1azEShg6SWUz7Eh7t0CB
        RZUghx2VjgEMTGNfZdu45/ZrSev5UI14MOrifKlzWcl8HoE/aL9MzLi111u+f8zI
        2QL7fe9dTi1nGX64ij/kvIwRawgDk8z4iIiZZrnL2TYLnO8uuPxp9pzrlEye0+39
        ZsbSM5IigVgrbhEF28RbQCI92Vd6n1col++Fbf4Bh5vJco88ygh2J5H7FJNJqP1+
        YqShE2cEC/5Wk0tbfTDPNBrjgQXPVFZ4NZoC+zsrje+Sc2W0YI72tkIFvc2Azr5K
        0CEoUGttH86YVKstOkhs9de9CDpcANVvI1RuG/fPQAYZgBcjscpt0p/PwA88OkzA
        rR9tiHLytkor1ohUccwDYXNC7/ZSXzP0lEp3Cboh8Z5woI5qRNxExaH4oYG7GZjA
        0viEdkLPFOJIZKPajwEYO7kIBO+sQ7UY7q4Ll47GMNlpP+F8OPNJ0LXMCYt6wDg1
        ZPrRMip2/O1T5QXd1DeXKCWguKrdM7fLj77ojwN1a+UcaGHUDIeKDvy9jSOMaK/S
        FRD49RjrJQ3uTftkQGtMD2zOcjEPOi5ErSrgkOnqumb81YVfTvCz5i5VqSt2QtiN
        Dscp8DVfb02BE7MrEg4tcjuC5Co+9bE0GWa78e9+WkBl/G5c0k0MM5hOYeXN2rAA
        8nQDAeaw=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DDS6U23BV9m5; Sun,  1 Dec 2019 13:19:44 +0100 (CET)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id 74850465;
        Sun,  1 Dec 2019 13:19:44 +0100 (CET)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 298FD1C1C;
        Sun,  1 Dec 2019 13:19:44 +0100 (CET)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH] doc:locking: fix locktorture parameter description
Date:   Sun,  1 Dec 2019 13:19:41 +0100
Message-Id: <20191201121941.6971-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The description was talking about two default values: I removed the
wrong one.

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 Documentation/locking/locktorture.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/locking/locktorture.rst b/Documentation/locking/locktorture.rst
index 54899c95e45e..e49da0a0bf94 100644
--- a/Documentation/locking/locktorture.rst
+++ b/Documentation/locking/locktorture.rst
@@ -105,8 +105,7 @@ stat_interval
 		  Number of seconds between statistics-related printk()s.
 		  By default, locktorture will report stats every 60 seconds.
 		  Setting the interval to zero causes the statistics to
-		  be printed -only- when the module is unloaded, and this
-		  is the default.
+		  be printed -only- when the module is unloaded.
 
 stutter
 		  The length of time to run the test before pausing for this
-- 
2.23.0

