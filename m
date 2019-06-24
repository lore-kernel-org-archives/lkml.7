Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88136C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 12:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C7B42133F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 12:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbfFXMjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 08:39:52 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48242 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730243AbfFXMjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 08:39:49 -0400
Received: from turingmachine.home (unknown [IPv6:2804:431:d719:dd85:d711:794d:1c68:5ed3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tonyk)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 549DF260ED4;
        Mon, 24 Jun 2019 13:39:46 +0100 (BST)
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     mchehab@kernel.org, hverkuil@xs4all.nl, helen.koike@collabora.com,
        kernel@collabora.com, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v2 5/5] media: vimc.rst: add vimc-streamer source documentation
Date:   Mon, 24 Jun 2019 09:37:29 -0300
Message-Id: <20190624123729.5847-5-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624123729.5847-1-andrealmeid@collabora.com>
References: <20190624123729.5847-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since vimc-streamer.{c, h} are fully documented and conforming with the
kernel-doc syntax, add those files to vimc.rst

Signed-off-by: André Almeida <andrealmeid@collabora.com>
Suggested-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---

Changes in v2: none

 Documentation/media/v4l-drivers/vimc.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/media/v4l-drivers/vimc.rst b/Documentation/media/v4l-drivers/vimc.rst
index bece85867424..406417680db5 100644
--- a/Documentation/media/v4l-drivers/vimc.rst
+++ b/Documentation/media/v4l-drivers/vimc.rst
@@ -96,3 +96,14 @@ those arguments to each subdevice, not to the vimc module. For example::
         Window size to calculate the mean. Note: the window size needs to be an
         odd number, as the main pixel stays in the center of the window,
         otherwise the next odd number is considered (the default value is 3).
+
+Source code documentation
+-------------------------
+
+vimc-streamer
+~~~~~~~~~~~~~
+
+.. kernel-doc:: drivers/media/platform/vimc/vimc-streamer.h
+   :internal:
+
+.. kernel-doc:: drivers/media/platform/vimc/vimc-streamer.c
-- 
2.22.0

