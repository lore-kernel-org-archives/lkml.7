Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC3AC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 787C0208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559933785;
	bh=2OaHwYsyYZDAKdRCnH4328gj0UauTTIjWlca+edMqlQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=WyqkdzuKHGvviYUOB+NiOlX1aFibAYZmUXA9NkB8TiHBgSTo51p3L+5oiuE/DbOqW
	 /3r0HsfjXVXyS+UCij7Du9CpA5/dTbhS+wWgLL+uYQcavqksePbzF4GE+ZLIQZ3Pl0
	 c1+3m+NFtEV7Y/QZeEcFoQA4nBiDoy/emkmYtnc4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732329AbfFGS4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 14:56:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42298 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732069AbfFGSyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 14:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nUtpajCtj97wPHuOj/zKTNziiUpSH4053jytFacwfJk=; b=qTmeSmP8ZrwkerYDhguEpvn8r
        09iCwGCNZCkzgj4abN/3J6dyS98uWzYJRNWYrz2gCjjA+jDbU20B/Iqu3hf7jnolgRpmRdJiYZKRt
        BnFnj3/G5Q5WBB/TFvXq/k6jzdWk5bPa5LDO3QcdAU1PmPucZdgsH3b9lykHBdvOmDMTo0FJ46EHh
        ++NBxkWwp9QVCyRa9euoTExUA1pVZ3TJAAeT5XfHmNy6URCB6ht68r2MRlHuBcJm3dWMFYExnk28K
        R9w6+LcrCfpdxqC9jZQnBquqrw00BSy14paWoU1qVW2UuiBzzZyHOzngCAiwFqojjGgbH+RYg7AVj
        wMEnRagVw==;
Received: from [179.181.119.115] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hZK0d-0005sd-Jx; Fri, 07 Jun 2019 18:54:39 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hZK0b-0007ET-7C; Fri, 07 Jun 2019 15:54:37 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v3 01/20] ABI: sysfs-devices-system-cpu: point to the right docs
Date:   Fri,  7 Jun 2019 15:54:17 -0300
Message-Id: <ff457774d46d96e8fe56b45409aba39d87a8672a.1559933665.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpuidle doc was split on two, one at the admin guide
and another one at the driver API guide. Instead of pointing
to a non-existent file, point to both (admin guide being
the first one).

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 1528239f69b2..87478ac6c2af 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -137,7 +137,8 @@ Description:	Discover cpuidle policy and mechanism
 		current_governor: (RW) displays current idle policy. Users can
 		switch the governor at runtime by writing to this file.
 
-		See files in Documentation/cpuidle/ for more information.
+		See Documentation/admin-guide/pm/cpuidle.rst and
+		Documentation/driver-api/pm/cpuidle.rst for more information.
 
 
 What:		/sys/devices/system/cpu/cpuX/cpuidle/stateN/name
-- 
2.21.0

