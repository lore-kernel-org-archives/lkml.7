Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92627C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 19:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E1E1208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 19:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561491312;
	bh=4EGvDFLeBk4PJoyn0+P90KXm88w6KMDfWiCeX6JaV3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rM/mBV7bBzjyOJq3iT1cKly5iFsn+TWX3syvQ6lX8qvToKZgJ/sUsqyzI9k9PHxXI
	 LRwMtb4vziw9cLwP3SZ4l9V1K4sOfd+nagTmjJBiwrUdXv7NeX/lKZmBYrzSuVQ/OT
	 ezkGvcwNspfcMPI9wk+FpLEHm/RVlwHEPDgp94Is=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbfFYTfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 15:35:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728552AbfFYTfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 15:35:10 -0400
Received: from localhost.localdomain (unknown [194.230.155.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69A95213F2;
        Tue, 25 Jun 2019 19:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561491309;
        bh=4EGvDFLeBk4PJoyn0+P90KXm88w6KMDfWiCeX6JaV3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pSCDf/ZVtOEJiY9PhSVLjzx4XovFVEyB58LaNg519psG3Ctk4c7rrhpR/jaeXPwFs
         //eP2AUvjf04ykJgJGdrB/+vSn46QHRPAYQTAV1pc2jub2DstKHlrd1PidRfLy7y97
         fp33ExKSpoRtjbVJZPN9tuej1dy+/MAlsaRbRcb0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 4/4] ARM: exynos: Mach for v5.3
Date:   Tue, 25 Jun 2019 21:34:51 +0200
Message-Id: <20190625193451.7696-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190625193451.7696-1-krzk@kernel.org>
References: <20190625193451.7696-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-5.3

for you to fetch changes up to a55e040c6f21f55f81c53c56e1d8095df35e1d02:

  ARM: exynos: Cleanup cppcheck shifting warning (2019-06-25 20:45:09 +0200)

----------------------------------------------------------------
Samsung mach/soc changes for v5.3

Only cleanups and minor fixes.

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: exynos: Only build MCPM support if used

Krzysztof Kozlowski (1):
      ARM: exynos: Make ARCH_EXYNOS3 a default option

Phong Tran (1):
      ARM: exynos: Cleanup cppcheck shifting warning

 arch/arm/mach-exynos/Kconfig   | 7 ++++++-
 arch/arm/mach-exynos/Makefile  | 2 +-
 arch/arm/mach-exynos/suspend.c | 8 ++++----
 3 files changed, 11 insertions(+), 6 deletions(-)
