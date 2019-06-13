Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C123C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD6320B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732878AbfFMPE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:04:29 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:53083 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732470AbfFMOSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 10:18:44 -0400
Received: from [109.168.11.45] (port=39754 helo=pc-ceresoli.dev.aim)
        by hostingweb31.netsons.net with esmtpa (Exim 4.92)
        (envelope-from <luca@lucaceresoli.net>)
        id 1hbQYr-0005He-L4; Thu, 13 Jun 2019 16:18:41 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-media@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH 4/9] media: docs: v4l2-controls: add links to structs
Date:   Thu, 13 Jun 2019 16:18:21 +0200
Message-Id: <20190613141826.26775-4-luca@lucaceresoli.net>
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

This section lacks links to struct definitions. Add one where each struct
is introduced.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 Documentation/media/kapi/v4l2-controls.rst | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/Documentation/media/kapi/v4l2-controls.rst b/Documentation/media/kapi/v4l2-controls.rst
index 64ab99abf0b6..0c3f486727ed 100644
--- a/Documentation/media/kapi/v4l2-controls.rst
+++ b/Documentation/media/kapi/v4l2-controls.rst
@@ -26,8 +26,9 @@ The control framework was created in order to implement all the rules of the
 V4L2 specification with respect to controls in a central place. And to make
 life as easy as possible for the driver developer.
 
-Note that the control framework relies on the presence of a struct v4l2_device
-for V4L2 drivers and struct v4l2_subdev for sub-device drivers.
+Note that the control framework relies on the presence of a struct
+:c:type:`v4l2_device` for V4L2 drivers and struct :c:type:`v4l2_subdev` for
+sub-device drivers.
 
 
 Objects in the framework
@@ -35,12 +36,13 @@ Objects in the framework
 
 There are two main objects:
 
-The v4l2_ctrl object describes the control properties and keeps track of the
-control's value (both the current value and the proposed new value).
+The :c:type:`v4l2_ctrl` object describes the control properties and keeps
+track of the control's value (both the current value and the proposed new
+value).
 
-v4l2_ctrl_handler is the object that keeps track of controls. It maintains a
-list of v4l2_ctrl objects that it owns and another list of references to
-controls, possibly to controls owned by other handlers.
+:c:type:`v4l2_ctrl_handler` is the object that keeps track of controls. It
+maintains a list of v4l2_ctrl objects that it owns and another list of
+references to controls, possibly to controls owned by other handlers.
 
 
 Basic usage for V4L2 and sub-device drivers
@@ -242,7 +244,7 @@ initializes the hardware to the default control values. It is recommended
 that you do this as this ensures that both the internal data structures and
 the hardware are in sync.
 
-4) Finally: implement the v4l2_ctrl_ops
+4) Finally: implement the :c:type:`v4l2_ctrl_ops`
 
 .. code-block:: none
 
-- 
2.21.0

