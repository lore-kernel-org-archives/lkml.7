Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C829C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 20:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 591F121852
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 20:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfGDUuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 16:50:52 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:63204 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfGDUuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 16:50:51 -0400
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=svr-ies-mbx-02.mgc.mentorg.com)
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1hj8gq-0006IQ-4N from Cedric_Hombourger@mentor.com ; Thu, 04 Jul 2019 13:50:48 -0700
Received: from FRG-W10-HOMBOUR.world.mentorg.com (137.202.0.90) by
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Thu, 4 Jul 2019 21:50:43 +0100
From:   Cedric Hombourger <Cedric_Hombourger@mentor.com>
To:     <ben@decadent.org.uk>
CC:     <yamada.masahiro@socionext.com>, <isar-users@googlegroups.com>,
        <michal.lkml@markovi.net>, <linux-kbuild@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <riku.voipio@linaro.org>,
        Cedric Hombourger <Cedric_Hombourger@mentor.com>
Subject: [PATCH v3 0/1] builddeb: generate multi-arch friendly linux-libc-dev
Date:   Thu, 4 Jul 2019 22:50:26 +0200
Message-ID: <1562273427-204-1-git-send-email-Cedric_Hombourger@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <432e997617a0669886cd9ea5ceac7c1a2173044b.camel@decadent.org.uk>
References: <432e997617a0669886cd9ea5ceac7c1a2173044b.camel@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v3:

 - add Multi-Arch: same to debian/control for linux-libc-dev

Changes in v2:

 - forward $debarch from mkdebian to builddeb
 - use dpkg-architecture -qDEB_HOST_MULTIARCH instead of $CC -dumpmachine

Cedric Hombourger (1):
  builddeb: generate multi-arch friendly linux-libc-dev package

 scripts/package/builddeb | 8 ++++++++
 scripts/package/mkdebian | 5 +++--
 2 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.11.0

