Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5977C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE8222CF5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567619413;
	bh=0Ky5a6jI0AkemeGonRETgu9vKBzpw70po9Drs8yrHQU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=qyAHXQWJynw8D/7f8a4HFgG0bZ1II8rm9jaYqIguZ5hEVpTuj4kcwGXDiT+BU8Vpn
	 qQtCvqUI+OPTDZf0EiUsgNcSVdgjb1GtNxTkSje0p5LtUUr6EpHkuAGxIGgvndzG8R
	 3hAr7eJrAdvCGB+muOwHuKV+gnwvXlRZV1l4fV34=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732132AbfIDRuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 13:50:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729594AbfIDRuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 13:50:12 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 141E621670;
        Wed,  4 Sep 2019 17:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567619411;
        bh=0Ky5a6jI0AkemeGonRETgu9vKBzpw70po9Drs8yrHQU=;
        h=From:To:Cc:Subject:Date:From;
        b=d15ZoBlDldssJf4rJKpfX5FQ8Ak9BfyUApl8Inl6hS7n65N526vcsVFm4fCxicJlf
         EAyW+UeLU8atKZYv+Wz9US8cUTXtZQ4HgilPPm6N7/kI1Lmop6y4zDiCXNR1tUsMxS
         BUAm5cH4MwLHTTZ1Uja5dlb4fV3NDZQLCrq0Wtog=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 0/5] arm: exynos: Second round of pulls for v5.4
Date:   Wed,  4 Sep 2019 19:49:57 +0200
Message-Id: <20190904175002.10487-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Notes:
1. One patch for soc64 sent directly, not as pull req.
2. Drivers and DTS pulls are on top of previous.
3. mach/soc pull replaces previous pull (I see it was not merged).

No dependencies between pulls.

Best regards,
Krzysztof


