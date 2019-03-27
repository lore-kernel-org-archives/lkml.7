Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C975C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62AB0206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfC0Pi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 11:38:56 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33471 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbfC0Pi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 11:38:56 -0400
Received: by mail-qk1-f195.google.com with SMTP id k189so10178775qkc.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 08:38:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=qBOZFWN9sB6nqzEzI4RD7vVkE1GbS2GdtAIkD+MVO2E=;
        b=TVLl2JoyZ6V8mJRAuv1Q9clE5bGlKN5CtPHAmOyrbflac9d5j7LID3PAnDsCqwoj8r
         nw8TIEz1IkryHn9VxId0NxZqdsniADnAmUax8GVaQPsMRK8QP45E+a79XJjycPN0ZcPr
         vDYTmadlsc1UVSWf8Vo/6zLpENRHO++fpUjrTI237rH6QfX6kMezl4V+EpeOVdk+i6WA
         T8+BZmm8IkR6hW5gQRIflF9K75aMQoZzopVhOIl/TR20XXaCOXs5Z9NclYHeBbH1VU0F
         PjNqUG88Va8X97LmeHM21d0WZOnPIi3fRw5ALhNdMeZAvTKQYZiuj54dHSWUQZ1lWAsC
         zbcQ==
X-Gm-Message-State: APjAAAVJoKwX7kMUg34JezVO6BtS0CsI5+KRMxpmpvSPwh5qM6pHcpTq
        6IAcz82EOOkK8hHFzcwAvGGgJ4qOF1U=
X-Google-Smtp-Source: APXvYqyO/jpOQtzb8a5lnNecQZB9YqQepYMCG6frd0kDECdBmRg7h6RMHB6pW5Wju6Www3/Q+qeiAg==
X-Received: by 2002:a37:a2d5:: with SMTP id l204mr28191407qke.297.1553701135219;
        Wed, 27 Mar 2019 08:38:55 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id f66sm12396916qkj.11.2019.03.27.08.38.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 08:38:54 -0700 (PDT)
Date:   Wed, 27 Mar 2019 11:38:53 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2] MAiNTAINERS: add Paolo, Stefan for virtio blk/scsi
Message-ID: <20190327153753.29827-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jason doesn't really have the time to review blk/scsi
patches. Paolo and Setfan agreed to help out.

Thanks guys!

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

changes from v1:
- use R tag for new reviewers
- readd Jason as M

 MAINTAINERS | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 95a5ebecd04f..6085e2e65abe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16247,7 +16247,7 @@ F:	drivers/char/virtio_console.c
 F:	include/linux/virtio_console.h
 F:	include/uapi/linux/virtio_console.h
 
-VIRTIO CORE, NET AND BLOCK DRIVERS
+VIRTIO CORE AND NET DRIVERS
 M:	"Michael S. Tsirkin" <mst@redhat.com>
 M:	Jason Wang <jasowang@redhat.com>
 L:	virtualization@lists.linux-foundation.org
@@ -16262,6 +16262,19 @@ F:	include/uapi/linux/virtio_*.h
 F:	drivers/crypto/virtio/
 F:	mm/balloon_compaction.c
 
+VIRTIO BLOCK AND SCSI DRIVERS
+M:	"Michael S. Tsirkin" <mst@redhat.com>
+M:	Jason Wang <jasowang@redhat.com>
+R:	Paolo Bonzini <pbonzini@redhat.com>
+R:	Stefan Hajnoczi <stefanha@redhat.com>
+L:	virtualization@lists.linux-foundation.org
+S:	Maintained
+F:	drivers/block/virtio_blk.c
+F:	drivers/scsi/virtio_scsi.c
+F:	include/uapi/linux/virtio_blk.h
+F:	include/uapi/linux/virtio_scsi.h
+F:	drivers/vhost/scsi.c
+
 VIRTIO CRYPTO DRIVER
 M:	Gonglei <arei.gonglei@huawei.com>
 L:	virtualization@lists.linux-foundation.org
-- 
MST
