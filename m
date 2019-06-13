Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10459C31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E1F207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732869AbfFMPEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:04:49 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:60065 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732468AbfFMOSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 10:18:44 -0400
Received: from [109.168.11.45] (port=39754 helo=pc-ceresoli.dev.aim)
        by hostingweb31.netsons.net with esmtpa (Exim 4.92)
        (envelope-from <luca@lucaceresoli.net>)
        id 1hbQYr-0005He-4g; Thu, 13 Jun 2019 16:18:41 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-media@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH 2/9] media: docs: v4l2-controls: remove repeated ioctl names
Date:   Thu, 13 Jun 2019 16:18:19 +0200
Message-Id: <20190613141826.26775-2-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190613141826.26775-1-luca@lucaceresoli.net>
References: <20190613141826.26775-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mentioning :ref:`VIDIOC_QUERYCTRL` renders all the three related ioctls.
Explicitly adding VIDIOC_QUERY_EXT_CTRL and VIDIOC_QUERYMENU will make
them render twice, so remove them

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 Documentation/media/uapi/v4l/extended-controls.rst | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/media/uapi/v4l/extended-controls.rst b/Documentation/media/uapi/v4l/extended-controls.rst
index 0968aa9cd167..802a405aa535 100644
--- a/Documentation/media/uapi/v4l/extended-controls.rst
+++ b/Documentation/media/uapi/v4l/extended-controls.rst
@@ -96,9 +96,7 @@ if this control consists of more than one element.
    #. It is important to realize that due to the flexibility of controls it is
       necessary to check whether the control you want to set actually is
       supported in the driver and what the valid range of values is. So use
-      the :ref:`VIDIOC_QUERYCTRL` (or :ref:`VIDIOC_QUERY_EXT_CTRL
-      <VIDIOC_QUERYCTRL>`) and :ref:`VIDIOC_QUERYMENU <VIDIOC_QUERYCTRL>`
-      ioctls to check this.
+      :ref:`VIDIOC_QUERYCTRL` to check this.
 
    #. It is possible that some of the menu indices in a control of
       type ``V4L2_CTRL_TYPE_MENU`` may not be supported (``VIDIOC_QUERYMENU``
-- 
2.21.0

