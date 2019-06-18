Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C5EC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 21:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822F521897
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 21:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560891957;
	bh=5gnkgYUdaOuLJmG5tRU0UjjLShwtIgOhKJFjYPgxXQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ajVRtcuyh+mHZdNlwjU/jabgQuefkuyGfEWU9PKiaWVB1f+O0HPnwVqSP7Rampge7
	 yN2W3NIlceMBIx8vJdiBrVkB5GVaeZ0pkP4PY1Br3ivPNpeXiUFC9cVNjtpH+Su/H/
	 1Z1nf/LZHVWoM8yltmVTL3QTjQEgX/rSC+nL1YEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730862AbfFRVF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 17:05:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34356 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730555AbfFRVFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 17:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CXPCxH7Lws1zZBtVuZGQ87uuuQGJFqeUbiijE3bn4Sg=; b=lCejP9DfRshQseK0a6xTNEBK9L
        CQS7BxStHtUa8OrAENFWL+tMA/5rs4TNjQA5lL5eEpMdXJCnUxX1DBu7o80fhvRJkQcKWt1Xa/lyw
        x6CkTgKj/mds/bGxvCPWTiAwE6qqQpYP2UgpR8/uxMEwbiv/Mu15tRmTIeKBexH4WdLVZaZHuqbhT
        gaX8KWBpY3J59xvg4K5oZCYrE1gng5zbFEIzKOJlUuqyiXKKIO1x4UFS0oPVTtA54BJeuBY5/Cwcr
        NsWdaDyht5LAKwYJAVpq8nqD0NaNgUFaU8ipTCTCjM/K5pJHX9FpVqIgWIidA/sl7Y7dBFNHka50j
        nyQILsnw==;
Received: from 177.133.86.196.dynamic.adsl.gvt.net.br ([177.133.86.196] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdLIc-0006yt-8f; Tue, 18 Jun 2019 21:05:50 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hdLIa-0002D4-5K; Tue, 18 Jun 2019 18:05:48 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Kamil Debski <kamil@wypas.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v1 19/22] docs: driver-api: add remaining converted dirs to it
Date:   Tue, 18 Jun 2019 18:05:43 -0300
Message-Id: <03844b56f5b36b3cf8495764c8687d2ae15c1120.1560891322.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560891322.git.mchehab+samsung@kernel.org>
References: <cover.1560891322.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a number of driver-specific descriptions that contain a
mix of userspace and kernelspace documentation. Just like we did
with other similar subsystems, add them at the driver-api
groupset, but don't move the directories.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/index.rst            | 3 +++
 Documentation/mic/index.rst        | 2 --
 Documentation/phy/samsung-usb2.rst | 2 --
 Documentation/scheduler/index.rst  | 2 --
 4 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/Documentation/index.rst b/Documentation/index.rst
index 82cd9528dff0..b4a48979e15a 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -105,6 +105,9 @@ needed).
    PCI/index
    usb/index
    misc-devices/index
+   mic/index
+   phy/samsung-usb2
+   scheduler/index
 
 Architecture-specific documentation
 -----------------------------------
diff --git a/Documentation/mic/index.rst b/Documentation/mic/index.rst
index 082fa8f6a260..3a8d06367ef1 100644
--- a/Documentation/mic/index.rst
+++ b/Documentation/mic/index.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 =============================================
 Intel Many Integrated Core (MIC) architecture
 =============================================
diff --git a/Documentation/phy/samsung-usb2.rst b/Documentation/phy/samsung-usb2.rst
index 98b5952fcb97..c48c8b9797b9 100644
--- a/Documentation/phy/samsung-usb2.rst
+++ b/Documentation/phy/samsung-usb2.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 ====================================
 Samsung USB 2.0 PHY adaptation layer
 ====================================
diff --git a/Documentation/scheduler/index.rst b/Documentation/scheduler/index.rst
index 058be77a4c34..69074e5de9c4 100644
--- a/Documentation/scheduler/index.rst
+++ b/Documentation/scheduler/index.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 ===============
 Linux Scheduler
 ===============
-- 
2.21.0

