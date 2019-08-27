Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92044C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD29204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566893297;
	bh=fp7pC5A6v8DesicfVH1brRId9ycSV71FJmTtEnSVlJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ov4jqZbojsc4BVBlDSeuQ2RxX1PJe3Hta7ztYPNIjjX6YVsNxJiquROb6v4vWzZLB
	 ngOOacwZO4+foThfNrcBxWLQkogW4FzauHsXXW2b8CcFpzfNUC8rJSyevkQeKAx1s0
	 yHCkZhrWAELXBVcTwr0QTOvO6rjoLipJidCS0d1U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733041AbfH0IIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:08:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:36516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732614AbfH0IGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:06:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 180C1206BA;
        Tue, 27 Aug 2019 08:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566893189;
        bh=fp7pC5A6v8DesicfVH1brRId9ycSV71FJmTtEnSVlJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wrVMW4+jF37azWxlAxg6wrJsEzVFA/O0Xff519cSNJh0seLiVxWim56WDGT2Q6Cf+
         PPR1M9nyGutf7fML1POtQwW9VVEGhHYtY5ukeBu+HUGvoOXbGFLHX6m2bjF11QFQhP
         Nu5hbk5RqRMahp+HZ7jTd+3b7FJqbwcNVEP3v5Gc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Naresh Kamboju <naresh.kamboju@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 109/162] selftests: kvm: Adding config fragments
Date:   Tue, 27 Aug 2019 09:50:37 +0200
Message-Id: <20190827072742.135445492@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072738.093683223@linuxfoundation.org>
References: <20190827072738.093683223@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



