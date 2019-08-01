Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9EAC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7928320665
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732601AbfHAPZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 11:25:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47604 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732586AbfHAPZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 11:25:52 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8B7016FADF;
        Thu,  1 Aug 2019 15:25:52 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-117-63.ams2.redhat.com [10.36.117.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D2AB600C4;
        Thu,  1 Aug 2019 15:25:50 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     netdev@vger.kernel.org
Cc:     kvm@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
        Dexuan Cui <decui@microsoft.com>,
        virtualization@lists.linux-foundation.org,
        "David S. Miller" <davem@davemloft.net>,
        Jorgen Hansen <jhansen@vmware.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/11] VSOCK: add SPDX identifiers to vsock tests
Date:   Thu,  1 Aug 2019 17:25:32 +0200
Message-Id: <20190801152541.245833-3-sgarzare@redhat.com>
In-Reply-To: <20190801152541.245833-1-sgarzare@redhat.com>
References: <20190801152541.245833-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 01 Aug 2019 15:25:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Hajnoczi <stefanha@redhat.com>

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v2:
 * Aligned with the current SPDX [Stefano]
---
 tools/testing/vsock/control.h | 1 +
 tools/testing/vsock/timeout.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/testing/vsock/control.h b/tools/testing/vsock/control.h
index 54a07efd267c..dac3964a891d 100644
--- a/tools/testing/vsock/control.h
+++ b/tools/testing/vsock/control.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 #ifndef CONTROL_H
 #define CONTROL_H
 
diff --git a/tools/testing/vsock/timeout.h b/tools/testing/vsock/timeout.h
index 77db9ce9860a..ecb7c840e65a 100644
--- a/tools/testing/vsock/timeout.h
+++ b/tools/testing/vsock/timeout.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 #ifndef TIMEOUT_H
 #define TIMEOUT_H
 
-- 
2.20.1

