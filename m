Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1381C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED802171F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554201177;
	bh=VxRcKjXAkmPFzy6m9uh0q/v6tV1u4rdk19jGcQc9OhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eg1k6QDw2x90sqYIg5agtlYrPxyhkn2v2+rec0Nn90hsnQQTr1/2h6LwvQDOvK1xd
	 UK5cC2CeO4+zUcPL/gN9ljaVw6EqsTx8LUFue9d1I90h0DGUiuPUIFm0oGRbQaYut4
	 O66YES/bPwtN4hGLj1loV/t1BzBLPNWMdmjGf4ps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730495AbfDBKcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 06:32:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:36384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730433AbfDBKcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 06:32:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0BCE2133D;
        Tue,  2 Apr 2019 10:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554201172;
        bh=VxRcKjXAkmPFzy6m9uh0q/v6tV1u4rdk19jGcQc9OhA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jkw96W/Nt1q8LJ+19un+tl9gkam2ARr4cb6uPqHO2nixnxRLAEu8JoId2ruRlaSjT
         eNiaG/3Zz1IT/8hNp/KyPAQiXqcJo73AizzcsFPYsb8YuYCtwFtAK97NyrmAr4vSL6
         2m0BgB0emmfUN5z+efLo75vKXjSHlPXcbZY6sCi4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Brent Baccala <baccala@freesoft.org>,
        "David A . Schleef" <ds@schleef.org>
Subject: [PATCH 07/16] staging: comedi: quatec_daqp_cs: add proper SPDX identifier to driver
Date:   Tue,  2 Apr 2019 12:31:54 +0200
Message-Id: <20190402103203.14959-8-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190402103203.14959-1-gregkh@linuxfoundation.org>
References: <20190402103203.14959-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default all files without license information are under the default
license of the kernel, which is GPL version 2.  Because of this, add the
GPL-2.0 identifier to the quatec_daqp_cs driver which did not have any license
identifiers in it at all.

Cc: Ian Abbott <abbotti@mev.co.uk>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Brent Baccala <baccala@freesoft.org>
Cc: David A. Schleef <ds@schleef.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/comedi/drivers/quatech_daqp_cs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/comedi/drivers/quatech_daqp_cs.c b/drivers/staging/comedi/drivers/quatech_daqp_cs.c
index 257b0daff01f..6daaacf7a26a 100644
--- a/drivers/staging/comedi/drivers/quatech_daqp_cs.c
+++ b/drivers/staging/comedi/drivers/quatech_daqp_cs.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * quatech_daqp_cs.c
  * Quatech DAQP PCMCIA data capture cards COMEDI client driver
-- 
2.21.0

