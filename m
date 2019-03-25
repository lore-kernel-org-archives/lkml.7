Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40559C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A21A2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730979AbfCYV15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:27:57 -0400
Received: from smtprelay0236.hostedemail.com ([216.40.44.236]:45170 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730260AbfCYV14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:27:56 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 7328B100E86CC;
        Mon, 25 Mar 2019 21:27:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: leg70_27a9b3a88a542
X-Filterd-Recvd-Size: 2991
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Mon, 25 Mar 2019 21:27:52 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Bad file pattern in MAINTAINERS section 'SAMSUNG EXYNOS TRUE RANDOM NUMBER GENERATOR (TRNG) DRIVER'
Date:   Mon, 25 Mar 2019 14:27:51 -0700
Message-Id: <20190325212751.27532-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A file pattern line in this section of the MAINTAINERS file in linux-next
does not have a match in the linux source files.

This could occur because a matching filename was never added, was deleted
or renamed in some other commit.

The commits that added and if found renamed or removed the file pattern
are shown below.

Please fix this defect appropriately.

1: ---------------------------------------------------------------------------

linux-next MAINTAINERS section:

	13589	SAMSUNG EXYNOS TRUE RANDOM NUMBER GENERATOR (TRNG) DRIVER
	13590	M:	Łukasz Stelmach <l.stelmach@samsung.com>
	13591	L:	linux-samsung-soc@vger.kernel.org
	13592	S:	Maintained
	13593	F:	drivers/char/hw_random/exynos-trng.c
-->	13594	F:	Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.txt

2: ---------------------------------------------------------------------------

The most recent commit that added or modified file pattern 'Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.txt':

commit 6cd225cc5d8a6526b2bea41955882be55d4f109e
Author: Łukasz Stelmach <l.stelmach@samsung.com>
Date:   Fri Dec 22 17:48:35 2017 +0100

    hwrng: exynos - add Samsung Exynos True RNG driver
    
    Add support for True Random Number Generator found in Samsung Exynos
    5250+ SoCs.
    
    Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
    Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
    Acked-by: Philippe Ombredanne <pombredanne@nexb.com>
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

 MAINTAINERS                          |   7 ++
 drivers/char/hw_random/Kconfig       |  12 ++
 drivers/char/hw_random/Makefile      |   1 +
 drivers/char/hw_random/exynos-trng.c | 237 +++++++++++++++++++++++++++++++++++
 4 files changed, 257 insertions(+)

3: ---------------------------------------------------------------------------

No commit with file pattern 'Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.txt' was found
