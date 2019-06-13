Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3D6C31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F1D207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732921AbfFMPEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:04:07 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:45540 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732475AbfFMOSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 10:18:46 -0400
Received: from [109.168.11.45] (port=39754 helo=pc-ceresoli.dev.aim)
        by hostingweb31.netsons.net with esmtpa (Exim 4.92)
        (envelope-from <luca@lucaceresoli.net>)
        id 1hbQYs-0005He-T4; Thu, 13 Jun 2019 16:18:42 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-media@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH 9/9] media: docs: v4l2-controls: remove outdated paragraph
Date:   Thu, 13 Jun 2019 16:18:26 +0200
Message-Id: <20190613141826.26775-9-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190613141826.26775-1-luca@lucaceresoli.net>
References: <20190613141826.26775-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

This paragraph was added by commit a42b57f5aacf ("V4L/DVB: Documentation:
add v4l2-controls.txt documenting the new controls API") back in 2010, when
the controls API has been improved. Nowadays it is a bit anachronistic, so
remove it.

The same information is stated in up-to-date wording a few paragraphs later
anyway:

> You’re done! And this is sufficient for most of the drivers we have. No
> need to do any validation of control values, or implement QUERYCTRL,
> QUERY_EXT_CTRL and QUERYMENU. And G/S_CTRL as well as G/TRY/S_EXT_CTRLS
> are automatically supported.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 Documentation/media/kapi/v4l2-controls.rst | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/media/kapi/v4l2-controls.rst b/Documentation/media/kapi/v4l2-controls.rst
index 407617b1d0ce..ebe2a55908be 100644
--- a/Documentation/media/kapi/v4l2-controls.rst
+++ b/Documentation/media/kapi/v4l2-controls.rst
@@ -98,11 +98,6 @@ For V4L2 drivers:
 
 	foo->v4l2_dev.ctrl_handler = &foo->ctrl_handler;
 
-Finally, remove all control functions from your v4l2_ioctl_ops (if any):
-vidioc_queryctrl, vidioc_query_ext_ctrl, vidioc_querymenu, vidioc_g_ctrl,
-vidioc_s_ctrl, vidioc_g_ext_ctrls, vidioc_try_ext_ctrls and vidioc_s_ext_ctrls.
-Those are now no longer needed.
-
 For sub-device drivers:
 
 .. code-block:: c
-- 
2.21.0

