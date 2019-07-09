Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E44C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 06:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C6B216C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 06:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="KUpNEaDS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfGIGqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 02:46:43 -0400
Received: from first.geanix.com ([116.203.34.67]:46422 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbfGIGql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 02:46:41 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id CEEF3A742;
        Tue,  9 Jul 2019 06:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1562654711; bh=hbPCQQVPqZIoYMntGiWvEsOQTkIuxWitxVSaU5o6y+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=KUpNEaDSPXmNH1CzA0gdqYA+cT66lUyO/dbzLmMMM78ikYhxrLKp8aEoM+42TKc0Q
         Xl87yZs8SoRz1geIBYXlECkS2zmU4+kqy5l1egdSqJOYmaonsKPSZe+RzhFZoX7U/g
         FFoJY9lxdOSbhM/TRG3ZBrWYShCBS8Mib8k8ANOPBApdrhN38VMQ+Q00u1tVUSfc5l
         sD7KbzrVZ9IFhj/uRHzWLNrzViFjK4pKGPEKuuj6FPgi9qQeytKMgR76NwGfkh7bK2
         0qYt6V4Yt6pzFOUW4rrRIyyTOA4NthsnWi+JL3viP0g6EJgrxSFbCa3yq1Yq/Sjjh5
         dLUdiJ/h0Pj9w==
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
        =?UTF-8?q?Sean=20Nyekj=C3=A6r?= <sean@geanix.com>,
        Esben Haabendal <esben@geanix.com>
Subject: [PATCHv2 2/4] tty: n_gsm: update doc example to use header for N_GSM0710 define
Date:   Tue,  9 Jul 2019 08:46:31 +0200
Message-Id: <20190709064633.45411-2-martin@geanix.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190709064633.45411-1-martin@geanix.com>
References: <20190709064633.45411-1-martin@geanix.com>
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
index 4f37198423f7..0ba731ab00b2 100644
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

