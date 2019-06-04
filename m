Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFD6C28CC3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D47F42479E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559657888;
	bh=ZH92tvX7FmSj9eWf9UO99t6Kr3zTPYlBNbYMT4GIuh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yLIKAgYhjEtLkxyy1H708zkW4474LuXlXnO3Zfqrbgfnr8wrnTlB6OXvTuIO+qOtw
	 tRwYI+ywGHhB5nV7jOg8pAGz+q49ANWdNNUbuq34UtjywAhlyCpLholDMomcQ65Nkz
	 7aIQrVkm+Y9aPwV6pgg8eny4yVyppz0uGMx7SHFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbfFDOSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 10:18:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52550 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727719AbfFDOSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 10:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kjhz9ZDClKO+GVwWomvO0sdT8nN7V5kJ8pUXdG9VfXk=; b=JTYXEHZMLzldK0P3t1DJm7x6nb
        BQmvT1qrKWPVRiEbb53beHUKHD30P1fdTUfE0YObx5pm6PM+ksAgw35d0J3/9gTMHsm5TFTEsajWy
        60UoXiA/rNuU+y+k99eOJadMchlmm4pSTkYo7UancRfAKIyHzPvk5kwCMJ3sJ+pJ2Y7iaCBL/Iems
        FrwZ4B+lpEg1lLmiAF979ZFmN6zicC33fN8sPhNdztaXa+vP6Rfrjl0FUBCYlkwUZhIlDRFHW3LuD
        yhi4IUPvVHEMRbwoW+WyuZPiMAgeqrrqKj5eZe/J8yJZJUq4wXroABdmkCPrNmtXeuppgD+x1fawI
        9kHZ5WDQ==;
Received: from [179.182.172.34] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYAGH-0001Rs-VW; Tue, 04 Jun 2019 14:18:01 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hYAGE-0002l7-Mq; Tue, 04 Jun 2019 11:17:58 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v2 08/22] gpu: i915.rst: Fix references to renamed files
Date:   Tue,  4 Jun 2019 11:17:42 -0300
Message-Id: <bd7dd29b9fb2101c954c8cfb2c3b4efc7d277045.1559656538.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559656538.git.mchehab+samsung@kernel.org>
References: <cover.1559656538.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: kernel-doc './scripts/kernel-doc -rst -enable-lineno -function Hardware workarounds ./drivers/gpu/drm/i915/intel_workarounds.c' failed with return code 1
WARNING: kernel-doc './scripts/kernel-doc -rst -enable-lineno -function Logical Rings, Logical Ring Contexts and Execlists ./drivers/gpu/drm/i915/intel_lrc.c' failed with return code 1
WARNING: kernel-doc './scripts/kernel-doc -rst -enable-lineno -internal ./drivers/gpu/drm/i915/intel_lrc.c' failed with return code 2

Fixes: 112ed2d31a46 ("drm/i915: Move GraphicsTechnology files under gt/")
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/gpu/i915.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/gpu/i915.rst b/Documentation/gpu/i915.rst
index 055df45596c1..6c75380b2928 100644
--- a/Documentation/gpu/i915.rst
+++ b/Documentation/gpu/i915.rst
@@ -61,7 +61,7 @@ Intel GVT-g Host Support(vGPU device model)
 Workarounds
 -----------
 
-.. kernel-doc:: drivers/gpu/drm/i915/intel_workarounds.c
+.. kernel-doc:: drivers/gpu/drm/i915/gt/intel_workarounds.c
    :doc: Hardware workarounds
 
 Display Hardware Handling
@@ -379,10 +379,10 @@ User Batchbuffer Execution
 Logical Rings, Logical Ring Contexts and Execlists
 --------------------------------------------------
 
-.. kernel-doc:: drivers/gpu/drm/i915/intel_lrc.c
+.. kernel-doc:: drivers/gpu/drm/i915/gt/intel_lrc.c
    :doc: Logical Rings, Logical Ring Contexts and Execlists
 
-.. kernel-doc:: drivers/gpu/drm/i915/intel_lrc.c
+.. kernel-doc:: drivers/gpu/drm/i915/gt/intel_lrc.c
    :internal:
 
 Global GTT views
-- 
2.21.0

