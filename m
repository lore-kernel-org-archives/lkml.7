Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54572C282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F31620693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbfDPOmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:42:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33190 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfDPOmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:42:21 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hGPHu-0003mR-Fp; Tue, 16 Apr 2019 14:42:18 +0000
From:   Colin King <colin.king@canonical.com>
To:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] apparmor: fix spelling mistake "immutible" -> "immutable"
Date:   Tue, 16 Apr 2019 15:42:18 +0100
Message-Id: <20190416144218.1842-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in an information message string, fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 security/apparmor/policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
index 71a3e6291478..04f2480e8374 100644
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -587,7 +587,7 @@ static int replacement_allowed(struct aa_profile *profile, int noreplace,
 {
 	if (profile) {
 		if (profile->label.flags & FLAG_IMMUTIBLE) {
-			*info = "cannot replace immutible profile";
+			*info = "cannot replace immutable profile";
 			return -EPERM;
 		} else if (noreplace) {
 			*info = "profile already exists";
-- 
2.20.1

