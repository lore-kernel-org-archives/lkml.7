Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E7CECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B48FA2190F
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570696812;
	bh=nZadMcj7fPoGQcubnVdX3ztsZDaR+rVqTVTDnDv6IP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WUiLYJ8GIGUtipwDdhOelkQ/zRalcoCjl8YYqS0gKnzLmODPDFOVzashRXWQziO8r
	 fpre0nB4Rh7O0GW08FBFbcR9jEuISsowPRImF6K8+nOHD8jkx3Ym5CN7NxZq00XCSq
	 t7wUMEvHTwKQjQjMRrWpPJTmuBCdcgaRkEKNHsuE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388029AbfJJIkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:40:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:43908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733181AbfJJIkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:40:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C45FF21920;
        Thu, 10 Oct 2019 08:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570696800;
        bh=nZadMcj7fPoGQcubnVdX3ztsZDaR+rVqTVTDnDv6IP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=suGodArxf4QTjeHoTqJYLkmlZJv+BVc/S3zQMvb7G0FnWZXPE1EghuuA1a+zf9fWZ
         j3VAnh//3dQbFA6CUPxg36i4aXeKep7UFHaowcVowj12XI1Py37Zu7YPUdTtrkaqxY
         x+OsToNSjDFn/ulqh5GIETcsEVTHpIQF7H8I98DY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Petr Vorel <pvorel@suse.cz>
Subject: [PATCH 5.3 057/148] selftests/tpm2: Add the missing TEST_FILES assignment
Date:   Thu, 10 Oct 2019 10:35:18 +0200
Message-Id: <20191010083614.606686413@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010083609.660878383@linuxfoundation.org>
References: <20191010083609.660878383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

commit 981c107cbb420ee028f8ecd155352cfd6351c246 upstream.

The Python files required by the selftests are not packaged because of
the missing assignment to TEST_FILES. Add the assignment.

Cc: stable@vger.kernel.org
Fixes: 6ea3dfe1e073 ("selftests: add TPM 2.0 tests")
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/tpm2/Makefile |    1 +
 1 file changed, 1 insertion(+)

--- a/tools/testing/selftests/tpm2/Makefile
+++ b/tools/testing/selftests/tpm2/Makefile
@@ -2,3 +2,4 @@
 include ../lib.mk
 
 TEST_PROGS := test_smoke.sh test_space.sh
+TEST_FILES := tpm2.py tpm2_tests.py


