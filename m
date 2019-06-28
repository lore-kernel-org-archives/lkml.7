Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FB1C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36088208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561723992;
	bh=qgCdNXFPvDKQN+CS6kIvNO0/ThSTHOb9We4e6K8BLPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g/9H83Lx/h6IfBLqimqy9wHddg0eGKSzY+Tyr122PYX5Ob8fjouwrOD79Vu7SiSXi
	 UcNdW0jQs9Q5MhOeeZYTQ7KTlCiyqr1idsgZUkNtpKjuq21boqpGEgF3+Ol6+6maSU
	 Avaco50a8SQ8A2UwKcuWRm97rUb0rtNbsktiGSXY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbfF1MND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:13:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58270 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbfF1MMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TeaGt8pI6Vwu62riXQZpDCGAriDc3nIBGdy7UclDHhY=; b=P48mKojoqFFE1MDRkjdbVDRgQU
        EsQ5VFxzLhz9BgMT+T38WG/FqVN1k2+GAgYAPnVtMixUoi7MqfmsCV1lht7wGGJrgtBIB8uvqEcoA
        O1bNc2pWd6gSxp+dHsmyV0LzHSDRPsQySyK1tzFOFxwQEY1CyNEUg8zQFgleg9WHHjvzTzWWFpzop
        DrXbaa8k7wr60EZ4V6AFQ0jB0BqcsYjkYIJ2JsSreT4OH2UMdzo1aN9ajU33eQHNlmNXFNvmwzvG9
        hrpC90S32aWAFQfBs9MjFyWEsnQ4DQABBMK5l1anOEEkre6dKkXySmHlw1+WlyE3XkZj4ucmuBF7v
        +fl4mwRA==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgpk3-0005BY-9l; Fri, 28 Jun 2019 12:12:35 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgpk0-0004zj-Bx; Fri, 28 Jun 2019 09:12:32 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org
Subject: [PATCH 7/9] docs: gpu: add msm-crash-dump.rst to the index.rst file
Date:   Fri, 28 Jun 2019 09:12:29 -0300
Message-Id: <e5550abd8da391b539e9deb64b1305fc62fd00f2.1561723736.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561723736.git.mchehab+samsung@kernel.org>
References: <cover.1561723736.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file is currently orphaned.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/gpu/drivers.rst        | 1 +
 Documentation/gpu/msm-crash-dump.rst | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/gpu/drivers.rst b/Documentation/gpu/drivers.rst
index 4bfb7068e9f7..6c88c57b90cf 100644
--- a/Documentation/gpu/drivers.rst
+++ b/Documentation/gpu/drivers.rst
@@ -20,6 +20,7 @@ GPU Driver Documentation
    xen-front
    afbc
    komeda-kms
+   msm-crash-dump
 
 .. only::  subproject and html
 
diff --git a/Documentation/gpu/msm-crash-dump.rst b/Documentation/gpu/msm-crash-dump.rst
index 240ef200f76c..757cd257e0d8 100644
--- a/Documentation/gpu/msm-crash-dump.rst
+++ b/Documentation/gpu/msm-crash-dump.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 =====================
 MSM Crash Dump Format
 =====================
-- 
2.21.0

