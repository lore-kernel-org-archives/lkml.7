Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60384C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 23:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A112184B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 23:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563405068;
	bh=eqjfu4EfQ+2Wfj1wuya+/cWVM8GGec0PJnrVTjC1VOk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=B9j1V6hF+wPvnisa8uHWAKYO7hkS//m1ZqVIaTVexxQJGqgL22hZj/UDk9yCpNEas
	 6LhA2twShDSyNS1EqXrVmJq/HUWPcRLZamKV9XY5J7wOtlKKy/qIW9dvMlOn7lChkL
	 UMkdibRLiNVDiE7KJ1Rt4S6AiUCw6WLKl9ifhLH4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731378AbfGQXLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 19:11:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:48238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727468AbfGQXLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 19:11:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B050208C0;
        Wed, 17 Jul 2019 23:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563405066;
        bh=eqjfu4EfQ+2Wfj1wuya+/cWVM8GGec0PJnrVTjC1VOk=;
        h=From:To:Cc:Subject:Date:From;
        b=1TAPHuM4Q8YW8zNcJToxVk7TV5HRiHU0NTvap+eqbtdDvPDnGVt8vB5oswn7gWty8
         2RET96Qti3KRKIkaPWNq3beg8vsxK/XkzLX4rEvF0i58ABx85dJTA5QgJlWh8kkM5p
         wZnq7yTmEKF23QWpeyuz4VO+OBiQ0jtUbag8BKx0=
From:   Sasha Levin <sashal@kernel.org>
To:     corbet@lwn.net, solar@openwall.com
Cc:     will@kernel.org, keescook@chromium.org, peterz@infradead.org,
        gregkh@linuxfoundation.org, tyhicks@canonical.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v2] Documentation/security-bugs: provide more information about linux-distros
Date:   Wed, 17 Jul 2019 19:11:03 -0400
Message-Id: <20190717231103.13949-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide more information about how to interact with the linux-distros
mailing list for disclosing security bugs.

Reference the linux-distros list policy and clarify that the reporter
must read and understand those policies as they differ from
security@kernel.org's policy.

Suggested-by: Solar Designer <solar@openwall.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Changes in v2:
 - Focus more on pointing to the linux-distros wiki and policies.
 - Remove explicit linux-distros email.
 - Remove various explanations of linux-distros policies.

 Documentation/admin-guide/security-bugs.rst | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/security-bugs.rst b/Documentation/admin-guide/security-bugs.rst
index dcd6c93c7aac..380d44fd618d 100644
--- a/Documentation/admin-guide/security-bugs.rst
+++ b/Documentation/admin-guide/security-bugs.rst
@@ -60,16 +60,15 @@ Coordination
 ------------
 
 Fixes for sensitive bugs, such as those that might lead to privilege
-escalations, may need to be coordinated with the private
-<linux-distros@vs.openwall.org> mailing list so that distribution vendors
-are well prepared to issue a fixed kernel upon public disclosure of the
-upstream fix. Distros will need some time to test the proposed patch and
-will generally request at least a few days of embargo, and vendor update
-publication prefers to happen Tuesday through Thursday. When appropriate,
-the security team can assist with this coordination, or the reporter can
-include linux-distros from the start. In this case, remember to prefix
-the email Subject line with "[vs]" as described in the linux-distros wiki:
-<http://oss-security.openwall.org/wiki/mailing-lists/distros#how-to-use-the-lists>
+escalations, may need to be coordinated with the private linux-distros mailing
+list so that distribution vendors are well prepared to issue a fixed kernel
+upon public disclosure of the upstream fix. Please read and follow the policies
+of linux-distros as specified in the linux-distros wiki page before reporting:
+<https://oss-security.openwall.org/wiki/mailing-lists/distros>. When
+appropriate, the security team can assist with this coordination, or the
+reporter can include linux-distros from the start. In this case, remember to
+prefix the email Subject line with "[vs]" as described in the linux-distros
+wiki.
 
 CVE assignment
 --------------
-- 
2.20.1

