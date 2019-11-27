Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D1EC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1A562080F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574890413;
	bh=GL2BxTNj0E0U6b50Cgt11UhBHTzZtJbYm0AmbFQSoMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rArKNYWScymtanF5SoEDjo5FkG3COuSIcRF70Qyz9N5lYXza0JJ0nNd5rokjAJDxT
	 i/o8v5eqwZNeK/WzbJyvmJ2QrPXzinke+uSsn0jMzXJ+QCIZ2C1fr6Z0Vcj5YiHgaC
	 iCNaGVl0a8Hcl/KGgGrs636OBStVCcfUuJXzTZeA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731058AbfK0Vdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:33:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:39462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730190AbfK0UwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:52:09 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D721218AE;
        Wed, 27 Nov 2019 20:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887929;
        bh=GL2BxTNj0E0U6b50Cgt11UhBHTzZtJbYm0AmbFQSoMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wYgxGCFuOL22M8hVtJiimZ24PNYsKANkGDkZrt24uscaq8P2GCZf8DIkTvPj8nHp3
         n8vPCXRgEMUo7LohanomYmI2HXvmCkmn77h/Yd83R/Rj0KDA15fgQEHUHhiQue+Sxl
         uEUpgngfr7ErVl00hHChVbW0bwT1nj4Hwhar2LAI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 150/211] ACPICA: Use %d for signed int print formatting instead of %u
Date:   Wed, 27 Nov 2019 21:31:23 +0100
Message-Id: <20191127203108.177654992@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203049.431810767@linuxfoundation.org>
References: <20191127203049.431810767@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit f8ddf49b420112e28bdd23d7ad52d7991a0ccbe3 ]

Fix warnings found using static analysis with cppcheck, use %d printf
format specifier for signed ints rather than %u

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/acpi/tools/acpidump/apmain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/acpi/tools/acpidump/apmain.c b/tools/power/acpi/tools/acpidump/apmain.c
index 943b6b6146834..bed0794e3295f 100644
--- a/tools/power/acpi/tools/acpidump/apmain.c
+++ b/tools/power/acpi/tools/acpidump/apmain.c
@@ -139,7 +139,7 @@ static int ap_insert_action(char *argument, u32 to_be_done)
 
 	current_action++;
 	if (current_action > AP_MAX_ACTIONS) {
-		fprintf(stderr, "Too many table options (max %u)\n",
+		fprintf(stderr, "Too many table options (max %d)\n",
 			AP_MAX_ACTIONS);
 		return (-1);
 	}
-- 
2.20.1



