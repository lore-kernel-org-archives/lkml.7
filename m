Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74A0C2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 20:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D59424671
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 20:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575576276;
	bh=6i7NWqiwckPbF7W78MFVTVfCgJ8Ms5/BpWOxNhnaeMI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=puNxP2DmkWGF11HkpmJskmZp+VFqbwJGCn96ymUaUDjQbBmhrHvg/3yapNbHM6XfP
	 rp0veA1gDaZcTUHLN0QfK30AV06i5scthKS0t9oLWQ+KKMXnW9eMv/xDq4C/wAfHQ1
	 b3gMhf1InY3gQ1l1hxOYwQ7FKcYr872O71++ZqUo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729755AbfLEUEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 15:04:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:37428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729154AbfLEUEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 15:04:35 -0500
Received: from localhost.localdomain (unknown [194.230.155.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 198DB24670;
        Thu,  5 Dec 2019 20:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575576274;
        bh=6i7NWqiwckPbF7W78MFVTVfCgJ8Ms5/BpWOxNhnaeMI=;
        h=From:To:Cc:Subject:Date:From;
        b=QCy1zTpUqeOjX5KHc1vWn36JjhU/Ro2t7HZZfk0ZLURg8cjoC7IL6vlBCYN+vYUcR
         BqFkaDlSqBmjDbxZAqsGrW5uPZor+tX8kG0zfeYq5fq3Lc/eBOIDkIByoh/Bn7ig2P
         J/dctXEC3KW7523KdYunbe/jS5AqsfEZ1JNu7nHI=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, Jiri Slaby <jslaby@suse.com>
Subject: [PATCH] MAINTAINERS: Include Samsung SoC serial driver in Samsung entry
Date:   Thu,  5 Dec 2019 21:04:22 +0100
Message-Id: <20191205200422.5781-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Samsung SoC (S3C, S5P and Exynos) serial driver does not have dedicated
reviewing person so some patches might be missed be Samsung-related
folks (e.g. not even reaching Samsung SoC mailing list).  Include them
in generic Samsung SoC maintainer entry to provide some level of
reviewing and care.  This will not change handling of patches (via
serial tree).

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

I am not the author of the code and I do not feel confident in its
internals so if anyone else would also like to join in taking care
serial driver, feel free to let me know.
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 15e905b37790..d6e593ee9adc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2272,6 +2272,7 @@ F:	drivers/*/*s3c64xx*
 F:	drivers/*/*s5pv210*
 F:	drivers/memory/samsung/
 F:	drivers/soc/samsung/
+F:	drivers/tty/serial/samsung*
 F:	include/linux/soc/samsung/
 F:	Documentation/arm/samsung/
 F:	Documentation/devicetree/bindings/arm/samsung/
-- 
2.17.1

