Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF93C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D2820657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557921748;
	bh=UjY/Fn0JNmLHvW7FKm0Bc7m7bujPbFu0FK5CtX4pT90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yS+vlvVb+r6VZwHdjwqdr3DQGscm/GNs9MZbZBwBghQIZcAZGF3P9jbUr8KDasjhN
	 fjjrAA9F5gxM75d/zUsazgGi3k9ukVA3XCsMmihgVTKY/+oIs+UY30sx0U9J0vSs4J
	 jn7slIv3pxr5zhn1+wyftr50aiirn4OkhXdrpWd8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730148AbfEOMC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 08:02:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729677AbfEOLNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:13:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0304D2168B;
        Wed, 15 May 2019 11:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918793;
        bh=UjY/Fn0JNmLHvW7FKm0Bc7m7bujPbFu0FK5CtX4pT90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VGrm8O2BiLo4XRwkO9u78930UAn11FD9UeJ7igsptzCE+57hm+avW6WFCCcr0wcHB
         nM4ynfH0rAqHNlJeF355XuQgfCixuYO7ku09AVAgw+8qTRUr7+twngEOjsxfydW4F4
         tCjiMSfmn5Lzbo6A+hgdLi0d27691qdHEOk99+9g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 4.4 253/266] x86/bugs: Change L1TF mitigation string to match upstream
Date:   Wed, 15 May 2019 12:56:00 +0200
Message-Id: <20190515090731.572194091@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090722.696531131@linuxfoundation.org>
References: <20190515090722.696531131@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Hutchings <ben@decadent.org.uk>

Commit 72c6d2db64fa "x86/litf: Introduce vmx status variable" upstream
changed "Page Table Inversion" to "PTE Inversion".  That was part of
the implementation of additional mitigations for VMX which haven't
been applied to this branch.  Just change this string to be consistent
and match documentation.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1160,7 +1160,7 @@ static ssize_t cpu_show_common(struct de
 
 	case X86_BUG_L1TF:
 		if (boot_cpu_has(X86_FEATURE_L1TF_PTEINV))
-			return sprintf(buf, "Mitigation: Page Table Inversion\n");
+			return sprintf(buf, "Mitigation: PTE Inversion\n");
 		break;
 
 	case X86_BUG_MDS:


