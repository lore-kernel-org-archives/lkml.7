Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC4DC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 895CA2085A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565749408;
	bh=5rLlWUJ+nSWbLbJ/vJkace/NVU+oEELFK99umC/pAFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fj6/Im3EVtNMFLK5CscGY71/bu4SJ/MIpmz1X7xV9Lg8ZKV/T7ntIs5i/H4ZGCceM
	 Uw9i3SBekQmgMZBZfpuz7Gl18DwzC1qyExV1Vt9IlqB4jtIGmbzWEuQshHaNbkWFF0
	 4ZgsCy1uzlSGf/4uZdJ6OzFvV2ZeUkpkQBNrDvT0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729830AbfHNCX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:23:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:52434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729549AbfHNCXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:23:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50D6020679;
        Wed, 14 Aug 2019 02:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565749402;
        bh=5rLlWUJ+nSWbLbJ/vJkace/NVU+oEELFK99umC/pAFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Unj0i8TYla8OhCgo/fGsIeDFBgEQTQ+Rhr8OVujNZ1SJJCWXnXhUw1JEmskKn0Agz
         oRUFDQAaBSRtj97OB9jDrKQybWo+NCH3WFKK0ON/RNDc8JQdFjSKvC8Ur9svEG5LD1
         eAvhKniMQPQCV8ruOaMwp5f8a85jS7RWKLGXIMik=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 44/44] selftests: kvm: Adding config fragments
Date:   Tue, 13 Aug 2019 22:18:33 -0400
Message-Id: <20190814021834.16662-44-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814021834.16662-1-sashal@kernel.org>
References: <20190814021834.16662-1-sashal@kernel.org>
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

