Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9564C606CA
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A341321783
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="BwJWe4RW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390227AbfGHTDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:03:19 -0400
Received: from first.geanix.com ([116.203.34.67]:59822 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731445AbfGHTDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:03:16 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 5257AA722;
        Mon,  8 Jul 2019 19:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1562612507; bh=YOgNTioIODzZk0iBQ1vACJ3KaIxxtswdmVXCX8C8rGk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=BwJWe4RWxPQXiX3LQ1DOSknVqwiafW9D5hEVyaOwcytGPUyrkKIq3Kds2Jtq0btSV
         EglhKfv2N2jQLHKXCNaNyPDdN86VV4Mwkz3GBEcL736+6AD2T/o3EG6K1d5kT5yj2q
         76TRijvk/G6hFqleXTVH5pInpkkrNQBs5kp+PjPONlI/uyn8z+Kst1eE3JugWKI4y2
         rctTh67Z6MdQfN+MweG7yjhvEM6HZSHlyIQ0PFxcbUBXy3buusQX4bXFGjsddLTNNv
         zF6ReboReuBxerNl5d8tomxzcpUy0vfihL963pYQUI8ysiSAiOrbz5jQirO9xfJT51
         fs9zJabxmfbGw==
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
        =?UTF-8?q?Sean=20Nyekj=C3=A6r?= <sean@geanix.com>,
        Esben Haabendal <esben@geanix.com>
Subject: [PATCH 2/4] tty: n_gsm: update doc example to use header for N_GSM0710 define
Date:   Mon,  8 Jul 2019 21:02:50 +0200
Message-Id: <20190708190252.24628-2-martin@geanix.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708190252.24628-1-martin@geanix.com>
References: <20190708190252.24628-1-martin@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason to gues the line discipline number when it is
available from tty.h

Signed-off-by: Martin Hundebøll <martin@geanix.com>
---
 Documentation/serial/n_gsm.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/serial/n_gsm.rst b/Documentation/serial/n_gsm.rst
index 78f91ce06956..a3ce1b269018 100644
--- a/Documentation/serial/n_gsm.rst
+++ b/Documentation/serial/n_gsm.rst
@@ -23,7 +23,7 @@ Major parts of the initialization program :
 (a good starting point is util-linux-ng/sys-utils/ldattach.c)::
 
   #include <linux/gsmmux.h>
-  #define N_GSM0710	21	/* GSM 0710 Mux */
+  #include <linux/tty.h>
   #define DEFAULT_SPEED	B115200
   #define SERIAL_PORT	/dev/ttyS0
 
-- 
2.22.0

