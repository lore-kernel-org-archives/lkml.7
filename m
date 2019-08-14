Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE2AC32750
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E730920679
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565749610;
	bh=5rLlWUJ+nSWbLbJ/vJkace/NVU+oEELFK99umC/pAFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O1wV/ck/5g+mJTDKuYQpERcZWItUg7estDMpXo5FXPpyAWJBtRR3VXlPy9k3OPe9y
	 Xq3qkg9aPHcpkBnMYANyA18fjc1VWUCvIw11qbrbwkrvvc0wj14FETw/G/JvZDS1Sj
	 wUEIGfhF8ZhkBMzJsBJa3q2DpikpgB4+vtS/o+40=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbfHNC0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:26:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:54752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730385AbfHNC0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:26:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B5E220679;
        Wed, 14 Aug 2019 02:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565749603;
        bh=5rLlWUJ+nSWbLbJ/vJkace/NVU+oEELFK99umC/pAFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cUbHpTpmh6mVjI0E9EFPj1+v3HzBJAFT8mDBRShocN2IpyDJpkJWS/MfXFGOov+pa
         CFZ9VdxiFApxL7bT0p6HOXPUWwOEju9cSFS6f9jX4jJhYRIsD8V2zhFpeJLm0wxaKn
         8mcArY6HLazuNDNrpdAIJFwpotzUwsHq7lIBmigM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 28/28] selftests: kvm: Adding config fragments
Date:   Tue, 13 Aug 2019 22:25:50 -0400
Message-Id: <20190814022550.17463-28-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814022550.17463-1-sashal@kernel.org>
References: <20190814022550.17463-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naresh Kamboju <naresh.kamboju () linaro ! org>

[ Upstream commit c096397c78f766db972f923433031f2dec01cae0 ]

selftests kvm test cases need pre-required kernel configs for the test
to get pass.

Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/kvm/config | 3 +++
 1 file changed, 3 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/config

diff --git a/tools/testing/selftests/kvm/config b/tools/testing/selftests/kvm/config
new file mode 100644
index 0000000000000..63ed533f73d6e
--- /dev/null
+++ b/tools/testing/selftests/kvm/config
@@ -0,0 +1,3 @@
+CONFIG_KVM=y
+CONFIG_KVM_INTEL=y
+CONFIG_KVM_AMD=y
-- 
2.20.1

